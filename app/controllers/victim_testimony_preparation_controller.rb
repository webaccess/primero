class VictimTestimonyPreparationController < ApplicationController
	def index
	
	end
	
	def redirect_to_index
		redirect_to '/all_reports/victim_testimony_preparation'
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
		end_year = Date.today.year.to_s
		end_year = end_year.to_i 
		start_year = start_year.to_i
		diff_year = end_year-start_year
		@year = [[start_year,0]]
			(1..diff_year).each do |i|
			@year.push([start_year+i,0])
		 end
		 @year.push(["Total"])
    victim_testimony_preparation = Child.by_victim_testimony_preparation.startkey([start_date]).endkey([end_date,{}])['rows']
    
    for i in victim_testimony_preparation
			year_array = [[start_year,0]]
			(1..diff_year).each do |i|
			year_array.push([start_year+i,0])
			end
			for j in i['key'][1][6]
				if j.has_key?('date_of_each_victim_interaction_session')
					date = j["date_of_each_victim_interaction_session"].split("/")[0]
					for k in year_array
						if k[0] == date.to_i
							k[1] +=1
						end
					end
				end
			end
			year_array.push(["Total",0])
			for j in year_array
				if j[0]!= "Total"
					year_array[year_array.length-1][1] += j[1]
				end
			end
			@data.push({
					"year" => year_array, 
					"case_id"=>i['key'][1][0],
					"pseudonyms"=>i['key'][1][1],
					"examinationinchief_commenced"=>i['key'][1][2],
					"examinationinchief_was_completed"=>i['key'][1][3],
					"crossexamination_commenced"=>i['key'][1][4],
					"crossexamination_completed"=>i['key'][1][5],
				})		
		end
   
		@start_date = start_date
    @end_date = (Date.parse(end_date)-1).to_s
    render "show_report"    
	end
end

