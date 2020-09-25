class AppealInAppellateController < ApplicationController
	def index
		
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
		
		start_date_x = (Date.parse(start_date)-365).to_s
		end_date_x = (Date.parse(end_date)-365).to_s

		appeal_in_appellate = Child.by_appeal_in_appellate.startkey([start_date]).endkey([end_date,{}])['rows']
		previous_year_cases = Child.by_appeal_in_appellate.startkey([start_date_x]).endkey([end_date_x,{}])['rows']
		@previous_year = 0

		for year in year_array
			@total_case = 0
			
			@formal_close = 0
			@before_formal_close = 0
			@balance_cases = 0
			@pending_cases = 0
			@live_cases = 0
			@test = []

			for i in appeal_in_appellate
				if i['key'][0]!=nil
					recieved_year = i['key'][0].split('-')[0]
					if recieved_year.to_i == year
						@total_case += 1
						if i['key'][3]!=nil
							if i['key'][3].include? "closed"
								@formal_close += 1
							end
						end
					end
				end
			end
			
			@formal_intake_total = ((@total_case + @previous_year) - @before_formal_close)
			@balance_cases = (@formal_intake_total - @formal_close)
			@pending_cases = (@balance_cases - @previous_year)

			@data.push({
				"year" => year,
				"total" => @total_case,
				"close" => @formal_close,
				"previous" => @previous_year,
				"formalTotal" => @formal_intake_total,
				"beforeClose" => @before_formal_close,
				"balance" => @balance_cases,
				"pending" => @pending_cases
			})

			@previous_year = @balance_cases
		end
		@start_date = start_date
		@end_date = (Date.parse(end_date)-1).to_s
		render "show_report"
	end

end

