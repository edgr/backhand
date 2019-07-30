const label = document.querySelector('.custom-file-label');

const changeLabelValue = () => {
  if (label) {
    const file = document.getElementById('user_picture');
    file.addEventListener('change', () => {
      label.innerHTML = file.files[0].name
    });
  }
}

export { changeLabelValue };
