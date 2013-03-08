//= require jquery-fileupload

$ ->
  $("a[data-remote]").on "click", () ->
    $(this).closest('li').fadeOut()
  $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    alert "Deleted."
    