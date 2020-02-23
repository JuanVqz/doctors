ready =->
  $("#patient_id").on "select2:select", ->
    window.location.href = "/appoinments/new?patient_id="+$("#patient_id").val()

$(document).on "turbolinks:load", ready
