report 50006 "Statutory Notice-2"
{
    ApplicationArea = All;
    Caption = 'Statutory Notice-2';
    DefaultLayout = Word;
    UsageCategory = ReportsAndAnalysis;
    WordLayout = './src/Layouts/Statutory Notice-2.docx';

    dataset
    {
        dataitem(Loans; "Loan Security")
        {
            DataItemTableView = where("Guarantor Type" = const(Collateral), Substituted = const(false));
            RequestFilterFields = "Loan No.", "Collateral Reg. No.", "Account No.";

            column(ReportForNavId_2; 2) { }
            column(CompanyInformation_Name; CompanyInformation.Name) { }
            column(CompanyInformation_Picture; CompanyInformation."Letter Head") { }
            column(CompanyInformation_watermark; CompanyInformation."Document Watermark") { }
            column(CompanyInformation_CEOSignature; CompanyInformation."CEO Signature") { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompPhone; CompanyInformation."Phone No.") { }
            column(companyEmail; CompanyInformation."E-Mail") { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(PhoneNo_Members; Members."Mobile Phone No.") { }
            column(No_Members; Members."No.") { }
            column(Name_Members; Members.Name) { }
            column(CompName; CompName) { }
            column(OutstandingBalance_Loans; LoanRec."Outstanding Principal") { }
            column(firstName; FirstName) { }
            column(LoanNo_Loans; Loans."Loan No.") { }
            column(DefAmount; DefAmount) { }
            column(ApplicationDate_Loans; LoanRec."Application Date") { }
            column(LoanProductType_Loans; LoanRec."Loan Product Type Name") { }
            column(MemberNo_Loans; LoanRec."Member No.") { }
            column(RequestedAmount_Loans; LoanRec."Requested Amount") { }
            column(ApprovedAmount_Loans; LoanRec."Approved Amount") { }
            column(Interest_Loans; LoanRec."Annual Interest %") { }
            column(MemberName_Loans; LoanRec."Member Name") { }
            column(OutstandingInterest_Loans; LoanRec."Outstanding Interest") { }
            column(OutstandingBills_Loans; LoanRec."Total Arrears") { }
            column(OutstandingAppraisal_Loans; LoanRec."Outstanding Appraisal") { }
            column(Installments_Loans; LoanRec.Installments) { }
            column(LoanProductTypeName_Loans; LoanRec."Loan Product Type Name") { }
            column(DisbursementDate_Loans; LoanRec."Disbursement Date") { }
            column(IssuedDate; IssuedDate) { }
            column(LastPayDate; LastPayDate) { }
            column(PrincipalArrears_Loans; LoanRec."Principal Arrears") { }
            column(OutstandingPenalty_Loans; LoanRec."Outstanding Penalty") { }
            column(TotalOutstandingBalance_Loans; LoanRec."Total Outstanding Balance") { }
            column(ID_No_; "ID No.") { }
            column(AsAt; AsAt) { }
            column(ArrearsDate; AsAt) { }
            column(CreditOfficerName; Ceoname) { }
            column(MemberEmail; MemberEmail) { }
            column(Memberaddress; Memberaddress) { }
            column(CreditOfficerPost; CeoPost) { }
            column(Repayment; Repayment) { }
            column(StatutoryNoticeDate; AsAt) { }
            column(StatutoryTitleNumber; StatutoryTitleNumber) { }
            column(StatutoryBorrowerName; LoanRec."Member Name") { }
            column(StatutoryChargorName; StatutoryChargorName) { }
            column(StatutoryDateOfCharge; StatutoryDateOfCharge) { }
            column(StatutoryPropertyReferenceNo; StatutoryPropertyReferenceNo) { }
            column(StatutoryChargeAmount; StatutoryChargeAmount) { }
            column(StatutoryTotalIndebtedness; StatutoryTotalIndebtedness) { }
            column(StatutoryTotalIndebtednessInWords; StatutoryTotalIndebtednessInWords) { }
            column(StatutoryCollateralNo; StatutoryCollateralNo) { }
            column(StatutoryCollateralName; StatutoryCollateralName) { }
            column(StatutoryCollateralDetails; StatutoryCollateralDetails) { }
            column(StatutoryCounty; StatutoryCounty) { }
            column(StatutoryCountyCommissionerAddress; StatutoryCountyCommissionerAddress) { }

            trigger OnAfterGetRecord()
            var
                UserSetup: Record "User Setup";
                Employee: Record Employee;
            begin
                ClearNoticeValues();

                if not LoanRec.Get(Loans."Loan No.") then
                    CurrReport.Skip();
                    
                LoanRec.CalcFields("Outstanding Principal", "Outstanding Interest", "Outstanding Appraisal", "Outstanding Penalty", "Total Arrears", "Total Outstanding Balance");

                if Members.Get(LoanRec."Member No.") then begin
                    Memberaddress := Members.Address + ' -Post Code: ' + Members."Post Code" + ' -City:' + Members.City + ' Region: ' + Members."Country/Region Code";
                    MemberEmail := Members."E-Mail";
                    TelPhone := 'Tel: ' + Members."Mobile Phone No.";
                    StatutoryCounty := Members.County;
                end;

                IssuedDate := CalcDate('3M', Today);
                
                AsAt := Today;
                DefAmount := LoanRec."Total Arrears";
                FirstName := MemberActivities.GetMemberFirstName(LoanRec."Member Name");
                Repayment := LoanRec.Repayment;

                StatutoryTotalIndebtedness := LoanRec."Total Outstanding Balance";
                if StatutoryTotalIndebtedness = 0 then
                    StatutoryTotalIndebtedness := LoanRec."Outstanding Principal" + LoanRec."Outstanding Interest" + LoanRec."Outstanding Appraisal" + LoanRec."Outstanding Penalty";
                StatutoryTotalIndebtednessInWords := GetAmountInWords(StatutoryTotalIndebtedness);

                LoadSecurityDetails(Loans);

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
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail";
    end;

    var
        AmountInWords: array[2] of Text[80];
        AsAt: Date;
        CheckReport: Report Check;
        CommunicationOnline: Text;
        CompanyAddress: Text;
        CompanyInformation: Record "Company Information";
        CompanyTelephone: Text;
        CompName: Text[100];
        CEOName: Text[100];
        CEOPost: Text[100];
        DefAmount: Decimal;
        FirstName: Text;
        IssuedDate: Date;
        LastPayDate: Date;
        MemberActivities: Codeunit "Member Activities";
        Memberaddress: Text[250];
        MemberEmail: Text[100];
        Members: Record Members;
        Repayment: Decimal;
        StatutoryChargeAmount: Decimal;
        StatutoryChargorName: Text[100];
        StatutoryCollateralDetails: Text[250];
        StatutoryCollateralName: Text[100];
        StatutoryCollateralNo: Code[20];
        StatutoryCounty: Text[50];
        StatutoryCountyCommissionerAddress: Text[100];
        StatutoryDateOfCharge: Date;
        StatutoryPropertyReferenceNo: Text[100];
        StatutoryTitleNumber: Text[100];
        StatutoryTotalIndebtedness: Decimal;
        StatutoryTotalIndebtednessInWords: Text[250];
        TelPhone: Text[50];
        LoanRec: Record Loans;

    local procedure ClearNoticeValues()
    begin
        Clear(AmountInWords);
        Clear(CEOName);
        Clear(CEOPost);
        Clear(LastPayDate);
        Clear(Memberaddress);
        Clear(MemberEmail);
        Clear(Members);
        Clear(StatutoryChargeAmount);
        Clear(StatutoryChargorName);
        Clear(StatutoryCollateralDetails);
        Clear(StatutoryCollateralName);
        Clear(StatutoryCollateralNo);
        Clear(StatutoryCounty);
        Clear(StatutoryCountyCommissionerAddress);
        Clear(StatutoryDateOfCharge);
        Clear(StatutoryPropertyReferenceNo);
        Clear(StatutoryTitleNumber);
        Clear(StatutoryTotalIndebtedness);
        Clear(StatutoryTotalIndebtednessInWords);
        Clear(TelPhone);
    end;

    local procedure GetAmountInWords(Amount: Decimal): Text[250]
    begin
        Clear(AmountInWords);
        CheckReport.InitTextVariable();
        CheckReport.FormatNoText(AmountInWords, Amount, '');
        exit(DelChr(AmountInWords[1] + ' ' + AmountInWords[2], '<>'));
    end;

    local procedure LoadSecurityDetails(LoanSecurity: Record "Loan Security")
    var
        SecReg: Record "Loan Collateral Register";
    begin
        StatutoryCollateralNo := LoanSecurity."Collateral Reg. No.";
        StatutoryChargorName := LoanSecurity.Name;
        StatutoryChargeAmount := LoanSecurity."Amount Guaranteed";
        StatutoryDateOfCharge := LoanSecurity.Date;

        if SecReg.Get(LoanSecurity."Collateral Reg. No.") then begin
            StatutoryCollateralName := SecReg."Collateral Name";
            StatutoryCollateralDetails := SecReg."Collateral Details";
            if StatutoryCollateralDetails = '' then
                StatutoryCollateralDetails := SecReg.Remarks;

            StatutoryTitleNumber := SecReg."Title Name";
            if StatutoryTitleNumber = '' then
                StatutoryTitleNumber := SecReg."Plot No.";
            if StatutoryTitleNumber = '' then
                StatutoryTitleNumber := SecReg."No.";

            StatutoryPropertyReferenceNo := SecReg."Plot No.";
            if StatutoryPropertyReferenceNo = '' then
                StatutoryPropertyReferenceNo := SecReg."Title Name";
            if StatutoryPropertyReferenceNo = '' then
                StatutoryPropertyReferenceNo := SecReg."No.";

            if SecReg."Registered Owner" <> '' then
                StatutoryChargorName := SecReg."Registered Owner";
            if SecReg."Charged Value" <> 0 then
                StatutoryChargeAmount := SecReg."Charged Value";
            if StatutoryDateOfCharge = 0D then
                StatutoryDateOfCharge := SecReg."Date Captured";
            if StatutoryCounty = '' then
                StatutoryCounty := SecReg.Location;
        end;

        if StatutoryCounty <> '' then
            StatutoryCountyCommissionerAddress := StatutoryCounty + ' County';
    end;
}

