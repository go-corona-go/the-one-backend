import { FileUpload } from 'graphql-upload';
import {
  FileUploadService,
  FileUploadResponse
} from '../../../services/file-upload-service';

export const fileUploadResolver = {
  Mutation: {
    async uploadFile(
      _parent,
      { file }: { file: Promise<FileUpload> },
      { fileUploadService }: { fileUploadService: FileUploadService }
    ): Promise<FileUploadResponse> {
      // 1. TODO - Validate file metadata.
      const { createReadStream, filename, mimetype, encoding } = await file;
      const stream = createReadStream();

      const uploadFileResponse = await fileUploadService.uploadFile({
        filename,
        mimetype,
        encoding,
        stream
      });

      // 2. Record the file upload in DB.
      // const id = await recordFile( … )

      return uploadFileResponse;
    }
  }
};
