//= require select2

import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
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
import { initSelectYourPartners } from '../components/init_select2';
import { initSelectTheWinner } from '../components/init_select2';
import '../plugins/intl';
import { selectOpponent } from '../components/select_opponent';
import { selectSets } from '../components/select_sets';
import { reviewSteps } from '../components/review_steps';
import { selectSkillValue } from '../components/skills_rating';
import { photoPreview } from '../components/photo_preview';
import { addPlayer } from '../components/new_event';
import { welcomeRedirect } from '../components/redirect';
import { showTrash } from '../components/event_actions';
import { openActions } from '../components/actions_button';
import { copyLink } from '../components/copy_to_clipboard';
import { initMapbox } from '../plugins/init_mapbox';
import { initMapboxClubShow } from '../plugins/init_mapbox_club_show';
import { verifyPhoto } from '../components/verifyPhoto';
// import { triggerShare } from '../components/share_profile';

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
initSelectYourPartners();
initSelectTheWinner();
selectOpponent();
selectSets();
reviewSteps();
selectSkillValue();
photoPreview();
addPlayer();
welcomeRedirect();
showTrash();
openActions();
copyLink();
initMapbox();
initMapboxClubShow();
verifyPhoto();

// triggerShare();
