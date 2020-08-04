class StatusOnFinancialNeedsController < ApplicationController
	def index
		
	end
	
	def redirect_to_index
		redirect_to '/all_reports/status_on_financial_needs'
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
    
    status_on_financial_needs = Child.by_status_on_financial_needs.startkey([start_date]).endkey([end_date,{}])['rows']
    
    for year in year_array
		@no_of_total_cases = 0
		@assessed_need_identified = 0
		@assessed_no_need_identified = 0
		@financial_met_partially = 0
		@efforts_ongoing = 0
		@could_not_meet_reason = 0
		@status_financial = 0
		@financial_needs = 0
		@total_financial_need = 0
		@trying = 0
		@reviewing = 0
		@appy_for_final = 0
		@applied_pending = 0

		for i in status_on_financial_needs
			if i['key'][0].split("-")[0].to_i == year
				if i['key'][1][0]!=nil and i['key'][1][1]!=nil and i['key'][1][2]!=nil
					if i['key'][1][0].include? "psy_so_99767" or i['key'][1][0].include? "psy_so_cum_legal_17991" and i['key'][1][2].include? "approved"
						@no_of_total_cases += 1 
					end
				end
			end
			
			if  i['key'][1][3]!= nil
				for j in i['key'][1][3]
					if j.has_key?('psychosocial_need_financial')
						if j['psychosocial_need_financial'].include? "need_identified"
							@assessed_need_identified += 1
						end
					end
					if j.has_key?('psychosocial_need_financial')
						if j['psychosocial_need_financial'].exclude? "no_need_assessment_done"
							@total_financial_need += 1
						end
					end
					if j.has_key?('need_fulfilment_financial')
						if j['need_fulfilment_financial'].include? "partially_met" or j['need_fulfilment_financial'].include? "fully_met"
							@financial_met_partially += 1
						end
					end
					if j.has_key?('need_fulfilment_financial')
						if j['need_fulfilment_financial'].include? "efforts_ongoing"
							@efforts_ongoing += 1
						end
					end
					if j.has_key?('need_fulfilment_financial')
						if j['need_fulfilment_financial'].include? "could_not_be_met_reason"
							@could_not_meet_reason += 1
						end
					end
					if j.has_key?('need_fulfilment_financial') and j.has_key?('ongoing_effect_financial_needs') 
						if j['need_fulfilment_financial'].include? "efforts_ongoing" and j['ongoing_effect_financial_needs'].include? "trying_for_other_social_security_schemes_as_interim_compensation_may_be_difficult_nature_of_case_and_circumstances_45618"
							@trying +=1
						end
						if j['ongoing_effect_financial_needs'].include? "not_applied_11372"  or j['ongoing_effect_financial_needs'].include? "reviewing_grounds_97162"  and j['need_fulfilment_financial'].include? "efforts_ongoing" 
							@reviewing +=1
						end
						if j['ongoing_effect_financial_needs'].include? "applied_21040" or j['ongoing_effect_financial_needs'].include? "pending_15746" and j['need_fulfilment_financial'].include? "efforts_ongoing" 
							@applied_pending +=1
						end
						if j['ongoing_effect_financial_needs'].include? "to_apply_for_final_compensation_43074"  and j['need_fulfilment_financial'].include? "efforts_ongoing" 
							@appy_for_final +=1
						end
					end 
				end
			end
			
		end
	end
		@start_date = start_date
		@end_date = (Date.parse(end_date)-1).to_s
		render "show_report"
	end
end
