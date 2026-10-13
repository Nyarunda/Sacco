namespace UnitedWomen.UnitedWomen;
using Microsoft.HumanResources.Employee;
using Microsoft.Foundation.Company;
using System.Security.User;

report 50553 "Loan Disbursement letter"
{
    ApplicationArea = All;
    Caption = 'Loan Disbursement letter';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './src/Layouts/LoanDisbursment.docx';
    dataset
    {
        dataitem(Loans; Loans)
        {
            column(LoanNo; "Loan No.")
            {
            }
            column(CeoSiganture; CI."CEO Signature")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(NetToBeDisbursed; "Net To Be Disbursed")
            {
            }
            column(DisbursementDate; "Disbursement Date")
            {
            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {
            }
            column(Approved_Amount; "Approved Amount")
            {
            }
            column(TopupInt; TopupInt)
            { }
            column(PrincipalTopUp; PrincipalTopUp)
            { }
            column(CreditOfficerName; CreditOfficerName)
            { }
            column(CreditOfficerPost; CreditOfficerPost)
            { }
            column(Amount_To_Disburse; "Amount To Disburse")
            { }
            column(Installments; Installments)
            { }
            column(FirstName; FirstName)
            { }
            column(MemberEmail; MemberEmail)
            { }
            column(ProcessingFee; ProcessingFee)
            { }
            column(ProcessingFeeExcise; ProcessingFeeExciseAmount)
            { }
            column(FeeLineText; FeeLineText)
            { }
            column(ExciseLineText; ExciseLineText)
            { }
            column(FeeExplanationText; FeeExplanationText)
            { }
            column(FeeBaseAmount; FeeBaseAmount)
            { }
            column(FeeText; FeeText)
            { }
            column(ExciseText; ExciseText)
            { }
            column(TopupCommission; FeeText)
            { }
            column(TopupCommisionExcise; ExciseText)
            { }
            column(LoanTypeName; LoanTypeName)
            { }
            column(SubjectText; SubjectText)
            { }
            column(TopUpDescriptionText; TopUpDescriptionText)
            { }
            column(ClearLoanBalanceText; ClearLoanBalanceText)
            { }
            column(ClearInterestInsuranceText; ClearInterestInsuranceText)
            { }
            dataitem("HR Employee Bank Accounts"; "HR Employee Bank Accounts")
            {
                DataItemLink = "Loan No." = field("Loan No.");

                column(HR_Bank_Accounts_Amount_to_Transfer; "Amount to Transfer")
                { }
                column(HR_Bank_Accounts_Remarks; Remarks)
                { }
                column(HR_Bank_Accounts_DisbursementEntries; DisbursementEntries)
                { }

                trigger OnPreDataItem()
                begin
                    CI.Get();
                    CI.CalcFields("CEO Signature");
                    DisbursementEntries := 2;
                end;

                trigger OnAfterGetRecord()
                begin
                    DisbursementEntries += 1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                LoanTopUp: Record "Loan Top Up";
                LoanType: Record "Product Setup";
                MemberRec: Record Members;
                MemberAct: Codeunit "Member Activities";
            begin
                Clear(PrincipalTopUp);
                Clear(TopupInt);
                Clear(ProcessingFee);
                Clear(ProcessingPercentage);
                Clear(ProcessingFeeExciseAmount);
                Clear(FeeLineText);
                Clear(ExciseLineText);
                Clear(FeeExplanationText);
                Clear(FeeBaseAmount);
                Clear(FeeText);
                Clear(ExciseText);
                Clear(TopupCommissionAmount);
                Clear(TopupCommissionExciseAmount);
                Clear(LoanTypeName);
                Clear(SubjectText);
                Clear(TopUpDescriptionText);
                Clear(ClearLoanBalanceText);
                Clear(ClearInterestInsuranceText);

                LoanTopUp.Reset();
                LoanTopUp.SetRange("Loan No.", Loans."Loan No.");
                if LoanTopUp.FindFirst() then begin
                    LoanTopUp.CalcSums(
                        "Principle Top Up",
                        "Interest Top Up",
                        "Uncharged Interest",
                        "Uncharged Insurance",
                        "Commision Excise",
                        Commision);
                    PrincipalTopUp := LoanTopUp."Principle Top Up";
                    TopupInt := LoanTopUp."Interest Top Up" +
                        LoanTopUp."Uncharged Interest" +
                        LoanTopUp."Uncharged Insurance";
                    TopupCommissionAmount := LoanTopUp.Commision;
                    TopupCommissionExciseAmount := LoanTopUp."Commision Excise";
                    if LoanType.Get(LoanTopUp."Loan Type") then
                        LoanTypeName := LoanType.Description;
                end;
                usersetup.Reset();
                usersetup.SetRange("Is CEO", true);
                if usersetup.FindFirst() then begin
                    Employee.get(usersetup."Staff No");
                    CreditOfficerName := Employee.FullName();
                    CreditOfficerPost := Employee."Job Title";
                end;
                if MemberRec.get("Member No.") then begin
                    MemberEmail := MemberRec."E-Mail";
                end;
                FirstName := MemberAct.GetMemberFirstName(MemberRec.Name);

                ApplyProcessingFeeCharge();
                SetFeeExplanationText();
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
    var
        PrincipalTopUp: Decimal;
        TopupInt: Decimal;
        CreditOfficerPost: Text;
        CreditOfficerName: Text;
        Employee: Record Employee;
        usersetup: Record "User Setup";
        MemberEmail: Text;
        FirstName: Text;
        DisbursementEntries: Integer;
        ProcessingFee: Decimal;
        ProcessingPercentage: Decimal;
        ProcessingFeeExciseAmount: Decimal;
        ExciseDutyPercentage: Decimal;
        FeeBaseAmount: Decimal;
        FeeLineText: Text[100];
        ExciseLineText: Text[100];
        FeeExplanationText: Text;
        FeeText: Text[30];
        ExciseText: Text[30];
        TopupCommissionAmount: Decimal;
        TopupCommissionExciseAmount: Decimal;
        LoanTypeName: Text[100];
        SubjectText: Text[150];
        TopUpDescriptionText: Text[250];
        ClearLoanBalanceText: Text[150];
        ClearInterestInsuranceText: Text[150];
        CI: Record "Company Information";

    local procedure ApplyProcessingFeeCharge()
    var
        LoanCharge: Record "Loan Charges";
        SaccoSetup: Record "Sacco Setup";
    begin
        if SaccoSetup.Get() then
            ExciseDutyPercentage := SaccoSetup."Excise Duty (%)";

        LoanCharge.Reset();
        LoanCharge.SetRange("Loan No.", Loans."Loan No.");
        LoanCharge.SetRange("Charge Code", 'PFEE');
        if not LoanCharge.FindFirst() then
            exit;

        ProcessingFee := LoanCharge.Amount;
        ProcessingPercentage := LoanCharge."Charge %";
        ProcessingFeeExciseAmount := LoanCharge."Excise Duty";
    end;

    local procedure SetFeeExplanationText()
    var
        ProductName: Text[100];
        DisbursementMonthText: Text[50];
    begin
        ProductName := Loans."Loan Product Type Name";
        if ProductName = '' then
            ProductName := LoanTypeName;
        if ProductName = '' then
            ProductName := 'Loan';

        FeeBaseAmount := Loans."Amount To Disburse" - PrincipalTopUp;
        SubjectText := StrSubstNo('RE: %1 DISBURSEMENT', UpperCase(ProductName));
        if Loans."Type of Disbursement" = Loans."Type of Disbursement"::"Partial Disbursement" then
            SubjectText := StrSubstNo('RE: PARTIAL %1 DISBURSEMENT', UpperCase(ProductName));

        if PrincipalTopUp > 0 then
            TopUpDescriptionText := StrSubstNo(
                'Top up of your loan amount to Kshs. %1 as per the breakdown below:',
                Format(Loans."Amount To Disburse"));

        ClearLoanBalanceText := StrSubstNo('Clear %1 Loan Balance', LoanTypeName);
        if StrPos(UpperCase(LoanTypeName), 'LOAN') > 0 then
            ClearLoanBalanceText := StrSubstNo('Clear %1 Balance', LoanTypeName);

        DisbursementMonthText := Format(
            Loans."Disbursement Date",
            0,
            '<Month Text> <Year4>');
        ClearInterestInsuranceText :=
            StrSubstNo('Clear %1 Interest & Insurance', DisbursementMonthText);

        if TopupCommissionAmount > 0 then begin
            FeeLineText := 'Top up commission';
            FeeText := Format(TopupCommissionAmount);
            ExciseText := Format(TopupCommissionExciseAmount);
            FeeBaseAmount := PrincipalTopUp;
        end else begin
            FeeLineText := 'Processing fees';
            FeeText := Format(ProcessingFee);
            ExciseText := Format(ProcessingFeeExciseAmount);
        end;

        ExciseLineText := StrSubstNo('Excise duty on %1', FeeLineText);

        if ProcessingFee > 0 then
            FeeExplanationText := StrSubstNo(
                'As per our lending policy, there is a %1% processing fee for %2. In view of this, please note that we have deducted Kshs.%3 being the processing fees on Kshs.%4. This amount is subject to %5% excise duty whose amount is Kshs.%6 as highlighted above.',
                ProcessingPercentage,
                ProductName,
                FeeText,
                Format(FeeBaseAmount),
                ExciseDutyPercentage,
                ExciseText)
        else
            if TopupCommissionAmount > 0 then
                FeeExplanationText := StrSubstNo(
                    'As per our lending policy, a refinance fee applies to this loan top-up. We have deducted Kshs.%1 as the refinancing fee on Kshs.%2. This amount is subject to excise duty of Kshs.%3 as highlighted above.',
                    FeeText,
                    Format(FeeBaseAmount),
                    ExciseText);
    end;
}
