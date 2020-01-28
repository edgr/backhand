const step3Submit = document.getElementById('step3-submit')

const verifyPhoto = () => {
  if (step3Submit) {
    step3Submit.addEventListener('click', event => {
      const image = document.querySelector('.imagePreview').style.backgroundImage
      if (image === "") {
        event.preventDefault();
        const alert = document.querySelector('.please-photo').innerText
        swal(alert)
      }
    })
  }
}

export { verifyPhoto };
