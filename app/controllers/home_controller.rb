class HomeController < ApplicationController
  def index
  end

  def schedule
    @private_lesson = PrivateLesson.new
  end

end
