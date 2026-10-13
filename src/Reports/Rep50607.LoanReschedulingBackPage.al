namespace UnitedWomen.UnitedWomen;

using Microsoft.Foundation.Company;

report 50607 "Loan Rescheduling Back Page"
{
    ApplicationArea = All;
    Caption = 'Loan Rescheduling Back Page';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Rescheduling Back Page.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(LoanChanges; "Loan Changes")
        {
            DataItemTableView = where("Type of Change" = const("Loan Rescheduling"));
            RequestFilterFields = "No.", "Loan No.", "Member No.";

            column(Picture; CompanyInformation.Picture) { }
            column(C_Name; CompanyInformation.Name) { }
            column(AppraisalNo; "No.") { }
            column(OfficialUseDate; OfficialUseDate) { }
            column(MemberName; "Member Name") { }
            column(MemberNo; "Member No.") { }
            column(ShareDeposits; ShareDeposits) { }
            column(MaxLoanAllowed; MaximumLoanAllowed) { }
            column(BOSALoanBalance; OutstandingLoanBalance) { }
            column(QualificationAsPerDeposits; QualificationAmount) { }
            column(LoanOfficer; LoanOfficer) { }
            column(ProcessingNotes; Remarks) { }
            column(Installement; "New Installments") { }

            dataitem(LoanGuarantorsAndSecurity; "Loan Security")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = where(Substituted = const(false));

                column(ReportForNavId_60; 60) { }
                column(GuarantorLineNo; GuarantorLineNo) { }
                column(GuarantorType; "Guarantor Type") { }
                column(GuarantorMemberNo; "Member No") { }
                column(GuarantorName; SecurityDetails) { }
                column(GuarantorDeposits; "Guarantor Deposits") { }
                column(PriorGuaranteeAmount; PriorGuaranteeAmount) { }
                column(LoanGuaranteeAmount; "Amount Guaranteed") { }
                column(GuarantorRowKey; GuarantorRowKey) { }

                trigger OnAfterGetRecord()
                var
                    Collateral: Record "Loan Collateral Register";
                    SavingsAccount: Record "Savings Accounts";
                begin
                    GuarantorLineNo += 1;
                    Clear(SecurityDetails);
                    GuarantorRowKey := CopyStr(Format(RecordId), 1, MaxStrLen(GuarantorRowKey));

                    if SavingsAccount.Get("Account No.") then
                        SecurityDetails := CopyStr(Name + ' - ' + SavingsAccount."Product Name", 1, MaxStrLen(SecurityDetails))
                    else
                        if Collateral.Get("Collateral Reg. No.") then
                            SecurityDetails := CopyStr(Name + ' - ' + Collateral."Vehicle Reg. No." + ' ' + Collateral.Remarks, 1, MaxStrLen(SecurityDetails))
                        else
                            SecurityDetails := CopyStr(Name, 1, MaxStrLen(SecurityDetails));

                    PriorGuaranteeAmount := GetPriorGuarantorCommitment(LoanGuarantorsAndSecurity);
                end;

                trigger OnPreDataItem()
                begin
                    GuarantorLineNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SetReportValues();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    local procedure SetReportValues()
    var
        Loan: Record Loans;
        ProductSetup: Record "Product Setup";
    begin
        OfficialUseDate := LoanChanges."Rescheduling Date";
        if OfficialUseDate = 0D then
            OfficialUseDate := Today;

        ShareDeposits := GetDepositBalance(LoanChanges."Member No.", OfficialUseDate);
        OutstandingLoanBalance := LoanChanges."Total Outstanding";
        if OutstandingLoanBalance = 0 then
            OutstandingLoanBalance := LoanChanges."Outstanding Principal";

        LoanOfficer := LoanChanges."Entered By";
        if LoanOfficer = '' then
            LoanOfficer := LoanChanges."Account Manager";

        MaximumLoanAllowed := 0;
        if not Loan.Get(LoanChanges."Loan No.") then begin
            QualificationAmount := 0;
            exit;
        end;

        if ProductSetup.Get(Loan."Loan Product Type") then begin
            if ProductSetup."Deposit Multiplier" > 0 then
                MaximumLoanAllowed := ShareDeposits * ProductSetup."Deposit Multiplier";

            if (ProductSetup."Maximum Loan Amount" > 0) and
               ((MaximumLoanAllowed = 0) or (MaximumLoanAllowed > ProductSetup."Maximum Loan Amount"))
            then
                MaximumLoanAllowed := ProductSetup."Maximum Loan Amount";

            if ProductSetup."Appraise Security" then
                SetSecurityBasedMaximum(Loan, MaximumLoanAllowed);
        end;

        QualificationAmount := MaximumLoanAllowed - OutstandingLoanBalance;
        if QualificationAmount < 0 then
            QualificationAmount := 0;
    end;

    local procedure GetDepositBalance(MemberNo: Code[20]; BalanceDate: Date): Decimal
    var
        SavingsAccount: Record "Savings Accounts";
        DepositBalance: Decimal;
    begin
        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", MemberNo);
        SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Deposit Contribution");
        SavingsAccount.SetRange("Date Filter", 0D, BalanceDate);
        if SavingsAccount.FindSet() then
            repeat
                SavingsAccount.CalcFields("Balance (LCY)");
                DepositBalance += SavingsAccount."Balance (LCY)";
            until SavingsAccount.Next() = 0;

        exit(DepositBalance);
    end;

    local procedure SetSecurityBasedMaximum(Loan: Record Loans; var MaximumAmount: Decimal)
    var
        Appraisal: Record "Member Salary Appraisal";
    begin
        if (Loan."Salary Appraisal No." <> '') and Appraisal.Get(Loan."Salary Appraisal No.") then
            if Appraisal."Maximum Credit" > 0 then
                MaximumAmount := Appraisal."Maximum Credit";
    end;

    local procedure GetPriorGuarantorCommitment(CurrentLoanSecurity: Record "Loan Security"): Decimal
    var
        OtherLoanSecurity: Record "Loan Security";
        PriorCommitment: Decimal;
    begin
        OtherLoanSecurity.Reset();
        OtherLoanSecurity.SetRange("Member No", CurrentLoanSecurity."Member No");
        OtherLoanSecurity.SetRange("Guarantor Type", CurrentLoanSecurity."Guarantor Type");
        OtherLoanSecurity.SetRange("Account No.", CurrentLoanSecurity."Account No.");
        OtherLoanSecurity.SetRange("Collateral Reg. No.", CurrentLoanSecurity."Collateral Reg. No.");
        OtherLoanSecurity.SetFilter("Loan No.", '<>%1', CurrentLoanSecurity."Loan No.");
        OtherLoanSecurity.SetFilter("Amount Guaranteed", '>%1', 0);
        OtherLoanSecurity.SetRange(Substituted, false);
        OtherLoanSecurity.SetFilter("Outstanding Principal", '>%1', 0);
        if OtherLoanSecurity.FindSet() then
            repeat
                if OtherLoanSecurity.RecordId <> CurrentLoanSecurity.RecordId then
                    PriorCommitment += OtherLoanSecurity."Current Committed";
            until OtherLoanSecurity.Next() = 0;

        exit(PriorCommitment);
    end;

    var
        CompanyInformation: Record "Company Information";
        GuarantorLineNo: Integer;
        GuarantorRowKey: Text[250];
        LoanOfficer: Code[80];
        MaximumLoanAllowed: Decimal;
        OfficialUseDate: Date;
        OutstandingLoanBalance: Decimal;
        PriorGuaranteeAmount: Decimal;
        QualificationAmount: Decimal;
        SecurityDetails: Text[2048];
        ShareDeposits: Decimal;
}
