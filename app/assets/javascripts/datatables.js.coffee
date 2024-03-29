$ ->
  load_datatable = ->
    $('.datatable').dataTable({
      sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>"
      sPaginationType: "bootstrap"
      bProcessing: true
      bServerSide: true
      sAjaxSource: $('.table').data('source')
      aoColumns: [{ "sWidth": "5%" }, null, null, { "sWidth": "5%" }, { "sWidth": "5%" }]
    })

  $(document).ready(load_datatable)
  $(document).on('page:load', load_datatable)