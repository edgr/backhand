import "bootstrap";
import { addListener } from "../components/tabs";

const tabs = document.querySelectorAll(".tab-underlined");
if (tabs) { tabs.forEach(addListener) };
