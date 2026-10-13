report 50362 "Loans Due Report"
{
    ApplicationArea = All;
    Caption = 'Loans Due Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans Due Today.rdl';
    dataset
    {
        dataitem(LoanRepaymentSchedule; "Loan Repayment Schedule")
        {
            DataItemTableView = where("Loan Balance" = filter('>0'));
            RequestFilterFields = "Loan No.";
            column(LoanNo; "Loan No.")
            {
            }

            column(LoanAmount; "Loan Amount")
            {
            }
            column(MonthlyRepayment; "Monthly Repayment")
            {
            }
            column(RepaymentDate; "Repayment Date")
            {
            }
            column(Loan_Balance; "Loan Balance") { }


            dataitem(Loans; Loans)
            {
                DataItemTableView = where("Total Outstanding Balance" = filter('>0'));
                DataItemLinkReference = LoanRepaymentSchedule;
                DataItemLink = "Loan No." = field("Loan No.");

                column(Last_Pay_Date; "Last Pay Date") { }
                column(Member_No_; "Member No.") { }
                column(Member_Name; "Member Name") { }
                column(Total_Outstanding_Balance; "Total Outstanding Balance") { }
                column(ExpAmt; ExpAmt) { }
                column(AmtPaid; AmtPaid) { }
                column(DefAmount; DefAmount) { }
                column(DaysInarrears; DaysInarrears) { }
                column(ArrearsDate; ArrearsDate) { }

                trigger OnAfterGetRecord()
                var
                    SC: Codeunit "Sacco Activities";
                    GracePeriod: DateFormula;

                begin
                    ExpAmt := 0;
                    AmtPaid := 0;
                    DefAmount := 0;
                    DaysInarrears := 0;
                    sc.GetDefaultedAmount(Loans."Loan No.", DueDate, ExpAmt, AmtPaid, DefAmount, DaysInarrears, ArrearsDate, true, GracePeriod);

                end;

            }
            trigger OnPreDataItem()
            begin
                if DueDate = 0D then Error(ErrorDate);
                LoanRepaymentSchedule.SetRange("Repayment Date", DueDate);
            end;

            trigger OnAfterGetRecord()
            begin
                if "Loan No." = '' then CurrReport.Skip();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field("Due Date"; DueDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Due Date';
                        ToolTip = 'Specifies the last date until which information in the report is shown.';
                        ShowMandatory = true;
                    }
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
    var
        DueDate: Date;
        ErrorDate: Label 'Loan Due Date Must have a value';
        ExpAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInarrears: Integer;
        ArrearsDate: Date;
}
