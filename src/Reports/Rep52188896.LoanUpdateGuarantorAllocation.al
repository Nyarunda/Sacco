report 50598 "Guarantor Allocation Notice"
{
    ApplicationArea = All;
    Caption = 'Loan Update - Guarantor Allocation';
    DefaultLayout = Word;
    WordLayout = './src/Layouts/Loan Update- Guarantor Allocation.docx';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(RecoveryLines; "Defaulter Recovery Lines")
        {
            DataItemTableView = sorting("Header No.", "Loan No.", "Guarantor Savings Account", "Guarantor Member No.");
            RequestFilterFields = "Header No.", "Guarantor Member No.", "Loan No.";

            column(CompanyName; CompanyInformation.Name) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CompanyEmail; CompanyInformation."E-Mail") { }
            column(HeaderNo; "Header No.") { }
            column(PostingDate; DefaulterLoanRecovery."Posting Date") { }
            column(DefaulterMemberNo; DefaulterLoanRecovery."Member No.") { }
            column(DefaulterName; DefaulterLoanRecovery.Name) { }
            column(TotalDeduction; DefaulterLoanRecovery."Total Deduction") { }
            column(TotalAvailable; DefaulterLoanRecovery."Total Available") { }
            column(RecoverySource; Format(DefaulterLoanRecovery."Recovery Source")) { }
            column(RecoveryType; Format(DefaulterLoanRecovery."Recovery Type")) { }
            column(LoanNo; "Loan No.") { }
            column(LoanTypeName; "Loan Type Name") { }
            column(GuarantorMemberNo; "Guarantor Member No.") { }
            column(GuarantorName; "Guarantor Name") { }
            column(GuarantorSavingsAccount; "Guarantor Savings Account") { }
            column(WithdrawableSavings; "Withdrawable Savings") { }
            column(NonWithdrawableSavings; "Non-Withdrable Savings") { }
            column(AmountGuaranteed; "Amount Guaranteed") { }
            column(LoanAllocation; "Loan Allocation") { }
            column(AmountToRecover; "Amount to Recover") { }
            column(AmountRecovered; "Amount Recovered") { }
            column(RecoveryMethod; Format("Recovery Method")) { }
            column(RecoveryMethodText; RecoveryMethodText) { }
            column(SavingsRecoveryAmount; SavingsRecoveryAmount) { }
            column(LoanRecoveryAmount; LoanRecoveryAmount) { }
            column(Installement; Installement) { }
            column(LoanBalanceAfterOffset; "Loan Balance After Offset") { }
            column(GuarantorPhoneNo; GuarantorPhoneNo) { }
            column(GuarantorEmail; GuarantorEmail) { }
            column(NoticeMessage; NoticeMessage) { }

            trigger OnAfterGetRecord()
            begin
                CalcFields("Loan Type Name");

                if not DefaulterLoanRecovery.Get("Header No.") then
                    Clear(DefaulterLoanRecovery);

                SetLineValues();
            end;
        }
    }

    trigger OnPreReport()
    begin
        if CompanyInformation.Get() then;

        CompanyAddress := CompanyInformation.Address;
        if CompanyInformation."Post Code" <> '' then
            CompanyAddress += ' -Post Code: ' + CompanyInformation."Post Code";
        if CompanyInformation.City <> '' then
            CompanyAddress += ' -City: ' + CompanyInformation.City;
        if CompanyInformation."Country/Region Code" <> '' then
            CompanyAddress += ' Region: ' + CompanyInformation."Country/Region Code";

        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No.";
    end;

    var
        CompanyAddress: Text[250];
        CompanyInformation: Record "Company Information";
        CompanyTelephone: Text[100];
        DefaulterLoanRecovery: Record "Defaulter Loan Recovery";
        GuarantorEmail: Text[100];
        GuarantorPhoneNo: Text[30];
        LoanRecoveryAmount: Decimal;
        NoticeMessage: Text[250];
        RecoveryMethodText: Text[100];
        SavingsRecoveryAmount: Decimal;

    local procedure SetLineValues()
    var
        GuarantorMember: Record Members;
    begin
        Clear(GuarantorEmail);
        Clear(GuarantorPhoneNo);
        Clear(LoanRecoveryAmount);
        Clear(NoticeMessage);
        Clear(RecoveryMethodText);
        Clear(SavingsRecoveryAmount);

        SavingsRecoveryAmount := RecoveryLines.GetSavingsAmount();
        LoanRecoveryAmount := RecoveryLines.GetLoanAmount();

        case RecoveryLines."Recovery Method" of
            RecoveryLines."Recovery Method"::Loan:
                RecoveryMethodText := 'Defaulter loan issued to guarantor';
            RecoveryLines."Recovery Method"::Savings:
                RecoveryMethodText := 'Recovered from guarantor deposits';
            RecoveryLines."Recovery Method"::Split:
                RecoveryMethodText := 'Split between deposits and defaulter loan';
            else
                RecoveryMethodText := 'Recovered from guarantor deposits';
        end;

        if GuarantorMember.Get(RecoveryLines."Guarantor Member No.") then begin
            GuarantorPhoneNo := GuarantorMember."Mobile Phone No.";
            GuarantorEmail := GuarantorMember."E-Mail";
        end;

        if LoanRecoveryAmount > 0 then
            NoticeMessage := StrSubstNo('A defaulter loan of KES %1 has been allocated to you for loan %2 guaranteed for %3.',
                Format(LoanRecoveryAmount), RecoveryLines."Loan No.", DefaulterLoanRecovery.Name)
        else
            NoticeMessage := StrSubstNo('KES %1 has been recovered from your deposits for loan %2 guaranteed for %3.',
                Format(SavingsRecoveryAmount), RecoveryLines."Loan No.", DefaulterLoanRecovery.Name);
    end;
}
