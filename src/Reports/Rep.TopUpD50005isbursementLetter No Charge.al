namespace UnitedWomen.UnitedWomen;
using Microsoft.HumanResources.Employee;
using Microsoft.Foundation.Company;
using System.Security.User;

report 50005 "Top Up Disbursement No Charge"
{
    ApplicationArea = All;
    Caption = 'Top Up Disbursement Letter No Charges';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './src/Layouts/TopUpDisbursementTable NoCharge.docx';
    dataset
    {
        dataitem(Loans; Loans)
        {
            column(LoanNo; "Loan No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(FirstName; FirstName) { }
            column(MemberEmail; MemberEmail) { }
            column(NetToBeDisbursed; NetToBeDisbursedAmount)
            {
            }
            column(DisbursementDate; "Disbursement Date")
            {
            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
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
            column(TopupCommission; FeeText)
            { }
            column(TopupCommisionExcise; ExciseText)
            { }
            column(FeeLineNoText; FeeLineNoText) { }
            column(ExciseLineNoText; ExciseLineNoText) { }
            column(LoanTypeName; LoanTypeName)
            { }
            column(CommissionRate; CommissionRate) { }
            column(SubjectText; SubjectText) { }
            column(TopUpDescriptionText; TopUpDescriptionText) { }
            column(ClearLoanBalanceText; ClearLoanBalanceText) { }
            column(ClearInterestInsuranceText; ClearInterestInsuranceText) { }
            column(FeeLineText; FeeLineText) { }
            column(ExciseLineText; ExciseLineText) { }
            column(FeeExplanationText; FeeExplanationText) { }
            column(FeeBaseAmount; FeeBaseAmount) { }
            column(CEOSignature; CompanyInformation."CEO Signature") { }
            column(ProcessingFee; ProcessingFee) { }
            dataitem("HR Employee Bank Accounts"; "HR Employee Bank Accounts")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                column(HR_Bank_Accounts_Amount_to_Transfer; "Amount to Transfer") { }
                column(HR_Bank_Accounts_Remarks; Remarks) { }
                column(HR_Bank_Accounts_DisbursementEntries; DisbursementEntries) { }
                trigger OnPreDataItem()
                begin
                    DisbursementEntries := 2;
                end;

                trigger OnAfterGetRecord()
                begin
                    DisbursementEntries += 1;
                end;
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if CompanyInformation.Get() then
                    CompanyInformation.CalcFields("CEO Signature");
            end;

            trigger OnAfterGetRecord()
            var
                LoanTopUp: Record "Loan Top Up";
                MemberRec: Record Members;
                LoanType: Record "Product Setup";
                BankAccountLine: Record "HR Employee Bank Accounts";
                Sky: Codeunit "Sky MBanking";
                AmountPaid: Decimal;
                MainLoan: record Loans;
                LoanTop: record Loans;
                TopUpProduct: Record "Top Up Products";
            begin
                Clear(PrincipalTopUp);
                Clear(TopupInt);
                Clear(NetToBeDisbursedAmount);
                Clear(TopupCommission);
                Clear(TopupCommisionExcise);
                Clear(CommissionRate);
                Clear(FeeBaseAmount);
                Clear(LoanTypeName);
                Clear(SubjectText);
                Clear(TopUpDescriptionText);
                Clear(ClearLoanBalanceText);
                Clear(ClearInterestInsuranceText);
                Clear(FeeLineText);
                Clear(ExciseLineText);
                Clear(FeeLineNoText);
                Clear(ExciseLineNoText);
                Clear(FeeText);
                Clear(ExciseText);
                Clear(FeeExplanationText);
                clear(ProcessingFee);
                clear(ProcessingFeeExcise);
                clear(ProcessingFeeExciseAmount);

                LoanTopUp.Reset();
                LoanTopUp.SetRange("Loan No.", Loans."Loan No.");
                if LoanTopUp.FindFirst() then begin
                    LoanTopUp.CalcSums("Principle Top Up", "Interest Top Up", "Uncharged Interest", "Uncharged Insurance", "Appraisal Top Up", "Commision Excise", Commision);
                    PrincipalTopUp := LoanTopUp."Principle Top Up";
                    TopupInt := LoanTopUp."Interest Top Up" + LoanTopUp."Uncharged Insurance" + LoanTopUp."Appraisal Top Up" + LoanTopUp."Uncharged Interest";
                    TopupCommission := LoanTopUp.Commision;
                    TopupCommisionExcise := LoanTopUp."Commision Excise";

                    repeat
                        if LoanType.Get(LoanTopUp."Loan Type") then begin
                            if LoanTypeName <> '' then
                                LoanTypeName := CopyStr(LoanTypeName + ', ', 1, MaxStrLen(LoanTypeName));

                            LoanTypeName := CopyStr(LoanTypeName + ' - ' + LoanType.Description, 1, MaxStrLen(LoanTypeName));
                        end else begin
                            if LoanTypeName <> '' then
                                LoanTypeName := CopyStr(LoanTypeName + ', ', 1, MaxStrLen(LoanTypeName));

                            LoanTypeName := CopyStr(LoanTypeName, 1, MaxStrLen(LoanTypeName));
                        end;

                        if (CommissionRate = 0) and (LoanTopUp."Commission % Threshold" <> 0) then
                            CommissionRate := LoanTopUp."Commission % Threshold";

                        if LoanTop."Loan No." = '' then
                            if LoanTop.Get(LoanTopUp."Loan Top Up") then;
                    until LoanTopUp.Next() = 0;
                end;

                if MainLoan.Get("Loan No.") then;

                TopUpProduct.Reset();
                TopUpProduct.SetRange("Product ID", MainLoan."Loan Product Type");
                TopUpProduct.SetRange("Top Up Product", Loans."Loan Product Type");
                if TopUpProduct.FindFirst() then begin
                    LoanTop.CalcFields("Outstanding Principal", "Total Disbursed");
                    if TopUpProduct."Use Payment Threshold" then begin
                        if LoanTop."Total Disbursed" > 0 then begin
                            AmountPaid := LoanTop."Total Disbursed" - LoanTop."Outstanding Principal";
                            /* if AmountPaid >= LoanTop."Total Disbursed" * (TopUpProduct."Payment Threshold %" / 100) then
                                CommissionRate := TopUpProduct."Commission % Above Threshold"
                            else
                                CommissionRate := TopUpProduct."Commission % Below Threshold"; */
                        end;
                    end// else
                       //CommissionRate := TopUpProduct."Commission %";

                end;

                ApplyProcessingFeeCharge();

                BankAccountLine.Reset();
                BankAccountLine.SetRange("Loan No.", Loans."Loan No.");
                if BankAccountLine.FindSet() then
                    repeat
                        NetToBeDisbursedAmount += BankAccountLine."Amount to Transfer";
                    until BankAccountLine.Next() = 0;

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
                FirstName := Sky.FirstName(Loans."Member Name");

                SetLetterWording();
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
        DisbursementEntries: Integer;
        CommissionRate: Decimal;
        PrincipalTopUp: Decimal;
        TopupInt: Decimal;
        CompanyInformation: Record "Company Information";
        NetToBeDisbursedAmount: Decimal;
        CreditOfficerPost: Text;
        CreditOfficerName: Text;
        Employee: Record Employee;
        usersetup: Record "User Setup";
        MemberEmail: Text;
        FirstName: Text[50];
        TopupCommission: Decimal;
        TopUpAmount: Decimal;
        TopupCommisionExcise: Decimal;
        LoanTypeName: Text[250];
        SubjectText: Text[150];
        ProcessingFee: Decimal;
        ExciseDutyPercentage: Decimal;
        ProcessingPercentage: Decimal;
        ProcessingFeeExcise: Decimal;
        ProcessingFeeExciseAmount: Decimal;
        TopUpDescriptionText: Text[250];
        ClearLoanBalanceText: Text[150];
        ClearInterestInsuranceText: Text[150];
        FeeLineText: Text[100];
        ExciseLineText: Text[100];
        FeeExplanationText: Text;
        FeeBaseAmount: Decimal;
        ExciseText: Text[30];
        FeeText: Text[30];
        FeeLineNoText: Text[10];
        ExciseLineNoText: Text[10];


    local procedure ApplyProcessingFeeCharge()
    var
        LoanCharge: Record "Loan Charges";
        ProductName: Text[100];
        SaccoSetup: Record "Sacco Setup";
    begin
        SaccoSetup.Get();

        LoanCharge.Reset();
        LoanCharge.SetRange("Loan No.", Loans."Loan No.");
        LoanCharge.SetRange("Charge Code", 'PFEE');
        if not LoanCharge.FindFirst() then
            exit;

        ProcessingFee := LoanCharge.Amount;
        ExciseDutyPercentage := SaccoSetup."Excise Duty (%)";
        ProcessingPercentage := LoanCharge."Charge %";
        ProcessingFeeExciseAmount := LoanCharge."Excise Duty";

    end;

    local procedure SetLetterWording()
    var
        ProductName: Text[100];
        RateText: Text[30];
        FeeBaseText: Text[30];
        DisbursementMonthText: Text[50];
    begin
        ProductName := Loans."Loan Product Type Name";
        if ProductName = '' then
            ProductName := LoanTypeName;

        if ProductName = '' then
            ProductName := 'Loan';

        SubjectText := StrSubstNo('RE: %1 DISBURSEMENT', UpperCase(ProductName));
        if Loans."Type of Disbursement" = Loans."Type of Disbursement"::"Partial Disbursement" then
            SubjectText := StrSubstNo('RE:PARTIAL %1 DISBURSEMENT', UpperCase(ProductName));

        if TopupCommission > 0 then
            TopUpDescriptionText := StrSubstNo('Top up of your loan amount to Kshs. %1 as per the breakdown below:', Format(Loans."Amount To Disburse"));

        ClearLoanBalanceText := StrSubstNo('Clear %1 Loan Balance', LoanTypeName);
        if StrPos(UpperCase(LoanTypeName), 'LOAN') > 0 then
            ClearLoanBalanceText := StrSubstNo('Clear %1 Balance', LoanTypeName);

        DisbursementMonthText := Format(Loans."Disbursement Date", 0, '<Month Text> <Year4>');
        ClearInterestInsuranceText := StrSubstNo('Clear %1 Interest & Insurance', DisbursementMonthText);

        if TopupCommission > 0 then
            FeeLineText := 'Top up commission'
        else
            if ProcessingFee > 0 then
                FeeLineText := 'Processing fees';

        if FeeLineText <> '' then
            FeeLineNoText := '3.';

        if (CommissionRate <> 0) and (TopupCommission <> 0) then
            FeeBaseAmount := PrincipalTopUp
        else
            FeeBaseAmount := Loans."Amount To Disburse";

        /* if TopupCommission = 0 then
            exit; */
        if ProcessingPercentage > 0 then
            RateText := Format(ProcessingPercentage)
        else
            RateText := Format(CommissionRate);

        if ProcessingFee > 0 then
            FeeText := Format(ProcessingFee)
        else
            if TopupCommission > 0 then
                FeeText := Format(TopupCommission);

        if ProcessingFee > 0 then begin
            FeeBaseText := Format(Loans."Amount To Disburse" - PrincipalTopUp);
        end else
            FeeBaseText := Format(FeeBaseAmount);


        if ProcessingFeeExciseAmount > 0 then
            ExciseText := Format(ProcessingFeeExciseAmount)
        else
            if TopupCommisionExcise > 0 then
                ExciseText := Format(TopupCommisionExcise);

        if (FeeLineText <> '') and (ExciseText <> '') then begin
            ExciseLineNoText := '4.';
            ExciseLineText := StrSubstNo('Excise duty on %1', FeeLineText);
        end;

        if ProcessingFee > 0 then
            FeeExplanationText := StrSubstNo(
                'As per our lending policy, there is a %1% processing fee for %2. In view of this, please note that we have deducted Kshs.%3 being the processing fees of Kshs.%4. This amount is subject to %5% excise duty whose amount is Kshs.%6 as highlighted above.',
                RateText, Productname, FeeText, FeeBaseText, ExciseDutyPercentage, ProcessingFeeExciseAmount)
        else
            if TopupCommission > 0 then
                FeeExplanationText := StrSubstNo(
                    'As per our lending policy, there is a %1% refinance fee for any loan top-up where a member has not paid half of the current loan. In view of this, please note that we have deducted Kshs.%2 being the refinancing fee for your loan of Kshs.%3. This amount is subject to 20% excise duty as per the above.',
                    RateText, FeeText, FeeBaseText);

        /* if StrPos(UpperCase(ProductName), 'PLATINUM') > 0 then
                FeeExplanationText := StrSubstNo(
                    'Kindly note that a processing fee of %1% of the loan amount is applicable when topping up to a %2 Loan. Consequently, Kshs.%3 has been deducted, being the processing fee on the loan amount of Kshs.%4. In addition, the processing fee attracts Excise Duty at the prevailing rate of 20% as per the above.',
                    RateText, ProductName, FeeText, FeeBaseText) */
    end;

}
