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

const initAutocompleteCityFilter = () => {
  const searchInput = document.getElementById('search_location');
  if (searchInput) {
    places({
      container: searchInput
    }).configure({
      type: 'city'
    });
  }
};

const initAutocompleteClubAddress = () => {
  const searchInput = document.getElementById('clubs-address');
  if (searchInput) {
    places({
      container: searchInput
    }).configure({
      type: 'city'
    });
  }
};

export { initAutocompleteCity };
export { initAutocompleteCityFilter };
export { initAutocompleteClubAddress };
