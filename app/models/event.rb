class Event < ActiveRecord::Base
	has_many :tickets, dependent: :destroy

	validates_presence_of :name
	validates :member_price, presence: true, numericality: { :greater_than => 0 }
	validates :non_member_price, presence: true, numericality: { :greater_than => 0 }
end
