import noUiSlider from "nouislider";

const slider = document.getElementById('level-slider');

const startSlider = () => {
  if (slider) {
    noUiSlider.create(slider, {
        start: [400, 2000],
        connect: true,
        range: {
            'min': 0,
            'max': 2400
        }
    });
    slider.noUiSlider.on('update', (event) => {
      console.log(slider.noUiSlider.get())
    })
  }
}

export { startSlider }
