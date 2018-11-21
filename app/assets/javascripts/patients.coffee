ready =->
  tabs()

tabs =->
  $("#tabs li").on "click", ->
    tab = $(this).data 'tab'

    $("#tabs li").removeClass "is-active"
    $(this).addClass "is-active"

    $("#tabs-content span").removeClass "is-active"
    $("span[data-content='" + tab + "']").addClass "is-active"

$(document).on "turbolinks:load", ready
