class StatusOfPsychosocialController < ApplicationController
    def index
		
	end

	def redirect_to_index
		redirect_to '/all_reports/status_of_psychosocial'
	end

	def submit_form
		start_date = params[:start_date]
		end_date = params[:end_date]
		end_date = (Date.parse(end_date)+1).to_s
		calculate_report(start_date,end_date)
	end

	def calculate_report(start_date, end_date)
        @data = []
     
        @type_of_need = [['Emotional/Psychological','psychosocial_need_emotional','need_fulfilment_emotional'],['Medical Needs','psychosocial_need_medical','need_fulfilment_medical'],['Shelter/Protection Needs','psychosocial_need_shelter_protection','need_fulfilment_shelter_protection'],['Educational/ Vocational','psychosocial_need_educational_vocational','need_fulfilment_educational_vocational'],['Financial Needs','psychosocial_need_financial','need_fulfilment_financial'],['Paralegal Needs','psychosocial_need_paralegal','need_fulfilment_paralegal'],['Familial Needs','psychosocial_need_familial','need_fulfilment_familial']]
        
        total_cases = Child.all['total_rows']

		
		psychosocial_data_count = Child.by_status_of_psychosocial.startkey([start_date]).endkey([end_date,{}])['rows']
		
        for need in @type_of_need
            @assessment_made = 0
            @no_need_assessment_done = 0
            @no_need_identified = 0
            @need_re_occured = 0
            @need_identified = 0
            @need_fulfilled_fully_met = 0
            @need_fulfilled_partially_met = 0
            @could_not_be_met = 0
            @efforts_ongoing = 0
            for i in psychosocial_data_count
                if i['key'][0]!=nil
                    if i['key'][1]!= nil and i['key'][1].length > 0
                        for j in i['key'][1]
                            if j.has_key? (need[1]) 
                                @assessment_made += 1
                                if j[need[1]].include? "need_identified_19219"
                                    @need_identified += 1
                                elsif j[need[1]].include? "need_re_occurred"
                                    @need_re_occured += 1
                                elsif j[need[1]].include? "no_need_identified"
                                    @no_need_identified += 1
                                elsif j[need[1]].include? "no_need_assessment_done"
                                    @no_need_assessment_done += 1
                                end
                            end

                            if j.has_key? (need[2])
                                if j[need[2]].include? "efforts_ongoing"
                                    @efforts_ongoing += 1
                                elsif j[need[2]].include? "partially_met"
                                    @need_fulfilled_partially_met += 1
                                elsif j[need[2]].include? "fully_met"
                                    @need_fulfilled_fully_met += 1
                                elsif j[need[2]].include? "could_not_be_met_reason"
                                    @could_not_be_met += 1
                                end
                            end
                        end
                    end
                end
            end
            total = @assessment_made + @no_need_assessment_done + @no_need_identified + @need_re_occured + @need_identified + @need_fulfilled_fully_met + @need_fulfilled_partially_met + @could_not_be_met + @efforts_ongoing

            @data.push({
            "need" => need[0],
            "length" => 1,
            "total_cases" => total_cases,
            "assessment_made" => @assessment_made,
            "no_need_assessment_done" => @no_need_assessment_done,
            "no_need_identified" => @no_need_identified,
            "need_re_occured" => @need_re_occured,
            "need_identified" => @need_identified,
            "need_fulfilled_fully_met" => @need_fulfilled_fully_met,
            "need_fulfilled_partially_met" => @need_fulfilled_partially_met,
            "could_not_be_met" => @could_not_be_met,
            "efforts_ongoing" => @efforts_ongoing,
            "total" => total
            })
        end

        @data.push({
            "need" => "Total",
            "length" => 1,
            "total_cases" => total_cases,
            "assessment_made" => 0,
            "no_need_assessment_done" => 0,
            "no_need_identified" => 0,
            "need_re_occured" => 0,
            "need_identified" => 0,
            "need_fulfilled_fully_met" => 0,
            "need_fulfilled_partially_met" => 0,
            "could_not_be_met" => 0,
            "efforts_ongoing" => 0,
            "total" => total
            })

        length = 7

		for i in @data
            if i['need']!= 'Total'
                @data[length]['assessment_made'] += i['assessment_made']
                @data[length]['no_need_assessment_done'] += i['no_need_assessment_done']
                @data[length]['no_need_identified'] += i['no_need_identified']
                @data[length]['need_re_occured'] += i['need_re_occured']
                @data[length]['need_identified'] += i['need_identified']
                @data[length]['need_fulfilled_fully_met'] += i['need_fulfilled_fully_met']
                @data[length]['need_fulfilled_partially_met'] += i['need_fulfilled_partially_met']
                @data[length]['could_not_be_met'] += i['could_not_be_met'] 
                @data[length]['efforts_ongoing'] += i['efforts_ongoing'] 
                @data[length]['total'] += i['total'] 
            end
		end

		@start_date = start_date
		@end_date = (Date.parse(end_date)-1).to_s
		render "show_report"
	end	
end
