namespace CentralDB.CentralDB;
using Microsoft.Foundation.Company;

report 50423 "Member GFE Contribution"
{
    ApplicationArea = All;
    Caption = 'Member GFE Contribution';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Member GFE Contribution.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Registration Date", Status, "Employer Code", "Self Employed", "Other Group Type";
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(DateofBirth; "Date of Birth")
            {
            }
            column(MobilePhoneNo; "Mobile Phone No.")
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
            column(Web; Web)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(PeriodFilter; PeriodFilter)
            {
            }
            dataitem("Member Statements"; "Statement Buffer New")
            {
                DataItemLink = "Member No" = FIELD("No.");
                DataItemTableView = SORTING("Member No", Date);
                column(MonthlyShares; MonthlyShares)
                {
                }
                column(Date_MemberStatements; DatePeriod)
                {
                }
                column(Debit_Amount; "Debit Amount")
                {
                }
                column(Credit_Amount; "Credit Amount")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DatePeriod := (FORMAT("Member Statements".Date, 0, '<Month Text,3>  <Year4> '));
                end;
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                DepAmt: Decimal;
            begin
                StartDate := 0D;
                StartDate := GlobalStartDate;

                IF StartDate = 0D THEN BEGIN
                    StartDate := CALCDATE('-11M -CM', TODAY);
                    EndDate := CALCDATE('CM', StartDate);
                END;

                DivProg.RESET;
                DivProg.SETRANGE(DivProg."Member No", Members."No.");
                IF DivProg.FIND('-') THEN
                    DivProg.DELETEALL;

                FOR i := 1 TO Months DO BEGIN

                    FromDate := CALCDATE('-CM', StartDate);
                    ToDate := CALCDATE('CM', StartDate);

                    EVALUATE(FromDateS, FORMAT(FromDate));
                    EVALUATE(ToDateS, FORMAT(ToDate));
                    DateFilter := FromDateS + '..' + ToDateS;

                    DivProg.INIT;
                    DivProg."Member No" := Members."No.";
                    DivProg.Date := ToDate;
                    DivProg."DepContrib." := DepAmt;

                    SAccount.RESET;
                    SAccount.SetRange(SAccount."Member No.", Members."No.");
                    SAccount.SetFilter(SAccount."Date Filter", DateFilter);
                    SAccount.SetRange(SAccount."Product Category", SAccount."Product Category"::"Benevolent Fund");
                    IF SAccount.FIND('-') THEN BEGIN
                        SAccount.CALCFIELDS("Balance (LCY)", "Credit Amount", "Debit Amount");
                        DivProg.DepOpeingBal := SAccount."Balance (LCY)";
                        DivProg."Debit Amount" := SAccount."Debit Amount";
                        DivProg."Credit Amount" := SAccount."Credit Amount";
                    END;


                    DivProg.INSERT;

                    StartDate := CALCDATE('1M', StartDate);
                end;
            end;

            trigger OnPreDataItem()
            begin

                IF Months = 0 THEN
                    Months := 12;
            end;
        }
    }
    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date::"; GlobalStartDate)
                {
                    ApplicationArea = All;
                }
                field("Months::"; Months)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }
    labels
    {
        DateFilter = 'Date Filter :';
        Period = 'Period';
    }
    trigger OnPreReport()
    begin
        IF CompanyInformation.GET THEN
            CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' - ' + CompanyInformation."Post Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No.";//+' ; '+CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail";
#pragma warning disable AL0432
        Web := 'Member Portal: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432
    end;



    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        PeriodFilter: Text;
        GlobalStartDate: Date;
        StartDate: Date;
        EndDate: Date;
        DateFilter: Text[100];
        FromDate: Date;
        ToDate: Date;
        FromDateS: Text[100];
        ToDateS: Text[100];
        i: Integer;
        Months: Integer;
        Web: Text[100];
        DivProg: Record "Statement Buffer New";
        SAccount: Record "Savings Accounts";
}
