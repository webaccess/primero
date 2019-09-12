class VictimCompensationDisposedPdf < Prawn::Document
	def initialize(victim_comp_dis)
			super()
			@disposed = victim_comp_dis
			
			compensation_disposed
	end
	
	def compensation_disposed
    move_down 1
    table compensation_disposed_all do
		
		end
  end
	
	def compensation_disposed_all
        [["CASE ID","COURT","CHILD’S PSEUDONYM","VICTIM COMPENSATION"]]	+
    @disposed.map do |close|
        [close["case_id"],close["court"], close["pseudonym"], close["vc"]]
    end
  end
end
