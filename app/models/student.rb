class Student < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_many :tickets, dependent: :destroy

	validates :name, presence: true
	validates :student_id, presence: true, numericality: { only_integer: true }, uniqueness: true
	validates :contact_number, presence: true
	validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX, message: "string in invalid" }

	def display_ac
    	"#{self.name} (#{self.student_id})"
  	end

  	def self.search(search)
  		search_condition = "%" + search + "%"
  		where('lower(name) LIKE ? OR student_id LIKE ? OR contact_number LIKE ? OR lower(email) LIKE ?', search_condition.downcase, search_condition, search_condition, search_condition.downcase)
  	end
  	
  	self.per_page = 10;
end
