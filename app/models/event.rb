class Event < ActiveRecord::Base
	has_many :tickets, dependent: :destroy

	validates_presence_of :name
	validates :starting_serial, presence: true, numericality: { only_integer: true, :greater_than => 0 }
	validates :ending_serial, presence: true, numericality: { only_integer: true, :greater_than => 0 }
	validates :serial_number_range, :range => { :not_overlapping => :other_records }
	validates :member_price, presence: true, numericality: { :greater_than => 0 }
	validates :non_member_price, presence: true, numericality: { :greater_than => 0 }

	def serial_number_range
		starting_serial..ending_serial
	end

	def other_records
		Event.all
	end
end
