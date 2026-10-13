namespace UnitedWomen_Production.UnitedWomen_Production;
using Microsoft.Foundation.Company;

report 50499 "Checkoff Report"
{
    ApplicationArea = All;
    Caption = 'Checkoff Report';
    UsageCategory = History;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Checkoff Report.rdlc';

    dataset
    {
        dataitem(MHeader; "Monthly Checkoff Header")
        {
            RequestFilterFields = "No.";
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(VATRegistrationNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(EMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
#pragma warning disable AL0432
            column(HomePage; CompanyInfo."Home Page")
#pragma warning restore AL0432
            {
            }
            column(No_; "No.")
            {
            }
            column(Date_Entered; "Date Entered")
            {
            }
            column(Entered_By; "Entered By")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Account_Type; "Account Type")
            {
            }
            column(Account_No_; "Account No.")
            {
            }
            column(Account_Name; "Account Name")
            {
            }
            column(Description; Description)
            {
            }
            column(Checkoff_Type; "Checkoff Type")
            {
            }
            column(Status; Status)
            {
            }
            column(Activity_Code; "Global Dimension 1 Code")
            {
            }
            dataitem("MCLines"; "Monthly Checkoff Buffer")
            {
                DataItemTableView = sorting(No);
                DataItemLinkReference = MHeader;
                DataItemLink = "Checkoff No" = field("No.");
                column(No; No)
                {
                }
                column(ChkMember_No_; "Member No.")
                {
                }
                column(Name; Name)
                {
                }
                column(Payroll; Payroll)
                {
                }
                column(Account_No; "Account No")
                {
                }
                column(Amount; Amount)
                {
                }
                column(Reporting_Name; "Reporting Name")
                {
                }
            }
            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ProductFactory: Record "Product Setup";
        Loans: Record Loans;
        Cust: Record Members;
        ClolumHeader: Code[10];
        ColumnValue: Decimal;
        MemberNo: Code[10];
        PayrollNo: Code[10];
        Name: Text;
        Interest: Decimal;
        ExpAmt: Decimal;
        Turn: Integer;
        CulumnA: array[50] of Code[10];
        CompanyInfo: Record "Company Information";
        i: Integer;
        EDcode: Code[10];
        SaccoCode: Code[10];
        NarationCode: Text;
        IntCode: Integer;
        ActionCode: Code[10];
        TransCode: Integer;
        ChAdvice: Record "Monthly Advice";
        ChkAmt: Decimal;
        AccBalance: Decimal;
        HeaderNo: Code[20];
        Variance: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        SDate: Date;
        EDate: Date;
        AdvDate: Date;
}
