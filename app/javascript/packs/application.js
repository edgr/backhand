import "bootstrap";
import { addListener } from "../components/tabs";
import { initAutocompleteAddress } from '../plugins/autocomplete_address';
import { initAutocompleteCity } from '../plugins/autocomplete_city';
import { autoLoserSelection } from '../components/autoLoserSelection';
import "../plugins/flatpickr";
import 'select2/dist/css/select2.css';
import { initSelect2 } from '../components/init_select2';

const tabs = document.querySelectorAll(".tab-underlined");
if (tabs) { tabs.forEach(addListener) };

initAutocompleteAddress();
initAutocompleteCity();
autoLoserSelection();
initSelect2();
