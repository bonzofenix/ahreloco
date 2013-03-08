every 1.day, at: '00:00 am' do
  runner 'Video.update_all(arl_views_today: 0)'
end

every 1.week, at: '00:00 am' do
  runner 'Video.update_all(arl_views_week: 0)'
end

every 1.month, at: '00:00 am' do
  runner 'Video.update_all(arl_views_month: 0)'
end


