ready =->
  tabs()
  toggleButtonForTab("general")
  showNameFileUploading()

tabs =->
  $("#tabs li").on "click", ->
    tab = $(this).data 'tab'
    toggleButtonForTab(tab)

    $("#tabs li").removeClass "is-active"
    $(this).addClass "is-active"

    $("#tabs-content span").removeClass "is-active"
    $("span[data-content='" + tab + "']").addClass "is-active"

toggleButtonForTab = (tab) ->
  switch tab
    when "medical_consultations"
      $("#edit_patient_path").hide()
      $("#new_hospitalization_path").hide()
      $("#new_medical_consultation_path").show()
    when "hospitalizations"
      $("#edit_patient_path").hide()
      $("#new_medical_consultation_path").hide()
      $("#new_hospitalization_path").show()
    else
      $("#new_medical_consultation_path").hide()
      $("#new_hospitalization_path").hide()
      $("#edit_patient_path").show()

showNameFileUploading =->
  fileField = $(".file-input")

  fileField.on "change", ->
    if fileField[0].files.length
      $(".file-name").text(fileField[0].files[0].name)

$(document).on "turbolinks:load", ready
