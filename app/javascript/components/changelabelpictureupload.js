const changeLabelValue = (event) => {
  const label = document.querySelector('.custom-file-label')
  const file = document.getElementById('user_picture').files[0]
  if (label && file) {
    label.innerHTML = file.name
  }
}

export { changeLabelValue };
