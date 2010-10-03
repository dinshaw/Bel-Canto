class PhoneNumber < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  validates_with PhoneNumberValidator
  
  belongs_to :user
  
  def number=(number)
    write_attribute :number, number.gsub(/\D/,'')
  end
  
  def formatted_number
    [kind,number_to_phone(number, :area_code => true)].join(': ')
  end
end
