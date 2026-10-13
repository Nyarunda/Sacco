namespace UnitedWomen.UnitedWomen;
using Microsoft.Foundation.Company;

report 50577 "Loans Restructured Report"
{

    Caption = 'Loans Restructured Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/LoansRestructuredReport.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = sorting("Loan No.") where(Posted = const(true));

            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyPicture; CompanyInfo.Picture) { }
            column(ReportTitle; 'LOANS RESTRUCTURED REPORT') { }
            column(AsAtDateValue; AsAtDate) { }
            column(MembershipNumber; "Member No.") { }
            column(MemberIDNumber; MemberIDNo) { }
            column(MemberName; MemberName) { }
            column(LoanGranted; "Approved Amount") { }
            column(DateLoanGranted; "Disbursement Date") { }
            column(InitialRepaymentPeriod; "Installments") { }
            column(DateOfRestructure; "Date Rescheduled") { }
            column(OutstandingLoanBalance; OutstandingBalance) { }
            column(OutstandingLoanPeriod; "SASRA Months Arrears") { }
            column(RevisedLoanPeriod; RevisedPeriod) { }
            column(NewLoanEndDate; "Completion Date") { }

            trigger OnPreDataItem()
            begin
                SetRange("Date Filter", 0D, AsAtDate);

                // Only restructured loans
                SetRange("Loan Restructured", true);
            end;

            trigger OnAfterGetRecord()
            begin
                CalcFields("Outstanding Principal");

                OutstandingBalance := "Outstanding Principal";

                if OutstandingBalance <= 0 then
                    CurrReport.Skip();

                // Get member details
                if Members.Get("Member No.") then begin
                    MemberName := Members.Name;
                    MemberIDNo := Members."ID No.";
                end;

                // Revised period logic
                RevisedPeriod := "Installments";

                // Logging
                /*  Session.LogMessage(
                     'RESTRUCTURED_LOAN',
                     StrSubstNo('Processed Loan %1 for Member %2', "Loan No.", MemberName),
                     Verbosity::Normal,
                     DataClassification::SystemMetadata
                 ); */
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field(AsAtDate; AsAtDate)
                    {
                        ApplicationArea = All;
                        Caption = 'As At Date';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if AsAtDate = 0D then
            AsAtDate := Today;

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Members: Record Members;

        AsAtDate: Date;

        MemberName: Text[100];
        MemberIDNo: Code[20];
        OutstandingBalance: Decimal;
        RevisedPeriod: Integer;
}