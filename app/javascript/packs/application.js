import "bootstrap";
import { addListener } from "../components/tabs";
import { initAutocompleteAddress } from '../plugins/init_autocomplete';
import { initAutocompleteCity } from '../plugins/autocomplete_city';

const tabs = document.querySelectorAll(".tab-underlined");
if (tabs) { tabs.forEach(addListener) };

initAutocompleteAddress();
initAutocompleteCity();
