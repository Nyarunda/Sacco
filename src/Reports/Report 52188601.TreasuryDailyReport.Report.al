Report 50264 "Treasury Daily Report"
{
    // 
    // 
    // SavingsAccounts.RESET;
    // SavingsAccounts.SETRANGE("Member No.","No.");
    // SavingsAccounts.SETRANGE("Product Category",SavingsAccounts."Product Category"::" ");
    // SavingsAccounts.SETFILTER(Blocked,'<>%1',SavingsAccounts.Blocked::" ");
    // SavingsAccounts.SETFILTER("Balance (LCY)",'>0');
    // IF SavingsAccounts.FINDFIRST THEN BEGIN
    //     REPEAT
    //         SavingsAccounts."Blocked 2":=SavingsAccounts."Blocked 2"::" ";
    //         IF SavingsAccounts.Blocked<>SavingsAccounts.Blocked::" " THEN BEGIN
    //             SavingsAccounts."Blocked 2" := SavingsAccounts.Blocked;
    //             SavingsAccounts.Blocked := SavingsAccounts.Blocked::" ";
    //             SavingsAccounts.MODIFY;
    //         END;
    // 
    // 
    //         IF SavingsAccounts."Blocked 2"<>SavingsAccounts."Blocked 2"::" " THEN BEGIN
    //             SavingsAccounts.Blocked := SavingsAccounts."Blocked 2";
    //             SavingsAccounts."Blocked 2" := SavingsAccounts."Blocked 2"::" ";
    //             SavingsAccounts.MODIFY;
    //         END;
    // 
    //     UNTIL SavingsAccounts.NEXT=0;
    // END;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Treasury Daily Report.rdlc';


    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = where("Global Dimension No." = const(2));
            column(ReportForNavId_1; 1)
            {
            }
            column(Code_DimensionValue; "Dimension Value".Code)
            {
            }
            column(Name_DimensionValue; "Dimension Value".Name)
            {
            }
            column(Treasury; Treasury)
            {
            }
            column(Cashier; Cashier)
            {
            }
            column(TreasuryCashier; TreasuryCashier)
            {
            }
            column(MPESACust; MPESACust)
            {
            }
            column(ATM1; ATM1)
            {
            }
            column(ATM2; ATM2)
            {
            }
            column(MYetu; MYetu)
            {
            }
            column(MPESAAdmin; MPESAAdmin)
            {
            }
            column(MpesaPlaza; MpesaPlaza)
            {
            }
            column(MpesaPhysical; MpesaPhysical)
            {
            }
            column(CoopCust; CoopCust)
            {
            }
            column(Date; Format(Date))
            {
            }
            column(Time; Time)
            {
            }
            column(Today; Today)
            {
            }
            column(Petty; Petty)
            {
            }

            trigger OnAfterGetRecord()
            var
                NoOfProgressed: Integer;
            begin

                Treasury := 0;
                BankAcc.Reset;
                BankAcc.SetRange("Global Dimension 2 Code", "Dimension Value".Code);
                BankAcc.SetRange("Bank Type", BankAcc."bank type"::Treasury);
                BankAcc.SetRange("Date Filter", 0D, Date);
                if BankAcc.Find('-') then begin
                    repeat
                        BankAcc.CalcFields("Net Change (LCY)");
                        Treasury += BankAcc."Net Change (LCY)";
                    until BankAcc.Next = 0;
                end;


                Cashier := 0;
                BankAcc.Reset;
                BankAcc.SetRange("Global Dimension 2 Code", "Dimension Value".Code);
                BankAcc.SetRange("Bank Type", BankAcc."bank type"::Cashier);
                BankAcc.SetRange("Date Filter", 0D, Date);
                BankAcc.SetFilter("No.", '<>500');
                if BankAcc.Find('-') then begin
                    repeat
                        BankAcc.CalcFields("Net Change (LCY)");
                        Cashier += BankAcc."Net Change (LCY)";
                    until BankAcc.Next = 0;
                end;

                TreasuryCashier := Treasury + Cashier;

                Petty := 0;
                BankAcc.Reset;
                BankAcc.SetRange("Global Dimension 2 Code", "Dimension Value".Code);
                BankAcc.SetRange("Bank Type", BankAcc."bank type"::Cash);
                BankAcc.SetRange("Date Filter", 0D, Date);
                if BankAcc.Find('-') then begin
                    repeat
                        BankAcc.CalcFields("Net Change (LCY)");
                        Petty += BankAcc."Net Change (LCY)";
                    until BankAcc.Next = 0;
                end;


                MPESACust := 0;
                Cust.Reset;
                Cust.SetRange("Global Dimension 2 Code", "Dimension Value".Code);
                Cust.SetRange("Account Type", Cust."account type"::"MPESA");
                Cust.SetRange("Date Filter", 0D, Date);
                if Cust.Find('-') then begin
                    repeat
                        Cust.CalcFields("Net Change (LCY)");
                        MPESACust += Cust."Net Change (LCY)";
                    until Cust.Next = 0;
                end;

                /*
                CoopCust:=0;
                Cust.RESET;
                Cust.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                Cust.SETRANGE("Account Type",Cust."Account Type"::"Coop Agency");
                Cust.SETRANGE("Date Filter",0D,Date);
                IF Cust.FIND('-') THEN BEGIN
                    REPEAT
                        Cust.CALCFIELDS("Net Change (LCY)");
                        CoopCust+=Cust."Net Change (LCY)";
                    UNTIL Cust.NEXT=0;
                END;
                
                
                MpesaPlaza:=0;
                Cust.RESET;
                //Cust.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                Cust.SETRANGE("Account Type",Cust."Account Type"::"Mpesa Plaza");
                Cust.SETRANGE("Date Filter",0D,Date);
                IF Cust.FIND('-') THEN BEGIN
                    REPEAT
                        Cust.CALCFIELDS("Net Change (LCY)");
                        MpesaPlaza+=Cust."Net Change (LCY)";
                    UNTIL Cust.NEXT=0;
                END;
                */


                ATM2 := 0;
                BankAcc.Reset;
                BankAcc.SetRange("Bank Type", BankAcc."bank type"::ATM);
                BankAcc.SetRange("Global Dimension 2 Code", "Dimension Value".Code);
                BankAcc.SetRange("Date Filter", 0D, Date);
                if BankAcc.Find('-') then begin
                    repeat

                        BankAcc.CalcFields("Net Change (LCY)");
                        ATM2 += BankAcc."Net Change (LCY)";
                    until BankAcc.Next = 0;
                end;

            end;

            trigger OnPostDataItem()
            var
                Txt0001: label 'Auto Recovery Successful';
            begin
            end;

            trigger OnPreDataItem()
            begin


                MpesaPhysical := 0;
                BankAcc.Reset;
                BankAcc.SetRange("No.", '500');
                BankAcc.SetRange("Date Filter", 0D, Date);
                if BankAcc.Find('-') then begin
                    BankAcc.CalcFields("Net Change (LCY)");
                    MpesaPhysical := BankAcc."Net Change (LCY)";
                end;


                MYetu := 0;
                BankAcc.Reset;
                BankAcc.SetRange("No.", 'MYetu');
                BankAcc.SetRange("Date Filter", 0D, Date);
                if BankAcc.Find('-') then begin
                    repeat
                        BankAcc.CalcFields("Balance (LCY)");
                        MYetu += BankAcc."Balance (LCY)";
                    until BankAcc.Next = 0;
                end;


                MPESAAdmin := 0;
                GLAcc.Reset;
                GLAcc.SetRange("No.", '801210');
                GLAcc.SetRange("Date Filter", 0D, Date);
                if GLAcc.Find('-') then begin
                    repeat
                        GLAcc.CalcFields("Net Change");
                        MPESAAdmin += GLAcc."Net Change";
                    until GLAcc.Next = 0;
                end;
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
        dWindow: Dialog;
        intProgressTotal: Integer;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        SaccoTrans: Codeunit "Sacco Activities";
        Jtemplate: Code[10];
        JBatch: Code[10];
        Loans: Record Loans;
        Defaulters: Boolean;
        JTransfer: Boolean;
        SavingsAccounts: Record "Savings Accounts";
        Treasury: Decimal;
        Cashier: Decimal;
        MPESACust: Decimal;
        ATM1: Decimal;
        MPESAAdmin: Decimal;
        Date: Date;
        BankAcc: Record "Bank Account";
        TreasuryCashier: Decimal;
        Cust: Record Customer;
        MpesaPlaza: Decimal;
        ATM2: Decimal;
        MYetu: Decimal;
        GLAcc: Record "G/L Account";
        MpesaPhysical: Decimal;
        CoopCust: Decimal;
        Petty: Decimal;
}

