class DisposalController < ApplicationController
	def index
		
	end

	def redirect_to_index
		redirect_to '/all_reports/disposal'
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

        disposal_of_cases = Child.by_disposal_of_cases.startkey([start_date]).endkey([end_date,{}])['rows']

        @cases_abeted = 0
        @cases_discharged = 0
        @cases_acquittal = 0
        @cases_conviction = 0
        @total = 0
        @cases_abeted_percent = 0
        @cases_discharged_percent = 0
        @cases_acquittal_percent = 0
        @cases_conviction_percent = 0
        @total_percent = 0
        for i in disposal_of_cases
            if i['key'][0]!=nil
                if i['key'][1]!= nil and i['key'][1].length > 0
                    if i['key'][1][0]!= nil
                        if i['key'][1][0].include? "convicted"
                            @cases_conviction += 1
                        elsif i['key'][1][0].include? "acquitted"
                            @cases_acquittal += 1
                        elsif i['key'][1][0].include? "abated"
                            @cases_abeted += 1
                        elsif i['key'][1][0].include? "discharged"
                            @cases_discharged += 1
                        end
                    end
                end
            end
        end            
        @total = @cases_conviction + @cases_abeted + @cases_acquittal + @cases_discharged
        if @total!=0
            @cases_conviction_percent = (@cases_conviction.to_f/@total.to_f)*100.round
            @cases_discharged_percent = (@cases_discharged.to_f/@total.to_f)*100.round
            @cases_acquittal_percent = (@cases_acquittal.to_f/@total.to_f)*100.round
            @cases_abeted_percent = (@cases_abeted.to_f/@total.to_f)*100.round
            @total_percent = (@total.to_f/@total.to_f)*100.round
        end

    @start_date = start_date
    @end_date = (Date.parse(end_date)-1).to_s   
		render "show_report"
	end
end
