const label = document.querySelector('.custom-file-label');

const changeLabelValue = () => {
  if (label) {
    // const input = document.querySelector('custom-file-input')
    const file = document.getElementById('user_picture');
    file.addEventListener('change', () => {
      label.innerHTML = file.files[0].name
    });
  }
}

// const changeLabelValue = (event) => {
//   const label = document.querySelector('.custom-file-label')
//   const file = document.getElementById('user_picture').files[0]
//   if (label && file) {
//     label.innerHTML = file.name
//   }
// }

export { changeLabelValue };
