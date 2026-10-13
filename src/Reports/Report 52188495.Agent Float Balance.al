
Report 50158 "Agent Float Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Agent Float Balance.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(BUser; "Banking User Setup")
        {
            DataItemTableView = where(Type = const(Cashier));
            RequestFilterFields = "User Name";
            column(ReportForNavId_1; 1)
            {
            }
            column(UserID_MpesaUserSetup; "User Name")
            {
            }
            column(MpesaFloatAccount_MpesaUserSetup; "MPesa Customer Account")
            {
            }
            column(AgentTillAccount_MpesaUserSetup; "MPesa Bank Account")
            {
            }
            column(FloatBalance; FloatBalance)
            {
            }
            column(TillBalance; TillBalance)
            {
            }
            column(Date; Date)
            {
            }
            column(TellerTotal; TellerTotal)
            {
            }
            column(EquityBankAccount_BUser; BUser."Equity Bank Account")
            {
            }
            column(EquityCustomerAccount_BUser; BUser."Equity Customer Account")
            {
            }
            column(EqFloatBalance; EqFloatBalance)
            {
            }
            column(EqTillBalance; EqTillBalance)
            {
            }
            column(EqTellerTotal; EqTellerTotal)
            {
            }

            trigger OnAfterGetRecord()
            begin
                FloatBalance := 0;
                TillBalance := 0;
                TellerTotal := 0;

                EqFloatBalance := 0;
                EqTillBalance := 0;
                EqTellerTotal := 0;


                Customer.Reset;
                Customer.SetRange("No.", BUser."MPesa Customer Account");
                Customer.SetFilter("Date Filter", '..%1', Date);
                if Customer.FindFirst then begin
                    Customer.CalcFields("Net Change (LCY)");
                    FloatBalance := Customer."Net Change (LCY)";
                end;

                BankAccount.Reset;
                BankAccount.SetRange("No.", BUser."MPesa Bank Account");
                if BankAccount.FindFirst then begin
                    BankAccount.CalcFields("Net Change (LCY)");
                    TillBalance := BankAccount."Net Change (LCY)";
                end;

                TellerTotal := TillBalance + FloatBalance;




                Customer.Reset;
                Customer.SetRange("No.", BUser."Equity Customer Account");
                Customer.SetFilter("Date Filter", '..%1', Date);
                if Customer.FindFirst then begin
                    Customer.CalcFields("Net Change (LCY)");
                    EqFloatBalance := Customer."Net Change (LCY)";
                end;

                BankAccount.Reset;
                BankAccount.SetRange("No.", BUser."Equity Bank Account");
                if BankAccount.FindFirst then begin
                    BankAccount.CalcFields("Net Change (LCY)");
                    EqTillBalance := BankAccount."Net Change (LCY)";
                end;

                EqTellerTotal := EqTillBalance + EqFloatBalance;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Date; Date)
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
        FloatBalance: Decimal;
        TillBalance: Decimal;
        Customer: Record Customer;
        BankAccount: Record "Bank Account";
        Date: Date;
        TellerTotal: Decimal;
        EqFloatBalance: Decimal;
        EqTillBalance: Decimal;
        EqTellerTotal: Decimal;
}

