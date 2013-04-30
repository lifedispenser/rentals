$ ->
  load_js = ->
    load_tooltips()
    load_datepicker()

  load_tooltips = ->
    $('#rental-details .icon').tooltip()

  load_datepicker = ->
    startDate = new Date(9011,1,20)
    endDate = new Date(9012,1,25)
    $('#contact_from').datepicker().on('changeDate', (ev)->
      if (ev.date.valueOf() > endDate.valueOf())
        $('#alert').show().find('strong').text('The start date must be before the end date.')
      else
        $('#alert').hide()
        startDate = new Date(ev.date)

      $('#contact_from').datepicker('hide')
    )

    $('#contact_to').datepicker().on('changeDate', (ev)->
      if (ev.date.valueOf() < startDate.valueOf())
        $('#alert').show().find('strong').text('The end date must be after the start date.')
      else
        $('#alert').hide()
        endDate = new Date(ev.date)

      $('#contact_to').datepicker('hide')
    )
  $(document).ready(load_js)
  $(document).on('page:load', load_js)


