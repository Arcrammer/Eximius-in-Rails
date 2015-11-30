(($) ->
  $('.selfie').off('mouseover').mouseover () ->
    # Hovered over the image
    $('.selfie-plus').addClass 'selfie-plus-hover'
    $('.selfie').addClass 'higher'
    plusOverlay = $('.selfie-plus-hover')
    plusOverlay.off('mouseout').mouseout () ->
      # Hovered away from the image
      $('.selfie').removeClass 'higher'
      $('.selfie-plus').removeClass 'selfie-plus-hover'
      undefined
    plusOverlay.off('mousedown').mousedown () ->
      plusOverlay.addClass 'darker'
      undefined
    plusOverlay.off('mouseup').mouseup () ->
      plusOverlay.removeClass 'darker'
      undefined
    plusOverlay.off('click').click () ->
      $('#selfie').click()
      undefined
    undefined
) jQuery
