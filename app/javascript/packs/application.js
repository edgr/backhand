//= require select2

import "bootstrap";
import { addListener } from "../components/tabs";
import { initAutocompleteAddress } from '../plugins/autocomplete_address';
import { initAutocompleteCity } from '../plugins/autocomplete_city';
import { autoLoserSelection } from '../components/autoLoserSelection';
import "../plugins/flatpickr";
import "../plugins/google_analytics";
import { initSelect2 } from '../components/init_select2';
import '../plugins/intl';
import { changeLabelValue } from '../components/changelabelpictureupload';
import { onChange } from '../components/select_winner';

const tabs = document.querySelectorAll(".tab-underlined");
if (tabs) { tabs.forEach(addListener) };

initAutocompleteAddress();
initAutocompleteCity();
autoLoserSelection();
initSelect2();
changeLabelValue();
onChange();
