require 'test_helper'

class PrivateLessonTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert PrivateLesson.new.valid?
  end
end
