class Student < ActiveRecord::Base
	has_many :tickets

	validates :name, presence: true
	validates :student_id, presence: true, numericality: { only_integer: true }
	validates :member, presence: true
	validates :contact_number, presence: true
	validates :email, presence: true
end
