import {
  FileUploadArg,
  FileUploadAzureResponse,
  FileUploadResponse
} from './file-upload-service.interface';
import { uploadOptions, getAzureKeys } from './constants';
import { BlobServiceClient, BlockBlobClient } from '@azure/storage-blob';
import { v1 as generateUUID } from 'uuid';

export class FileUploadService {
  public async uploadFile(file: FileUploadArg): Promise<FileUploadResponse> {
    const response = this._uploadFileToAzureBlob(file);
    return response;
  }

  private async _uploadFileToAzureBlob(
    file: FileUploadArg
  ): Promise<FileUploadAzureResponse> {
    const uniqueId = generateUUID();
    const newFileName = `${uniqueId}-${file.filename}`;
    // TO make sure there is no file name conflict
    const azureUploadClient = this._getAzureUploadClient(newFileName);
    try {
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
    } catch (error) {
      console.error(error);
      const newError = new Error(
        `Error occured while uploading stream to the storage - ${error.message}`
      );
      newError.name = 'AZURE_STREAM_UPLOAD_ERROR';
      throw newError;
    }
  }

  private _getAzureUploadClient(fileName: string): BlockBlobClient {
    try {
      const {
        AZURE_STORAGE_CONNECTION_STRING,
        AZURE_STORAGE_CONTAINER_NAME
      } = getAzureKeys();
      // Create the BlobServiceClient object which will be used to create a container client
      const blobServiceClient = BlobServiceClient.fromConnectionString(
        AZURE_STORAGE_CONNECTION_STRING
      );
      // Get a reference to a container
      const azureStorageContainer = blobServiceClient.getContainerClient(
        AZURE_STORAGE_CONTAINER_NAME
      );
      const blockBlobClient = azureStorageContainer.getBlockBlobClient(
        fileName
      );
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
}
