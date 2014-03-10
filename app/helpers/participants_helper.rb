module ParticipantsHelper

  def show_gender(record)
    if record.gender == 'F'
      'Vrouw'
    else
      'Man'
    end
  end

  def distance_error(participant)
    participant.errors[:distance].present? ? {class: 'field_with_errors'} : {}  
  end
end
