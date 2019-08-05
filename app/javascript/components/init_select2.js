import 'select2';

const initSelectYourClub = () => {
  $('.select-your-club').select2 ({
    theme: "bootstrap",
    width: '100%',
    placeholder: "If your club is not listed, let us know!",
    allowClear: true,
  });
};

const initSelectCountry = () => {
  $('.select-country').select2 ({
    theme: "bootstrap",
    width: '100%',
    placeholder: "Type in the country you are looking for",
    allowClear: true,
  });
};

const initSelectClub = () => {
  $('.select-club').select2 ({
    theme: "bootstrap",
    width: '100%',
    placeholder: "Type in the club you are looking for",
    allowClear: true,
  });
};

export { initSelectYourClub };
export { initSelectCountry };
export { initSelectClub };
