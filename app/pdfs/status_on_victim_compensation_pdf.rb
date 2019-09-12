class StatusOnVictimCompensationPdf < Prawn::Document
	def initialize(users,data)
			@data=data
			super()
			victim_compensation
	end
	
	def victim_compensation
    move_down 1
    table victim_compensation_all do
		
		end
  end
	
	def victim_compensation_all
        [["Case ID","CONCERNED COURT/DLSA", "CLIENT'S", "INTERIM COMPENSATION", "FINAL COMPENSATION"]]
    end
    
end
