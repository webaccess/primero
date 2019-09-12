class ListOfTrainingsPdf < Prawn::Document
	def initialize(training_list)
			super()
			@list = training_list
			
			list_of_training
	end
	
	def list_of_training
    move_down 1
    table training_list_all do
		
		end
  end
	
	def training_list_all
        [["DATE","FACILITATOR", "POLICE DISTRICT", "PARTICIPANT GROUP", "NO. OF PARTICIPANTS"]] +
					@list.map do |close|
					[close["date_of_training"],close["facilitated_by"], close["organised"], close["description"], close["number_of_participants"]]
    end
  end  
end

