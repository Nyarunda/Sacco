
Report 50261 "Fixed Deposit Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Fixed Deposit Register.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("Fixed Deposit Accounts"; "Fixed Deposit Accounts")
        {
            DataItemTableView = where("FD Status" = filter(Active | Matured | Closed));
            RequestFilterFields = "Global Dimension 2 Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(No_; "No.")
            {
            }
            column(MemberNo_FixedDepositAccounts; "Fixed Deposit Accounts"."Member No.")
            {
            }
            column(MemberName_FixedDepositAccounts; "Fixed Deposit Accounts".Name)
            {
            }
            column(FixedAccountNo_FixedDepositAccounts; "Fixed Deposit Accounts"."Fixed Account No.")
            {
            }
            column(Period_FixedDepositAccounts; "Fixed Deposit Accounts"."FD Duration")
            {
            }
            column(InterestRate_FixedDepositAccounts; "Fixed Deposit Accounts"."FD Annual Interest %")
            {
            }
            column(FDStartDate_FixedDepositAccounts; "Fixed Deposit Accounts"."FD Start Date")
            {
            }
            column(FDMaturityDate_FixedDepositAccounts; "Fixed Deposit Accounts"."FD Maturity Date")
            {
            }
            column(FDAmount_FixedDepositAccounts; "Fixed Deposit Accounts"."FD Amount")
            {
            }
            column(TotalExpectedInterest_FixedDepositAccounts; "Fixed Deposit Accounts"."Total Expected Interest")
            {
            }
            column(GlobalDimension2Code_FixedDepositAccounts; "Fixed Deposit Accounts"."Global Dimension 2 Code")
            {
            }
            column(Name_FixedDepositAccounts; "Fixed Deposit Accounts".Name)
            {
            }
            column(KRAPIN_FixedDepositAccounts; MemberKRAPIN)
            {
            }
            column(StartDate; SDate)
            {
            }
            column(EndDate; EDate)
            {
            }
            column(Rno; Rno)
            {
            }

            trigger OnAfterGetRecord()
            var
                Member: Record Members;
            begin
                MemberKRAPIN := '';
                if Member.Get("Fixed Deposit Accounts"."Member No.") then
                    MemberKRAPIN := Member."KRA PIN";

                if "Fixed Deposit Accounts"."FD Start Date" < SDate then CurrReport.Skip;
                if "Fixed Deposit Accounts"."FD Start Date" > EDate then CurrReport.Skip;

                Rno += 1;
            end;

            trigger OnPreDataItem()
            begin
                Rno := 0;
                if EDate = 0D then EDate := Today;
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
        }
    }

    labels
    {
    }

    var
        SDate: Date;
        EDate: Date;
        Rno: Integer;
        MemberKRAPIN: Code[20];
}
