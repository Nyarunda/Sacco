report 50683 "Vendor Account Statement"
{
    ApplicationArea = All;
    Caption = 'Vendor Account Statement';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Vendor Account Statement.rdlc';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.", "Date Filter";

            column(CompanyName; CompanyInformation.Name) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyContacts; CompanyContacts) { }
            column(CompanyPicture; CompanyInformation.Picture) { }
            column(ReportTitle; 'Vendor Account Statement') { }
            column(AmountsCaption; 'All amounts are in LCY') { }
            column(PrintUserId; UserId) { }
            column(FilterText; FilterText) { }
            column(VendorNo; "No.") { }
            column(VendorName; Name) { }
            column(VendorAddress; VendorAddress) { }
            column(OpeningBalance; OpeningBalance) { }
            column(StatementStartDate; StatementStartDate) { }
            column(StatementEndDate; StatementEndDate) { }

            dataitem(VendorLedgerEntry; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = field("No.");
                DataItemTableView = sorting("Vendor No.", "Posting Date", "Currency Code") order(Ascending);

                column(PostingDate; "Posting Date") { }
                column(DocumentNo; "Document No.") { }
                column(ExternalDocumentNo; "External Document No.") { }
                column(Description; Description) { }
                column(DebitAmount; DebitAmount) { }
                column(CreditAmount; CreditAmount) { }
                column(RunningBalance; RunningBalance) { }
                column(EntryNo; "Entry No.") { }

                trigger OnAfterGetRecord()
                begin
                    CalcFields(Amount);

                    DebitAmount := 0;
                    CreditAmount := 0;
                    if Amount > 0 then
                        DebitAmount := Amount
                    else
                        CreditAmount := Abs(Amount);

                    RunningBalance += DebitAmount - CreditAmount;
                end;

                trigger OnPreDataItem()
                begin
                    if Vendor.GetFilter("Date Filter") <> '' then
                        SetFilter("Posting Date", Vendor.GetFilter("Date Filter"));

                    RunningBalance := OpeningBalance;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SetStatementDates();
                BuildVendorHeader();
                OpeningBalance := GetOpeningBalance("No.", StatementStartDate);
            end;

            trigger OnPreDataItem()
            begin
                FilterText := GetFilters();
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);

        CompanyAddress := CompanyInformation.Address;
        if CompanyInformation."Address 2" <> '' then
            CompanyAddress += ', ' + CompanyInformation."Address 2";
        if CompanyInformation.City <> '' then
            CompanyAddress += ', ' + CompanyInformation.City;

        CompanyContacts := '';
        if CompanyInformation."Phone No." <> '' then
            CompanyContacts := 'Tel: ' + CompanyInformation."Phone No.";
        if CompanyInformation."E-Mail" <> '' then begin
            if CompanyContacts <> '' then
                CompanyContacts += ' | ';
            CompanyContacts += 'Email: ' + CompanyInformation."E-Mail";
        end;
    end;

    local procedure BuildVendorHeader()
    begin
        VendorAddress := Vendor.Address;
        if Vendor."Address 2" <> '' then
            VendorAddress += ', ' + Vendor."Address 2";
        if Vendor.City <> '' then
            VendorAddress += ', ' + Vendor.City;
    end;

    local procedure SetStatementDates()
    begin
        StatementStartDate := 0D;
        StatementEndDate := 0D;

        if Vendor.GetFilter("Date Filter") = '' then
            exit;

        StatementStartDate := Vendor.GetRangeMin("Date Filter");
        StatementEndDate := Vendor.GetRangeMax("Date Filter");
    end;

    local procedure GetOpeningBalance(VendorNo: Code[20]; StartDate: Date): Decimal
    var
        VendorLedgerEntry2: Record "Vendor Ledger Entry";
        OpeningAmount: Decimal;
    begin
        if StartDate = 0D then
            exit(0);

        VendorLedgerEntry2.Reset();
        VendorLedgerEntry2.SetRange("Vendor No.", VendorNo);
        VendorLedgerEntry2.SetFilter("Posting Date", '..%1', CalcDate('<-1D>', StartDate));
        if VendorLedgerEntry2.FindSet() then
            repeat
                VendorLedgerEntry2.CalcFields(Amount);
                OpeningAmount += VendorLedgerEntry2.Amount;
            until VendorLedgerEntry2.Next() = 0;

        exit(OpeningAmount);
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text[250];
        CompanyContacts: Text[250];
        VendorAddress: Text[250];
        FilterText: Text[250];
        StatementStartDate: Date;
        StatementEndDate: Date;
        OpeningBalance: Decimal;
        RunningBalance: Decimal;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
}
