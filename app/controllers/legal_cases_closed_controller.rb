class LegalCasesClosedController < ApplicationController
	
	def index
    
	end
	
	def redirect_to_index
		redirect_to '/all_reports/legal_cases_closed'
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
    
		by_legal_case_closed = Child.by_legal_cases_closed_with_reasons_for_closure.startkey([start_date]).endkey([end_date,{}])['rows']
		
		
		for i in by_legal_case_closed
			@uid = "-"
			@cname = "-"
			@cdate = 0
			@cstage = "-"
			@creason = "-"
			
			if i['key'][3].include? "legal_25204" or i['key'][3].include? "psy_so_cum_legal_17991"
				@uid = i['key'][1]
				@cname = i['key'][4]
				@cdate = i['key'][5]

				if i['key'][6]!= nil and i['key'][6].include? "any other specify"
					@cstage = i['key'][7]
				else
					@cstage = i['key'][6]
				end

				if i['key'][8]!= nil and i['key'][8].include? "any other specify"
					@creason = i['key'][9]
				else
					@creason = i['key'][8]
				end
			end
			
			@data.push({
				"userid" => @uid,
				"pseudonym" => @cname,
				"dateclosure" => @cdate,
				"closurestage" => @cstage,
				"reasonclosure" => @creason
			})
		end
		
		@start_date = start_date
		@end_date = (Date.parse(end_date)-1).to_s
		render "show_report"
    
  	end
end
