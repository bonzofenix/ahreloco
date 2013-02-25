# pageAttr("prefix") returns the value of "data-prefix" attribute on the body
# element
window.pageAttr = (attributeName) ->
  $("body").attr("data-#{attributeName}")

$ ->
  $('programs').click ->
    $(this).toggleClass('open')

  $('.programs-btn').click ->
    $(this).parent().addClass('open')

  $('.programs').unbind('click')
  $('.program').click ->
    $(this).next().slideToggle()
