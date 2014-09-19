class Ticket < ActiveRecord::Base
	belongs_to :student
	belongs_to :event

	validates :serial_number, 
				presence: true, 
				numericality: { only_integer: true },
				:inclusion: { :in => 140000..149999, :message => "is invalid" } 
				:uniqueness => {:scope => :event_id, :message => "%{value} has already been taken" }
	validates :student_id, presence: true, numericality: { only_integer: true }
	validates :event_id, presence: true, numericality: { only_integer: true }
end
