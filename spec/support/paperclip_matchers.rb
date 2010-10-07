require "paperclip/matchers"

Rspec.configure do |config|
  config.include Paperclip::Shoulda::Matchers
end