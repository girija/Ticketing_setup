class Ticket < ActiveRecord::Base
	belongs_to :user
	after_create :update_ticket_no
	acts_as_commentable
	def update_ticket_no
		ticket_no = "Tickt#{self.id}-#{SecureRandom.hex 4}"
		self.update_column("ticket_no",ticket_no)
	end
end
