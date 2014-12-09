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
        body.append('<li><label><input type="checkbox" class="person_with_same_skillsets_cb" name="person_with_same_skillsets_cb[]" value='+ each.id +'> '+ each.name +'</label></li>');
      });
    });

  }).on("click", ".js-propose-change-schedule-button", function() {

    var service_id = $("#current-schedule-id").val();
    var schedule_id = $("#current-person-schedule-id").val();
    var array = [];

    $.each($(".person_with_same_skillsets_cb"), function(index, value) {
      if(value.checked){
        array.push(value.value);
      }
    });

    $.post("/services/" + service_id + "/schedules/propose_change_schedule/" + schedule_id + ".json", { 'person_with_same_skillsets_cb[]': array })
      .done(function( data ) {
        alert( "Data Loaded: " + data );
      }
    );
    console.log(array);

  }).on("click", ".js-show-service-delete", function() {
    var url = $(this).attr("service-url");

    BootstrapDialog.confirm('Are you sure to delete this Service?', function(result){
      if(result){
        $.ajax({
          url: url ,
          type: "DELETE",
          data: {"_method":"delete"}
        });

        window.location.href = "/services";
      }
    });

    return false;
  });

});
