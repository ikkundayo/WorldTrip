// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
/*global $*/

import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"

require('packs/raty')

Rails.start()
// Turbolinks.start()
ActiveStorage.start()

window.$ = window.jQuery = require('jquery');

import Swiper from 'swiper/swiper-bundle.min'
import 'swiper/swiper.min'

$(document).ready(function() {
  new Swiper('.swiper', {
    loop: true,
    speed: 2800,
    effect: 'fade',
    autoplay: {
      delay: 5500
    }
  })
})

