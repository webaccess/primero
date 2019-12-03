class StatusOnVictimCompensationController < ApplicationController
	
	def index
		
	end
	
	def redirect_to_index
		redirect_to '/all_reports/status_on_victim_compensation'
	end
	
	def submit_form
		start_date = params[:start_date]
		end_date = params[:end_date]
		end_date = (Date.parse(end_date)+1).to_s
		calculate_report(start_date,end_date)
	end
	
	def calculate_report(start_date, end_date)
		@data = []

		start_year = start_date.split('-')[0]
		end_year = end_date.split('-')[0]

		end_year = end_year.to_i 
		start_year = start_year.to_i
		diff_year = end_year-start_year
		year_array = [start_year]

		(1..diff_year).each do |i|
			year_array.push(start_year+i)
    	end
		
		by_victim_comp = Child.by_status_victim_compensation.startkey([start_date]).endkey([end_date,{}])['rows']

		for i in by_victim_comp
			@uid = 0
			@court = 0
			@pname = 0
			@date_interim = 0
			@amount_interim = 0
			@date_final = 0
			@amount_final = 0
			if i['key'][4]!= nil and i['key'][4].include? "granted_31268"
				@uid = i['key'][1]
				@court = i['key'][2]
				@pname = i['key'][3]
				@date_interim = i['key'][5]
				@amount_interim = i['key'][6]
			end

			if i['key'][7]!= nil and i['key'][7].include? "granted_99087"
				@date_final = i['key'][8]
				@amount_final = i['key'][9]
			end
		

			@data.push({
				"userid" => @uid,
				"dcourt" => @court,
				"pname" => @pname,
				"dinterim" => @date_interim,
				"ainterim" => @amount_interim,
				"datefinal" => @date_final,
				"amountfinal" => @amount_final
			})

		end

		@start_date = start_date
		@end_date = (Date.parse(end_date)-1).to_s
		render "show_report"
	end
end
