const step3Submit = document.getElementById('step3-submit')

const verifyPhoto = () => {
  if (step3Submit) {
    step3Submit.addEventListener('click', event => {
      const image = document.querySelector('.imagePreview').style.backgroundImage
      if (image === "") {
        event.preventDefault();
        swal('A profile picture is mandatory :)')
      }
    })
  }
}

export { verifyPhoto };
