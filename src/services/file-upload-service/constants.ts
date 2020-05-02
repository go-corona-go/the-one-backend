export const AZURE_STORAGE_CONNECTION_STRING =
  process.env.AZURE_STORAGE_CONNECTION_STRING || '';
export const AZURE_STORAGE_CONTAINER_NAME = 'wfto-covid19-images';

const ONE_MB = 1024 * 1024;
export const uploadOptions = {
  bufferSize: 5 * ONE_MB,
  maxConcurrency: 5
};
