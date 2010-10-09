class PhoneNumberValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "should contain 10 digits") unless value =~ /^\d{10}$/i
  end
end