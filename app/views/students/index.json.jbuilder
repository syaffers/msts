json.array!(@students) do |student|
  json.extract! student, :id, :name, :email, :contact_number, :student_id
  json.url student_url(student, format: :json)
end
