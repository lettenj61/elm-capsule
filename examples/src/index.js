import { Elm } from './KitchenSink.elm'

window.addEventListener('DOMContentLoaded', () => {
  const app = Elm.KitchenSink.init({
    node: document.getElementById('elm')
  })
})
