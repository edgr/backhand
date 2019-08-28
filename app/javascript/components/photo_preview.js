const photoPreview = () => {
  const uploadInput = document.querySelector(".custom-file-input");
  const edit = document.getElementById("edit-photo-form");
  const imagePreview = document.querySelector(".imagePreview");
  if (edit) {
    imagePreview.style.backgroundImage = `url(${imagePreview.dataset.picture})`
  }
  if (uploadInput) {
    uploadInput.addEventListener('change', () => {
      const fReader = new FileReader();
      fReader.readAsDataURL(uploadInput.files[0]);
      fReader.addEventListener('loadend', (event) => {
        imagePreview.style.backgroundImage = `url("${event.target.result}")`;
      });
    });
  }
}

export { photoPreview }
