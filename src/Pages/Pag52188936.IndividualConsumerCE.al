page 50637 "Individual Consumer - CE"
{
    ApplicationArea = All;
    Caption = 'Individual Consumer - CE';
    PageType = ListPart;
    SourceTable = "CRB Monthly Submission CE";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Batch_No; Rec.Batch_No)
                {
                }
                field(Transaction_ID; Rec.Transaction_ID)
                {
                }
                field(Reference_Code; Rec.Reference_Code)
                {
                }
                field(Submit_Status; Rec.Submit_Status)
                {
                }
                field(account_closure_reason; Rec.account_closure_reason)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the account_closure_reason field.', Comment = '%';
                }
                field(account_indicator; Rec.account_indicator)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the account_indicator field.', Comment = '%';
                }
                field(account_number; Rec.account_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the account_number field.', Comment = '%';
                }
                field(account_product_type; Rec.account_product_type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the account_product_type field.', Comment = '%';
                }
                field(account_status; Rec.account_status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the account_status field.', Comment = '%';
                }
                field(account_status_date; Rec.account_status_date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the account_status_date field.', Comment = '%';
                }
                field(current_balance_kes; Rec.current_balance_kes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the current_balance_kes field.', Comment = '%';
                }
                field(client_number; Rec.client_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the client_number field.', Comment = '%';
                }
                field(consumer_email; Rec.consumer_email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the consumer_email field.', Comment = '%';
                }
                field(currency_facility; Rec.currency_facility)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the currency_facility field.', Comment = '%';
                }
                field(current_balance; Rec.current_balance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the current_balance field.', Comment = '%';
                }
                field(date_account_opened; Rec.date_account_opened)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the date_account_opened field.', Comment = '%';
                }
                field(date_at_physical_address; Rec.date_at_physical_address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the date_at_physical_address field.', Comment = '%';
                }
                field(days_arrears; Rec.days_arrears)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the days_arrears field.', Comment = '%';
                }
                field(deferred_payment_amount; Rec.deferred_payment_amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the deferred_payment_amount field.', Comment = '%';
                }
                field(deferred_payment_date; Rec.deferred_payment_date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the deferred_payment_date field.', Comment = '%';
                }
                field(disbursement_date; Rec.disbursement_date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the disbursement_date field.', Comment = '%';
                }
                field(dob; Rec.dob)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the dob field.', Comment = '%';
                }
                field(employer_name; Rec.employer_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the employer_name field.', Comment = '%';
                }
                field(employment_date; Rec.employment_date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the employment_date field.', Comment = '%';
                }
                field(employment_type; Rec.employment_type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the employment_type field.', Comment = '%';
                }
                field(forename1; Rec.forename1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the forename1 field.', Comment = '%';
                }
                field(forename2; Rec.forename2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the forename2 field.', Comment = '%';
                }
                field(forename3; Rec.forename3)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the forename3 field.', Comment = '%';
                }
                field(gender; Rec.gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the gender field.', Comment = '%';
                }
                field(home_telephone_number; Rec.home_telephone_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the home_telephone_number field.', Comment = '%';
                }
                field(industry_type; Rec.industry_type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the industry_type field.', Comment = '%';
                }
                field(installment_amount; Rec.installment_amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the installment_amount field.', Comment = '%';
                }
                field(installment_arrears; Rec.installment_arrears)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the installment_arrears field.', Comment = '%';
                }
                field(installment_due_date; Rec.installment_due_date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the installment_due_date field.', Comment = '%';
                }
                field(latest_payment_amount; Rec.latest_payment_amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the latest_payment_amount field.', Comment = '%';
                }
                field(latest_payment_date; Rec.latest_payment_date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the latest_payment_date field.', Comment = '%';
                }
                field(lenders_branch_code; Rec.lenders_branch_code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the lenders_branch_code field.', Comment = '%';
                }
                field(lenders_branch_name; Rec.lenders_branch_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the lenders_branch_name field.', Comment = '%';
                }
                field(lenders_registered_name; Rec.lenders_registered_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the lenders_registered_name field.', Comment = '%';
                }
                field(lenders_trading_name; Rec.lenders_trading_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the lenders_trading_name field.', Comment = '%';
                }
                field(location_country; Rec.location_country)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the location_country field.', Comment = '%';
                }
                field(location_town; Rec.location_town)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the location_town field.', Comment = '%';
                }
                field(marital_status; Rec.marital_status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the marital_status field.', Comment = '%';
                }
                field(mobile_telephone_number; Rec.mobile_telephone_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the mobile_telephone_number field.', Comment = '%';
                }
                field(nationality; Rec.nationality)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the nationality field.', Comment = '%';
                }
                field(original_amount; Rec.original_amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the original_amount field.', Comment = '%';
                }
                field(other_id_doc_no; Rec.other_id_doc_no)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the other_id_doc_no field.', Comment = '%';
                }
                field(other_id_doc_type; Rec.other_id_doc_type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the other_id_doc_type field.', Comment = '%';
                }
                field(overdue_balance; Rec.overdue_balance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the overdue_balance field.', Comment = '%';
                }
                field(overdue_date; Rec.overdue_date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the overdue_date field.', Comment = '%';
                }
                field(Prudential_Risk_Classification; Rec.Prudential_Risk_Classification)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the overdue_date field.', Comment = '%';
                }
                field(payment_frequency; Rec.payment_frequency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the payment_frequency field.', Comment = '%';
                }
                field(performing_npl_indicator; Rec.performing_npl_indicator)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the performing_npl_indicator field.', Comment = '%';
                }
                field(physical_address1; Rec.physical_address1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the physical_address1 field.', Comment = '%';
                }
                field(physical_address2; Rec.physical_address2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the physical_address2 field.', Comment = '%';
                }
                field(pin_number; Rec.pin_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the pin_number field.', Comment = '%';
                }
                field(plot_number; Rec.plot_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the plot_number field.', Comment = '%';
                }
                field(post_code; Rec.post_code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the post_code field.', Comment = '%';
                }
                field(postal_address1; Rec.postal_address1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the postal_address1 field.', Comment = '%';
                }
                field(postal_address2; Rec.postal_address2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the postal_address2 field.', Comment = '%';
                }
                field(postal_location_country; Rec.postal_location_country)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the postal_location_country field.', Comment = '%';
                }
                field(postal_location_town; Rec.postal_location_town)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the postal_location_town field.', Comment = '%';
                }
                field(primary_id_doc_no; Rec.primary_id_doc_no)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the primary_id_doc_no field.', Comment = '%';
                }
                field(primary_id_doc_type; Rec.primary_id_doc_type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the primary_id_doc_type field.', Comment = '%';
                }
                field(repayment_period; Rec.repayment_period)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the repayment_period field.', Comment = '%';
                }
                field(salary_band; Rec.salary_band)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the salary_band field.', Comment = '%';
                }
                field(salutation; Rec.salutation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the salutation field.', Comment = '%';
                }
                field(secondary_id_doc_no; Rec.secondary_id_doc_no)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the secondary_id_doc_no field.', Comment = '%';
                }
                field(secondary_id_doc_type; Rec.secondary_id_doc_type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the secondary_id_doc_type field.', Comment = '%';
                }
                field(security_type; Rec.security_type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the security_type field.', Comment = '%';
                }
                field(surname; Rec.surname)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the surname field.', Comment = '%';
                }
                field(work_telephone_number; Rec.work_telephone_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the work_telephone_number field.', Comment = '%';
                }



                field(account_holder_type; Rec.account_holder_type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the account_holder_type field.', Comment = '%';
                }
                field(annual_turnover_band; Rec.annual_turnover_band)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the annual_turnover_band field.', Comment = '%';
                }
                field(company_type; Rec.company_type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the company_type field.', Comment = '%';
                }
                field(country; Rec.country)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the country field.', Comment = '%';
                }
                field(industry_code; Rec.industry_code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the industry_code field.', Comment = '%';
                }
                field(main_telephone_number; Rec.main_telephone_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the main_telephone_number field.', Comment = '%';
                }
                field(number_of_shares; Rec.number_of_shares)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the number_of_shares field.', Comment = '%';
                }
                field(other_telephone_number; Rec.other_telephone_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the other_telephone_number field.', Comment = '%';
                }
                field(physical_location_country; Rec.physical_location_country)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the physical_location_country field.', Comment = '%';
                }
                field(physical_location_town; Rec.physical_location_town)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the physical_location_town field.', Comment = '%';
                }
                field(previous_registration_number; Rec.previous_registration_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the previous_registration_number field.', Comment = '%';
                }
                field(registered_name; Rec.registered_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the registered_name field.', Comment = '%';
                }
                field(registration_date; Rec.registration_date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the registration_date field.', Comment = '%';
                }
                field(registration_number; Rec.registration_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the registration_number field.', Comment = '%';
                }
                field(town; Rec.town)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the town field.', Comment = '%';
                }
                field(trading_name; Rec.trading_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the trading_name field.', Comment = '%';
                }
                field(trading_status; Rec.trading_status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the trading_status field.', Comment = '%';
                }
                field(trading_status_date; Rec.trading_status_date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the trading_status_date field.', Comment = '%';
                }
                field(vat_number; Rec.vat_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the vat_number field.', Comment = '%';
                }
                field(EntryNo; Rec.EntryNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EntryNo field.', Comment = '%';
                }
                field(Sent; Rec.Sent)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sent field.', Comment = '%';
                }
                field(API_Response; Rec.API_Response)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the API_Response field.', Comment = '%';
                }
                field(HeaderNo; Rec.HeaderNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HeaderNo field.', Comment = '%';
                }


            }
        }
    }
}
