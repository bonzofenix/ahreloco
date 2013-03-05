$ ->
  add_comment = (comment)->
    debugger
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
    add_comment 
      username:  $('#comment_username').val()
      content:  $('#comment_content').val()

    $('.comment').first().effect("highlight", {}, 3000)
    $('#comment_username').val('')
    $('#comment_content').val('')
