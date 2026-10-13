report 50516 CRBSubmitMonthlyCE
{
    ApplicationArea = All;
    Caption = 'CRBSubmitMonthlyCE';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(LoanListing; "Loans")
        {
            RequestFilterFields = "Member No.", "Disbursement Date";
            column(ReportForNavId_1; 1)
            {
            }
            trigger OnPreDataItem()
            var
                GenCRB: Report "Generate CRB Main";
            begin

                GenCRB.SetTableView(LoanListing);
                GenCRB.SetHeader(Header);
                GenCRB.Run();
                //Report.Run(Report::"Generate CRB Main", false, false, LoanListing);
            end;

            trigger OnAfterGetRecord()
            var
                CRBCE: Record "CRB Monthly Submission CE";
                CRBMainData: Record "CRB Main Data";
            begin
                CRBMainData.Reset;
                CRBMainData.setrange(HeaderNo, Header);
                if CRBMainData.FindFirst() then begin
                    repeat
                        CRBCE.EntryNo := CreateGuid();
                        CRBCE.account_closure_reason := CRBMainData."Account Closure Reason";
                        CRBCE.account_indicator := 'J';
                        CRBCE.account_number := CRBMainData."Account No.";
                        CRBCE.account_product_type := CRBMainData."Account Product Type";
                        CRBCE.account_status := CRBMainData."Account Status";
                        CRBCE.account_status_date := CRBMainData."Account Status Date";
                        CRBCE.current_balance_kes := CRBMainData."Current Balance";
                        CRBCE.client_number := CRBMainData."Client Code";
                        CRBCE.consumer_email := CRBMainData."Customer Work Email";
                        CRBCE.currency_facility := CRBMainData."Currency of Facilty";
                        CRBCE.current_balance := CRBMainData."Current Balance";
                        CRBCE.date_account_opened := CRBMainData."Date Account Opened";
                        CRBCE.date_at_physical_address := CRBMainData."Date of Physical Address";
                        CRBCE.days_arrears := CRBMainData."No. of Days in Arrears";
                        CRBCE.deferred_payment_amount := CRBMainData."Deferred Payment";
                        CRBCE.deferred_payment_date := CRBMainData."Deferred Payment Date";
                        CRBCE.disbursement_date := CRBMainData."Disbursement Date";
                        CRBCE.dob := CRBMainData."Date of Birth";
                        CRBCE.employer_name := CRBMainData."Employer Name";
                        CRBCE.employment_date := CRBMainData."Employment Date";
                        CRBCE.employment_type := CRBMainData."Employment Type";
                        CRBCE.forename1 := CRBMainData."Name 2";
                        CRBCE.forename2 := CRBMainData."Name 3";
                        CRBCE.forename3 := CRBMainData."Name 4";
                        CRBCE.gender := CRBMainData."Gender";
                        CRBCE.home_telephone_number := CRBMainData."Home Telephone";
                        CRBCE.industry_type := CRBMainData."Employer Industry Type";
                        CRBCE.installment_amount := CRBMainData."Installment Amount";
                        CRBCE.installment_arrears := CRBMainData."Installment Amount";
                        CRBCE.installment_due_date := CRBMainData."Installment Due Date";
                        CRBCE.latest_payment_amount := CRBMainData."Last Payment Amount";
                        CRBCE.latest_payment_date := CRBMainData."Date of Latest Payment";
                        CRBCE.lenders_branch_code := CRBMainData."Lenders Branch Code";
                        CRBCE.lenders_branch_name := CRBMainData."Lenders Branch Name";
                        CRBCE.lenders_registered_name := CRBMainData."Lenders Registered Name";
                        CRBCE.lenders_trading_name := CRBMainData."Lenders Trading Name";
                        CRBCE.location_country := CRBMainData."Location Country";
                        CRBCE.location_town := CRBMainData."Location Town";
                        CRBCE.marital_status := CRBMainData."Marital Status";
                        CRBCE.mobile_telephone_number := CRBMainData."Mobile No.";
                        CRBCE.nationality := CRBMainData."Nationality";
                        CRBCE.original_amount := CRBMainData."Original Amount";
                        CRBCE.other_id_doc_no := CRBMainData."Other Identification 1";
                        CRBCE.other_id_doc_type := CRBMainData."Other Identification Code";
                        CRBCE.overdue_balance := CRBMainData."Overdue Balance";
                        CRBCE.overdue_date := CRBMainData."Overdue Date";
                        CRBCE.payment_frequency := CRBMainData."Payment Frequency";
                        CRBCE.performing_npl_indicator := CRBMainData."Performing/NPL Indicator";
                        CRBCE.physical_address1 := CRBMainData."Physical Address 1";
                        CRBCE.physical_address2 := CRBMainData."Physical Address 2";
                        CRBCE.pin_number := CRBMainData."PIN No.";
                        CRBCE.Insert();
                    until CRBMainData.next = 0;
                end;

            end;

            trigger OnPostDataItem()
            var
                CRBActivities: Codeunit CRB;
            begin
                //CRBActivities.IndividualConsumerEmployerAccountSubmission();
                //Message('Successfully Run');
            end;

        }
    }



    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    procedure SetHeader(HNo: Integer)
    var
        myInt: Integer;
    begin
        Header := HNo;
    end;

    var
        Header: Integer;
}
