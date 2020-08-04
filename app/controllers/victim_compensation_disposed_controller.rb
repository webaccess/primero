class VictimCompensationDisposedController < ApplicationController
	def index
		
	end
	
	def submit_form
		start_date = params[:start_date]
		end_date = params[:end_date]
		end_date = (Date.parse(end_date)+1).to_s
		calculate_report(start_date,end_date)
	end
	
	def redirect_to_index
		redirect_to '/all_reports/victim_compensation_disposed'
	end

	def calculate_report(start_date, end_date)
		@victim_comp_dis = []

		start_year = start_date.split('-')[0]
		end_year = end_date.split('-')[0]

		end_year = end_year.to_i 
		start_year = start_year.to_i
		diff_year = end_year-start_year
		year_array = [start_year]

		(1..diff_year).each do |i|
			year_array.push(start_year+i)
    	end
		
		victim_compensation_disposed = Child.by_status_victim_compensation.startkey([start_date]).endkey([end_date,{}])['rows']
		
		for i in victim_compensation_disposed
			@uid = "-"
			@court = "-"
			@pname = "-"
			@date_interim = "-"
			@amount_interim = 0
			@date_final = "-"
			@amount_final = 0
			@date_special = "-"			
			@amount_special = 0
			
			if i['key'][1]!= nil and i['key'][1]!= ""
				@uid = i['key'][1]
			end
			
			if i['key'][2]!= nil and i['key'][2]!= ""
				@court = i['key'][2]
			end
			
			if i['key'][3]!= nil and i['key'][3]!= ""
				@pname = i['key'][3]
			end
			
			if i['key'][4]!= nil and i['key'][4]!= "" and i['key'][4].include? "psy_so_99767"
			
				if i['key'][5]!= nil and i['key'][5]!= ""
					@date_interim =  i['key'][5]
				end
				
				if i['key'][6]!= nil and i['key'][6]!= ""
					@amount_interim = i['key'][6]
				end			
				
				if i['key'][7]!= nil and i['key'][7]!= ""
					@date_final = i['key'][7]
				end	
				
				if i['key'][8]!= nil and i['key'][8]!= ""
					@amount_final = i['key'][8]
				end
				
			else i['key'][4]!= nil and i['key'][4]!= "" and i['key'][4].include? "psy_so_cum_legal_17991"
				for j in i["key"][11]
					if j.has_key? ("date_of_compensation_order") and j["date_of_compensation_order"]!=nil 
						@date_interim = j["date_of_compensation_order"]
					end
					if j.has_key? ("amount_in_inr") and j["amount_in_inr"]!=nil 
						@amount_interim = j["amount_in_inr"]
					end
				end
				for m in i["key"][12]
					if m.has_key? ("date_of_compensation_order") and m["date_of_compensation_order"]!=nil 
						@date_final = m["date_of_compensation_order"]
					end
					if m.has_key? ("amount_in_inr_final_compensation") and m["amount_in_inr_final_compensation"]!=nil 
						@amount_final = m["amount_in_inr_final_compensation"]
					end
				end
			end
			
			if i['key'][9]!= nil and i['key'][9]!= ""
				@date_special = i['key'][9]
			end
			
			if i['key'][10]!= nil and i['key'][10]!= ""
				@amount_special = i['key'][10]
			end
			
			@victimCompensation  = "Received Special Relief of INR #{@amount_special.to_s} on #{@date_special.to_s} also Interim compensation of INR #{@amount_interim.to_s} on #{@date_interim.to_s} & also received final compensation of INR #{@amount_final.to_s} on #{@date_final.to_s}"
		
			@victim_comp_dis.push({"case_id":@uid,"court":@court,"pseudonym":@pname,"vc":@victimCompensation})
		end
    	@start_date = start_date
		@end_date = (Date.parse(end_date)-1).to_s
		render "show_report"
	end
end
