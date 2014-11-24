$(function() {
  $(document).on("click", "#propose-change-schedule-link", function() {
    $("#propose-change-schedule-modal").modal({
      show: true
    });

    var service_id = $("#current-schedule-id").val();
    var schedule_id = $("#current-person-schedule-id").val();
    var body = $('.person_with_same_skillsets').empty();

    $.get("/services/" + service_id + "/schedules/propose_change_schedule/" + schedule_id + ".json", function(result) {
      $("#schedule-role-type").html(result.requested_role);

      result.person_with_same_skillsets.forEach(function(each){
        body.append('<li><label><input type="checkbox" class="person_with_same_skillsets" name="person_with_same_skillsets[]" value='+ each.id +'> '+ each.name +'</label></li>');
      });
    });

  });

  $(document).on("click", ".js-propose-change-schedule-button", function() {
  



  });



});
