module StudentsHelper
  def phone_numbers_list(student)
    student.phone_numbers.map(&:formatted_number).join('<br >').html_safe
  end
end
