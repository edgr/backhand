import places from 'places.js';

const initAutocompleteAddress = () => {
  const addressInput = document.getElementById('user_address');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocompleteAddress };
