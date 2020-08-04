class LawyerNextDateOfHearingController < ApplicationController

	def index
		
	end

	def redirect_to_index
		redirect_to '/all_reports/lawyer_next_date_of_hearing'
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
		
	by_lawyer_next_hearing = Child.by_lawyer_next_date_of_hearing.startkey([start_date]).endkey([end_date,{}])['rows']
	
	for i in by_lawyer_next_hearing
		 if i['key'][0]!= nil and i['key'][0]!= ""
			if i['key'][1]!= nil and i['key'][1].length > 0
				@casename = "-"
				@hearingdate = "-"
				@nexthearing = "-"
				@court = "-"
				@stage = "-"
				@purpose = "-"
				@judge = "-"
				@causetitle = "-"
				@caseid = "-"
				@lawyer = "-"


				if i["key"][1][0]!= nil and i["key"][1][0]!= ""
                        @casename = i["key"][1][0]
                end
				
				if i["key"][1][1]!=nil
						if i["key"][1][1].has_key? ("date_of_hearing")
							@hearingdate = i["key"][1][1]["date_of_hearing"]
						end
						if i["key"][1][1].has_key? ("date_of_next_hearing")
							@nexthearing = i["key"][1][1]["date_of_next_hearing"]
						end		
						if i["key"][1][1].has_key? ("court")
							@court = i["key"][1][1]["court"].gsub! '_', ' '
						end
						if i["key"][1][1].has_key? ("stage")
							@stage = i["key"][1][1]["stage"].gsub! '_', ' '
						end		
						if i["key"][1][1].has_key? ("purpose")
							@purpose = i["key"][1][1]["purpose"]
						end	
						if i["key"][1][1].has_key? ("judge")
							@judge = i["key"][1][1]["judge"]
						end							
				end
				
				if i["key"][1][2]!= nil and i["key"][1][2]!= ""
                    @causetitle = i["key"][1][2]
                end
				
				if i["key"][1][3]!= nil and i["key"][1][3]!= ""
                   @caseid = i["key"][1][3]
                end
				
				if i["key"][1][4]!= nil and i["key"][1][4]!= ""
                   for j in i["key"][1][4]
						@lawyer = i["key"][1][4].grep(/lc/)
					end 
                end
				
			end
		 end

		 @data.push({
            "casename" => @casename,    
            "hearingdate" => @hearingdate,
			"nexthearing" => @nexthearing,
            "court" => @court.split(' ')[0...-1].join(' '),
            "stage" => @stage.split(' ')[0...-1].join(' '),
			"purpose" => @purpose,
			"judge" => @judge,
			"causetitle" => @causetitle,
			"caseid" => @caseid,
			"lawyer" => @lawyer
            })
	end
	@start_date = start_date
		@end_date = (Date.parse(end_date)-1).to_s
		render "show_report"

	end
	end