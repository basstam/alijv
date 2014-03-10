module ParticipantsHelper

  def show_gender(record)
    if record.gender == 'F'
      'Vrouw'
    else
      'Man'
    end
  end

  def error_field(record, attribute)
    record.errors[attribute].present? ? {class: 'field_with_errors'} : {}  
  end
end
