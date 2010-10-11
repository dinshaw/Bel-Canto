class PhoneNumber < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  KINDS = ['Mobile', 'Home', 'Work', 'Mother', 'Father', 'Other']
  
  belongs_to :user
  
  validates :number, :phone_number => {:allow_blank => true}
  
  attr_accessor '_delete'
  
  def formatted_number
    [kind,number_to_phone(number, :area_code => true)].join(': ')
  end
end
