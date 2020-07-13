class BailInterimCompensationController < ApplicationController
	def index
		
	end

	def redirect_to_index
		redirect_to '/all_reports/bail_interim_compensation'
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
        
        stage_array=[]
        stages_of_a_legal_case = Lookup.by_lookup_stages_of_a_legal_case['rows']
        for i in stages_of_a_legal_case[0]['key']
            stage_array.push([i['id'],i['display_text']])
        end
		
		bail_interim_compensation_witness_protection = Child.by_bail_interim_compensation_witness_protection.startkey([start_date]).endkey([end_date,{}])['rows']
		
		for stage in stage_array
			for year in year_array
				@court_hearings = 0
				@no_of_cases = 0
				@hearing_atend_by_haq_lawyer = 0
				@no_of_heaing_missed_by_haq_lawyer = 0
				@no_info_avail_abt_hearing_date = 0
				@valkatname_not_signed = 0
				@no_lawyer_appoint = 0
				@valkatnama_signed_bt_no_lawyer_appoint = 0
				@no_need_of_lawyer_presence = 0
				
				for i in bail_interim_compensation_witness_protection
					if i['key'][0]!=nil
						recieved_year = i['key'][0].split('-')[0]
						if recieved_year.to_i == year
							if i['key'][1]!=nil
								if_stage_present = 0
								for j in i['key'][1] #----looping in all subforms of a case #
									if j.has_key? ("stage") and j["stage"].include? stage[0] #----match stage
										if_stage_present += 1 
										@court_hearings += 1
										if j.has_key? ("lawyer_present_for_hearing") and j['lawyer_present_for_hearing'].include? "yes"
											@hearing_atend_by_haq_lawyer += 1
										else
											@no_of_heaing_missed_by_haq_lawyer += 1
										end
										
										if j.has_key? ("reason_lawyer_absent_court_hearing")
											if j['reason_lawyer_absent_court_hearing'].include? "no_information_available_about_hearing_date"
												@no_info_avail_abt_hearing_date += 1
											elsif j['reason_lawyer_absent_court_hearing'].include? "vakalatname_was_not_signed"
												@valkatname_not_signed += 1
											elsif j['reason_lawyer_absent_court_hearing'].include? "no_lawyer_was_appointed"
												@no_lawyer_appoint += 1
											elsif j['reason_lawyer_absent_court_hearing'].include? "vakalatnama_was_signed_but_no_lawyer_was_appointed"
												@valkatnama_signed_bt_no_lawyer_appoint += 1
											elsif j['reason_lawyer_absent_court_hearing'].include? "no_need_of_lawyer_s_presence"
												@no_need_of_lawyer_presence += 1
											end
										end
									end
								end
								if if_stage_present > 0 #check if stage present in that case
									@no_of_cases += 1
								end
							end
						end
					end
				end

				if !@data.empty?
					if_data_present = 0
					for i in @data
						if i['stage'] == stage[1]
							if_data_present += 1
							i['length'] += 1 
							i['data'].push({
								"year" => year,
								"court_hearings" => @court_hearings,
								"no_of_cases" => @no_of_cases,
								"hearing_atend_by_haq_lawyer" => @hearing_atend_by_haq_lawyer,
								"no_of_heaing_missed_by_haq_lawyer" => @no_of_heaing_missed_by_haq_lawyer,
								"no_info_avail_abt_hearing_date" => @no_info_avail_abt_hearing_date,
								"valkatname_not_signed" => @valkatname_not_signed,
								"no_lawyer_appoint" => @no_lawyer_appoint,
								"valkatnama_signed_bt_no_lawyer_appoint" => @valkatnama_signed_bt_no_lawyer_appoint,
								"no_need_of_lawyer_presence" => @no_need_of_lawyer_presence
							})
							break
						end
					end
					if if_data_present == 0
						@data.push({
						"stage" => stage[1],
						"length" => 1,
						"data" => [
							{
								"year" => year,
								"court_hearings" => @court_hearings,
								"no_of_cases" => @no_of_cases,
								"hearing_atend_by_haq_lawyer" => @hearing_atend_by_haq_lawyer,
								"no_of_heaing_missed_by_haq_lawyer" => @no_of_heaing_missed_by_haq_lawyer,
								"no_info_avail_abt_hearing_date" => @no_info_avail_abt_hearing_date,
								"valkatname_not_signed" => @valkatname_not_signed,
								"no_lawyer_appoint" => @no_lawyer_appoint,
								"valkatnama_signed_bt_no_lawyer_appoint" => @valkatnama_signed_bt_no_lawyer_appoint,
								"no_need_of_lawyer_presence" => @no_need_of_lawyer_presence
							}]
						})
					end
				else
					@data.push({
					"stage" => stage[1],
					"length" => 1,
					"data" => [
						{
							"year" => year,
							"court_hearings" => @court_hearings,
							"no_of_cases" => @no_of_cases,
							"hearing_atend_by_haq_lawyer" => @hearing_atend_by_haq_lawyer,
							"no_of_heaing_missed_by_haq_lawyer" => @no_of_heaing_missed_by_haq_lawyer,
							"no_info_avail_abt_hearing_date" => @no_info_avail_abt_hearing_date,
							"valkatname_not_signed" => @valkatname_not_signed,
							"no_lawyer_appoint" => @no_lawyer_appoint,
							"valkatnama_signed_bt_no_lawyer_appoint" => @valkatnama_signed_bt_no_lawyer_appoint,
							"no_need_of_lawyer_presence" => @no_need_of_lawyer_presence
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
					"court_hearings" => 0,
					"no_of_cases" => 0,
					"hearing_atend_by_haq_lawyer" => 0,
					"no_of_heaing_missed_by_haq_lawyer" => 0,
					"no_info_avail_abt_hearing_date" => 0,
					"valkatname_not_signed" => 0,
					"no_lawyer_appoint" => 0,
					"valkatnama_signed_bt_no_lawyer_appoint" => 0,
					"no_need_of_lawyer_presence" => 0
				})

				length = i['length']-1

				for j in i['data']
					if j['year']!= 'Total'
						i['data'][length]['court_hearings'] += j['court_hearings']
						i['data'][length]['no_of_cases'] += j['no_of_cases']
						i['data'][length]['hearing_atend_by_haq_lawyer'] += j['hearing_atend_by_haq_lawyer']
						i['data'][length]['no_of_heaing_missed_by_haq_lawyer'] += j['no_of_heaing_missed_by_haq_lawyer']
						i['data'][length]['no_info_avail_abt_hearing_date'] += j['no_info_avail_abt_hearing_date']
						i['data'][length]['valkatname_not_signed'] += j['valkatname_not_signed']
						i['data'][length]['no_lawyer_appoint'] += j['no_lawyer_appoint']
						i['data'][length]['valkatnama_signed_bt_no_lawyer_appoint'] += j['valkatnama_signed_bt_no_lawyer_appoint']
						i['data'][length]['no_need_of_lawyer_presence'] += j['no_need_of_lawyer_presence'] 
					end
				end
			end
		end

		@start_date = start_date
		@end_date = (Date.parse(end_date)-1).to_s
		render "show_report"
	end
end

