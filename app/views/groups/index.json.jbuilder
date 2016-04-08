json.array!(@wtodos) do |wtodo|
  json.extract! wtodo, :id, :title, :description, :completed
  json.url wtodo_url(wtodo, format: :json)
end
