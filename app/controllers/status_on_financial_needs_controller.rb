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
			@application_filed_on_interim = 0
			@interim_compensation_status = 0
			@financial_needs = 0
			@application_filed_on_final = 0
			
			for i in status_on_financial_needs
				if i['key'][0].split("-")[0].to_i == year
					if i['key'][1][0]!=nil and i['key'][1][1]!=nil and i['key'][1][2]!=nil
						if i['key'][1][0]!= "referral" and i['key'][1][1].include? "open" and i['key'][1][2].include? "approved"
							@no_of_total_cases += 1 
						end
					end
					if i['key'][1][4] == nil
						@application_filed_on_interim += 1
					end
					if i ['key'][1][5]!=nil
						if i ['key'][1][5].include? "pending"
							@interim_compensation_status += 1
						end
					end
					if i ['key'][1][6] == nil
						@application_filed_on_final += 1
					end
					for j in i['key'][1][3]
						if j.has_key?('psychosocial_need_financial')
							if j['psychosocial_need_financial'].include? "need_identified"
								@assessed_need_identified += 1
							end
						end
						if j.has_key?('psychosocial_need_financial')
							if j['psychosocial_need_financial'].include? "no_need_identified"
								@assessed_no_need_identified += 1
							end
						end
						if j.has_key?('need_fulfilment_financial')
							if j['need_fulfilment_financial'].include? "partially_met"
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
						if j.has_key?('status_financial')
							if j['status_financial']!= nil and j['status_financial']!= ''
								@status_financial += 1
							end
						end
						if j.has_key?('financial_needs') and j.has_key?('psychosocial_need_financial')
							if j['financial_needs'].include? "survivor_and_or_family_member_s_can_avail_the_benefits_of_social_security_schemes_such_as_disability_benefits_ladli_yojna_old_age_pension_widow_pension_etc_need_to_be_referred_connected_to_relevant_schemes_38829" and j['psychosocial_need_financial'].include? "need_identified_19219"
								@financial_needs += 1
							end
						end
					end
					@total_financial_need = @assessed_need_identified + @assessed_no_need_identified 
				end
			end
		end
		@start_date = start_date
		@end_date = (Date.parse(end_date)-1).to_s
		render "show_report"
	end
end
