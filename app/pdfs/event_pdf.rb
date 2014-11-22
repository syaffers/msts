class EventPdf < Prawn::Document
	def initialize(event)
		super(top_margin: 60)
		@event = event
		header_section
		details_section
		stats_section
	end

	def header_section
		font_size(20)
		text "Event Report for #{@event.name}"
	end

	def details_section
		move_down(20)
		font_size(12)
		text "Member price: RM#{sprintf("%.2f", @event.member_price)}"
		text "Non-member price: RM#{sprintf("%.2f", @event.non_member_price)}"
		text "Serial number range: #{@event.starting_serial} - #{@event.ending_serial}"
	end

	def stats_section
		revenue = @event.tickets.map {|t| t.member? ? t.event.member_price : t.event.non_member_price}.reduce {|a,b| a.to_f + b.to_f}
		total = @event.tickets.count
		members = @event.tickets.map(&:member).count true
		non_members = @event.tickets.map(&:member).count false
		move_down(20)
		font_size(12)
		text "Number of tickets bought: #{total}"
		text "Member tickets: #{members} (#{members.to_f/total * 100}%)"
		text "Non-member tickets: #{non_members} (#{non_members.to_f/total * 100}%)"
		text "Revenue generated: RM#{sprintf "%.2f", revenue}"
	end
end