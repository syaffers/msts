class Ticket < ActiveRecord::Base
	belongs_to :student

	validates :serial_number, presence: true
	validates :student_id, presence: true, numericality: { only_integer: true }
end
