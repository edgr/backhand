import places from 'places.js';

const initAutocompleteAddress = () => {
  const cityInput = document.getElementById('user_address');
  if (cityInput) {
    places({
      container: cityInput
    }).configure({
      type: 'city'
    });
  }
};

export { initAutocompleteAddress };
