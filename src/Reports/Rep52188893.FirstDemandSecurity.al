report 50595 "First Demand Letter Security"
{
    ApplicationArea = All;
    Caption = 'First Demand Letter - With Security';
    DefaultLayout = Word;
    UsageCategory = ReportsAndAnalysis;
    WordLayout = './src/Layouts/First Demand Letter - With Security.docx';

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Outstanding Principal", "Outstanding Interest", "Outstanding Insurance", "Outstanding Appraisal", "Outstanding Penalty", "Total Arrears", "Total Outstanding Balance";
            RequestFilterFields = "Loan No.", "Member No.";

            column(ReportForNavId_2; 2) { }
            column(CompanyInformation_Name; CompanyInformation.Name) { }
            column(CompanyInformation_Picture; CompanyInformation."Letter Head") { }
            column(CompanyInformation_watermark; CompanyInformation."Document Watermark") { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompPhone; CompanyInformation."Phone No.") { }
            column(companyEmail; CompanyInformation."E-Mail") { }
            column(CEOSignature; CompanyInformation."CEO Signature") { }
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
            column(SecuritySummary; SecuritySummary) { }
            column(SecurityDetails; SecurityDetails) { }
            column(SecurityTotalAmountGuaranteed; SecurityTotalAmountGuaranteed) { }
            column(SecurityGuarantorCount; SecurityGuarantorCount) { }
            column(SecurityCollateralCount; SecurityCollateralCount) { }
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
                LoadSecurityDetails(Loans."Loan No.");

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
        SecurityCollateralCount: Integer;
        SecurityDetails: Text[1024];
        SecurityGuarantorCount: Integer;
        SecuritySummary: Text[1024];
        SecurityTotalAmountGuaranteed: Decimal;

    local procedure AppendSecurityText(var TargetText: Text[1024]; NewText: Text)
    begin
        if NewText = '' then
            exit;

        if TargetText <> '' then
            NewText := '; ' + NewText;

        TargetText := CopyStr(TargetText + NewText, 1, MaxStrLen(TargetText));
    end;

    local procedure BuildCollateralSecurityLine(LoanSecurity: Record "Loan Security"): Text[250]
    var
        CollateralRegister: Record "Loan Collateral Register";
        Amount: Decimal;
        CollateralName: Text[150];
    begin
        Amount := LoanSecurity."Amount Guaranteed";
        CollateralName := LoanSecurity.Name;

        if CollateralRegister.Get(LoanSecurity."Collateral Reg. No.") then begin
            CollateralName := CollateralRegister."Collateral Name";
            if CollateralName = '' then
                CollateralName := CollateralRegister."Collateral Description";
            if CollateralName = '' then
                CollateralName := CollateralRegister."Collateral Details";
            if CollateralName = '' then
                CollateralName := CollateralRegister."Title Name";
            if CollateralName = '' then
                CollateralName := CollateralRegister."Plot No.";
            if CollateralName = '' then
                CollateralName := CollateralRegister."No.";

            if CollateralRegister."Charged Value" <> 0 then
                Amount := CollateralRegister."Charged Value";
        end;

        if LoanSecurity."Collateral Reg. No." <> '' then
            CollateralName := CopyStr(CollateralName + ' - ' + LoanSecurity."Collateral Reg. No.", 1, MaxStrLen(CollateralName));

        exit(CopyStr(StrSubstNo('%1 - Kshs. %2', CollateralName, Amount), 1, 250));
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

    local procedure BuildSecurityLine(LoanSecurity: Record "Loan Security"): Text[250]
    var
        SecurityName: Text[150];
    begin
        if LoanSecurity."Guarantor Type" = LoanSecurity."Guarantor Type"::Collateral then
            exit(BuildCollateralSecurityLine(LoanSecurity));

        SecurityName := LoanSecurity.Name;
        if SecurityName = '' then
            SecurityName := LoanSecurity."Account No.";

        exit(CopyStr(StrSubstNo('%1 - Kshs. %2', SecurityName, LoanSecurity."Amount Guaranteed"), 1, 250));
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
        Clear(SecurityCollateralCount);
        Clear(SecurityDetails);
        Clear(SecurityGuarantorCount);
        Clear(SecuritySummary);
        Clear(SecurityTotalAmountGuaranteed);
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

    local procedure LoadSecurityDetails(LoanNo: Code[20])
    var
        LoanSecurity: Record "Loan Security";
        SecurityLine: Text[250];
    begin
        if LoanNo = '' then
            exit;

        LoanSecurity.Reset();
        LoanSecurity.SetRange("Loan No.", LoanNo);
        LoanSecurity.SetRange(Substituted, false);
        if LoanSecurity.FindSet() then
            repeat
                LoanSecurity.CalcFields("Security Details");
                SecurityTotalAmountGuaranteed += LoanSecurity."Amount Guaranteed";

                if LoanSecurity."Guarantor Type" = LoanSecurity."Guarantor Type"::Guarantor then
                    SecurityGuarantorCount += 1
                else
                    if LoanSecurity."Guarantor Type" = LoanSecurity."Guarantor Type"::Collateral then
                        SecurityCollateralCount += 1;

                SecurityLine := BuildSecurityLine(LoanSecurity);
                AppendSecurityText(SecuritySummary, SecurityLine);
                AppendSecurityText(SecurityDetails, LoanSecurity."Security Details");
            until LoanSecurity.Next() = 0;
    end;
}
