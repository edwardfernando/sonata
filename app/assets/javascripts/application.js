// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require turbolinks
//= require_tree .
//= require bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.id.js

  $(function () {
      $("[rel='tooltip']").tooltip();
  });

  $(function() {
    $( ".datepicker-field" ).datepicker({
      language: "id",
      format: "yyyy-mm-dd",
      todayBtn: "linked",
      orientation: "top auto",
      calendarWeeks: true,
      autoclose: true,
      todayHighlight: true
    });
  });

  function pop(url) {
    w = 600;
    h = 600;
    wLeft = window.screenLeft ? window.screenLeft : window.screenX;
    wTop = window.screenTop ? window.screenTop : window.screenY;

    var left = wLeft + (window.innerWidth / 2) - (w / 2);
    var top = wTop + (window.innerHeight / 2) - (h / 2);

    window.open(url, "Sonata", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
  }

  function choose(n, t, id, text){
    window.opener.document.getElementById(n + '-id-' + t).value = id;
    window.opener.document.getElementById(n + '-text-' + t).innerHTML = text;
    window.close();
  }

  function getUrlParameter(sParam){
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++){
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam){
            return sParameterName[1];
        }
    }

    return 'undefined';
  }
