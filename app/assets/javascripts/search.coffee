ready =->
  $("#query").focus()
  $("#query").select()

$(document).on "turbolinks:load", ready
