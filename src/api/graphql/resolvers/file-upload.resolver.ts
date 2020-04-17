import { FileUpload } from "graphql-upload";
import { BlobServiceClient } from "@azure/storage-blob";
import { v1 as generateUUID } from "uuid";


const AZURE_STORAGE_CONNECTION_STRING = "";
export const fileUploadResolver = {
  Mutation: {
    async uploadFile(parent, { file }: { file: Promise<FileUpload> }) {
      const { createReadStream, filename, mimetype, encoding } = await file;
      const stream = createReadStream();

      const uploadClient = await getAzureUploadClient(filename);
      const uploadFileResponse = await uploadClient.uploadStream(stream);

      console.log("File was uploaded successfully. requestId: ", uploadFileResponse.requestId);

      // 1. Validate file metadata.

      // 2. Stream file contents into cloud storage:
      // https://nodejs.org/api/stream.html

      // 3. Record the file upload in your DB.
      // const id = await recordFile( … )

      return { filename, mimetype, encoding };
    }
  },
}

async function getAzureUploadClient(fileName: string) {
  const uniqueId = generateUUID();
  const newFileName = `${uniqueId}-${fileName}`;
  // Create the BlobServiceClient object which will be used to create a container client
  const blobServiceClient = await BlobServiceClient.fromConnectionString(AZURE_STORAGE_CONNECTION_STRING);
  const containerName = "wfto-covid19-images";
  // Get a reference to a container
  const containerClient = await blobServiceClient.getContainerClient(containerName);

  const blockBlobClient = containerClient.getBlockBlobClient(newFileName);

  // console.log('\nUploading to Azure storage as blob:\n\t');
  // // Upload data to the blob
  // const data = 'Hello, World!';
  // const uploadBlobResponse = await blockBlobClient.upload(data, data.length);
  // console.log("Blob was uploaded successfully. requestId: ", uploadBlobResponse.requestId);

  return blockBlobClient;
  // console.log('\nListing blobs...');
  // // List the blob(s) in the container.
  // for await (const blob of containerClient.listBlobsFlat()) {
  //     console.log('\t', blob.name);
  // }
}