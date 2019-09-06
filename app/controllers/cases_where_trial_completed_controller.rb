class CasesWhereTrialCompletedController < ApplicationController
	def index
		
	end

	def redirect_to_index
		redirect_to '/all_reports/cases_where_trial_completed'
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

        cases_where_trial_completed = Child.by_cases_where_trial_completed.startkey([start_date]).endkey([end_date,{}])['rows']

        @zeroSixMonth = 0
        @sixTweleveMonth = 0
        @tweleveEighteenMonth = 0
        @eighteenTwentyFourMonth = 0
        @greaterThanTwentyFourMonth = 0
        @total = 0
        @zeroSixMonthPercent = 0
        @sixTweleveMonthPercent = 0
        @tweleveEighteenMonthPercent = 0
        @eighteenTwentyFourMonthPercent = 0
        @greaterThanTwentyFourMonthPercent = 0
        @totalPercent = 0
        for i in cases_where_trial_completed
            if i['key'][0]!=nil
                if i['key'][1]!= nil and i['key'][1].length > 0
                    if i['key'][1][0]!= nil and i['key'][1][1]!= nil
                        cognizanceDate = Date.parse(i['key'][1][0])
                        judgementDate = Date.parse(i['key'][1][1])
                        if cognizanceDate <= judgementDate
                            monthDifference = (judgementDate.year * 12 + judgementDate.month) - (cognizanceDate.year * 12 + cognizanceDate.month)
                            if monthDifference >=0 and monthDifference < 6
                                @zeroSixMonth += 1
                            elsif monthDifference >= 6 and monthDifference < 12 
                                @sixTweleveMonth += 1
                            elsif monthDifference >= 12 and monthDifference < 18
                                @tweleveEighteenMonth += 1
                            elsif monthDifference >=18 and monthDifference < 24
                                @eighteenTwentyFourMonth += 1
                            elsif monthDifference >= 24
                                @greaterThanTwentyFourMonth += 1
                            end 
                        end
                    end
                end
            end
        end
            
        @total = @zeroSixMonth + @sixTweleveMonth + @tweleveEighteenMonth + @eighteenTwentyFourMonth + @greaterThanTwentyFourMonth
        if @total!=0
            @zeroSixMonthPercent = @zeroSixMonth.to_f / @total.to_f* 100.round
            @sixTweleveMonthPercent = @sixTweleveMonth.to_f / @total.to_f* 100.round
            @tweleveEighteenMonthPercent = @tweleveEighteenMonth.to_f / @total.to_f * 100.round
            @eighteenTwentyFourMonthPercent = @eighteenTwentyFourMonth.to_f / @total.to_f * 100.round
            @greaterThanTwentyFourMonthPercent = @greaterThanTwentyFourMonth.to_f / @total.to_f* 100.round
            @totalPercent = @total.to_f / @total.to_f* 100.round
        end
		
		@start_date = start_date
    @end_date = (Date.parse(end_date)-1).to_s 
		render "show_report"
	end
end
