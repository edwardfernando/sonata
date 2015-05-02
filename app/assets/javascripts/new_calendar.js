(function($) {

	"use strict";

	var options = {
		events_source: '/services/show_new_calendar.json',
		view: 'month',
		tmpl_path: '/tmpls/',
		tmpl_cache: false,
		day: moment(new Date()).format('YYYY-MM-DD'),
		onAfterEventsLoad: function(events) {
			if(!events) {
				return;
			}
			var list = $('#eventlist');
			list.html('');

			$.each(events, function(key, val) {
				$(document.createElement('li'))
					.html('<a href="' + val.url + '">' + val.title + '</a>')
					.appendTo(list);
			});
		},
		onAfterViewLoad: function(view) {
			$('.page-header h3').text(this.getTitle());
			$('.btn-group button').removeClass('active');
			$('button[data-calendar-view="' + view + '"]').addClass('active');
		},
		classes: {
			months: {
				general: 'label'
			}
		}
	};


	// Question: How to disable "single day" (daily) mode? #454
	// https://github.com/Serhioromano/bootstrap-calendar/issues/454
	function unbindClicks(){
		$('*[data-cal-date]').unbind("click");
		$('.cal-cell').unbind("dblclick");
	}

	var ready = function(){

		var calendar = $('#calendar_new').calendar(options);

		unbindClicks();

		$('.btn-group button[data-calendar-nav]').each(function() {
			var $this = $(this);
			$this.click(function() {
				calendar.navigate($this.data('calendar-nav'));
				unbindClicks();
			});
		});

		$('.btn-group button[data-calendar-view]').each(function() {
			var $this = $(this);
			$this.click(function() {
				calendar.view($this.data('calendar-view'));
			});
		});

		$('#first_day').change(function(){
			var value = $(this).val();
			value = value.length ? parseInt(value) : null;
			calendar.setOptions({first_day: value});
			calendar.view();
		});

		$('#language').change(function(){
			calendar.setLanguage($(this).val());
			calendar.view();
		});

		$('#events-in-modal').change(function(){
			var val = $(this).is(':checked') ? $(this).val() : null;
			calendar.setOptions({modal: val});
		});
		$('#events-modal .modal-header, #events-modal .modal-footer').click(function(e){
			//e.preventDefault();
			//e.stopPropagation();
		});

	};


	$(document).ready(ready);
	$(document).on('page:load', ready);


}(jQuery));
