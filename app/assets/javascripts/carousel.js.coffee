$ ->
  load_carousel = ->
    $('#splashCarousel .item:first-child').addClass('active')
    $('#splashCarousel').carousel({interval: 5000})

  $(document).ready(load_carousel)
  $(document).on('page:load', load_carousel)
