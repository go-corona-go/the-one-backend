import { FileUpload } from 'graphql-upload';
import { BlobServiceClient, BlockBlobClient } from '@azure/storage-blob';
import { v1 as generateUUID } from 'uuid';
import { Readable } from 'stream';

interface FileUploadInput extends Omit<FileUpload, 'createReadStream'> {
  stream: Readable;
}

interface FileUploadAzureResponse {
  filename: string;
  link: string;
  lastModified: Date;
}

const AZURE_STORAGE_CONNECTION_STRING =
  process.env.AZURE_STORAGE_CONNECTION_STRING;
const AZURE_STORAGE_CONTAINER_NAME = 'wfto-covid19-images';

const ONE_MB = 1024 * 1024;
const uploadOptions = {
  bufferSize: 5 * ONE_MB,
  maxConcurrency: 5
};

async function getAzureUploadClient(
  fileName: string
): Promise<BlockBlobClient> {
  try {
    // Create the BlobServiceClient object which will be used to create a container client
    const blobServiceClient = await BlobServiceClient.fromConnectionString(
      AZURE_STORAGE_CONNECTION_STRING
    );
    // Get a reference to a container
    const storageContainer = await blobServiceClient.getContainerClient(
      AZURE_STORAGE_CONTAINER_NAME
    );
    // Blob client is used to upload blob/file to the server
    const blockBlobClient = storageContainer.getBlockBlobClient(fileName);
    return blockBlobClient;
  } catch (error) {
    console.error(error);
    const newError = new Error(
      `Error occured while initialising the azure client - ${error.message}`
    );
    newError.name = 'AZURE_INIT_ERROR';
    throw newError;
  }
}

async function uploadFileToAzure(
  file: FileUploadInput
): Promise<FileUploadAzureResponse> {
  const uniqueId = generateUUID();
  const newFileName = `${uniqueId}-${file.filename}`;
  const azureUploadClient = await getAzureUploadClient(newFileName);

  const uploadFileResponse = await azureUploadClient.uploadStream(
    file.stream,
    uploadOptions.bufferSize,
    uploadOptions.maxConcurrency,
    {
      blobHTTPHeaders: {
        blobContentEncoding: file.encoding,
        blobContentType: file.mimetype
      }
    }
  );
  // console.log("response: ", uploadFileResponse);
  return {
    filename: newFileName,
    link: azureUploadClient.url,
    lastModified: uploadFileResponse.lastModified
  };
}

export const fileUploadResolver = {
  Mutation: {
    async uploadFile(
      _parent,
      { file }: { file: Promise<FileUpload> }
    ): Promise<FileUploadAzureResponse> {
      // 1. TODO - Validate file metadata.
      const { createReadStream, filename, mimetype, encoding } = await file;
      const stream = createReadStream();

      const uploadFileResponse = await uploadFileToAzure({
        filename,
        mimetype,
        encoding,
        stream
      });

      // 2. Record the file upload in your DB.
      // const id = await recordFile( … )

      return uploadFileResponse;
    }
  }
};
