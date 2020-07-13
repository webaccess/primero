Primero::Application.routes.draw do
  match '/' => 'home#index', :as => :root, :via => :get
  match '/_notify_change' => 'couch_changes#notify', :via => :get

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

#######################
# USER URLS
#######################

  match '/all_reports' => 'all_reports#index', :as => :reports_list, :via => :get
  
  # legal_cases_closed
  match '/all_reports/legal_cases_closed' => 'legal_cases_closed#index', :as => :legal_cases_closed_index, :via => :get
  match '/all_reports/legal_cases_closed/submit_form' => 'legal_cases_closed#submit_form', :as => :legal_cases_closed_submit_form, :via => :post
  match '/all_reports/legal_cases_closed/submit_form' => 'legal_cases_closed#redirect_to_index', :as => :legal_cases_closed_redirect_to_index, :via => :get
	
	# bail_application_moved
  match '/all_reports/bail_application_moved' => 'bail_application_moved#index', :as => :bail_application_moved_index, :via => :get
  match '/all_reports/bail_application_moved/submit_form' => 'bail_application_moved#submit_form', :as => :bail_application_moved_submit_form, :via => :post
  match '/all_reports/bail_application_moved/submit_form' => 'bail_application_moved#redirect_to_index', :as => :bail_application_moved_redirect_to_index, :via => :get
	
	# cases_closed_by_lawyers
  match '/all_reports/cases_closed_by_lawyers' => 'cases_closed_by_lawyers#index', :as => :cases_closed_by_lawyers_index, :via => :get
  match '/all_reports/cases_closed_by_lawyers/submit_form' => 'cases_closed_by_lawyers#submit_form', :as => :cases_closed_by_submit_form, :via => :post
  match '/all_reports/cases_closed_by_lawyers/submit_form' => 'cases_closed_by_lawyers#redirect_to_index', :as => :cases_closed_by_redirect_to_index, :via => :get
	
	# secondary_psychological_care
  match '/all_reports/secondary_psychological_care' => 'secondary_psychological_care#index', :as => :secondary_psychological_care_lawyers_index, :via => :get
  match '/all_reports/secondary_psychological_care/submit_form' => 'secondary_psychological_care#submit_form', :as => :secondary_psychological_care_submit_form, :via => :post
  match '/all_reports/secondary_psychological_care/submit_form' => 'secondary_psychological_care#redirect_to_index', :as => :secondary_psychological_care_redirect_to_index, :via => :get
	
	# tertiary_psychological_care
  match '/all_reports/tertiary_psychological_care' => 'tertiary_psychological_care#index', :as => :tertiary_psychological_care_index, :via => :get
  match '/all_reports/tertiary_psychological_care/submit_form' => 'tertiary_psychological_care#submit_form', :as => :tertiary_psychological_care_submit_form, :via => :post
  match '/all_reports/tertiary_psychological_care/submit_form' => 'tertiary_psychological_care#redirect_to_index', :as => :tertiary_psychological_care_redirect_to_index, :via => :get
  
  # details of case intake & closure
  match '/all_reports/detail_case_intake_closure' => 'detail_case_intake_closure#index', :as => :detail_case_intake_closure_index, :via => :get
  match '/all_reports/detail_case_intake_closure/submit_form' => 'detail_case_intake_closure#submit_form', :as => :detail_case_intake_closure_submit_form, :via => :post
  match '/all_reports/detail_case_intake_closure/submit_form' => 'detail_case_intake_closure#redirect_to_index', :as => :detail_case_intake_closure_redirect_to_index, :via => :get
	
	# status_on_victim_compensation
  match '/all_reports/status_on_victim_compensation' => 'status_on_victim_compensation#index', :as => :status_on_victim_compensation_index, :via => :get
  match '/all_reports/status_on_victim_compensation/submit_form' => 'status_on_victim_compensation#submit_form', :as => :status_on_victim_compensation_submit_form, :via => :post
  match '/all_reports/status_on_victim_compensation/submit_form' => 'status_on_victim_compensation#redirect_to_index', :as => :status_on_victim_compensation_redirect_to_index, :via => :get
	
  # victim_compensation_disposed
  match '/all_reports/victim_compensation_disposed' => 'victim_compensation_disposed#index', :as => :victim_compensation_disposed_index, :via => :get
  match '/all_reports/victim_compensation_disposed/submit_form' => 'victim_compensation_disposed#submit_form', :as => :victim_compensation_disposed_submit_form, :via => :post
  match '/all_reports/victim_compensation_disposed/submit_form' => 'victim_compensation_disposed#redirect_to_index', :as => :victim_compensation_disposed_redirect_to_index, :via => :get
	
  # list_of_trainings
  match '/all_reports/list_of_trainings' => 'list_of_trainings#index', :as => :list_of_trainings_index, :via => :get
  match '/all_reports/list_of_trainings/submit_form' => 'list_of_trainings#submit_form', :as => :list_of_trainings_submit_form, :via => :post
  match '/all_reports/list_of_trainings/submit_form' => 'list_of_trainings#redirect_to_index', :as => :list_of_trainings_redirect_to_index, :via => :get
	
	# high_court_iprobono
  match '/all_reports/high_court_iprobono' => 'high_court_iprobono#index', :as => :high_court_iprobono_index, :via => :get
  match '/all_reports/high_court_iprobono/submit_form' => 'high_court_iprobono#submit_form', :as => :high_court_iprobono_submit_form, :via => :post
  match '/all_reports/high_court_iprobono/submit_form' => 'high_court_iprobono#redirect_to_index', :as => :high_court_iprobono_redirect_to_index, :via => :get
	
	# trial_court_cases
  match '/all_reports/trial_court_cases' => 'trial_court_cases#index', :as => :trial_court_cases_index, :via => :get
  match '/all_reports/trial_court_cases/submit_form' => 'trial_court_cases#submit_form', :as => :trial_court_cases_submit_form, :via => :post
  match '/all_reports/trial_court_cases/submit_form' => 'trial_court_cases#redirect_to_index', :as => :trial_court_cases_redirect_to_index, :via => :get
	
	# overall_psychosocial_cases
  match '/all_reports/overall_psychosocial_cases' => 'overall_psychosocial_cases#index', :as => :overall_psychosocial_cases_index, :via => :get
  match '/all_reports/overall_psychosocial_cases/submit_form' => 'overall_psychosocial_cases#submit_form', :as => :overall_psychosocial_cases_submit_form, :via => :post
  match '/all_reports/overall_psychosocial_cases/submit_form' => 'overall_psychosocial_cases#redirect_to_index', :as => :overall_psychosocial_cases_redirect_to_index, :via => :get
  
  # appeal_in_appellate
  match '/all_reports/appeal_in_appellate' => 'appeal_in_appellate#index', :as => :appeal_in_appellate_index, :via => :get
  match '/all_reports/appeal_in_appellate/submit_form' => 'appeal_in_appellate#submit_form', :as => :appeal_in_appellate_submit_form, :via => :post
  match '/all_reports/appeal_in_appellate/submit_form' => 'appeal_in_appellate#redirect_to_index', :as => :appeal_in_appellate_redirect_to_index, :via => :get
	
	# status_on_financial_needs
  match '/all_reports/status_on_financial_needs' => 'status_on_financial_needs#index', :as => :status_on_financial_needs_index, :via => :get
  match '/all_reports/status_on_financial_needs/submit_form' => 'status_on_financial_needs#submit_form', :as => :status_on_financial_needs_submit_form, :via => :post
  match '/all_reports/status_on_financial_needs/submit_form' => 'status_on_financial_needs#redirect_to_index', :as => :status_on_financial_needs_redirect_to_index, :via => :get

  # rightful_conviction_indicators
  match '/all_reports/rightful_conviction_indicators' => 'rightful_conviction_indicators#index', :as => :rightful_conviction_indicators_index, :via => :get
  match '/all_reports/rightful_conviction_indicators/submit_form' => 'rightful_conviction_indicators#submit_form', :as => :rightful_conviction_indicators_submit_form, :via => :post
  match '/all_reports/rightful_conviction_indicators/submit_form' => 'rightful_conviction_indicators#redirect_to_index', :as => :rightful_conviction_indicators_redirect_to_index, :via => :get
	
	# victim_testimony_preparation
  match '/all_reports/victim_testimony_preparation' => 'victim_testimony_preparation#index', :as => :victim_testimony_preparation_index, :via => :get
  match '/all_reports/victim_testimony_preparation/submit_form' => 'victim_testimony_preparation#submit_form', :as => :victim_testimony_preparation_submit_form, :via => :post
  match '/all_reports/victim_testimony_preparation/submit_form' => 'victim_testimony_preparation#redirect_to_index', :as => :victim_testimony_preparation_redirect_to_index, :via => :get
	
	#-----------------------------------------------------------------------------------------------------------------------------#
	#bail_interim_compensation 
  match '/all_reports/bail_interim_compensation' => 'bail_interim_compensation#index', :as => :bail_interim_compensation, :via => :get
  match '/all_reports/bail_interim_compensation/submit_form' => 'bail_interim_compensation#submit_form', :as => :bail_interim_compensation_submit_form, :via => :post
  match '/all_reports/bail_interim_compensation/submit_form' => 'bail_interim_compensation#redirect_to_index', :as => :bail_interim_compensation_redirect_to_index, :via => :get

  # supported_by_lawyers
  match '/all_reports/supported_by_lawyers' => 'supported_by_lawyers#index', :as => :supported_by_lawyers_index, :via => :get
  match '/all_reports/supported_by_lawyers/submit_form' => 'supported_by_lawyers#submit_form', :as => :supported_by_lawyers_submit_form, :via => :post
  match '/all_reports/supported_by_lawyers/submit_form' => 'supported_by_lawyers#redirect_to_index', :as => :supported_by_lawyers_redirect_to_index, :via => :get

  # reason_for_adjournments
  match '/all_reports/reason_for_adjournments' => 'reason_for_adjournments#index', :as => :reason_for_adjournments_index, :via => :get
  match '/all_reports/reason_for_adjournments/submit_form' => 'reason_for_adjournments#submit_form', :as => :reason_for_adjournments_submit_form, :via => :post
  match '/all_reports/reason_for_adjournments/submit_form' => 'reason_for_adjournments#redirect_to_index', :as => :reason_for_adjournments_redirect_to_index, :via => :get

  # status_of_psychosocial
  match '/all_reports/status_of_psychosocial' => 'status_of_psychosocial#index', :as => :status_of_psychosocial_index, :via => :get
  match '/all_reports/status_of_psychosocial/submit_form' => 'status_of_psychosocial#submit_form', :as => :status_of_psychosocial_submit_form, :via => :post
  match '/all_reports/status_of_psychosocial/submit_form' => 'status_of_psychosocial#redirect_to_index', :as => :status_of_psychosocial_redirect_to_index, :via => :get

  # cases_where_identified
  match '/all_reports/cases_where_identified' => 'cases_where_identified#index', :as => :cases_where_identified_index, :via => :get
  match '/all_reports/cases_where_identified/submit_form' => 'cases_where_identified#submit_form', :as => :cases_where_identified_submit_form, :via => :post
  match '/all_reports/cases_where_identified/submit_form' => 'cases_where_identified#redirect_to_index', :as => :cases_where_identified_redirect_to_index, :via => :get

  # Table 6A
  # progress_impact_achievement_psychological_needs_filled_by_social_worker
  match '/all_reports/psychological_progress_impact_achievement' => 'psychological_progress_impact_achievement#index', :as => :psychological_progress_impact_achievement_index, :via => :get
  match '/all_reports/psychological_progress_impact_achievement/submit_form' => 'psychological_progress_impact_achievement#submit_form', :as => :psychological_progress_impact_achievement_submit_form, :via => :post
  match '/all_reports/psychological_progress_impact_achievement/submit_form' => 'psychological_progress_impact_achievement#redirect_to_index', :as => :psychological_progress_impact_achievement_redirect_to_index, :via => :get

  # Table 9
  # judgement_status web e
  match '/all_reports/judgement_status' => 'judgement_status#index', :as => :judgement_status_index, :via => :get
  match '/all_reports/judgement_status/submit_form' => 'judgement_status#submit_form', :as => :judgement_status_submit_form, :via => :post
  match '/all_reports/judgement_status/submit_form' => 'judgement_status#redirect_to_index', :as => :judgement_status_redirect_to_index, :via => :get
  
  # Table 10----------------------------
  # Disposal
  match '/all_reports/disposal' => 'disposal#index', :as => :disposal_index, :via => :get
  match '/all_reports/disposal/submit_form' => 'disposal#submit_form', :as => :disposal_submit_form, :via => :post
  match '/all_reports/disposal/submit_form' => 'disposal#redirect_to_index', :as => :disposal_redirect_to_index, :via => :get

  # Cases where trial completed
  match '/all_reports/cases_where_trial_completed' => 'cases_where_trial_completed#index', :as => :cases_where_trial_completed_index, :via => :get
  match '/all_reports/cases_where_trial_completed/submit_form' => 'cases_where_trial_completed#submit_form', :as => :cases_where_trial_completed_submit_form, :via => :post
  match '/all_reports/cases_where_trial_completed/submit_form' => 'cases_where_trial_completed#redirect_to_index', :as => :cases_where_trial_completed_redirect_to_index, :via => :get

  # Time taken in disposal of cases
  match '/all_reports/time_taken_in_disposal_of_cases' => 'time_taken_in_disposal_of_cases#index', :as => :time_taken_in_disposal_of_cases_index, :via => :get
  match '/all_reports/time_taken_in_disposal_of_cases/submit_form' => 'time_taken_in_disposal_of_cases#submit_form', :as => :time_taken_in_disposal_of_cases_submit_form, :via => :post
  match '/all_reports/time_taken_in_disposal_of_cases/submit_form' => 'time_taken_in_disposal_of_cases#redirect_to_index', :as => :time_taken_in_disposal_of_cases_redirect_to_index, :via => :get
  # ---------------------------------------

# Table annexure-03----------------------------------
  # --Time taken for completion of childs testimony
  # Time taken in disposal of cases
  match '/all_reports/time_taken_for_completion_of_childs_testimony' => 'time_taken_for_completion_of_childs_testimony#index', :as => :time_taken_for_completion_of_childs_testimony_index, :via => :get
  match '/all_reports/time_taken_for_completion_of_childs_testimony/submit_form' => 'time_taken_for_completion_of_childs_testimony#submit_form', :as => :time_taken_for_completion_of_childs_testimony_submit_form, :via => :post
  match '/all_reports/time_taken_for_completion_of_childs_testimony/submit_form' => 'time_taken_for_completion_of_childs_testimony#redirect_to_index', :as => :time_taken_for_completion_of_childs_testimony_redirect_to_index, :via => :get
  # ----------------------------------------------------
	
# Table Lawyer
  # Lawyer's next date of hearing  
  match '/all_reports/lawyer_next_date_of_hearing' => 'lawyer_next_date_of_hearing#index', :as => :lawyer_next_date_of_hearing_index, :via => :get
  match '/all_reports/lawyer_next_date_of_hearing/submit_form' => 'lawyer_next_date_of_hearing#submit_form', :as => :lawyer_next_date_of_hearing_submit_form, :via => :post
  match '/all_reports/lawyer_next_date_of_hearing/submit_form' => 'lawyer_next_date_of_hearing#redirect_to_index', :as => :lawyer_next_date_of_hearing_redirect_to_index, :via => :get

  resource :general_report

  
  resources :summary_of_cases

  resources :trial_completed
  
  
  resources :status_as_on

	
	#resources :case_intake_and_closure
  
  resources :family_members_impact do
    collection do
      post :submit_form
      end
    end
	
	resources :sensitisation_trainings
	
  resources :users do
    collection do
      get :change_password
      get :unverified
      post :update_password
      post :import_file
    end
  end
  match '/users/register_unverified' => 'users#register_unverified', :as => :register_unverified_user, :via => :post

  resources :sessions, :except => :index
  match 'login' => 'sessions#new', :as => :login, :via => [:post, :get, :put, :delete]
  match 'logout' => 'sessions#destroy', :as => :logout, :via => [:post, :get, :put, :delete]
  match '/active' => 'sessions#active', :as => :session_active, :via => [:post, :get, :put, :delete]

  resources :user_preferences
  resources :password_recovery_requests, :only => [:new, :create]
  match 'password_recovery_request/:password_recovery_request_id/hide' => 'password_recovery_requests#hide', :as => :hide_password_recovery_request, :via => :delete

  resources :contact_information

  resources :system_settings, only: [:show, :edit, :update]
  resources :saved_searches, only: [:create, :index, :show, :destroy]
  resources :matching_configurations, only: [:show, :edit, :update]

  resources :roles do
    collection do
      post :import_file
    end
  end

  match '/roles/:id/copy' => 'roles#copy', :as => :copy_role, :via => [:post]

  resources :user_groups
  resources :primero_modules
  resources :primero_programs
  resources :agencies do
    collection do
      post :update_order
    end
  end

#######################
# CHILD URLS
#######################

  resources :children do
    collection do
      post :import_file
      get :search
    end

    resources :attachments, :only => :show
    resource :duplicate, :only => [:new, :create]
  end

  resources :children, as: :cases, path: :cases do
    collection do
      post :import_file
      post :transition
      post :mark_for_mobile
      post :approve_form
      post :add_note
      put :request_transfer
      get :search
      get :consent_count
    end

    member do
      put :match_record
      put :transfer_status
    end

    resources :attachments, :only => :show
    resource :duplicate, :only => [:new, :create]
  end

#######################
# TRACING REQUESTS URLS
#######################
  resources :tracing_requests, as: :tracing_requests, path: :tracing_requests do
    collection do
      post :import_file
      get :search
    end

    resources :attachments, :only => :show
  end


  match '/children-ids' => 'child_ids#all', :as => :child_ids, :via => [:post, :get, :put, :delete]
  match '/children/:id/photo/edit' => 'children#edit_photo', :as => :edit_photo, :via => :get
  match '/children/:id/photo' => 'children#update_photo', :as => :update_photo, :via => :put
  match '/children/:child_id/photos_index' => 'child_media#index', :as => :photos_index, :via => [:post, :get, :put, :delete]
  match '/children/:child_id/photos' => 'child_media#manage_photos', :as => :manage_photos, :via => [:post, :get, :put, :delete]
  match '/children/:child_id/document/:document_id' => 'child_media#download_document', :as => :child_document, :via => [:post, :get, :put, :delete]
  match '/children/:child_id/audio(/:id)' => 'child_media#download_audio', :as => :child_audio, :via => [:post, :get, :put, :delete]
  match '/children/:child_id/photo/:photo_id' => 'child_media#show_photo', :as => :child_photo, :via => [:post, :get, :put, :delete]
  match '/children/:child_id/photo' => 'child_media#show_photo', :as => :child_legacy_photo, :via => [:post, :get, :put, :delete]
  match '/children/:child_id/select_primary_photo/:photo_id' => 'children#select_primary_photo', :as => :child_select_primary_photo, :via => :put
  match '/children/:child_id/resized_photo/:size' => 'child_media#show_resized_photo', :as => :child_legacy_resized_photo, :via => [:post, :get, :put, :delete]
  match '/children/:child_id/photo/:photo_id/resized/:size' => 'child_media#show_resized_photo', :as => :child_resized_photo, :via => [:post, :get, :put, :delete]
  match '/children/:child_id/thumbnail(/:photo_id)' => 'child_media#show_thumbnail', :as => :child_thumbnail, :via => [:post, :get, :put, :delete]
  match '/children' => 'children#index', :as => :child_filter, :via => [:post, :get, :put, :delete]

  match '/agency/:agency_id/logo/:logo_id' => 'agency_media#show_logo', :as => :agency_logo, :via => [:get]

  match '/case-ids' => 'child_ids#all', :as => :case_ids, :via => [:post, :get, :put, :delete]
  match '/cases/:id/photo/edit' => 'children#edit_photo', :as => :edit_case_photo, :via => :get
  match '/cases/:id/photo' => 'children#update_photo', :as => :update_case_photo, :via => :put
  match '/cases/:child_id/photos_index' => 'child_media#index', :as => :case_photos_index, :via => [:post, :get, :put, :delete]
  match '/cases/:child_id/photos' => 'child_media#manage_photos', :as => :manage_case_photos, :via => [:post, :get, :put, :delete]
  match '/cases/:child_id/audio(/:id)' => 'child_media#download_audio', :as => :case_audio, :via => [:post, :get, :put, :delete]
  match '/cases/:child_id/photo/:photo_id' => 'child_media#show_photo', :as => :case_photo, :via => [:post, :get, :put, :delete]
  match '/cases/:child_id/photo' => 'child_media#show_photo', :as => :case_legacy_photo, :via => [:post, :get, :put, :delete]
  match '/cases/:child_id/select_primary_photo/:photo_id' => 'children#select_primary_photo', :as => :case_select_primary_photo, :via => :put
  match '/cases/:child_id/resized_photo/:size' => 'child_media#show_resized_photo', :as => :case_legacy_resized_photo, :via => [:post, :get, :put, :delete]
  match '/cases/:child_id/photo/:photo_id/resized/:size' => 'child_media#show_resized_photo', :as => :case_resized_photo, :via => [:post, :get, :put, :delete]
  match '/cases/:child_id/thumbnail(/:photo_id)' => 'child_media#show_thumbnail', :as => :case_thumbnail, :via => [:post, :get, :put, :delete]
  match '/cases' => 'children#index', :as => :case_filter, :via => [:post, :get, :put, :delete]
  match '/cases/:id/hide_name' => 'children#hide_name', :as => :child_hide_name, :via => :post

  match '/incident-ids' => 'incident_ids#all', :as => :incident_ids, :via => [:post, :get, :put, :delete]

#Route to create a Incident from a Case, this is mostly for the show page. User can create from the edit as well which goes to the update controller.
  match '/cases/:child_id/create_incident' => 'children#create_incident', :as => :child_create_incident, :via => :get
  match '/cases/:child_id/create_subform' => 'children#create_subform', :as => :child_create_subform, :via => :get
  match '/cases/:child_id/save_subform' => 'children#save_subform', :as => :child_save_subform, :via => [:post, :put]
  match '/cases/:child_id/quick_view' => 'children#quick_view', :as => :child_quick_view, :via => :get
  match '/cases/:child_id/request_transfer_view' => 'children#request_transfer_view', :as => :request_transfer_view, :via => :get


#Flag routing
  match '/cases/:id/flag' => 'record_flag#flag', :as => :child_flag, model_class: 'Child', :via => [:post, :put]
  match '/incidents/:id/flag' => 'record_flag#flag', :as => :incident_flag, model_class: 'Incident', :via => [:post, :put]
  match '/tracing_requests/:id/flag' => 'record_flag#flag', :as => :tracing_request_flag, model_class: 'TracingRequest', :via => [:post, :put]

#Flag multiple records routing
  match '/cases/flag_records' => 'record_flag#flag_records', :as => :child_flag_records, :model_class => 'Child', :via => [:post, :put]
  match '/incidents/flag_records' => 'record_flag#flag_records', :as => :incident_flag_records, :model_class => 'Incident', :via => [:post, :put]
  match '/tracing_requests/flag_records' => 'record_flag#flag_records', :as => :tracing_request_flag_records, :model_class => 'TracingRequest', :via => [:post, :put]

# Set Record Status
  match '/cases/record_status' => 'record_status#set_record_status', :as => :child_record_status, :model_class => 'Child', :via => [:post, :put]
  match '/incidents/record_status' => 'record_status#set_record_status', :as => :incident_record_status, :model_class => 'Incident', :via => [:post, :put]
  match '/tracing_requests/record_status' => 'record_status#set_record_status', :as => :tracing_request_record_status, :model_class => 'TracingRequest', :via => [:post, :put]

  # Set Case Status on reopening
  match '/cases/:id/reopen_case' => 'children#reopen_case', :as => :child_reopen_case, :model_class => 'Child', :via => [:post, :put]
  match '/cases/:id/request_approval' => 'children#request_approval', :as => :child_request_approval, :model_class => 'Child', :via => [:post, :put]
  match '/cases/:id/transfer_status' => 'children#transfer_status', :as => :child_transfer_status, :model_class => 'Child', :via => [:post, :put]
  match '/cases/:id/relinquish_referral' => 'children#relinquish_referral', :as => :child_relinquish_referral, :model_class => 'Child', :via => [:post, :put]

  # Download forms spreadsheet
  match '/forms/download' => 'form_section#download_all_forms', :as => :download_forms, :via => [:get]

  #Unflag routing
  match '/cases/:id/unflag' => 'record_flag#unflag', :as => :child_unflag, model_class:'Child', :via => [:post, :put]
  match '/incidents/:id/unflag' => 'record_flag#unflag', :as => :incident_unflag, model_class:'Incident', :via => [:post, :put]
  match '/tracing_requests/:id/unflag' => 'record_flag#unflag', :as => :tracing_request_unflag, model_class:'TracingRequest', :via => [:post, :put]

  match '/tracing_requests-ids' => 'tracing_request_ids#all', :as => :tracing_request_ids, :via => [:post, :get, :put, :delete]
  match '/tracing_requests/:id/photo/edit' => 'tracing_requests#edit_photo', :as => :edit_tracing_requests_photo, :via => :get
  match '/tracing_requests/:id/photo' => 'tracing_requests#update_photo', :as => :update_tracing_requests_photo, :via => :put
  match '/tracing_requests/:tracing_request_id/photos_index' => 'tracing_request_media#index', :as => :tracing_request_photos_index, :via => [:post, :get, :put, :delete]
  match '/tracing_requests/:tracing_request_id/photos' => 'tracing_request_media#manage_photos', :as => :manage_tracing_request_photos, :via => [:post, :get, :put, :delete]
  match '/tracing_requests/:tracing_request_id/document/:document_id' => 'tracing_request_media#download_document', :as => :tracing_request_document, :via => [:post, :get, :put, :delete]
  match '/tracing_requests/:tracing_request_id/audio(/:id)' => 'tracing_request_media#download_audio', :as => :tracing_request_audio, :via => [:post, :get, :put, :delete]
  match '/tracing_requests/:tracing_request_id/photo/:photo_id' => 'tracing_request_media#show_photo', :as => :tracing_request_photo, :via => [:post, :get, :put, :delete]
  match '/tracing_requests/:tracing_request_id/photo' => 'tracing_request_media#show_photo', :as => :tracing_request_legacy_photo, :via => [:post, :get, :put, :delete]
  match '/tracing_requests/:tracing_request_id/select_primary_photo/:photo_id' => 'tracing_requests#select_primary_photo', :as => :tracing_requests_select_primary_photo, :via => :put
  match '/tracing_requests/:tracing_request_id/resized_photo/:size' => 'tracing_request_media#show_resized_photo', :as => :tracing_request_legacy_resized_photo, :via => [:post, :get, :put, :delete]
  match '/tracing_requests/:tracing_request_id/photo/:photo_id/resized/:size' => 'tracing_request_media#show_resized_photo', :as => :tracing_request_resized_photo, :via => [:post, :get, :put, :delete]
  match '/tracing_requests/:tracing_request_id/thumbnail(/:photo_id)' => 'tracing_request_media#show_thumbnail', :as => :tracing_request_thumbnail, :via => [:post, :get, :put, :delete]
  match '/tracing_requests' => 'tracing_requests#index', :as => :tracing_request_filter, :via => [:post, :get, :put, :delete]

#######################
# RECORD HISTORIES URLS
#######################
  match '/cases/:id/change_log' => 'record_histories#record_change_log', :as => :child_record_change_log, model_class: 'Child', :via => [:get]
  match '/incidents/:id/change_log' => 'record_histories#record_change_log', :as => :incident_record_change_log, model_class: 'Incident', :via => [:get]
  match '/tracing_requests/:id/change_log' => 'record_histories#record_change_log', :as => :tracing_request_record_change_log, model_class: 'TracingRequest', :via => [:get]

#######################
# INCIDENT URLS
#######################
  resources :incidents do
    collection do
      # post :sync_unverified
      post :import_file
      post :mark_for_mobile
      # get :advanced_search
      get :search
    end

    # resources :attachments, :only => :show
    # resource :duplicate, :only => [:new, :create]
  end

  match '/incidents/:incident_id/document/:document_id' => 'incident_media#download_document', :as => :incident_document, :via => [:post, :get, :put, :delete]
  match '/incidents/:incident_id/create_cp_case_from_individual_details/:individual_details_subform_section' => 'incidents#create_cp_case_from_individual_details', :as => :create_cp_case_from_individual_details, :via => [:post, :get]

#######################
# POTENTIAL MATCHES URLS
#######################
  resources :potential_matches do
    collection do
      post :import_file
      get :quick_view
    end
  end
  # match '/potential_matches/:method' => 'potential_matches#index', :as => :potential_matches_method, :via => [:post, :get, :put, :delete]



  resources :bulk_exports, only: [:index, :show]
  resources :tasks, only: [:index]


#######################
# FORM SECTION URLS
#######################

  resources :form_sections, :path => 'forms', :controller => 'form_section' do
    collection do
      match 'save_order', :via => [:post, :get, :put, :delete]
      match 'toggle', :via => [:post, :get, :put, :delete]
      match 'published', :via => [:post, :get, :put, :delete]
      post :import_file
    end

    resources :fields, :controller => 'fields' do
      collection do
        post 'save_order'
        post 'delete'
        post 'toggle_fields'
        post 'change_form'
      end
    end
  end

  resources :highlight_fields do
    collection do
      post :remove
    end
  end

  match '/published_form_sections', :to => 'form_section#published', :via => [:post, :get, :put, :delete]


#######################
# API URLS
#######################

  scope '/api', defaults: { format: :json }, constraints: { format: :json } do
    #Session API
    post :login, to: 'sessions#create'
    post :logout, to: 'sessions#destroy'

    #Forms API
    resources :form_sections, controller: 'form_section', only: [:index]
    resources :form_sections, controller: 'form_section', as: :forms, path: :forms, only: [:index]

    #Records API
    resources :children
    resources :children, as: :cases, path: :cases
    resources :incidents, as: :incidents
    resources :tracing_requests, as: :tracing_requests
    resources :potential_matches, as: :potential_matches
    resources :options, :only => [:index]
    resources :system_settings, :only => [:index]
  end

#######################
# ADVANCED SEARCH URLS
#######################

  resources :advanced_search, :only => [:index, :new]
  match 'advanced_search/index', :to => 'advanced_search#index', :via => [:post, :get, :put, :delete]
  match 'advanced_search/export_data' => 'advanced_search#export_data', :as => :export_data_children, :via => :post


  match 'configuration_bundle/export', :to => 'configuration_bundle#export_bundle', :via => [:get, :post]
  match 'configuration_bundle/import', :to => 'configuration_bundle#import_bundle', :via => [:post]


#######################
# LOGGING URLS
#######################

  resources :system_logs, :only => :index
  match '/children/:id/history' => 'child_histories#index', :as => :child_history, :via => :get
  match '/incidents/:id/history' => 'incident_histories#index', :as => :incident_history, :via => :get
  match '/tracing_requests/:id/history' => 'tracing_request_histories#index', :as => :tracing_request_history, :via => :get
  match '/cases/:id/history' => 'child_histories#index', :as => :cases_history, :via => :get
  match '/users/:id/history' => 'user_histories#index', :as => :user_history, :via => :get

  resources :audit_logs, only: [:index]

#######################
# REPLICATION URLS
#######################
  resources :replications do
    collection do
      post :configuration
      post :update_blacklist
    end

    member do
      post :start
      post :stop
    end
  end

  resources :system_users, :path => "/admin/system_users"

#######################
# REPORTING URLS
#######################
  resources :reports do
    member do
      get :graph_data
      #put :rebuild
    end
    collection do
      get :permitted_field_list
      get :lookups_for_field
    end
  end

#######################
# CUSTOM EXPORT URLS
#######################
  resources :custom_exports do
    collection do
      get :permitted_forms_list
      get :permitted_fields_list
      get :export
    end
  end

#######################
# LOOKUPS URLS
#######################
  resources :lookups

#######################
# LOCATION URLS
#######################
  resources :locations


end
