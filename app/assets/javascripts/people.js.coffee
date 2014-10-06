# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".person_level_text").click ->
    $("#available-access-level-dialog").modal show: true
    person_id = $(this).attr("person-id")
    $("#available-access-level-dialog-confirm").attr("href", $(this).attr("href")).attr "data-method", "post"
    $.get "/people/" + person_id + ".json", (result) ->
      $("#person_level_combobox").val(result.role).change ->
        url = "/people/" + person_id + "/level/" + $(this).val()
        $("#available-access-level-dialog-confirm").attr("href", url).attr "data-method", "post"
        return

      return

    false

  return
