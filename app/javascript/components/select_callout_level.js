import noUiSlider from "nouislider";
import wNumb from "wnumb";

const slider = document.getElementById('level-slider');
const minLevel = document.getElementById('callout_minimum_level');
const maxLevel = document.getElementById('callout_maximum_level');

const startSlider = () => {
  if (slider) {
    noUiSlider.create(slider, {
        start: [600, 1800],
        connect: true,
        behaviour: 'drag',
        padding: [50, 50],
        margin: 200,
        limit: 1200,
        step: 50,
        tooltips: true,
        format: wNumb({
            decimals: 0
        }),
        range: {
            'min': -50,
            'max': 2450
        }
    });
    slider.noUiSlider.on('update', (event) => {
      minLevel.value = slider.noUiSlider.get()[0]
      maxLevel.value = slider.noUiSlider.get()[1]
    })
  }
}

export { startSlider }
