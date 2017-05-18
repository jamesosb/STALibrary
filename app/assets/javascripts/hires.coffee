# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
# Configure infinite table
  $('.results').infinitePages
# debug: true
    loading: ->
      $(this).text('Loading more children...')
    error: ->
      $(this).button('There was an error, please try again')


####### Fix window on scroll #######

jQuery ($) ->

fixDiv = ->

  $cache = $('#signpost-box')
  $youbox = $('.you-box')
  $centreboxes = $('.centre-boxes:first')
  if $(window).scrollTop() > 50
    $cache.css
      'position': 'fixed'
      'width': '100%'
      'margin-top': 'auto'
    $youbox.css
      'margin-top': '100px'
  else
    $cache.css
      'position': 'relative'
      'margin-top': '50px'
    $youbox.css
      'margin-top': '-50px'

  return

$(window).scroll fixDiv
fixDiv()
return