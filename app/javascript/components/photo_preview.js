const photoPreview = () => {
  const uploadInput = document.querySelector(".custom-file-input");
  const editInput = document.querySelector(".edit-file-input");
  const imagePreview = document.querySelector(".imagePreview");
  if (uploadInput) {
    uploadInput.addEventListener('change', () => {
      const fReader = new FileReader();
      fReader.readAsDataURL(uploadInput.files[0]);
      fReader.addEventListener('loadend', (event) => {
        imagePreview.style.backgroundImage = `url("${event.target.result}")`;
      });
    });
  } else if (editInput) {
    imagePreview.style.backgroundImage = `url(${imagePreview.dataset.picture})`
    editInput.addEventListener('change', () => {
      const fReader = new FileReader();
      fReader.readAsDataURL(editInput.files[0]);
      fReader.addEventListener('loadend', (event) => {
        imagePreview.style.backgroundImage = `url("${event.target.result}")`;
      });
    });
  }
}

export { photoPreview }
