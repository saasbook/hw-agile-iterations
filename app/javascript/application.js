/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_include_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import '@hotwired/turbo-rails';
import $ from 'jquery';
import 'timeago';
import 'select2';
import * as bootstrap from 'bootstrap';

// Expose globals after imports
window.jQuery = $;
window.$ = $;
window.bootstrap = bootstrap;

// Use fontawesome icons improve page visuals
// require('@fortawesome/fontawesome-free/css/all.css');

$(document).on('turbo:load', () => {
  jQuery.timeago.settings.allowPast = true;
  jQuery.timeago.settings.allowFuture = true;
  $('time.timeago').timeago();
  $('.actionmap-select2').select2({
    theme: 'bootstrap',
  });
});
