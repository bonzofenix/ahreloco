# pageAttr("prefix") returns the value of "data-prefix" attribute on the body
# element
window.pageAttr = (attributeName) ->
  $("body").attr("data-#{attributeName}")

$ ->
  $('.programs-btn').click ->
    $(this).parent().toggleClass('open')
    $('.programs .channels').hide()

  $('.programs').unbind('click')
  $('.program').click ->
    $(this).next().slideToggle()

  $('.flexslider').flexslider
    animation: "slide"
    controlNav: "thumbnails"
  
