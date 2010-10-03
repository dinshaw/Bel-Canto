class PhoneNumberValidator < ActiveModel::Validator
  
  def validate(record)
    record.errors.add(:base, 'must only contain numbers 0-9') if record.number !~ /\d/
    record.errors.add(:base, 'must be 10 characters long') if record.number.length != 10
  end
end