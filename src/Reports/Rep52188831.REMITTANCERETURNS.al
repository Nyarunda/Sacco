report 50533 "Monthly Remittance Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Monthly Remittance Report';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Monthly Remittance Report.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = where(Number = const(1));
            column(RefTextLbl; StrSubstNo('REF: WA/CS2700/MINISTRY OF COOP %1/%2', GetMonth(), GetYear())) { }
            column(RecipientLine1Lbl; 'The District Co-operative Officer,') { }
            column(RecipientLine2Lbl; 'Embakasi District,') { }
            column(RecipientLine3Lbl; StrSubstNo('P.O. Box %1', GetCompanyPostCode())) { }
            column(RecipientLine4Lbl; GetCompanyCity()) { }
            column(SalutationLbl; 'Dear Madam,') { }
            column(SubjectLineLbl; StrSubstNo('RE: %1 %2 REMITTANCE RETURNS, C/S 2700.', GetMonth(), GetYear())) { }
            column(ComplianceLbl; StrSubstNo('A)Companies which are current on deductions –  %1  %2', GetMonth(), GetYear())) { }
            column(ComplianceNoteLbl; 'Forwarded herewith are monthly checks off deductions in compliance with rule 31(b) of coop societies rules 2004') { }
            column(ClosingNoteLbl; 'Kindly acknowledge.') { }
            column(SignatureLine1; 'Yours faithfully,') { }
            column(SignatureLine2; 'For Wanandege Cs and Cs Ltd.') { }
            column(SignatureLine3; 'JOANNE CHERUTO') { }
            column(SignatureLine4; 'CHIEF EXECUTIVE OFFICER') { }

        }
        dataitem("Monthly Checkoff Header"; "Monthly Checkoff Header")
        {
            DataItemTableView = where(Posted = const(false));
            column(Employer_Code; "Employer Code")
            {
            }
            column(Employer_Name; "Employer Name")
            {
            }
            column(Amount; Amount)
            {
            }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                "Monthly Checkoff Header".SetFilter("Reporting Period", '%1..%2', CalcDate('-CM', RequestDate), CalcDate('CM', RequestDate));
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(RequestDate; RequestDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        RequestDate: Date;

    procedure GetMonth(): Text[20]
    begin
        exit(Format(Date2DMY(RequestDate, 2)));
    end;

    procedure GetYear(): Text[4]
    begin
        exit(Format(Date2DMY(RequestDate, 3)));
    end;

    procedure GetCompanyPostCode(): Code[20]
    var
        CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.Get();
        exit(CompanyInfo."Post Code");
    end;

    procedure GetCompanyCity(): Text[50]
    var
        CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.Get();
        exit(CompanyInfo.City);
    end;
}