class CasesClosedByLawyersPdf < Prawn::Document
	def initialize(cases_closed)
			super()
			@closed_case = cases_closed
			lawyer_case_closed
	end
	
	def lawyer_case_closed
    move_down 1
    table lawyer_case_closed_all do
		
		end
  end
	
	def lawyer_case_closed_all
     [["CASE ID","CHILD'S NAME", "LEGAL CASE TITLE", "STAGE AT THE TIME OF CLOSURE", "REASONS FOR CLOSURE"]] +
     @closed_case.map do |close|
        [close["case_id"],close["first_name"], close["case_title"], close["stage"], close["closure_reason"]]
    end
   end
    
end
