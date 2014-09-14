json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :serial_number
  json.url ticket_url(ticket, format: :json)
end
