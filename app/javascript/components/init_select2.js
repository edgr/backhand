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

const initSelectYourPartners = () => {
  $('.select-your-partners').select2 ({
    theme: "bootstrap",
    width: '100%'
  });
};

const initSelectYourClub = () => {
  $('#user_club_id').select2 ({
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
  });
};

export { initSelectYourClub };
export { initSelectCountry };
export { initSelectClub };
export { initSelectYourOpponent};
export { initSelectYourPartners};
export { initSelectTheWinner};
