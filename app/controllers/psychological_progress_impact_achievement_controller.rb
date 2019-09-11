class PsychologicalProgressImpactAchievementController < ApplicationController
    def index
		
	end

	def redirect_to_index
		redirect_to '/all_reports/psychological_progress_impact_achievement'
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

        psychosocial_data_count = Child.by_psychological_progress_impact_achievement.startkey([start_date]).endkey([end_date,{}])['rows']
        for year in year_array
            @family_stopped_blamming_child = 0
            @family_has_attended_atleast_3_parents_supp_grp = 0
            @family_understands_the_imp_of_being_reg_with_child = 0
            @family_understands_imp_of_self_care = 0
            @family_regular_with_counselling_of_child = 0
            @family_regular_with_counselling_of_self = 0
            @family_supports_child_in_cont_edu = 0
            @family_is_using_final_compensation_for_childs_benifits = 0
            @family_linked_to_social_sec_welfare_scheme = 0
            @increase_in_fam_know_under_of_csa = 0
            @family_unserderstands_imp_of_reg_with_child_court_heariing = 0
            @family_able_to_procure_basic_case_document = 0
            @complaint_of_domestic_violence = 0
            @reffereal_services_provided_to_family_mem = 0
            @family_domestic_vio_able_to_find_shelter = 0
            @mother_able_to_file_work_empolyment = 0
            for i in psychosocial_data_count
                if i['key'][0]!=nil
                    recieved_year = i['key'][0].split('-')[0]
                    if recieved_year.to_i == year
                        
                        if i['key'][1]!= nil and i['key'][1].length > 0
                            if i['key'][1][0]!= nil and i['key'][1][0].include? "yes" 
                                @family_stopped_blamming_child += 1
                            end
                            if i['key'][1][1]!= nil and i['key'][1][1].include? "yes" 
                                @family_has_attended_atleast_3_parents_supp_grp += 1
                            end
                            if i['key'][1][2]!= nil and i['key'][1][2].include? "yes" 
                                @family_understands_the_imp_of_being_reg_with_child += 1
                            end
                            if i['key'][1][3]!= nil and i['key'][1][3].include? "yes" 
                                @family_understands_imp_of_self_care += 1
                            end
                            if i['key'][1][4]!= nil and i['key'][1][4].include? "yes" 
                                @family_regular_with_counselling_of_child += 1
                            end
                            if i['key'][1][5]!= nil and i['key'][1][5].include? "yes" 
                                @family_regular_with_counselling_of_self += 1
                            end
                            if i['key'][1][6]!= nil and i['key'][1][6].include? "yes" 
                                @family_supports_child_in_cont_edu += 1
                            end
                            if i['key'][1][7]!= nil and i['key'][1][7].include? "yes" 
                                @family_is_using_final_compensation_for_childs_benifits += 1
                            end
                            if i['key'][1][8]!= nil and i['key'][1][8].include? "yes" 
                                @family_linked_to_social_sec_welfare_scheme += 1
                            end
                            if i['key'][1][9]!= nil and i['key'][1][9].include? "yes" 
                                @increase_in_fam_know_under_of_csa += 1
                            end
                            if i['key'][1][10]!= nil and i['key'][1][10].include? "yes" 
                                @family_unserderstands_imp_of_reg_with_child_court_heariing += 1
                            end
                            if i['key'][1][11]!= nil and i['key'][1][11].include? "yes" 
                                @family_able_to_procure_basic_case_document += 1
                            end
                            if i['key'][1][12]!= nil and i['key'][1][12].include? "yes" 
                                @complaint_of_domestic_violence += 1
                            end
                            if i['key'][1][13]!= nil and i['key'][1][13].include? "yes" 
                                @reffereal_services_provided_to_family_mem += 1
                            end
                            if i['key'][1][14]!= nil and i['key'][1][14].include? "yes" 
                                @family_domestic_vio_able_to_find_shelter += 1
                            end
                            if i['key'][1][15]!= nil and i['key'][1][15].include? "yes" 
                                @mother_able_to_file_work_empolyment += 1
                            end
                        end
                    end
                end
            end
            @data.push({
            "year" => year,
            "family_stopped_blamming_child" => @family_stopped_blamming_child,
            "family_has_attended_atleast_3_parents_supp_grp" => @family_has_attended_atleast_3_parents_supp_grp,
            "family_understands_the_imp_of_being_reg_with_child" => @family_understands_the_imp_of_being_reg_with_child,
            "family_understands_imp_of_self_care" => @family_understands_imp_of_self_care,
            "family_is_regular_with_childs_counselling_of_the_child" => @family_regular_with_counselling_of_child,
            "family_is_regular_with_counselling_for_self" => @family_regular_with_counselling_of_self,
            "family_supports_child_in_cont_edu" => @family_supports_child_in_cont_edu,
            "family_is_using_final_compensation_for_childs_benifits" => @family_is_using_final_compensation_for_childs_benifits,
            "family_linked_to_social_sec_welfare_scheme" => @family_linked_to_social_sec_welfare_scheme,
            "increase_in_fam_know_under_of_csa" => @increase_in_fam_know_under_of_csa,
            "family_unserderstands_imp_of_reg_with_child_court_heariing" => @family_unserderstands_imp_of_reg_with_child_court_heariing,
            "family_able_to_procure_basic_case_document" => @family_able_to_procure_basic_case_document,
            "complaint_of_domestic_violence" => @complaint_of_domestic_violence,
            "reffereal_services_provided_to_family_mem" => @reffereal_services_provided_to_family_mem,
            "family_domestic_vio_able_to_find_shelter" => @family_domestic_vio_able_to_find_shelter,
            "mother_able_to_file_work_empolyment" => @mother_able_to_file_work_empolyment
            })
        end
        @start_date = start_date
        @end_date = (Date.parse(end_date)-1).to_s 
        render "show_report"
	end	
end
