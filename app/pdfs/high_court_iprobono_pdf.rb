class HighCourtIprobonoPdf < Prawn::Document
	def initialize(high_court)
			super()
			@court = high_court
			high_court_ip
	end
	
	def high_court_ip
    move_down 1
    table high_court_all do
		
		end
  end

	
	def high_court_all
      
        [["Case ID","CHILD NAME", "PURPOSE", "GROUND/RESONS FOR APPROACHING H.C.", "PETITION FILED BEFORE", "CASE NUMBER", "CASE TITLE", "CASE IS HANDLED BY", "DATE OF FILING", "DATE OF DISPOSAL", "OUTCOME", "STATUS ON JUNE 2018"]] +
    @court.map do |close|
        [close["case_id"],close["name"],close["purpose"],close["groundreasons"],close["court"],close["case_number"],close["case_title"],close["case_is_handled_by"],close["date_of_filing"],close["date_of_disposal"],close["outcome"],close["child_status"]]
    end
  end
end

