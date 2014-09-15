json.array!(@events) do |event|
  json.extract! event, :id, :name, :code, :member_price, :non-member_price
  json.url event_url(event, format: :json)
end
