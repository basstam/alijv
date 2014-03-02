json.array!(@participations) do |participation|
  json.extract! participation, :id, :participant.firstname, :participant.lastname, :participant.street, :participant.street_number, :participant.zipcode, :participant.city, :participant.email, :participant.phone, :participant.date_of_birth, :participant.gender, :category.distance, :category.description
  json.url participation_url(participation, format: :json)
end
