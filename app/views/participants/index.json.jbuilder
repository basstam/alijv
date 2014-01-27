json.array!(@participants) do |participant|
  json.extract! participant, :id, :firstname, :lastname, :street, :street_number, :zipcode, :city, :email, :phone, :date_of_birth, :gender
  json.url participant_url(participant, format: :json)
end
