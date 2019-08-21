import FileUploadWithPreview from 'file-upload-with-preview'
import 'file-upload-with-preview/dist/file-upload-with-preview.min.css'

const photo = new FileUploadWithPreview('myUniqueUploadId');

const getPicture = (event) => {
  if (photo) {
    photo.cachedFileArray[0];
  }
}

const picUpload = () => {
  const preview = document.getElementById('user_picture');
  if (preview) {
    preview.addEventListener('fileUploadWithPreview:imagesAdded', getPicture());
  }
};

export { picUpload };
