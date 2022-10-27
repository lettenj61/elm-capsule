import "bulma/css/bulma.min.css";
import { Elm } from "./KitchenSink.elm";

window.addEventListener("DOMContentLoaded", () => {
  const app = Elm.KitchenSink.init({
    node: document.getElementById("elm"),
  });
});
