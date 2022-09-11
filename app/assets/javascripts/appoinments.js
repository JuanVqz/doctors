function calculateImc() {
  var height = $("#appoinment_height");
  var weight = $("#appoinment_weight");
  setImc(weight.val(), height.val());

  height.on("change", function () {
    setImc(weight.val(), height.val());
  });
  weight.on("change", function () {
    setImc(weight.val(), height.val());
  });
}

function setImc(weight, height) {
  var masa = parseFloat((weight / height ** 2) * 10000).toFixed(2);
  $("#appoinment_imc").val(masa);
  setImcText();
}

function preloadPatient() {
  var url = new URL(window.location.href);
  if (!url.searchParams.get("patient_id")) {
    return;
  }
  searchPatient(parseInt(location.search.split("patient_id=")[1]));
}

function selectPatient() {
  $("#appoinment_patient_id").on("select2:select", function () {
    searchPatient($(this).val());
  });
}

function searchPatient(patient_id) {
  $.ajax({
    type: "GET",
    url: `/patients/${patient_id}/appoinments`,
    success: function () {
      calculateImc();
    },
  });
}

function setImcText() {
  var imc = $("#appoinment_imc").val();
  var imc_text = $("#imc_text");

  if (imc < 18.5) {
    imc_text.html("PESO BAJO");
  } else if (imc >= 18.5 && imc <= 24.99) {
    imc_text.html("PESO NORMAL");
  } else if (imc >= 25.0 && imc <= 29.99) {
    imc_text.html("SOBREPESO");
  } else if (imc >= 30.0 && imc <= 39.99) {
    imc_text.html("OBESIDAD");
  } else if (imc > 40.0) {
    imc_text.html("OBESIDAD MÓRBIDA");
  } else {
    imc_text.html("NO ASIGNADO");
  }
}

function appoinmentsReady() {
  calculateImc();
  preloadPatient();
  selectPatient();
}

$(document).on("turbolinks:load", appoinmentsReady);
