class RightfulConvictionIndicatorsController < ApplicationController
	def index
		
	end

	def redirect_to_index
        redirect_to '/all_reports/rightful_conviction_indicators'
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

		monthly_lawyer_vakalatnama = Child.by_vakalatnama_monthly_lawyer.startkey([start_date]).endkey([end_date,{}])['rows']
		indicator_three = Child.by_child_before_testimony.startkey([start_date]).endkey([end_date,{}])['rows']
		indicator_four = Child.by_judgement_is_pronounced.startkey([start_date]).endkey([end_date,{}])['rows']
		indicator_six = Child.by_bail_app_result.startkey([start_date]).endkey([end_date,{}])['rows']
		indicator_one = Child.by_closure_form_lawyer.startkey([start_date]).endkey([end_date,{}])['rows']

		@institution = 0
		@parentalsupport = 0
		@vakalatnamacount = 0
		@childpercent = 0
		@totalchildren= 0 
		@childtestimony = 0
		@conferencing_record = 0
		@court_record = 0
		@totaltestimony = 0

		@legalcount = 0
		@legaljudgement = 0
		@judgementpercent = 0
		@legalconvicted = 0
		@convictionpercent = 0

		@disposaldate = 0
		@appdispos = 0
		@lawdismissed = 0

		@incest = 0
		@incestdisposal = 0
		@reasonincest = 0
		@incestpercent = 0

		for year in year_array
			for i in monthly_lawyer_vakalatnama
				received_year = i['key'][0].split("-")[0].to_i
				if received_year== year
					if i["key"][1]!=nil and i["key"][1].length!= 0
						for j in i["key"][1][0]
							if j.has_key?('institutional_care_monthly_vakalatnama')
								if j['institutional_care_monthly_vakalatnama'] == true
									@institution += 1
								end
							end
							if j.has_key?('child_no_parental_support_monthly_vakalatnama')
								if j['child_no_parental_support_monthly_vakalatnama'] == true
									@parentalsupport += 1
								end
							end     
							if j.has_key?('date_of_signing_vakalatnama')
								if j['date_of_signing_vakalatnama']!=nil
									@vakalatnamacount += 1
								end
							end  
						end
					end
				end
			end	
			for k in indicator_three
				received_year = k['key'][0].split("-")[0].to_i
				if received_year== year
					if k['key'][1]== true and k['key'][2]!=nil
						@childtestimony += 1
					end
					if k['key'][1]== true and k['key'][2].include? "testimony_recorded_through_video_conferencing_08722"
						@conferencing_record += 1
					end
					if k['key'][1]== true and k['key'][2].include? "child_was_asked_to_come_to_court_to_testify_14555"
						@court_record += 1
					end
				end
			end

			for l in indicator_four
				received_year = l['key'][0].split("-")[0].to_i
				if received_year== year
					if l['key'][1]!= nil
						if l['key'][1].include? "legal_25204"
							@legalcount += 1
						end
						if l['key'][1].include? "legal_25204" and l['key'][2]!=nil
							@legaljudgement += 1
						end
						if l['key'][1].include? "legal_25204" and l['key'][2]!=nil and l['key'][3].include? "convicted_37330"
							@legalconvicted += 1
						end
					end
				end
			end

			for m in indicator_six
				received_year = m['key'][0].split("-")[0].to_i
				if received_year== year
					if m['key'][1]!=0
						@disposaldate +=1
					end
					if m['key'][1]!=0 and m['key'][3]!=nil
						if m['key'][1]!=0 and m['key'][3]==true
							@appdispos +=1
						end
					end
					if m['key'][1]!=0 and m['key'][2]!=nil and m['key'][3]!=nil
						if m['key'][1]!=0 and m['key'][2].include? "dismissed_09645" and m['key'][3]==true
							@lawdismissed +=1
						end
					end
				end
			end

			for n in indicator_one
				received_year = n['key'][0].split("-")[0].to_i
				if received_year== year
					if n['key'][1]!=nil
						if n['key'][1].include? "incest_47243"
							@incest +=1
						end
						if n['key'][1].include? "incest_and_disability_70022"
							@incestdisposal +=1
						end
						if n['key'][2]!=nil and n['key'][3]!=nil
							if n['key'][2].include? "leg_66044" and n['key'][3].include? "it_is_a_case_of_incest_and_child_has_turned_hostile_82909"
								@reasonincest += 1
							end
						end
					end 


				end
			end


			
		end
		#-------indicator 1 ---------#
		@totalincest = @incest + @incestdisposal
		if @totalincest!=0
			@incestpercent = (@reasonincest.to_f/@totalincest.to_f)*100.round
		end

		#-------indicator 2 ---------#
		@totalchildren = @institution + @parentalsupport
			if @totalchildren!=0
				@childpercent = (@vakalatnamacount.to_f/@totalchildren.to_f)*100.round
			end

		#-------indicator 3 ---------#
		@totaltestimony = @conferencing_record + @court_record
			if @totaltestimony!=0
				@testimonypercent = (@totaltestimony.to_f/@childtestimony.to_f)*100.round 
			end

		#-------indicator 4 ---------#
			@judgementpercent = (@legaljudgement.to_f/@legalcount.to_f)*100.round

		#-------indicator 5 ---------#
			@convictionpercent = (@legalconvicted.to_f/@legaljudgement.to_f)*100.round

		#-------indicator 6 ---------#
			@bailpercent = (@lawdismissed.to_f/@appdispos.to_f)*100.round

		render "show_report"
		@start_date = start_date
		@end_date = (Date.parse(end_date)-1).to_s
	end
end
