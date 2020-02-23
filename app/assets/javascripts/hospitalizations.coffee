ready =->
  $("#hospitalization_starting").on "change", ->
    daysOfDiff()

  $("#hospitalization_ending").on "change", ->
    daysOfDiff()

daysOfDiff =->
  starting = new Date($("#hospitalization_starting").val()).getTime()
  ending = new Date($("#hospitalization_ending").val()).getTime()
  diff = ((ending - starting)/(1000*60*60*24))
  $("#hospitalization_days_of_stay").val(diff)

$(document).on "turbolinks:load", ready
