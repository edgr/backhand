import noUiSlider from "nouislider";
import wNumb from "wnumb";

const slider = document.getElementById('level-slider');

const startSlider = () => {
  if (slider) {
    noUiSlider.create(slider, {
        start: [400, 2000],
        connect: true,
        step: 50,
        tooltips: true,
        format: wNumb({
            decimals: 0
        }),
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
