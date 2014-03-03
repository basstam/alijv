module ParticipantsHelper

  def show_gender(record)
    if record.gender == 'F'
      'Vrouw'
    else
      'Man'
    end
  end

end
