# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
#
$(document).ready ->
  $(document).mousemove (event) ->
    TweenLite.to $("body"), .5,
      css:
        backgroundPosition: "" + parseInt(event.pageX / 8) + "px " + parseInt(event.pageY / "12") + "px, " + parseInt(event.pageX / "15") + "px " + parseInt(event.pageY / "15") + "px, " + parseInt(event.pageX / "30") + "px " + parseInt(event.pageY / "30") + "px"
        "background-position": parseInt(event.pageX / 8) + "px " + parseInt(event.pageY / 12) + "px, " + parseInt(event.pageX / 15) + "px " + parseInt(event.pageY / 15) + "px, " + parseInt(event.pageX / 30) + "px " + parseInt(event.pageY / 30) + "px"

    return

  return
