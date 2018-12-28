ready =->
  calculateImc()
  preloadPatient()
  selectPatient()

calculateImc =->
  height = $("#medical_consultation_height")
  weight = $("#medical_consultation_weight")
  setImc(weight.val(), height.val())

  height.on "change", ->
    setImc(weight.val(), height.val())
  weight.on "change", ->
    setImc(weight.val(), height.val())

setImc = (weight, height) ->
  masa = (weight/(height**2))*10000
  $("#medical_consultation_imc").val(masa)
  setImcText()

preloadPatient =->
  patient_id = location.search.split('patient_id=')[1]
  if (patient_id)
    searchPatient patient_id

selectPatient =->
  $("#medical_consultation_patient_id").on "select2:select", ->
    searchPatient $(this).val()

searchPatient = (patient_id) ->
  $.ajax
    type: "GET",
    url: "/patients/"+patient_id+"/weight",
    success: (response) ->
      calculateImc()
    error: (err) ->
      console.log err

setImcText =->
  imc      = $("#medical_consultation_imc").val()
  imc_text = $("#imc_text")

  if (imc < 18.50)
    imc_text.html("PESO BAJO")
  else if (imc >= 18.50 && imc <= 24.99)
    imc_text.html("PESO NORMAL")
  else if (imc >= 25.00 && imc <= 29.99)
    imc_text.html("SOBREPESO")
  else if (imc >= 30.00 && imc <= 39.99)
    imc_text.html("OBESIDAD")
  else if (imc > 40.00)
    imc_text.html("OBESIDAD MÓRBIDA")
  else
    imc_text.html("NO ASIGNADO")

$(document).on "turbolinks:load", ready
