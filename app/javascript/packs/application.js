import "bootstrap";
import { addListener } from "../components/tabs";
import { initAutocompleteAddress } from '../plugins/autocomplete_address';
import { initAutocompleteCity } from '../plugins/autocomplete_city';
import { autoLoserSelection } from '../components/autoLoserSelection';
import "../plugins/flatpickr";

const tabs = document.querySelectorAll(".tab-underlined");
if (tabs) { tabs.forEach(addListener) };

initAutocompleteAddress();
initAutocompleteCity();
autoLoserSelection();
