$ ->
  add_comment = (comment)->
    $('.comments').prepend "<div class='comment'>
      <a href='#{Routes.user_path(comment.username)}'>
      <b>#{comment.username}</b>
      </a>
      <p>#{comment.content}
      <em class='muted'>Hace #{comment.time_ago}</em>
      </p>
      </div>"

  if $('.comments').length
    video_id = pageAttr('video-id')
    $.getJSON Routes.comments_path(video_id: video_id), (comments) ->
      for comment in comments
        add_comment comment

  $('.new_comment .btn').click ->
        
    content = $('#message').val()
    $('#comment_content').val(content)
    $('#comment_content').val(content)
    add_comment
      username: $('a#username').text().trim()
      content: content
      time_ago:  '0 minutos'

    $('.comment').first().effect("highlight", {}, 3000)
    $('#message').val('')
