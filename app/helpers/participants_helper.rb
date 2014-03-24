module ParticipantsHelper

  def error_field(record, attribute)
    record.errors[attribute].present? ? {class: 'field_with_errors'} : {}  
  end

end
