class Event < ActiveRecord::Base
	has_many :tickets, dependent: :destroy

	validates_presence_of :name
	validates :starting_serial, presence: true, numericality: { only_integer: true, :greater_than => 0 }
	validates :ending_serial, presence: true, numericality: { only_integer: true, :greater_than => 0 }
	validates :member_price, presence: true, numericality: { :greater_than => 0 }
	validates :non_member_price, presence: true, numericality: { :greater_than => 0 }
end
