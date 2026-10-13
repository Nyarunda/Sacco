/// <summary>
/// Report Payroll Summary Detailed (ID 51532187).
/// </summary>
report 50377 "Payroll Summary Detailed"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/Layouts/Payroll Summary Detailed.rdl';

    dataset
    {
        dataitem("HR Employees"; Employee)
        {
            column(No_HREmployee; "HR Employees"."No.")
            {
            }
            column(FirstName_HREmployee; "HR Employees"."First Name")
            {
            }
            column(MiddleName_HREmployee; "HR Employees"."Middle Name")
            {
            }
            column(LastName_HREmployee; "HR Employees"."Last Name")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(LocationDivisionCode_HREmployee; "HR Employees".Location)
            {
            }
            column(DepartmentCode_HREmployee; "HR Employees".Department)
            {
            }
            column(Office_HREmployee; "HR Employees"."Location County")
            {
            }
            column(CostCenterCode_HREmployee; "HR Employees"."Cost Center Code")
            {
            }
            column(JobTitle_HREmployee; "HR Employees"."Job Title")
            {
            }
            dataitem("PR Period Transactions"; "Payroll Period Transactions")
            {
                DataItemLink = "Employee Code" = FIELD("No."),
                               "Payroll Period" = FIELD("Period Filter");
                column(TransactionCode_prPeriodTransactions; "PR Period Transactions"."Transaction Code")
                {
                }
                column(GroupText_prPeriodTransactions; "PR Period Transactions"."Transaction Code")
                {
                }
                column(TransactionName_prPeriodTransactions; "PR Period Transactions"."Transaction Name")
                {
                }
                column(Amount_prPeriodTransactions; "PR Period Transactions".Amount)
                {
                }
                column(Balance_prPeriodTransactions; "PR Period Transactions".Balance)
                {
                }
                // column(OriginalAmount_prPeriodTransactions; "PR Period Transactions".ori)
                // {
                // }

                trigger OnAfterGetRecord();
                begin
                    //ERROR('%1 vs %2 vs %3',"prPeriod Transactions"."Employee Code","prPeriod Transactions"."Transaction Code","prPeriod Transactions"."Payroll Period");
                end;
            }

            trigger OnPreDataItem();
            begin
                SETFILTER("Period Filter", FORMAT("Current Period Filter"));
                IF "HR Employees".GETFILTER("HR Employees"."Period Filter") = '' THEN
                    ERROR('You must specify current Period filter.');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Current Period Filter"; "Current Period Filter")
                {
                    ApplicationArea = All;
                    Caption = 'Period Filter';
                    TableRelation = "Payroll Periods";
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        //clear("HR-Employee"."Current Month Filter");
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        "Current Period Filter": Date;
}

