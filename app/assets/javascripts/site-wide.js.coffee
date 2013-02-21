# pageAttr("prefix") returns the value of "data-prefix" attribute on the body
# element
window.pageAttr = (attributeName) ->
  $("body").attr("data-#{attributeName}")
