class Ticket < ActiveRecord::Base
	belongs_to :student
	belongs_to :event

	validates :serial_number,
				presence: true,
				numericality: { only_integer: true, :greater_than_or_equal_to => 140000, :less_than => 149999, :message => "is invalid" },
				:uniqueness => { :message => "%{value} has already been taken" }
	validate  :valid_event_serial_number
	validates :student_id, presence: true, numericality: { only_integer: true }
	validates :event_id, presence: true, numericality: { only_integer: true }

	def valid_event_serial_number
		unless (serial_number >= event.starting_serial && serial_number <= event.ending_serial)
			errors.add(:serial_number, "must be within event serial number range")
		end
	end

	def self.search(search)
		if !search.empty?
			search = Student.find_by(student_id: search)
			where("student_id LIKE '%" + search.id.to_s + "%'")
		else
			all
		end
  	end
end
