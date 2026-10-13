
Report 50155 "Defaulter Notice-2"
{
    DefaultLayout = Word;
    WordLayout = './src/Layouts/Defaulter Notice-2.docx';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.";
            CalcFields = "Total Arrears", "Last Pay Date";
            column(ReportForNavId_2; 2)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation."Letter Head")
            {
            }
            column(CompanyInformation_CEO_Signature; CompanyInformation."CEO Signature")
            {
            }
            column(CompanyInformation_watermark; CompanyInformation."Document Watermark")
            {

            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompPhone; CompanyInformation."Phone No.")
            {
            }
            column(companyEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(PhoneNo_Members; Members."Mobile Phone No.")
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(firstName; FirstName)
            { }
            column(Name_Members; Members.Name)
            {
            }
            column(CompName; CompName)
            {
            }
            column(OutstandingBalance_Loans; Loans."Outstanding Principal")
            {
            }
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(DefAmount; DefAmount)
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type Name")
            {
            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(RequestedAmount_Loans; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount_Loans; Loans."Approved Amount")
            {
            }
            column(Interest_Loans; Loans."Annual Interest %")
            {
            }
            column(MemberName_Loans; Loans."Member Name")
            {
            }
            column(OutstandingInterest_Loans; Loans."Outstanding Interest")
            {
            }
            column(OutstandingBills_Loans; Loans."Total Arrears")
            {
            }
            column(OutstandingAppraisal_Loans; Loans."Outstanding Appraisal")
            {
            }
            column(Installments_Loans; Loans.Installments)
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(DisbursementDate_Loans; Loans."Disbursement Date")
            {
            }
            column(IssuedDate; IssuedDate)
            {
            }
            column(LastPayDate; LastPayDate)
            {
            }
            column(PrincipalArrears_Loans; Loans."Principal Arrears")
            {
            }
            column(OutstandingPenalty_Loans; Loans."Outstanding Penalty")
            {
            }
            column(TotalOutstandingBalance_Loans; Loans."Total Outstanding Balance")
            {
            }
            column(ID_No_; "ID No.")
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(ArrearsDate; ArrearsDate)
            {
            }
            column(CreditOfficerName; CreditOfficerName)
            {
            }
            column(CreditOfficerPost; CreditOfficerPost)
            { }
            column(MemberEmail; MemberEmail)
            {
            }
            column(Memberaddress; Memberaddress)
            {
            }
            column(Notice1Date; Notice1Date)
            {
            }
            dataitem("Loan Guarantors and Security"; "Loan Security")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = where("Guarantor Type" = filter(Guarantor), Substituted = const(false));
                column(ReportForNavId_19; 19)
                {
                }
                column(PhoneNo; Cust."Mobile Phone No.")
                {
                }
                column(LoanNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Loan No.")
                {
                }
                column(SavingsAccountNoMemberNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Account No.")
                {
                }
                column(Name_LoanGuarantorsandSecurity; "Loan Guarantors and Security".Name)
                {
                }
                column(LoanBalance_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Guarantor Loan Balance")
                {
                }
                column(Shares_LoanGuarantorsandSecurity; 0)
                {
                }
                column(NoOfLoansGuaranteed_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Loans Guaranteed")
                {
                }
                column(Substituted_LoanGuarantorsandSecurity; "Loan Guarantors and Security".Substituted)
                {
                }
                column(Date_LoanGuarantorsandSecurity; "Loan Guarantors and Security".Date)
                {
                }
                column(AmountGuaranteed_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Amount Guaranteed")
                {
                }
                column(StaffPayrollNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Staff/Payroll No.")
                {
                }
                column(AccountNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Account No.")
                {
                }
                column(SelfGuarantee_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Self Guarantee")
                {
                }
                column(IDNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."ID No.")
                {
                }
                column(OutstandingBalance_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Outstanding Principal")
                {
                }
                column(MemberGuaranteed_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Member Guaranteed")
                {
                }
                column(TotalGuaranteed_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Total Guaranteed")
                {
                }
                column(AvailableShares_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Available Guarantorship")
                {
                }
                column(MemberNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Member No")
                {
                }
                column(LoanType_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Loan Type")
                {
                }
                column(LoaneeName_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Loanee Name")
                {
                }
                column(GuarantorType_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Guarantor Type")
                {
                }
                column(CollateralRegNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Collateral Reg. No.")
                {
                }

                trigger OnAfterGetRecord()

                begin
                    Cust.Get("Loan Guarantors and Security"."Member No");
                end;
            }

            trigger OnAfterGetRecord()
            var
                usersetup: Record "User Setup";
                Employee: Record Employee;
                MemberActivities: Codeunit "Member Activities";
                SaccoSetup: record "Sacco Setup";
            begin
                Members.Get(Loans."Member No.");
                Memberaddress := Members.Address + ' -Post Code: ' + Members."Post Code" + ' -City:' + Members.City + ' Region: ' + Members."Country/Region Code";
                MemberEmail := Members."E-Mail";

                IssuedDate := CalcDate('7D', Today);
                Loans.CalcFields("Outstanding Principal");

                AmtPaid := Loans."Approved Amount" - Loans."Outstanding Principal";

                RSchedule.Reset;
                RSchedule.SetRange("Loan No.", Loans."Loan No.");
                if RSchedule.FindFirst then begin
                    ExpAmt := 0;
                    LastPayDate := 0D;
                    repeat
                        ExpAmt += RSchedule."Monthly Principal";
                        if AmtPaid < ExpAmt then
                            LastPayDate := RSchedule."Repayment Date";
                    until (RSchedule.Next = 0) or (LastPayDate <> 0D);
                end;
                if LastPayDate <> 0D then
                    LastPayDate := CalcDate('1M', LastPayDate);
                AsAt := Today;
                SActivities.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GracePriod);
                DefAmount += SActivities.GetInterestArrears(Loans."Loan No.", CalcDate('-CM-1D', AsAt));
                DefAmount := Loans."Total Arrears";
                if DefAmount < 0 then
                    DefAmount := 0;

                SaccoSetup.Get();
                if DefAmount > 0 then
                    DefAmount := DefAmount + SaccoSetup."Min. Contribution [Deposits]"; //Deposit for loan

                FirstName := MemberActivities.GetMemberFirstName(Loans."Member Name");

                usersetup.Reset();
                usersetup.SetRange("Is CEO", true);
                if usersetup.FindFirst() then
                    if Employee.Get(usersetup."Staff No") then begin
                        CreditOfficerName := Employee.FullName();
                        CreditOfficerPost := Employee."Job Title";
                    end;

                DefNotices.SetRange("Loan No", Loans."Loan No.");
                DefNotices.SetFilter(Notice, '%1', DefNotices.Notice::"1-Notice");
                if DefNotices.FindFirst then begin
                    Notice1Date := DefNotices."Date Sent";
                end else
                    Notice1Date := 0D;
            end;

            trigger OnPreDataItem()
            begin
                CompName := COMPANYNAME;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin

        if CompanyInformation.Get then
            CompanyInformation.CalcFields("Letter Head", "Document Watermark", "CEO Signature");
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No.";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail";
    end;

    var
        FirstName: Text;
        GracePriod: DateFormula;
        CompName: Text[100];
        LastPayDate: Date;
        LedgerEntries: Record "Credit Ledger Entry";
        IssuedDate: Date;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Members: Record Members;
        RSchedule: Record "Loan Repayment Schedule";
        AmtPaid: Decimal;
        ExpAmt: Decimal;
        AsAt: Date;
        Cust: Record Members;
        DefAmount: Decimal;
        SActivities: Codeunit "Sacco Activities";
        ExpectedAmt: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        Reportmgt: Codeunit "ReportManagement";
        CreditOfficerName: Text[100];
        CreditOfficerPost: Text[100];
        MemberEmail: Text[100];
        Memberaddress: Text[100];
        DefNotices: Record "Loans Defaulter Notices";
        Notice1Date: Date;

    local procedure Loadwatermark()
    var
        compinfo: Record "Company Information";
    begin
        if CompInfo.get() then begin

            CompInfo.CalcFields("Document Watermark", Picture);
            if not CompInfo."Document Watermark".HasValue then
                exit;


        end;
    end;

}
