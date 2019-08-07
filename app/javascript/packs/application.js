//= require select2

import "bootstrap";
import { addListener } from "../components/tabs";
import { initAutocompleteAddress } from '../plugins/autocomplete_address';
import { initAutocompleteCity } from '../plugins/autocomplete_city';
import { initAutocompleteCityFilter } from '../plugins/autocomplete_city';
import { autoLoserSelection } from '../components/autoLoserSelection';
import "../plugins/flatpickr";
import "../plugins/google_analytics";
import { initSelectYourClub } from '../components/init_select2';
import { initSelectCountry } from '../components/init_select2';
import { initSelectClub } from '../components/init_select2';
import { initSelectYourOpponent } from '../components/init_select2';
import '../plugins/intl';
import { changeLabelValue } from '../components/changelabelpictureupload';
import { onChange } from '../components/select_winner';
import { selectSets } from '../components/select_sets';

const tabs = document.querySelectorAll(".tab-underlined");
if (tabs) { tabs.forEach(addListener) };

initAutocompleteAddress();
initAutocompleteCity();
initAutocompleteCityFilter();
autoLoserSelection();
initSelectYourClub();
initSelectCountry();
initSelectClub();
initSelectYourOpponent();
changeLabelValue();
onChange();
selectSets();
