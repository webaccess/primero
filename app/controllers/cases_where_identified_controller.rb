class CasesWhereIdentifiedController < ApplicationController
	def index
		
	end

	def redirect_to_index
		redirect_to '/all_reports/cases_where_identified'
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
        
		@inability_to_meet=[]
		@teststs=[]
		reason_for_inability_to_meet = Lookup.by_reason_for_inability_to_meet['rows']
		for i in reason_for_inability_to_meet[0]['key']
			@teststs.push(i['id'])
			@inability_to_meet.push({"display_text":i['display_text']})
		end

		
		cases_where_ident = Child.by_cases_where_identified_res_not_met.startkey([start_date]).endkey([end_date,{}])['rows']
		
		@reason_emotional = 0
		@reason_medical = 0
		@reason_shelter_protection = 0
		@reason_educational_vocational = 0
		@reason_paralegal = 0
		@reason_familial = 0

			for year in year_array
				for k in cases_where_ident
					if k['key'][0].split("-")[0].to_i == year
						for j in k['key'][1]
							if j.has_key?('reason_emotional')
								#if j['reason_emotional'].include? "child_committed_suicide_94761"
								if j['reason_emotional'] != nil
									emotional = j['reason_emotional']
									test1 = @teststs.any?{|o| o[emotional]}
									if (test1 == true)
										@reason_emotional +=1
									end

								end
							end
							if j.has_key?('reason_medical')
								#if j['reason_medical'].include? "child_restored_to_family_and_ran_away_80737"
								if j['reason_medical'] != nil
									@reason_medical += 1
									
								end
							end
						end
					end
				end
			end
			puts "result"
			puts @reason_emotional

		@start_date = start_date
		@end_date = (Date.parse(end_date)-1).to_s
		render "show_report"
	end
end











