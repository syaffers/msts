class Event < ActiveRecord::Base
	has_many :tickets, dependent: :destroy

	validates_presence_of :name
	validates :code, presence: true, length: { maximum: 3 }
	validates :member_price, presence: true, numericality: true
	validates :non_member_price, presence: true, numericality: true

	def display_ac
    	"#{self.name} (#{self.code})"
  	end
end
