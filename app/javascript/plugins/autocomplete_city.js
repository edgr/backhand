import places from 'places.js';

const initAutocompleteCity = () => {
  const searchInput = document.getElementById('user_place_of_birth');
  if (searchInput) {
    places({
      container: searchInput
    }).configure({
      type: 'city'
    });
  }
};

export { initAutocompleteCity };
