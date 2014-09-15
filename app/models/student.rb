class Student < ActiveRecord::Base
	has_many :tickets, dependent: :destroy

	validates :name, presence: true
	validates :student_id, presence: true, numericality: { only_integer: true }
	validates :contact_number, presence: true
	validates :email, presence: true

	def display_ac
    	"#{self.name} (#{self.student_id})"
  	end
end
