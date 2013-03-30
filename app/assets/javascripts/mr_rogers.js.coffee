//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require jquery-fileupload
//= require datatables

$ ->
  $("a[data-remote].btn-danger").on "ajax:beforeSend", (xhr) ->
    $(this).closest('li').fadeOut()

  $("a[data-remote].btn-danger").on "ajax:success", (e, data, status, xhr) ->
    alert "Deleted."
    
  $('#uploadPhotosModal').on "hidden", () ->
    alert('Refresh photo list')

  $('.banner').on 'click', ->
    $(this).addClass('hide')
    $(this).siblings('.unbanner').removeClass('hide')
    
  $('.unbanner').on 'click', ->
    $(this).addClass('hide')
    $(this).siblings('.banner').removeClass('hide')
    
  $('.feature').on 'click', ->
    $(this).addClass('hide')
    $(this).siblings('.unfeature').removeClass('hide')

  $('.unfeature').on 'click', ->
    $(this).addClass('hide')
    $(this).siblings('.feature').removeClass('hide')