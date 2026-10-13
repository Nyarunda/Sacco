Table 55006 "Loan Guarantors"
{

    fields
    {
        field(1; "Loan No"; Code[20])
        {
        }
        field(2; "SACCO Account No."; Code[20])
        {
            TableRelation = "SACCO Account"."No." where("Product Type" = filter('S02'));

            trigger OnValidate()
            var
                iEntryNo: Integer;
                LoansGTS: Record "Loan Guarantors";
                AmtGuaranteed: Decimal;
            begin






                //Set Member Guaranteed
                if LoansR.Get("Loan No") then
                    "Member Guaranteed" := LoansR."Member No.";






                //Check Max garantors
                LoansG := 0;
                GuaranteedPerc := 0;
                LoanGuarantors.Reset;
                LoanGuarantors.SetRange(LoanGuarantors."SACCO Account No.", "SACCO Account No.");
                if LoanGuarantors.Find('-') then begin


                end;


                //changed

                "No Of Loans Guaranteed" := LoansG;
                "Total Guaranteed" := TotalGuaranteed;
                "Available Shares" := Shares - "Total Guaranteed";



                //Check If Self Guarantee



                // send guarantors SMS


                // send guarantors SMS
            end;
        }
        field(3; Name; Text[200])
        {
            Editable = false;
        }
        field(4; "Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(5; Shares; Decimal)
        {
            Editable = false;
        }
        field(6; "No Of Loans Guaranteed"; Integer)
        {
            Editable = false;
        }
        field(7; Substituted; Boolean)
        {

            trigger OnValidate()
            begin
                Date := Today;
            end;
        }
        field(8; Date; Date)
        {
        }
        field(9; "Shares Recovery"; Boolean)
        {
        }
        field(10; "New Upload"; Boolean)
        {
        }
        field(11; "Amount Guaranteed"; Decimal)
        {

            trigger OnValidate()
            var
                AmtGuaranteed: Decimal;
                iEntryNo: Integer;
                MemberActivities: Codeunit "Member Activities";
                SaccoAcc: Record "Savings Accounts";
                SaccoSetup: Record "Sacco Setup";
                AccBal: Decimal;
            begin
                if xRec."Amount Guaranteed" <> "Amount Guaranteed" then begin
                    TestField("SACCO Account No.");
                    SaccoSetup.TestField("Guarantors Multiplier");
                    AccBal := MemberActivities.GetAccountBalance("SACCO Account No.");
                    if "Amount Guaranteed" > AccBal then
                        Error('The amount guaranteed cannot exceed the account balance!');
                    "Amount Committed" := MemberActivities.GetMemberCommittedDeposits("SACCO Account No.", true);
                    "Available Shares" := (AccBal * SaccoSetup."Guarantors Multiplier") - "Amount Committed";
                    if "Amount Guaranteed" > "Available Shares" then
                        Error('The amount guaranteed cannot exceed the free available shares of %1', "Available Shares");
                    SendAnSmsToTheGuarantor();
                end;



                //"Percentage Guaranteed":=("Amount Guaranteed"/Loans."Approved Amount")*100;


                /*
                IF Loans.GET("Loan No") THEN
                "Percentage Guaranteed":=("Amount Guaranteed"/Loans."Approved Amount")*100;
                 */


                AmtGuaranteed := "Amount Guaranteed";


            end;
        }
        field(12; "Staff/Payroll No."; Code[20])
        {

            trigger OnValidate()
            begin

                Cust.Reset;
                Cust.SetRange(Cust."Payroll/Staff No", "Staff/Payroll No.");
                Cust.SetRange(Cust."Loan Security Inclination", Cust."loan security inclination"::"Long Term Loan Security");
                if Cust.Find('-') then begin
                    "SACCO Account No." := Cust."No.";
                    Validate("SACCO Account No.");
                end
                else begin
                    "SACCO Account No." := '';
                    Error('Member deposits account not found.');
                end;
            end;
        }
        field(13; "Account No."; Code[20])
        {
        }
        field(14; "Self Guarantee"; Boolean)
        {
        }
        field(15; "ID No."; Code[50])
        {
        }
        field(17; "Member Guaranteed"; Code[50])
        {
        }
        field(18; "Percentage Guaranteed"; Decimal)
        {
        }
        field(19; "Total Guaranteed"; Decimal)
        {
        }
        field(20; "Available Shares"; Decimal)
        {
        }
        field(21; Signature; Blob)
        {
        }
        field(22; "Member No"; Code[20])
        {
        }
        field(24; "Guaranteed Balance"; Decimal)
        {

        }
        field(25; "Loanee Name"; Text[150])
        {
        }
        field(26; "% Proportion"; Decimal)
        {
        }
        field(27; "Amount Committed"; Decimal)
        {
        }
        field(28; "Amount Released"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Loan No", "Staff/Payroll No.", "SACCO Account No.", "Amount Guaranteed", Name)
        {
        }
        key(Key2; "Loan No", "SACCO Account No.")
        {
            Clustered = true;
            SumIndexFields = Shares;
        }
    }

    fieldgroups
    {
    }

    local procedure SendAnSmsToTheGuarantor()
    var
        SaccoSetup: Record "Sacco Setup";
        LoanSecurity: Record "Loan Guarantors";
        Member: Record Members;
        Loan: Record Loans;
        Msg: Text;
        MemberActivities: Codeunit "Member Activities";
        Smssource: Enum "SMS Source Enum";
    begin

        SaccoSetup.get;
        LoanSecurity.Reset;
        LoanSecurity.SetRange("Loan No", Rec."Loan No");
        LoanSecurity.SetFilter("SACCO Account No.", "SACCO Account No.");
        if LoanSecurity.FindFirst() then begin
            if Loan.Get(Rec."Loan No") then
                if Member.Get(LoanSecurity."Member No") then begin

                    /* Msg := 'Dear ' + Member.Name + ', You have guaranteed ' + Loan."Member Name" + ' ' + Loan."Loan Product Type Name" + ' of KES ' + Format(Loan."Requested Amount") +
                            ' an Amount of KES ' + Format(LoanSecurity."Amount Guaranteed") + '. Call ' + SaccoSetup."Sacco Contacts" + ' if in dispute.';

                    //TestField("Disbursement Account No");
                    if LoanSecurity."Member No" <> Loan."Member No." then
                        MemberActivities.SendSms(Smssource::"Loan Guarantors", Member."Mobile Phone No.", Msg,
                        Loan."Loan No.", Loan."Disbursement Account No", true, false); */

                    /* 

                                        if SMTPSetup.Get then begin

                                            CompanyInfo.Get;
                                            SenderName := CompanyInfo.Name;
                                            SenderAddress := SMTPSetup."User ID";
                                            if SenderName = '' then
                                                SenderName := COMPANYNAME;

                                            if SaccoActivities.ValidEmailAddress(SenderAddress) then begin
                                                SMTP.CreateMessage(SenderName, SenderAddress, Member."E-Mail", 'LOAN GUARANTORSHIP: ' + UpperCase(SenderName), '', true);

                                                //SMTP.AppendBody('<img src="data:image/png;base64,'+MemberActivities.Base64Header+'" alt="Red dot" />');
                                                //SMTP.AppendBody('<br><br>');
                                                SMTP.AppendBody('Dear ' + Member."First Name");
                                                SMTP.AppendBody('<br><br>');
                                                SMTP.AppendBody('You have guaranteed ' + "Member Name" + ' ' + ProductSetup.Description + ' of KES ' + Format("Requested Amount") +
                                                    ' an Amount of KES ' + Format(LoanSecurity."Amount Guaranteed") + '. If in dispute kindly contact the SACCCO');
                                                SMTP.AppendBody('<br><br>');

                                                SMTP.AppendBody('<br><br>');
                                                SMTP.AppendBody('Kind Regards,');
                                                SMTP.AppendBody('<br>');
                                                SMTP.AppendBody(SenderName);

                                                SMTP.AppendBody('<hr>');
                                                if SMTP.TrySend then;
                                            end;
                                        end; */

                end;
        end;

    end;


    var
        Cust: Record "SACCO Account";
        LoanGuarantors: Record "Loan Guarantors";
        Loans: Record Loans;
        LoansR: Record Loans;
        LoansG: Integer;
        SelfGuaranteedA: Decimal;
        TotalGuaranteed: Decimal;
        BalanceRemaining: Decimal;
        LoanGuar: Record "Loan Guarantors";
        TotG: Decimal;
        Times4Shares: Decimal;
        GuaranteedPerc: Decimal;
        SumGuranteed: Decimal;

}

