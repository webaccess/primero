class JudgementStatusController < ApplicationController
	def index
		
	end

	def redirect_to_index
		redirect_to '/all_reports/judgement_status'
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

        status_of_judgement = Child.by_judgement_status.startkey([start_date]).endkey([end_date,{}])['rows']
        
        for year in year_array
            @judgement = 0
            @trial_complete = 0
            @cases_abeted = 0
            @cases_discharged = 0
            @cases_acquittal = 0
            @cases_conviction = 0
            @conviction_rate = 0
            for i in status_of_judgement
                if i['key'][0]!=nil
                    recieved_year = i['key'][0].split('-')[0]
                    if recieved_year.to_i == year
                        if i['key'][1]!= nil and i['key'][1].length > 0
                            if i['key'][1][0]!= nil and i['key'][1][1]!= nil 
                                @judgement += 1
                                @trial_complete += 1
                                if i['key'][1][2].include? "convicted"
                                    @cases_conviction += 1
                                elsif i['key'][1][2].include? "acquitted"
                                    @cases_acquittal += 1
                                elsif i['key'][1][2].include? "abated"
                                    @cases_abeted += 1
                                elsif i['key'][1][2].include? "discharged"
                                    @cases_discharged += 1
                                end
                            end
                        end
                    end
                end
            end
            if @trial_complete!= 0
                @conviction_rate = (@cases_conviction/@trial_complete)* 100
            end
                
            @data.push({
            "year" => year,
            "judgement" => @judgement,
            "trial_complete" => @trial_complete,
            "cases_abeted" => @cases_abeted,
            "cases_discharged" => @cases_discharged,
            "cases_acquittal" => @cases_acquittal,
            "cases_conviction" => @cases_conviction,
            "conviction_rate" => @conviction_rate
            })
        end

        if @data.length >1
            @data.push({
                "year" => "Total",
                "judgement" => 0,
                "trial_complete" => 0,
                "cases_abeted" => 0,
                "cases_discharged" => 0,
                "cases_acquittal" => 0,
                "cases_conviction" => 0,
                "conviction_rate" => 0
            })
            last_element = @data.length-1
            for i in @data
                if i['year']!= "Total"
                    @data[last_element]["judgement"] += i["judgement"]
                    @data[last_element]["trial_complete"] += i["trial_complete"]
                    @data[last_element]["cases_abeted"] += i["cases_abeted"]
                    @data[last_element]["cases_discharged"] += i["cases_discharged"]
                    @data[last_element]["cases_acquittal"] += i["cases_acquittal"]
                    @data[last_element]["cases_conviction"] += i["cases_conviction"]
                end
            end
            if @data[last_element]["trial_complete"]!= 0
                @data[last_element]["conviction_rate"] = (@data[last_element]["cases_conviction"]/@data[last_element]["trial_complete"])*100
            end
        end
		@start_date = start_date
		@end_date = (Date.parse(end_date)-1).to_s
		render "show_report"
	end
end
