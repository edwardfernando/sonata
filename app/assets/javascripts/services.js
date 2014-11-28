$(function() {
  $(document).on("click", ".js-show-service-delete", function() {
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
