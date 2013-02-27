class HomeController < ApplicationController
  def index
    @lattest_program_videos = Program.all.collect do |p|
      p.lattest_video
    end
  end
end
