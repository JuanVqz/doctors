ready =->
  $("#patient_id").on "select2:select", ->
    window.location.href = "/patients/"+$("#patient_id").val()

$(document).on "turbolinks:load", ready
