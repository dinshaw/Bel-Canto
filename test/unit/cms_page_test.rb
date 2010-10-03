require 'test_helper'

class CmsPageTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert CmsPage.new.valid?
  end
end
