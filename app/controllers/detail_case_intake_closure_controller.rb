class DetailCaseIntakeClosureController < ApplicationController
	def index
		
	end

	def submit_form
		start_date = params[:start_date]
		end_date = params[:end_date]
		end_date = (Date.parse(end_date)+1).to_s
		calculate_report(start_date,end_date)
	end

	def redirect_to_index
        redirect_to '/all_reports/detail_case_intake_closure'
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
		cases_pending_formal_intake = Child.by_cases_pending_formal_intake.startkey([start_date]).endkey([end_date,{}])['rows']
		cases_previous_year = Child.by_cases_pending_formal_intake.startkey([start_date_x]).endkey([end_date_x,{}])['rows']


		for year in year_array
			@total_case = 0
			@cases_pyscho = 0
			@cases_pyslegal = 0
			@cases_pending = 0
			@cases_previous = 0
			@formal_close = 0
			@before_formal_close = 0
			@totalpsylegal = 0
			@pyslegal_formal_close = 0
			@pyscho_formal_close = 0
			@totalpsylegal_close = 0
			@totalformal = 0

			for i in appeal_in_appellate
				if i['key'][0]!=nil
					recieved_year = i['key'][0].split('-')[0]
					if recieved_year.to_i == year
						@total_case += 1
						if i['key'][1].include? "closed"
							@formal_close += 1
						end
					end
				end
			end

			for j in cases_pending_formal_intake
				if j['key'][0]!=nil
					recieved_year = j['key'][0].split('-')[0]
					if recieved_year.to_i == year
						if j['key'][1]!=nil and j['key'][2]!=nil and j['key'][3]!=nil 
							if j['key'][1].include? "psy_so_99767" and j['key'][2].include? "open" and j['key'][3].include? "approved"
								@cases_pyscho += 1	
							end
							if j['key'][1].include? "psy_so_cum_legal_17991" and j['key'][2].include? "open" and j['key'][3].include? "approved"
								@cases_pyslegal += 1	
							end
							if j['key'][1].include? "psy_so_99767" and j['key'][2].include? "closed" and j['key'][3].include? "approved"
								@pyscho_formal_close += 1	
							end
							if j['key'][1].include? "psy_so_cum_legal_17991" and j['key'][2].include? "closed" and j['key'][3].include? "approved"
								@pyslegal_formal_close += 1	
							end
						end
						if j['key'][1].include? "referral_84755" and j['key'][2].include? "open" and j['key'][3] == nil
							@cases_pending += 1	
						end
						if j['key'][1].include? "referral_84755" and j['key'][2].include? "closed" and j['key'][3] == nil
							@before_formal_close += 1	
						end
						@totalpsylegal = @cases_pyscho + @cases_pyslegal
						@totalpsylegal_close = @pyscho_formal_close + @pyslegal_formal_close
						@totalformal = @totalpsylegal - @totalpsylegal_close
					end
				end
			end

			for k in cases_previous_year
				if k['key'][0]!=nil
					recieved_year = k['key'][0].split('-')[0]
					if recieved_year.to_i == year
						if k['key'][1].include? "referral_84755" and k['key'][2].include? "open" and k['key'][3] == nil
							@cases_previous += 1	
						end
						
					end
				end
			end
	
			@data.push({
				"year" => year,
				"total" => @total_case,
				"close" => @formal_close,
				"previous" => @cases_previous,
				"pending_live" => @cases_pending,
				"before_close" => @before_formal_close,
				"psychosocial" => @cases_pyscho,
				"psycholegal" => @cases_pyslegal,
				"totalpyscholegal" => @totalpsylegal,
				"psychosocial_closed" => @pyscho_formal_close,
				"psycholegal_closed" =>  @pyslegal_formal_close,
				"totalpyscholegal_closed" => @totalpsylegal_close,
				"totalformalcase" => @totalformal
			})

		end
		render "show_report"
	end

end

