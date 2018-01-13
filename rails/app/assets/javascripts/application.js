// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery2
//= require jquery_ujs
//= require turbolinks
//= require materialize-sprockets
//= require_tree .

$(document).on('turbolinks:load', function() {
  $('#mobile-menu-btn').sideNav();
  $('.collapsible').collapsible();
  $(".dropdown-button").dropdown();
  $('ul.tabs').tabs();

  $('.toasts').children().each(function (index, toast) {
    Materialize.toast(toast, 10000, toast.className);
  });
  
  $('.materialboxed').materialbox();

  Materialize.updateTextFields();
  
  $('.approve').click(function (){
    $('.approve, .decline').hide();
    $('.approved').show('slow');
    Materialize.toast('Schadensfall genehmigt', 10000);
    return false;
  })
});
