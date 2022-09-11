function daysOfDiff() {
  var starting = new Date($("#hospitalization_starting").val()).getTime();
  var ending = new Date($("#hospitalization_ending").val()).getTime();
  var diff = (ending - starting) / (1000 * 60 * 60 * 24);
  $("#hospitalization_days_of_stay").val(diff);
}

function hospitalizationsReady() {
  $("#hospitalization_starting").on("change", function () {
    daysOfDiff();
  });

  $("#hospitalization_ending").on("change", function () {
    daysOfDiff();
  });
}
$(document).on("turbolinks:load", hospitalizationsReady);
