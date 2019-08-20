import FileUploadWithPreview from 'file-upload-with-preview'
import 'file-upload-with-preview/dist/file-upload-with-preview.min.css'

const picUpload = () => {
  new FileUploadWithPreview('myUniqueUploadId');
};

export { picUpload };
