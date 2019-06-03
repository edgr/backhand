import places from 'places.js';

const initAutocompleteCity = () => {
  const searchInput = document.getElementById('search_location');
  if (searchInput) {
    places({
      container: searchInput
    }).configure({
      type: 'city'
    });
  }
};

export { initAutocompleteCity };
