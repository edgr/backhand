import FileUploadWithPreview from 'file-upload-with-preview'
import 'file-upload-with-preview/dist/file-upload-with-preview.min.css'

const picUpload = () => {
  const photo = new FileUploadWithPreview('user_picture');
  const preview = document.getElementById('user_picture');
  if (preview) {
    window.addEventListener('fileUploadWithPreview:imagesAdded', function(e) {
      // e.detail.uploadId
      // e.detail.cachedFileArray
      // e.detail.addedFilesCount
      // Use e.detail.uploadId to match up to your specific input
      if (e.detail.uploadId === 'user_picture') {
        const pic = e.detail.cachedFileArray[0];
        const playerPic = JSON.stringify(pic);
        console.log(playerPic);
      }
    });
  }
};

export { picUpload };
