report 50007 "Second Demand Letter -Security"
{
    ApplicationArea = All;
    Caption = 'Second Demand Letter - Security';
    DefaultLayout = Word;
    UsageCategory = ReportsAndAnalysis;
    WordLayout = './src/Layouts/2nd Demand Letter- Loan secured by Motorvehicle.docx';

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Outstanding Principal", "Outstanding Interest", "Outstanding Insurance", "Outstanding Appraisal", "Outstanding Penalty", "Total Arrears", "Total Outstanding Balance";
            RequestFilterFields = "Loan No.", "Member No.";

            column(CompanyInformation_Name; CompanyInformation.Name) { }
            column(CompanyInformation_Picture; CompanyInformation."Letter Head") { }
            column(CompanyInformation_CEO_Signature; CompanyInformation."CEO Signature") { }
            column(CompanyInformation_watermark; CompanyInformation."Document Watermark") { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompPhone; CompanyInformation."Phone No.") { }
            column(companyEmail; CompanyInformation."E-Mail") { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CompName; CompName) { }
            column(PhoneNo_Members; Members."Mobile Phone No.") { }
            column(No_Members; Members."No.") { }
            column(Name_Members; Members.Name) { }
            column(MemberNo_Loans; Loans."Member No.") { }
            column(MemberName_Loans; Loans."Member Name") { }
            column(MemberEmail; MemberEmail) { }
            column(Memberaddress; Memberaddress) { }
            column(DemandPostalEmail; DemandPostalEmail) { }
            column(firstName; FirstName) { }
            column(LoanNo_Loans; Loans."Loan No.") { }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name") { }
            column(ApprovedAmount_Loans; Loans."Approved Amount") { }
            column(RequestedAmount_Loans; Loans."Requested Amount") { }
            column(OutstandingBalance_Loans; Loans."Outstanding Principal") { }
            column(OutstandingInterest_Loans; Loans."Outstanding Interest") { }
            column(OutstandingPenalty_Loans; Loans."Outstanding Penalty") { }
            column(TotalOutstandingBalance_Loans; Loans."Total Outstanding Balance") { }
            column(OutstandingBills_Loans; Loans."Total Arrears") { }
            column(Installments_Loans; Loans.Installments) { }
            column(DisbursementDate_Loans; Loans."Disbursement Date") { }
            column(ApplicationDate_Loans; Loans."Application Date") { }
            column(DemandNoticeDate; DemandNoticeDate) { }
            column(DemandDueDate; DemandDueDate) { }
            column(DemandLoanAmount; DemandLoanAmount) { }
            column(DemandArrearsAmount; DemandArrearsAmount) { }
            column(DemandOverdueAmount; DemandOverdueAmount) { }
            column(DemandCurrentInstallment; DemandCurrentInstallment) { }
            column(DemandDepositBalance; DemandDepositBalance) { }
            column(DemandPreviousNoticeDate; DemandPreviousNoticeDate) { }
            column(SecuritySummary; SecuritySummary) { }
            column(SecurityDetails; SecurityDetails) { }
            column(SecurityCount; SecurityCount) { }
            column(CreditOfficerName; CreditOfficerName) { }
            column(CreditOfficerPost; CreditOfficerPost) { }

            trigger OnAfterGetRecord()
            var
                UserSetup: Record "User Setup";
                Employee: Record Employee;
                SaccoSetup: Record "Sacco Setup";
            begin
                SaccoSetup.get();
                ClearValues();
                LoadCollateralSecurity(Loans."Loan No.");

                DemandNoticeDate := CalcDate('-CM-1D', Today);
                DemandDueDate := CalcDate('14D', DemandNoticeDate);
                DemandPreviousNoticeDate := CalcDate('-30D', DemandNoticeDate);
                DemandLoanAmount := Loans."Approved Amount";
                if DemandLoanAmount = 0 then
                    DemandLoanAmount := Loans."Requested Amount";
                DemandOverdueAmount := Loans."Total Arrears" + Loans."Outstanding Penalty" + SaccoSetup."Min. Contribution [Deposits]";
                DemandArrearsAmount := DemandOverdueAmount;
                DemandCurrentInstallment := GetCurrentMonthScheduledInstallment(Loans."Loan No.", Today, 0);
                DemandDepositBalance := GetDepositContributionBalance(Loans."Member No.", DemandNoticeDate);

                if Members.Get(Loans."Member No.") then begin
                    Memberaddress := BuildMemberAddress(Members);
                    MemberEmail := Members."E-Mail";
                    DemandPostalEmail := MemberEmail;
                    if DemandPostalEmail = '' then
                        DemandPostalEmail := Memberaddress;
                end;

                FirstName := MemberActivities.GetMemberFirstName(Loans."Member Name");

                UserSetup.Reset();
                UserSetup.SetRange("Is CEO", true);
                if UserSetup.FindFirst() then
                    if Employee.Get(UserSetup."Staff No") then begin
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

    trigger OnPreReport()
    begin
        if CompanyInformation.Get() then
            CompanyInformation.CalcFields("Letter Head", "Document Watermark", "CEO Signature");

        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No.";
    end;

    var
        CompanyAddress: Text[250];
        CompanyInformation: Record "Company Information";
        CompanyTelephone: Text[100];
        CompName: Text[100];
        CreditOfficerName: Text[100];
        CreditOfficerPost: Text[100];
        DemandArrearsAmount: Decimal;
        DemandCurrentInstallment: Decimal;
        DemandDepositBalance: Decimal;
        DemandDueDate: Date;
        DemandLoanAmount: Decimal;
        DemandNoticeDate: Date;
        DemandOverdueAmount: Decimal;
        DemandPostalEmail: Text[250];
        DemandPreviousNoticeDate: Date;
        FirstName: Text;
        Memberaddress: Text[250];
        SecurityCount: Integer;
        SecurityDetails: Text[1024];
        SecuritySummary: Text[1024];
        MemberActivities: Codeunit "Member Activities";
        MemberEmail: Text[100];
        Members: Record Members;

    local procedure AppendText(var TargetText: Text[1024]; NewText: Text)
    begin
        if NewText = '' then
            exit;
        if TargetText <> '' then
            NewText := '; ' + NewText;
        TargetText := CopyStr(TargetText + NewText, 1, MaxStrLen(TargetText));
    end;

    local procedure BuildMemberAddress(MemberRec: Record Members): Text[250]
    var
        AddressText: Text[250];
    begin
        AddressText := MemberRec.Address;
        if MemberRec."Post Code" <> '' then
            AddressText += ' -Post Code: ' + MemberRec."Post Code";
        if MemberRec.City <> '' then
            AddressText += ' -City: ' + MemberRec.City;

        exit(AddressText);
    end;

    local procedure ClearValues()
    begin
        Clear(CreditOfficerName);
        Clear(CreditOfficerPost);
        Clear(DemandArrearsAmount);
        Clear(DemandCurrentInstallment);
        Clear(DemandDepositBalance);
        Clear(DemandDueDate);
        Clear(DemandLoanAmount);
        Clear(DemandNoticeDate);
        Clear(DemandOverdueAmount);
        Clear(DemandPostalEmail);
        Clear(DemandPreviousNoticeDate);
        Clear(FirstName);
        Clear(Memberaddress);
        Clear(MemberEmail);
        Clear(Members);
        Clear(SecurityCount);
        Clear(SecurityDetails);
        Clear(SecuritySummary);
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

    local procedure GetDepositContributionBalance(MemberNo: Code[20]; AsAtDate: Date): Decimal
    var
        Savings: Record "Savings Accounts";
        DepositBalance: Decimal;
    begin
        Savings.Reset();
        Savings.SetRange("Member No.", MemberNo);
        Savings.SetRange("Product Category", Savings."Product Category"::"Deposit Contribution");
        if AsAtDate <> 0D then
            Savings.SetRange("Date Filter", 0D, AsAtDate);
        if Savings.FindSet() then
            repeat
                Savings.CalcFields("Balance (LCY)");
                DepositBalance += Savings."Balance (LCY)";
            until Savings.Next() = 0;
        exit(DepositBalance);
    end;

    local procedure LoadCollateralSecurity(LoanNo: Code[20])
    var
        LoanSecurity: Record "Loan Security";
        SecurityLine: Text[250];
        CollateralName: Text[150];
    begin
        LoanSecurity.Reset();
        LoanSecurity.SetRange("Loan No.", LoanNo);
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."Guarantor Type"::Collateral);
        LoanSecurity.SetRange(Substituted, false);
        if LoanSecurity.FindSet() then
            repeat
                LoanSecurity.CalcFields("Security Details");
                SecurityCount += 1;
                if LoanSecurity.Name <> '' then
                    CollateralName := LoanSecurity.Name
                else
                    CollateralName := LoanSecurity."Collateral Reg. No.";
                SecurityLine := CopyStr(StrSubstNo('%1 - Kshs. %2', CollateralName, LoanSecurity."Amount Guaranteed"), 1, 250);
                AppendText(SecuritySummary, SecurityLine);
                AppendText(SecurityDetails, LoanSecurity."Security Details");
            until LoanSecurity.Next() = 0;
    end;
}
