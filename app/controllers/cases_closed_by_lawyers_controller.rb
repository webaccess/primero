class CasesClosedByLawyersController < ApplicationController
	
	def index
		
	end
	
	def redirect_to_index
		redirect_to '/all_reports/cases_closed_by_lawyers'
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
		
	by_lawyer_case_closed = Child.by_cases_closed_by_haq_lawyer.startkey([start_date]).endkey([end_date,{}])['rows']

	for i in by_lawyer_case_closed
		@uid = 0
		@cname = 0
		@ctitle = 0
		@cstage = 0
		@creason = 0

		if i['key'][2]!= nil and i['key'][2].include? "legal_25204" or i['key'][2].include? "psy_so_cum_legal_17991"
			@uid = i['key'][1]
			@cname = i['key'][3]
			@ctitle = i['key'][4]

			if i['key'][5]!= nil and i['key'][5].include? "any other specify"
				@cstage = i['key'][6]
			else
				@cstage = i['key'][5]
			end

			if i['key'][7]!= nil and i['key'][7].include? "any other specify"
				@creason = i['key'][8]
			else
				@creason = i['key'][7]
			end
		end
		@data.push({
			"userid" => @uid,
			"pseudonym" => @cname,
			"casetitle" => @ctitle,
			"closurestage" => @cstage,
			"reasonclosure" => @creason
			})
	end

    @start_date = start_date
    @end_date = (Date.parse(end_date)-1).to_s
	render "show_report"
	end
end
