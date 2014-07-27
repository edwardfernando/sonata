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
//= require fullcalendar


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

  // Reset person id and text each time user change role
  if(n == 'role'){
    window.opener.document.getElementById('person-id-' + t).value = "";
    window.opener.document.getElementById('person-text-' + t).innerHTML = "";
  }

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

  return false;
}

function isValidDate(d) {
  if ( Object.prototype.toString.call(d) !== "[object Date]" )
    return false;
  return !isNaN(d.getTime());
}

function getValidDateParam(){
  var param = getUrlParameter('date');
  if(!param || param == ''){
    param = new Date();
  }

  var dateParam = new Date(param) == 'Invalid Date' ? new Date() : new Date(param);
  return dateParam;
}

// Based on solution found at : http://stackoverflow.com/questions/18770517/rails-4-how-to-use-document-ready-with-turbo-links
var ready = function(){

  // Source : https://gist.github.com/Genkilabs/bdcc5f62c5b46a8e0904
  $.rails.allowAction = function(link){
		if( !link.is('[data-confirm]') )
			return true;
		BootstrapDialog.show({
			type: BootstrapDialog.TYPE_DANGER,
			title: 'Confirm',
			message: link.attr('data-confirm'),
			buttons: [{
				label: 'Accept',
				cssClass: 'btn-primary',
				action: function(dialogRef){
					link.removeAttr('data-confirm');
					link.trigger('click.rails');
					dialogRef.close();
				}
			}, {
				label: 'Cancel',
				action: function(dialogRef){
					dialogRef.close();
				}
			}]
		});
		return false; // always stops the action since code runs asynchronously
	};


  $(function(){
    $("#calendar").fullCalendar({
      events: '/services.json',
  		eventClick: function(calEvent, jsEvent, view) {
        $('.modal-body').load('/services/' + calEvent.id + ".json", function(result){
            var json = JSON.parse(result);

            $("#detail-service-modal-dialog-edit-link").attr("href", "/services/" + json.id + "/edit");
            $("#detail-service-modal-dialog-view-link").attr("href", "/services/" + json.id);
            $("#detail-service-modal-dialog-title").html(json.name + " / " + json.date);
            $("#detail-service-modal-dialog-body").html(json.description);

      	    $('#detail-service-modal-dialog').modal({show:true});
      	});
  		},
      eventRender: function(event, element) {
        element.css('cursor', 'pointer');
      }
    })
  });

  // All codes below are related to date picker
  $(function(){
    var dateParam = getValidDateParam();

    $('.inline-date-picker').datepicker({
      todayHighlight: true,
      language: "id",
      calendarWeeks: true,
      beforeShowDay: function(date){

        if(getUrlParameter('date')){ //to prevent preselect date for 'today' date
          if (date.getMonth() == dateParam.getMonth()){
            switch(date.getDate()){
            case dateParam.getDate():
              return{
                classes: 'active'
              }
            }
          }
        }

      }
      }).on('changeDate', function(e){
        window.location = '?date=' + $.datepicker.formatDate('yy-mm-dd', e.date) ;
      }).datepicker('update', dateParam);

  });
  // End date picker code

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
};


$(document).ready(ready);
$(document).on('page:load', ready);
