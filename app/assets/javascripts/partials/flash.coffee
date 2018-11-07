ready =->
  $(".delete").click ->
    $("#flash").remove()

$(document).on "turbolinks:load", ready
