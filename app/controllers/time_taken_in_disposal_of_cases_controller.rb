class TimeTakenInDisposalOfCasesController < ApplicationController
	def index
		
	end

	def redirect_to_index
		redirect_to '/all_reports/time_taken_in_disposal_of_cases'
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

        look_up_court = Lookup.by_lookup_court['rows']
        court_array =[]
        for i in look_up_court[0]['key']
            court_array.push([i['id'],i['display_text']])
        end
        time_taken_in_disposal_of_cases = Child.by_time_taken_in_disposal_of_cases.startkey([start_date]).endkey([end_date,{}])['rows']
        @noOfCase = 0
        for i in time_taken_in_disposal_of_cases 
            @noOfCase += 1
            if i['key'][0]!= nil and i['key'][0]!= ""
                if i['key'][1]!= nil and i['key'][1].length > 0
                    @caseId = "-"
                    @courtName = "-"
                    @clientPsyudoname = "-"
                    @outcome = "-"
                    @dateOfCognizance = "-"
                    @dateJudgement = "-"
                    @durationOfTrial = "-"
                    @effective = 0
                    @adjournment = 0
                    @total = 0
                    if i["key"][1][0]!= nil and i["key"][1][0]!= ""
                        @caseId = i["key"][1][0]
                    end
                    if i["key"][1][2]!= nil and i["key"][1][2]!= ""
                        @clientPsyudoname = i["key"][1][2]
                    end
                    if i["key"][1][3]!= nil and i["key"][1][3]!= ""
                        for j in court_array
                            if j[0] == i["key"][1][3]
                                @courtName = j[1]
                            end
                        end
                    end
                    if i["key"][1][4]!= nil and i["key"][1][4]!= ""
                        if i["key"][1][4].include? "convicted"
                            @outcome = "Conviction"
                        elsif i["key"][1][4].include? "acquitted"
                            @outcome = "Acquittal"
                        elsif i["key"][1][4].include? "abated"
                            @outcome = "Abated"
                        elsif i["key"][1][4].include? "discharged"
                            @outcome = "Discharged"
                        end
                    end
                    if i["key"][1][5]!=nil and i["key"][1][6]!= nil
                        if i["key"][1][5]!="" and i["key"][1][5]!=""
                            
                            @dateOfCognizance = i["key"][1][5]
                            @dateJudgement = i["key"][1][6]
                            cognizanceDate = Date.parse(i["key"][1][5])
                            judgementDate = Date.parse(i["key"][1][6])
                            if cognizanceDate <= judgementDate
                                date = judgementDate - cognizanceDate
                                numberOfDays = date.to_i
                                year = numberOfDays/365
                                if year!=0
                                    daysDifferenceForMonth = numberOfDays - (year*365)
                                else
                                    daysDifferenceForMonth = numberOfDays
                                end
                                month = daysDifferenceForMonth/30
                                if month!=0
                                    daysDifferenceForDays = daysDifferenceForMonth - (month*31)
                                else
                                    daysDifferenceForDays = daysDifferenceForMonth
                                end
                                days = daysDifferenceForDays
                                @durationOfTrial = year.to_s+" years, "+month.to_s+" months, "+days.to_s+" days"
                            else
                                @dateOfCognizance = i["key"][1][5]
                                @dateJudgement = i["key"][1][6] 
                            end
                        else
                            if i["key"][1][5]!=""
                                @dateOfCognizance = i["key"][1][5] 
                            end
                            if i["key"][1][6]!=""
                                @dateJudgement = i["key"][1][6] 
                            end
                        end
                    else
                        if i["key"][1][5]!= nil
                            @dateOfCognizance = i["key"][1][5] 
                        end
                        if i["key"][1][6]!= nil
                            @dateJudgement = i["key"][1][6] 
                        end
                    end

                    for j in i["key"][1][7]
                        if j.has_key? ("date_of_hearing") and j["date_of_hearing"]!=nil 
                            if j.has_key? ("stage") and j["stage"]!=nil
                                if j["stage"]!= "police_investigation_31129" and j["stage"]!= "argument_on_sentencing_01489" and j["stage"]!= "order_on_sentencing_47946" and !j["stage"].include? "post_disposal_58753" and j["stage"] != ""   
                                    if j.has_key? ("effective_court_hearing") and j.has_key? ("adjournment")
                                        if j['effective_court_hearing'] == true and j['adjournment'] == false 
                                            @effective += 1
                                        elsif j['effective_court_hearing'] == false and j['adjournment'] == true
                                            @adjournment += 1
                                        end
                                    else
                                        if j.has_key? ("effective_court_hearing")
                                            @effective += 1
                                        elsif j.has_key? ("adjournment")
                                            @adjournment += 1
                                        end
                                    end
                                end
                            end
                        end
                    end
                    @total = @effective + @adjournment
                end
            end
            @data.push({
            "noOfCase" => @noOfCase,    
            "caseId" => @caseId,
            "courtName" => @courtName,
            "clientPsyudoname" => @clientPsyudoname,
            "outcome" => @outcome,
            "dateOfCognizance" => @dateOfCognizance,
            "dateJudgement" => @dateJudgement,
            "durationOfTrial" => @durationOfTrial,
            "effective" => @effective,
            "adjournment" => @adjournment,
            "total" => @total
            })
        end
		@start_date = start_date
		@end_date = (Date.parse(end_date)-1).to_s
		render "show_report"
	end
end
