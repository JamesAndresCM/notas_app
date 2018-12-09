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
//= require jquery
//= require jquery-ui
//= require rails-ujs
//= require popper
//= require bootstrap-sprockets
//= require turbolinks
//= require gritter
//= require moment
//= require moment/es.js
//= require tempusdominus-bootstrap-4.js
//= require rails.validations
//= require rails.validations.simple_form
//= require validations.coffee
//= require activestorage
//= require jquery.mCustomScrollbar.concat.min
//= require bootstrap-sweetalert
//= require sweet-alert-confirm
//= require rails-timeago-all
//= require locales/jquery.timeago.es.js
//= require daterangepicker
//= require_tree .

$(document).on('turbolinks:load', function() {

    //scroll inside site
    var btn = $('#button-scroll');
    $(window).scroll(function() {
      if ($(window).scrollTop() > 300) {
        btn.addClass('show');
      } else {
        btn.removeClass('show');
      }
    });

    btn.on('click', function(e) {
      e.preventDefault();
      $('html, body').animate({scrollTop:0}, '300');
    });


    //scroll index
    var offset = 200;
    var duration = 500;
    $(window).scroll(function() {
      if ($(this).scrollTop() > offset) {
        $('.back-to-top').fadeIn(400);
      } else {
        $('.back-to-top').fadeOut(400);
      }
    });

    $('.back-to-top').click(function(event) {
      event.preventDefault();
      $('html, body').animate({
        scrollTop: 0
      }, 600);
      return false;
    })

    $("#sidebar").mCustomScrollbar({
                theme: "minimal",
                scrollInertia:300
      });
      $('#sidebarCollapse').on('click', function () {
          $('#sidebar, #content').toggleClass('active');
          $('.collapse.in').toggleClass('in');
          $('a[aria-expanded=true]').attr('aria-expanded', 'false');
      });
});

