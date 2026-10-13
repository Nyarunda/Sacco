table 50553 "CRB Monthly Submission CE"
{
    Caption = 'CRB Monthly Submission CE';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; account_closure_reason; Text[100])
        {

        }

        field(2; account_indicator; Text[100])
        {

        }
        field(3; account_number; Text[100])
        {

        }
        field(4; account_product_type; Text[100])
        {

        }
        field(5; account_status; Text[100])
        {

        }
        field(6; account_status_date; Text[100])
        {

        }

        field(7; current_balance_kes; Text[100])
        {

        }
        field(8; client_number; Text[100])
        {

        }
        field(9; consumer_email; Text[100])
        {

        }
        field(10; currency_facility; Text[100])
        {

        }
        field(11; current_balance; Text[100])
        {

        }
        field(12; date_account_opened; Text[100])
        {

        }
        field(13; date_at_physical_address; Text[100])
        {

        }
        field(14; days_arrears; Integer)
        {

        }
        field(15; deferred_payment_amount; Text[100])
        {

        }
        field(16; deferred_payment_date; Text[100])
        {

        }
        field(17; disbursement_date; Text[100])
        {

        }
        field(18; dob; Text[100])
        {

        }
        field(19; employer_name; Text[100])
        {

        }
        field(20; employment_date; Text[100])
        {

        }
        field(21; employment_type; Text[100])
        {

        }
        field(22; forename1; Text[100])
        {

        }
        field(23; forename2; Text[100])
        {

        }
        field(24; forename3; Text[100])
        {

        }
        field(25; gender; Text[100])
        {

        }
        field(26; home_telephone_number; Text[100])
        {

        }
        field(27; industry_type; Text[100])
        {

        }
        field(28; installment_amount; Text[100])
        {

        }
        field(29; installment_arrears; Text[100])
        {

        }
        field(30; installment_due_date; Text[100])
        {

        }
        field(31; latest_payment_amount; Text[100])
        {

        }
        field(32; latest_payment_date; Text[100])
        {

        }
        field(33; lenders_branch_code; Text[100])
        {

        }
        field(34; lenders_branch_name; Text[100])
        {

        }
        field(35; lenders_registered_name; Text[100])
        {

        }
        field(36; lenders_trading_name; Text[100])
        {

        }
        field(37; location_country; Text[100])
        {

        }
        field(38; location_town; Text[100])
        {

        }
        field(39; marital_status; Text[100])
        {

        }
        field(40; mobile_telephone_number; Text[100])
        {

        }
        field(41; nationality; Text[100])
        {

        }
        field(42; original_amount; Text[100])
        {

        }
        field(43; other_id_doc_no; Text[100])
        {

        }
        field(44; other_id_doc_type; Text[100])
        {

        }
        field(45; overdue_balance; Text[100])
        {

        }
        field(46; overdue_date; Text[100])
        {

        }
        field(47; payment_frequency; Text[100])
        {

        }
        field(48; performing_npl_indicator; Text[100])
        {

        }
        field(49; physical_address1; Text[100])
        {

        }
        field(50; physical_address2; Text[100])
        {

        }
        field(51; pin_number; Text[100])
        {

        }
        field(52; plot_number; Text[100])
        {

        }
        field(53; post_code; Text[100])
        {

        }
        field(54; postal_address1; Text[100])
        {

        }
        field(55; postal_address2; Text[100])
        {

        }
        field(56; postal_location_country; Text[100])
        {

        }
        field(57; postal_location_town; Text[100])
        {

        }
        field(58; primary_id_doc_no; Text[100])
        {

        }
        field(59; primary_id_doc_type; Text[100])
        {

        }
        field(60; repayment_period; Text[100])
        {

        }
        field(61; salary_band; Text[100])
        {

        }

        field(62; salutation; Text[100])
        {

        }
        field(63; secondary_id_doc_no; Text[100])
        {

        }
        field(64; secondary_id_doc_type; Text[100])
        {

        }
        field(65; security_type; Text[100])
        {

        }
        field(66; surname; Text[100])
        {

        }
        field(67; work_telephone_number; Text[100])
        {

        }
        field(68; EntryNo; Guid)
        {
        }
        field(69; Sent; Boolean)
        {
        }
        field(70; API_Response; text[100])
        {
        }

        field(73; HeaderNo; Integer)
        {
        }
        field(74; Prudential_Risk_Classification; text[10])
        {
        }
        field(75; Transaction_ID; text[50])
        {
        }
        field(76; Reference_Code; text[50])
        {
        }


        field(77; Submit_Status; Option)
        {
            OptionMembers = " ",Success,Failed;
        }
        field(78; Batch_No; Integer)
        {
        }

        field(79; account_holder_type; Text[100])
        {
        }
        field(80; annual_turnover_band; Text[100])
        {
        }
        field(81; company_type; Text[100])
        {
            trigger OnValidate()
            var
                myInt: Integer;
                Cust: Record Members;
            begin
                if Cust.get(client_number) then begin
                    cust."CRB Company Type" := company_type;
                    cust.Modify();
                end;
            end;
        }
        field(82; country; Text[100])
        {
        }
        field(83; industry_code; Text[100])
        {
            trigger OnValidate()
            var
                myInt: Integer;
                Cust: Record Members;
            begin
                if Cust.get(client_number) then begin
                    cust."CRB Industry Code" := industry_code;
                    cust.Modify();
                end;
            end;
        }
        field(84; main_telephone_number; Text[100])
        {
        }
        field(85; number_of_shares; Text[100])
        {
        }
        field(86; other_telephone_number; Text[100])
        {
        }
        field(87; physical_location_country; Text[100])
        {
        }
        field(88; physical_location_town; Text[100])
        {
        }
        field(89; previous_registration_number; Text[100])
        {
        }
        field(90; registered_name; Text[100])
        {
        }
        field(91; registration_date; Text[100])
        {
        }
        field(92; registration_number; Text[100])
        {
        }
        field(93; town; Text[100])
        {
        }
        field(94; trading_name; Text[100])
        {
        }
        field(95; trading_status; Text[100])
        {
        }
        field(96; trading_status_date; Text[100])
        {
        }
        field(97; vat_number; Text[100])
        {
        }

    }

    keys
    {
        key(PK; HeaderNo, EntryNo, account_status_date)
        {
            Clustered = true;
        }
        key(PK2; Batch_No)
        {

        }
    }
    trigger OnInsert()
    begin
        EntryNo := CreateGuid();
    end;

}
