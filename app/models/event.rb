class Event < ActiveRecord::Base
	has_many :tickets, dependent: :destroy

	validates_presence_of :name
	validates :code, presence: true, format: { with: /\A[A-Z]+\z/, message: "needs to be in capitals" }, length: { maximum: 5 }, uniqueness: true
	validates :member_price, presence: true, numericality: { :greater_than => 0 }
	validates :non_member_price, presence: true, numericality: { :greater_than => 0 }

	def display_ac
    	"#{self.name} (#{self.code})"
  	end
end
