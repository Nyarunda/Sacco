report 50358 "Sasra Insider Lending"
{
    ApplicationArea = All;
    Caption = 'Sasra Insider Lending';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Insider Lending Summary.rdlc';
    dataset
    {
        dataitem(customer; Members)
        {
            DataItemTableView = sorting("No.") order(Ascending) where("Member Category" = filter("Staff Members" | "Board Members"));
            RequestFilterFields = "No.";
            column(Name; Name)
            {
            }
            column(No; "No.")
            {
            }
            column(MemberCategory; "Member Category")
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(security; Loansecurity)
            {
            }
            column(Deposits; Deposits)
            {
            }
            column(SDate; SDate)
            {
            }
            column(EDate; EDate)
            {
            }
            dataitem(Loans; Loans)
            {

                DataItemLinkReference = customer;
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = sorting("Loan No.") where(Posted = filter(true), "Outstanding Principal" = filter(> 0), "Loan Product Type" = filter(<> 'L24'));
                CalcFields = "Loans Category-SASRA";

                column(Member_Name; "Member Name") { }
                column(Member_No_; "Member No.") { }
                column(Loan_Product_Type_Name; "Loan Product Type Name") { }
                column(Requested_Amount; "Requested Amount") { }
                column(Approved_Amount; "Total Disbursed") { }
                column(Disbursement_Date; "Disbursement Date") { }
                column(Repayment_Start_Date; "Repayment Start Date") { }
                column(Installments; Installments) { }
                column(Loans_Category_SASRA; "Loans Category-SASRA") { }
                column(Outstanding_Principal; "Outstanding Principal") { }
                column(Loansecurity; Loansecurity) { }

                column(SENo; SENo) { }


                trigger OnPreDataItem()
                begin
                    Loans.SetFilter("Disbursement Date", '%1..%2', SDate, EDate);
                    Loans.SetFilter("Date Filter", '..%1', EDate);
                    Loans.SetFilter("Member No.", customer."No.");
                end;

                trigger OnAfterGetRecord()
                var
                    Security: Record "Loan Security";
                    MemberActivities: Codeunit "Member Activities";
                    Legacy: Codeunit Legacy;
                    cust: record Customer;
                    LoansRec: Record Loans;

                begin
                    Security.Reset();
                    Security.SetRange("Loan No.", Loans."Loan No.");
                    if Security.FindFirst() then Loansecurity := Security."Guarantor Type";

                    if Loans."Mobile Loan" then
                        Loansecurity := Loansecurity::Deposits;

                    Deposits := MemberActivities.GetAccountBalanceAsAt(Legacy.GetDepositAccounts("Member No."), EDate);

                    //ommit completed loans
                    LoansRec.Reset();
                    LoansRec.SetRange("Member No.", customer."No.");
                    LoansRec.SetFilter("Outstanding Principal", '<%1', 0);
                    if LoansRec.FindFirst() then
                        IF LoansRec."Loan Product Type" = '' then CurrReport.skip;
                    SeNo += 1;
                end;

            }
            dataitem(Loans2; Loans)
            {
                DataItemLinkReference = customer;
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = sorting("Loan No.") where(Posted = filter(true), "Outstanding Principal" = filter(> 0), "Loan Product Type" = filter(<> 'L24'));
                CalcFields = "Loans Category-SASRA";


                column(Loan_Product_Type_Name1; "Loan Product Type Name") { }
                column(Requested_Amount1; "Requested Amount") { }
                column(Approved_Amount1; "Approved Amount") { }
                column(Disbursement_Date1; "Disbursement Date") { }
                column(Repayment_Start_Date1; "Repayment Start Date") { }
                column(Installments1; Installments) { }
                column(Loans_Category_SASRA1; "Loans Category-SASRA") { }
                column(Outstanding_Principal1; "Outstanding Principal") { }
                column(SNo; SNo) { }
                column(Loansecurity1; Loansecurity1) { }

                trigger OnPreDataItem()
                begin
                    Loans2.SetFilter("Disbursement Date", '%1..%2', CalcDate('-999Y', SDate), CalcDate('-1D', SDate));
                    Loans2.SetFilter("Date Filter", '..%1', EDate);
                    Loans2.SetFilter("Member No.", customer."No.");
                end;

                trigger OnAfterGetRecord()
                var
                    Security: Record "Loan Security";
                    MemberActivities: Codeunit "Member Activities";
                    Legacy: Codeunit Legacy;

                begin
                    Security.Reset();
                    Security.SetRange("Loan No.", Loans."Loan No.");
                    if Security.FindFirst() then
                        Loansecurity1 := Security."Guarantor Type";

                    if Loans2."Mobile Loan" then
                        Loansecurity1 := Loansecurity1::Deposits;

                    Deposits := MemberActivities.GetAccountBalanceAsAt(Legacy.GetDepositAccounts("Member No."), EDate);
                    SNo += 1;
                end;

            }
            trigger OnAfterGetRecord()
            var
                MLoans: Record Loans;
            begin
                MLoans.Reset();
                MLoans.SetRange("Member No.", customer."No.");
                MLoans.SetRange(Posted, true);
                if not MLoans.FindFirst() then
                    CurrReport.skip;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("Start Date"; SDate)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; EDate)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
#pragma warning disable AL0432
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432
        CompanyName := CompanyInformation.Name;
    end;



    var
        Loansecurity: Option Guarantor,Collateral,Lien,Deposits;
        Loansecurity1: Option Guarantor,Collateral,Lien,Deposits;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CompanyName: Text;
        SDate: Date;
        EDate: Date;
        Deposits: Decimal;
        SNo: Integer;
        SENo: Integer;
}
