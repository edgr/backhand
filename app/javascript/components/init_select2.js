import 'select2';

const initSelectTheWinner = () => {
  $('.select-the-winner').select2 ({
    theme: "bootstrap",
    width: '100%',
    minimumResultsForSearch: Infinity
  });
};

const initSelectYourOpponent = () => {
  $('.select-your-opponent').select2 ({
    theme: "bootstrap",
    width: '100%'
  });
};

const initSelectYourClub = () => {
  $('.select-your-club').select2 ({
    theme: "bootstrap",
    width: '100%'
  });
};

const initSelectCountry = () => {
  $('.select-country').select2 ({
    theme: "bootstrap",
    width: '100%',
    placeholder: "Type in the player's country you are looking for"
  });
};

const initSelectClub = () => {
  $('.select-club').select2 ({
    theme: "bootstrap",
    width: '100%',
    placeholder: "Type in the club where you are looking for players"
  });
};

export { initSelectYourClub };
export { initSelectCountry };
export { initSelectClub };
export { initSelectYourOpponent};
export { initSelectTheWinner};
