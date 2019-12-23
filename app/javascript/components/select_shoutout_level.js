import noUiSlider from "nouislider";
import wNumb from "wnumb";

const slider = document.getElementById('level-slider');
const minLevel = document.getElementById('shoutout_minimum_level');
const maxLevel = document.getElementById('shoutout_maximum_level');

const startSlider = () => {
  if (slider) {
    noUiSlider.create(slider, {
        start: [400, 2000],
        connect: true,
        behaviour: 'drag',
        margin: 600,
        limit: 1200,
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
      minLevel.value = slider.noUiSlider.get()[0]
      maxLevel.value = slider.noUiSlider.get()[1]
    })
  }
}

export { startSlider }
