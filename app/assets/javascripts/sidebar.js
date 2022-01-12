$(document).on("turbolinks:load", function () {
  $("#patient_id").on("select2:select", function (event) {
    window.location.href = `/appoinments/new?patient_id=${event.target.value}`;
  });
});
