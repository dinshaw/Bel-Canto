class PhoneNumber < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  
  belongs_to :user
  
  validates :number, :phone_number => {:allow_blank => true}
  
  def formatted_number
    [kind,number_to_phone(number, :area_code => true)].join(': ')
  end
end
