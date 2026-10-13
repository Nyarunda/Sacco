
Report 50154 "Defaulter Notice-1"
{
    DefaultLayout = Word;
    WordLayout = './src/Layouts/Defaulter Notice-1.docx';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.";
            CalcFields = "Total Arrears";
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
            column(Name_Members; Members.Name)
            {
            }
            column(CompName; CompName)
            {
            }
            column(OutstandingBalance_Loans; Loans."Outstanding Principal")
            {
            }
            column(firstName; FirstName)
            { }
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
            column(MemberEmail; MemberEmail)
            {
            }
            column(Memberaddress; Memberaddress)
            {
            }
            column(CreditOfficerPost; CreditOfficerPost)
            {
            }
            column(Repayment; DemandCurrentInstallment)
            {
            }
            column(ShowCRBNoticeClause; ShowCRBNoticeClause)
            {
            }
            column(CRBNoticeClause; CRBNoticeClause)
            {
            }

            trigger OnAfterGetRecord()
            var
                usersetup: Record "User Setup";
                Employee: Record Employee;
                SaccoSetup: record "Sacco Setup";
            begin
                Members.Get(Loans."Member No.");
                Memberaddress := Members.Address + ' -Post Code: ' + Members."Post Code" + ' -City:' + Members.City + ' Region: ' + Members."Country/Region Code";
                MemberEmail := Members."E-Mail";
                TelPhone := 'Tel: ' + Members."Mobile Phone No.";

                IssuedDate := CalcDate('-CM-1D', Today);
                Loans.CalcFields("Outstanding Principal");

                AmtPaid := Loans."Approved Amount" - Loans."Outstanding Principal";


                LedgerEntries.Reset;
                LedgerEntries.SetRange("Member No.", "Member No.");
                LedgerEntries.SetRange("Loan No.", "Loan No.");
                LedgerEntries.SetFilter("Transaction Type", '%1|%2', LedgerEntries."transaction type"::"Loan Disbursement", LedgerEntries."transaction type"::"Principal Repayment");
                if LedgerEntries.FindLast then begin
                    LastPayDate := LedgerEntries."Posting Date";
                end;



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

                AsAt := CalcDate('-CM-1D', Today);
                SActivities.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GracePriod);
                DefAmount += SActivities.GetInterestArrears(Loans."Loan No.", AsAt);
                FirstName := MemberActivities.GetMemberFirstName(Loans."Member Name");
                DefAmount := Loans."Total Arrears";

                SaccoSetup.Get();

                if DefAmount > 0 then
                    DefAmount := DefAmount + SaccoSetup."Min. Contribution [Deposits]"; //Deposit for loan

                DemandCurrentInstallment := GetCurrentMonthScheduledInstallment(Loans."Loan No.", Today, 0);

                ShowCRBNoticeClause := not IsLoanSecuredByLoaneeAlone(Loans."Loan No.", Loans."Member No.");
                if ShowCRBNoticeClause then
                    CRBNoticeClause := 'This letter serves as the 30 days'' notice required to list your name with Credit Reference Bureaus for inclusion in its credit information database.'
                else
                    Clear(CRBNoticeClause);

                usersetup.Reset();
                usersetup.SetRange("Is CEO", true);
                if usersetup.FindFirst() then
                    if Employee.Get(usersetup."Staff No") then begin
                        CreditOfficerName := Employee.FullName();
                        CreditOfficerPost := Employee."Job Title";
                    end;
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
            CompanyInformation.CalcFields("Letter Head", "CEO Signature");
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No.";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail";
    end;

    var
        FirstName: Text;
        DemandCurrentInstallment: Decimal;
        MemberActivities: Codeunit "Member Activities";
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
        TelPhone: Text[50];
        ShowCRBNoticeClause: Boolean;
        CRBNoticeClause: Text[250];

    local procedure Loadwatermark()
    var
        compinfo: Record "Company Information";
    begin
        if CompInfo.get() then begin

            CompInfo.CalcFields("Document Watermark", Picture, "CEO Signature");
            if not CompInfo."Document Watermark".HasValue then
                exit;


        end;
    end;

    local procedure IsLoanSecuredByLoaneeAlone(LoanNo: Code[20]; LoaneeMemberNo: Code[20]): Boolean
    var
        LoanSecurity: Record "Loan Security";
        HasSecurity: Boolean;
    begin
        if (LoanNo = '') or (LoaneeMemberNo = '') then
            exit(false);

        LoanSecurity.Reset();
        LoanSecurity.SetRange("Loan No.", LoanNo);
        LoanSecurity.SetRange(Substituted, false);
        LoanSecurity.SetFilter("Amount Guaranteed", '>%1', 0);
        if LoanSecurity.FindSet() then
            repeat
                HasSecurity := true;
                if LoanSecurity."Member No" <> LoaneeMemberNo then
                    exit(false);
            until LoanSecurity.Next() = 0;

        exit(HasSecurity);
    end;

    local procedure GetCurrentMonthScheduledInstallment(LoanNo: Code[20]; AsAtDate: Date; DefaultInstallment: Decimal): Decimal
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        MonthStartDate: Date;
        MonthEndDate: Date;
    begin
        if (LoanNo = '') or (AsAtDate = 0D) then
            exit(DefaultInstallment);

        MonthStartDate := CalcDate('<-CM>', AsAtDate);
        MonthEndDate := CalcDate('<CM>', AsAtDate);

        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange("Loan No.", LoanNo);
        LoanRepaymentSchedule.SetRange("Repayment Date", MonthStartDate, MonthEndDate);
        if LoanRepaymentSchedule.FindFirst() then
            exit(LoanRepaymentSchedule."Monthly Repayment");

        exit(DefaultInstallment);
    end;

}
