import { FileUpload } from 'graphql-upload';
import { Readable } from 'stream';

export interface FileUploadArg extends Omit<FileUpload, 'createReadStream'> {
  stream: Readable;
}

export interface FileUploadAzureResponse {
  filename: string;
  link: string;
  lastModified: Date;
}

export type FileUploadResponse = FileUploadAzureResponse;
