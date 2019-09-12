class StatusOnFinancialNeedsPdf < Prawn::Document
	def initialize(users,data)
			@data=data
			super()
			financial_needs
	end
	
	def financial_needs
    move_down 1
    table financial_needs_all do
		
		end
  end
	
	def financial_needs_all
        [["STATUS","CASES"]]
    end
    
end
