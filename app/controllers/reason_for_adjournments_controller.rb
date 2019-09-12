class ReasonForAdjournmentsController < ApplicationController
	def index
		
	end

	def redirect_to_index
		redirect_to '/all_reports/reason_for_adjournments'
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
        
        adj_reason_array=[]
        reason_of_adjournment = Lookup.by_lookup_reason_of_adjournment['rows']
        for i in reason_of_adjournment[0]['key']
            adj_reason_array.push([i['id'],i['display_text']])
		end
				
		court_hearing_subform_data = Child.by_reason_of_adjournments.startkey([start_date]).endkey([end_date,{}])['rows']

		for reason in adj_reason_array
			for year in year_array
                @adjornments_count = 0
				for i in court_hearing_subform_data
					if i['key'][0]!=nil
						recieved_year = i['key'][0].split('-')[0]
						if recieved_year.to_i == year
							if i['key'][1]!=nil
								for j in i['key'][1] #----looping in all subforms of a case #
									if j.has_key? ("reasons_for_adjournment_court_hearing") and j["reasons_for_adjournment_court_hearing"].include? reason[0] #----match stage
										@adjornments_count += 1
									end
								end
							end
						end
					end
				end

				if !@data.empty?
					if_data_present = 0
					for i in @data
						if i['reason'] == reason[1]
							if_data_present += 1
							i['length'] += 1 
							i['data'].push({
								"year" => year,
                                "adjornments_count" => @adjornments_count
							})
							break
						end
					end
					if if_data_present == 0
						@data.push({
						"reason" => reason[1],
						"length" => 1,
						"data" => [
							{
								"year" => year,
                                "adjornments_count" => @adjornments_count
							}]
						})
					end
				else
					@data.push({
					"reason" => reason[1],
					"length" => 1,
					"data" => [
						{
							"year" => year,
                            "adjornments_count" => @adjornments_count
						}]
					})
				end
			end		
		end	
		
		for i in @data
			if i['length'] >= 2
				i['length'] += 1
				i['data'].push({
					"year" => 'Total',
                    "adjornments_count" => 0
				})

				length = i['length']-1

				for j in i['data']
					if j['year']!= 'Total'
                        i['data'][length]['adjornments_count'] += j['adjornments_count'] 
					end
				end
			end
		end

		@start_date = start_date
		@end_date = (Date.parse(end_date)-1).to_s
		render "show_report"
	end
end


