function tabs() {
  $("#tabs li").on("click", function () {
    var tab = $(this).attr("data-tab");
    toggleButtonForTab(tab);
    $("#tabs li").removeClass("is-active");
    $(this).addClass("is-active");

    $("#tabs-content span").removeClass("is-active");
    $("span[data-content='" + tab + "']").addClass("is-active");
  });
}

function toggleButtonForTab(tab) {
  if (tab === "appoinments") {
    $("#edit_patient_path").hide();
    $("#new_hospitalization_path").hide();
    $("#new_appoinment_path").show();
  } else if (tab === "hospitalizations") {
    $("#edit_patient_path").hide();
    $("#new_appoinment_path").hide();
    $("#new_hospitalization_path").show();
  } else {
    $("#new_appoinment_path").hide();
    $("#new_hospitalization_path").hide();
    $("#edit_patient_path").show();
  }
}

function showNameFileUploading() {
  $(".file-input").on("change", function () {
    if (!fileField[0].files.length) {
      return;
    }
    $(".file-name").text(fileField[0].files[0].name);
  });
}

function patientsReady() {
  tabs();
  toggleButtonForTab("general");
  showNameFileUploading();
}

$(document).on("turbolinks:load", patientsReady);
