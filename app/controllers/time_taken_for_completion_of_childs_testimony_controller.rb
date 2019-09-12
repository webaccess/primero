class TimeTakenForCompletionOfChildsTestimonyController < ApplicationController
	def index
		
	end

	def redirect_to_index
		redirect_to '/all_reports/time_taken_for_completion_of_childs_testimony'
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

        time_taken_for_completion_of_childs_testimony = Child.by_time_taken_for_completion_of_childs_testimony.startkey([start_date]).endkey([end_date,{}])['rows']

        @oneDay = 0
        @twoTenDay = 0
        @zeroOneMonth = 0
        @oneThreeMonth = 0
        @threeSixMonth = 0
        @sixNineMonth = 0
        @nineTweleveMonth = 0
        @tweleveFifteenMonth = 0
        @fifteenEighteenMonth = 0
        @eighteenTwentyOneMonth = 0
        @twentyOneTwentySevenMonth = 0
        @total = 0

        @oneDayPercent = 0
        @twoTenDayPercent = 0
        @zeroOneMonthPercent = 0
        @oneThreeMonthPercent = 0
        @threeSixMonthPercent = 0
        @sixNineMonthPercent = 0
        @nineTweleveMonthPercent = 0
        @tweleveFifteenMonthPercent = 0
        @fifteenEighteenMonthPercent = 0
        @eighteenTwentyOneMonthPercent = 0
        @twentyOneTwentySevenMonthPercent = 0
        @totalPercent = 0

        for i in time_taken_for_completion_of_childs_testimony
            if i['key'][0]!=nil
                if i['key'][1]!= nil and i['key'][1].length > 0
                    if i['key'][1][0]!= nil and i['key'][1][1]!= nil
                        victimTestimonyCommenced = Date.parse(i['key'][1][0])
                        victimTestimonyEnded = Date.parse(i['key'][1][1])
                        puts "here"
                        if victimTestimonyCommenced <= victimTestimonyEnded
                            daysDiff = victimTestimonyEnded - victimTestimonyCommenced
                            daysDiff = daysDiff.to_i
                            if daysDiff >=0 and daysDiff < 2
                                @oneDay += 1
                            elsif daysDiff >= 2 and daysDiff < 11 
                                @twoTenDay += 1
                            elsif daysDiff >= 11 and daysDiff < 31
                                @zeroOneMonth += 1
                            elsif daysDiff >=31 and daysDiff < 91
                                @oneThreeMonth += 1
                            elsif daysDiff >=91 and daysDiff < 181
                                @threeSixMonth += 1
                            elsif daysDiff >=181 and daysDiff < 271
                                @sixNineMonth += 1
                            elsif daysDiff >=271 and daysDiff < 366
                                @nineTweleveMonth += 1
                            elsif daysDiff >=366 and daysDiff < 451
                                @tweleveFifteenMonth += 1
                            elsif daysDiff >=451 and daysDiff < 541
                                @fifteenEighteenMonth += 1
                            elsif daysDiff >=541 and daysDiff < 631
                                @eighteenTwentyOneMonth += 1
                            elsif daysDiff >=631 and daysDiff < 811
                                @twentyOneTwentySevenMonth += 1
                            end 
                        end
                    end
                end
            end
        end
    
        @total = @oneDay + @twoTenDay + @zeroOneMonth + @oneThreeMonth + @threeSixMonth + @sixNineMonth + @nineTweleveMonth + @tweleveFifteenMonth + @fifteenEighteenMonth + @eighteenTwentyOneMonth + @twentyOneTwentySevenMonth
        if @total!=0
            @oneDayPercent = @oneDay.to_f / @total.to_f* 100.round
            @twoTenDayPercent = @twoTenDay.to_f / @total.to_f* 100.round
            @zeroOneMonthPercent = @zeroOneMonth.to_f / @total.to_f * 100.round
            @oneThreeMonthPercent = @oneThreeMonth.to_f / @total.to_f * 100.round
            @threeSixMonthPercent = @threeSixMonth.to_f / @total.to_f* 100.round
            @sixNineMonthPercent = @sixNineMonth.to_f / @total.to_f* 100.round
            @nineTweleveMonthPercent = @nineTweleveMonth.to_f / @total.to_f* 100.round
            @tweleveFifteenMonthPercent = @tweleveFifteenMonth.to_f / @total.to_f* 100.round
            @fifteenEighteenMonthPercent = @fifteenEighteenMonth.to_f / @total.to_f* 100.round
            @eighteenTwentyOneMonthPercent = @eighteenTwentyOneMonth.to_f / @total.to_f* 100.round
            @twentyOneTwentySevenMonthPercent = @twentyOneTwentySevenMonth.to_f / @total.to_f* 100.round
            @totalPercent = @total.to_f / @total.to_f* 100.round
        end

        @start_date = start_date
		@end_date = (Date.parse(end_date)-1).to_s
        render "show_report"
    end
end
