angular.module 'trPcApp'
  .config [
    '$translateProvider'
    'APP_INFO'
    ($translateProvider, APP_INFO) ->
      $translateProvider.fallbackLanguage 'en_US'
      $translateProvider.useSanitizeValueStrategy 'escape'
      loginMessages =
        type: 'msgCat'
        bundle: 'login_user'
        keys: [
          'reset_password_title'
          'class_cancel_link'
          'login_button_label'
          'submit_button_label'
          'error_invalid_username_or_password'
        ]
      loginConsMessages =
        type: 'msgCat'
        bundle: 'cons'
        keys: [
          'password'
          'user_name'
        ]
      navMessages =
        type: 'msgCat'
        bundle: 'trpc'
        keys: [
          'nav_overview'
          'nav_messaging'
          'hdr_profile_link'
        ]
      dashboardMessages = 
        type: 'msgCat'
        bundle: 'trpc'
        keys: [
          'admin_newsfeed_header_h1'
          'recent_activity_header'
          'social_share_link_text'
          'contacts_label'
          'contacts_groups_all'
          'class_cancel_link'
          'dialog_save_label'
          'filter_email_rpt_show_never_emailed'
          'filter_email_rpt_show_nondonors_followup'
          'filter_email_rpt_show_unthanked_donors'
          'filter_email_rpt_show_donors'
          'filter_email_rpt_show_nondonors'
          'progress_bar_title'
          'goal_edit_goal'
          'goal_goal'
          'personal_page_shortcut_edit'
          'personal_page_shortcut_save'
          'shortcut_save_success'
          'nav_public_page'
          'donations_heading'
          'gift_add_button_label'
          'donations_no_donations_found'
          'captains_message_edit_link'
          'captains_message_save_button'
          'captains_message_header'
          'captains_message_empty'
          'progress_team_progress'
          'team_goal_edit_goal'
          'team_goal_goal'
          'nav_team_page'
          'team_page_shortcut_cancel'
          'team_page_shortcut_edit'
          'team_page_shortcut_edit2'
          'team_page_shortcut_save'
          'team_page_permalink'
          'team_donations_heading'
          'team_edit_team_name_label'
          'team_password_edit_label'
          'team_roster_heading'
          'company_progress_bar_title'
          'company_page_shortcut_cancel'
          'company_page_shortcut_edit'
          'company_page_shortcut_edit2'
          'company_page_shortcut_save'
          'company_page_shortcut_save_success'
          'company_page_content_label'
          'company_report_teams_label'
        ]
      enterGiftMessages = 
        type: 'msgCat'
        bundle: 'trpc'
        keys: [
          'dashboard_enter_gift_button'
          'gift_submit_success'
          'class_cancel_link'
          'gift_add_button_label'
          'gift_add_another_button_label'
          'gift_payment_type_cash'
          'gift_payment_type_check'
          'gift_payment_type_credit'
          'gift_payment_type_later'
          'gift_first_name_label'
          'gift_last_name_label'
          'gift_email_label'
          'gift_addl_options_label'
          'gift_street1_label'
          'gift_street2_label'
          'gift_city_label'
          'gift_state_label'
          'gift_zip_label'
          'gift_recongition_name_label'
          'gift_display_personal_page_label'
          'gift_amount_label'
          'gift_payment_type_label'
          'gift_check_number_label'
          'gift_credit_card_number_label'
          'gift_credit_expiration_date_label'
          'gift_credit_verification_code_label'
          'gift_billing_first_name_label'
          'gift_billing_last_name_label'
          'gift_billing_street1_label'
          'gift_billing_street2_label'
          'gift_billing_city_label'
          'gift_billing_state_label'
          'gift_billing_zip_label'
          'gift_gift_category_label'
        ]
      emailMessages =
        type: 'msgCat'
        bundle: 'trpc'
        keys: [
          'contacts_sidebar_add_contact_header'
          'add_contact_first_name_label'
          'add_contact_last_name_label'
          'add_contact_email_label'
          'add_contacts_cancel_link'
          'add_contact_submit_button'
          'contact_add_success'
          'contact_add_failure_email'
          'contact_add_failure_unknown'
          'class_cancel_link'
          'compose_preview_send_label'
          'compose_preview_button_label'
          'contact_details_edit_info'
          'contact_edit_first_name_label'
          'contact_edit_last_name_label'
          'contact_edit_email_label'
          'contact_edit_address1_label'
          'contact_edit_address2_label'
          'contact_edit_city_label'
          'contact_edit_state_label'
          'contact_edit_zip_label'
          'contact_edit_country_label'
          'contact_edit_save_button'
          'contact_edit_cancel_link'
          'contacts_groups_all'
          'filter_email_rpt_show_never_emailed'
          'filter_email_rpt_show_nondonors_followup'
          'filter_email_rpt_show_unthanked_donors'
          'filter_email_rpt_show_donors'
          'filter_email_rpt_show_nondonors'
          'contacts_confirm_delete_header'
          'contacts_confirm_delete_body'
          'contacts_delete_button'
          'drafts_drafts_label'
          'drafts_confirm_delete_header'
          'drafts_confirm_delete_body'
          'sent_sent_message_label'
          'compose_delete_button_label'
          'contacts_delete_success'
          'contacts_warn_delete_failure_body'
        ]
      profileMessages = 
        type: 'msgCat'
        bundle: 'trpc'
        keys: [
          'hdr_profile_link'
          'class_cancel_link'
          'personal_page_privacy_save_success'
          'personal_page_privacy_prefix_desc'
          'personal_page_privacy_private_label'
          'personal_page_privacy_public_label'
          'personal_page_privacy_public_desc'
          'personal_page_privacy_private_desc'
          'personal_page_save'
          'nav_manage_privacy_settings_link'
          'privacy_settings_radio_label'
          'privacy_settings_screenname_option'
          'privacy_settings_standard_option'
          'privacy_settings_anonymous_option'
          'manage_membership_label'
          'manage_membership_leave_team_radio_text'
          'manage_membership_join_team_radio_text'
          'manage_membership_find_team'
          'manage_membership_team_name'
          'manage_membership_team_company'
          'manage_membership_captain_first_name'
          'manage_membership_captain_last_name'
          'manage_membership_search_button'
          'manage_membership_search_results'
          'manage_membership_team_search_results_count'
          'manage_membership_team_search_results_found'
          'manage_membership_team_search_results_hint'
          'manage_membership_search_failure'
          'manage_membership_search_result_captain_label'
          'manage_membership_search_result_company_label'
          'manage_membership_join_team_password_label'
          'manage_membership_join_team'
          'manage_membership_leave_team_explanation_text'
          'manage_membership_continue_button'
          'subnav_edit_survey_responses'
          'survey_save_success'
          'survey_save_failure'
          'survey_save_responses_button'
        ]
      profileMessages2 =
        type: 'msgCat'
        bundle: 'login_user'
        keys: [
          'new_password'
          'new_password_repeat'
          'password_hint'
        ]
      overrideMessages = 
        type: 'file'
        prefix: APP_INFO.rootPath + 'dist/heart-walk/translation/participant-center/',
        suffix: '.json'
      $translateProvider.useLoader 'useMessageCatalog', messages: [
        loginMessages
        loginConsMessages
        navMessages
        dashboardMessages
        enterGiftMessages
        emailMessages
        profileMessages
        profileMessages2
        overrideMessages
      ]
  ]