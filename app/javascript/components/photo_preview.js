const imagePreview = document.querySelector(".imagePreview");
const imageAngle = document.getElementById("user_angle");

const getOrientation = (file, callback) => {
  const reader = new FileReader();
  reader.addEventListener ('load', (e) => {
    const view = new DataView(e.target.result);
    if (view.getUint16(0, false) != 0xFFD8) {
      return callback(-2);
    }
    const length = view.byteLength;
    let offset = 2;
    while (offset < length) {
      if (view.getUint16(offset+2, false) <= 8) return callback(-1);
      const marker = view.getUint16(offset, false);
      offset += 2;
      if (marker == 0xFFE1) {
        if (view.getUint32(offset += 2, false) != 0x45786966) return callback(-1);
        const little = view.getUint16(offset += 6, false) == 0x4949;
        offset += view.getUint32(offset + 4, little);
        const tags = view.getUint16(offset, little);
        offset += 2;
        for (let i = 0; i < tags; i++) {
          if (view.getUint16(offset + (i * 12), little) == 0x0112) {
            return callback(view.getUint16(offset + (i * 12) + 8, little));
          }
        }
      } else if ((marker & 0xFF00) != 0xFF00) {
        break;
      } else {
        offset += view.getUint16(offset, false);
      }
    }
    return callback(-1);
  });
  reader.readAsArrayBuffer(file);
}

const convertRotationToDegrees = (number) => {
  let rotationInDegrees = 0;
  switch (number) {
    case 8:
      rotationInDegrees = 270;
      break;
    case 6:
      rotationInDegrees = 90;
      break;
    case 3:
      rotationInDegrees = 180;
      break;
    default:
      rotationInDegrees = 0;
  }
  imageAngle.value = rotationInDegrees;
  imagePreview.setAttribute('style',`transform:rotate(${rotationInDegrees}deg)`);
}

const photoPreview = () => {
  const uploadInput = document.querySelector(".custom-file-input");
  const edit = document.getElementById("edit-photo-form");
  if (edit) {
    imagePreview.src = imagePreview.dataset.picture
  }
  if (uploadInput) {
    uploadInput.addEventListener('change', () => {
      const fReader = new FileReader();
      fReader.readAsDataURL(uploadInput.files[0]);
      fReader.addEventListener('loadend', (event) => {
        imagePreview.src = event.target.result;
        getOrientation(uploadInput.files[0], (orientation) => {
          convertRotationToDegrees(orientation);
        });

      });
    });
  }
}

export { photoPreview }
