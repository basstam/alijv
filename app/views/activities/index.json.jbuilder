json.array!(@activities) do |activity|
  json.extract! activity, :id, :name, :description, :start_date, :end_date, :active
  json.url activity_url(activity, format: :json)
end
