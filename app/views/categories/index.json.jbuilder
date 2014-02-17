json.array!(@categories) do |category|
  json.extract! category, :id, :activity_id, :description, :distance, :age_from, :age_to, :gender, :start_startnumber, :start_time
  json.url category_url(category, format: :json)
end
