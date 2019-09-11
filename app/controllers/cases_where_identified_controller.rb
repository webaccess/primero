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
		@inability_reasons=[]

		reason_for_inability_to_meet = Lookup.by_reason_for_inability_to_meet['rows']
		for i in reason_for_inability_to_meet[0]['key']
			if !i["id"].include? "any_other"
				@data.push({
					"id" => i["id"],
					"reason" => i["display_text"],
					"reason_emotional" => 0,
					"reason_medical" => 0,
					"reason_shelter_protection" => 0,
					"reason_educational_vocational" => 0,
					"reason_financial" => 0,
					"reason_paralegal" => 0,
					"reason_familial" => 0
				})
			end
		end

		type_of_need = [["reason_emotional", "other_emotional" ], ["reason_medical", "other_medical" ], ["reason_shelter_protection", "other_shelter_protection" ], ["reason_educational_vocational", "other_educational_vocational" ], ["reason_financial", "other_financial" ], ["reason_paralegal", "other_paralegal" ], ["reason_familial", "other_familial" ]]

		cases_where_identified_res_not_met = Child.by_cases_where_identified_res_not_met.startkey([start_date]).endkey([end_date,{}])['rows']	
		
		if cases_where_identified_res_not_met!=nil and cases_where_identified_res_not_met.length!= 0
			for i in cases_where_identified_res_not_met
				for reason in type_of_need
					for j in i["key"][1]
						if j.has_key? (reason[0]) and j[reason[0]]!= nil
							if j[reason[0]].include? "any_other"
								if j.has_key? (reason[1]) and j[reason[1]]!= nil and j[reason[1]]!= ""
									data_present = 0
									for data in @data
										if data["reason"] == j[reason[1]]
											data_present += 1
											data[reason[0]] += 1
											break
										end	
									end
									if data_present == 0
										@data.push({
											"id" => j[reason[1]],
											"reason" => j[reason[1]],
											"reason_emotional" => 0,
											"reason_medical" => 0,
											"reason_shelter_protection" => 0,
											"reason_educational_vocational" => 0,
											"reason_financial" => 0,
											"reason_paralegal" => 0,
											"reason_familial" => 0
										})
										for data in @data
											if data["reason"] == j[reason[1]]
												data[reason[0]] += 1
												break
											end	
										end
									end
								end
							else
								for data in @data
									if data["id"] == j[reason[0]]
										data[reason[0]] += 1
										break
									end	
								end
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











