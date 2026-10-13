report 50594 "First Demand Letter Savings"
{
    ApplicationArea = All;
    Caption = 'First Demand Letter-Loan Within Savings';
    DefaultLayout = Word;
    UsageCategory = ReportsAndAnalysis;
    WordLayout = './src/Layouts/First Demand Letter-Loan Within Savings.docx';

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Principal Arrears", "Outstanding Principal", "Outstanding Interest", "Outstanding Insurance", "Outstanding Appraisal", "Outstanding Penalty", "Total Arrears", "Total Outstanding Balance";
            RequestFilterFields = "Loan No.", "Member No.";

            column(ReportForNavId_2; 2) { }
            column(CompanyInformation_Name; CompanyInformation.Name) { }
            column(CompanyInformation_Picture; CompanyInformation."Letter Head") { }
            column(CompanyInformation_watermark; CompanyInformation."Document Watermark") { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompPhone; CompanyInformation."Phone No.") { }
            column(companyEmail; CompanyInformation."E-Mail") { }
            column(companyCeoSignature; CompanyInformation."CEO Signature") { }
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
            column(LoanProductType_Loans; Loans."Loan Product Type Name") { }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name") { }
            column(ApplicationDate_Loans; Loans."Application Date") { }
            column(DisbursementDate_Loans; Loans."Disbursement Date") { }
            column(ApprovedAmount_Loans; Loans."Approved Amount") { }
            column(RequestedAmount_Loans; Loans."Requested Amount") { }
            column(Installments_Loans; Loans.Installments) { }
            column(Repayment; Loans.Repayment) { }
            column(OutstandingBalance_Loans; Loans."Outstanding Principal") { }
            column(OutstandingInterest_Loans; Loans."Outstanding Interest") { }
            column(OutstandingInsurance_Loans; Loans."Outstanding Insurance") { }
            column(OutstandingAppraisal_Loans; Loans."Outstanding Appraisal") { }
            column(OutstandingPenalty_Loans; Loans."Outstanding Penalty") { }
            column(OutstandingBills_Loans; Loans."Total Arrears") { }
            column(TotalOutstandingBalance_Loans; Loans."Total Outstanding Balance") { }
            column(PrincipalArrears_Loans; Loans."Principal Arrears") { }
            column(DemandNoticeDate; DemandNoticeDate) { }
            column(DemandIssueDate; DemandIssueDate) { }
            column(DemandLoanAmount; DemandLoanAmount) { }
            column(DemandLoanTerm; Loans.Installments) { }
            column(DemandArrearsAmount; DemandArrearsAmount) { }
            column(DemandOverdueAmount; DemandOverdueAmount) { }
            column(DemandCurrentInstallment; DemandCurrentInstallment) { }
            column(DemandDepositBalance; DemandDepositBalance) { }
            column(DemandDueDate; DemandDueDate) { }
            column(CreditOfficerName; CEOName) { }
            column(CreditOfficerPost; CEOPost) { }

            trigger OnAfterGetRecord()
            var
                UserSetup: Record "User Setup";
                Employee: Record Employee;
                SaccoSetup: Record "Sacco Setup";
            begin
                SaccoSetup.Get();
                ClearDemandValues();

                Loans.CalcFields("Total Arrears");

                DemandNoticeDate := calcdate('-CM-1D', Today);
                DemandDueDate := CalcDate('30D', DemandNoticeDate);
                DemandIssueDate := Loans."Disbursement Date";
                if DemandIssueDate = 0D then
                    DemandIssueDate := Loans."Application Date";
                DemandLoanAmount := Loans."Approved Amount";
                if DemandLoanAmount = 0 then
                    DemandLoanAmount := Loans."Requested Amount";

                DemandOverdueAmount := Loans."Total Arrears" + Loans."Outstanding Penalty" + SaccoSetup."Min. Contribution [Deposits]";
                DemandArrearsAmount := DemandOverdueAmount;
                if DemandOverdueAmount = 0 then
                    DemandOverdueAmount := Loans."Principal Arrears" + Loans."Outstanding Interest" + Loans."Outstanding Insurance" + Loans."Outstanding Appraisal" + Loans."Outstanding Penalty";
                DemandCurrentInstallment := GetCurrentMonthScheduledInstallment(Loans."Loan No.", Today, 0);
                DemandDepositBalance := GetDepositContributionBalance(Loans."Member No.", DemandNoticeDate);

                if Members.Get(Loans."Member No.") then begin
                    Memberaddress := BuildMemberAddress(Members);
                    MemberEmail := Members."E-Mail";
                    DemandPostalEmail := Memberaddress;
                    if MemberEmail <> '' then
                        DemandPostalEmail := DemandPostalEmail + MemberEmail;
                end;

                FirstName := MemberActivities.GetMemberFirstName(Loans."Member Name");

                UserSetup.Reset();
                UserSetup.SetRange("Is CEO", true);
                if UserSetup.FindFirst() then
                    if Employee.Get(UserSetup."Staff No") then begin
                        CEOName := Employee.FullName();
                        CEOPost := Employee."Job Title";
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
        CEOName: Text[100];
        CEOPost: Text[100];
        CompanyAddress: Text[250];
        CompanyInformation: Record "Company Information";
        CompanyTelephone: Text[100];
        CompName: Text[100];
        DemandArrearsAmount: Decimal;
        DemandCurrentInstallment: Decimal;
        DemandDepositBalance: Decimal;
        DemandDueDate: Date;
        DemandIssueDate: Date;
        DemandLoanAmount: Decimal;
        DemandNoticeDate: Date;
        DemandOverdueAmount: Decimal;
        DemandPostalEmail: Text[250];
        FirstName: Text;
        MemberActivities: Codeunit "Member Activities";
        Memberaddress: Text[250];
        MemberEmail: Text[100];
        Members: Record Members;

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

    local procedure ClearDemandValues()
    begin
        Clear(CEOName);
        Clear(CEOPost);
        Clear(DemandArrearsAmount);
        Clear(DemandCurrentInstallment);
        Clear(DemandDepositBalance);
        Clear(DemandDueDate);
        Clear(DemandIssueDate);
        Clear(DemandLoanAmount);
        Clear(DemandNoticeDate);
        Clear(DemandOverdueAmount);
        Clear(DemandPostalEmail);
        Clear(FirstName);
        Clear(Memberaddress);
        Clear(MemberEmail);
        Clear(Members);
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
        if MemberNo = '' then
            exit(0);

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
}
