report 50024 "Savings Progression Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Savings Progression Report.rdlc';

    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;
            column(M1; M1)
            {
            }
            column(M2; M2)
            {
            }
            column(M3; M3)
            {
            }
            column(M4; M4)
            {
            }
            column(M5; M5)
            {
            }
            column(M6; M6)
            {
            }
            column(M7; M7)
            {
            }
            column(M8; M8)
            {
            }
            column(M9; M9)
            {
            }
            column(M10; M10)
            {
            }
            column(M11; M11)
            {
            }
            column(M12; M12)
            {
            }

            trigger OnPreDataItem()
            begin
                IF StartDate = 0D THEN
                    ERROR('Please enter the start date');

                Month := DATE2DMY(StartDate, 2);
                Year := DATE2DMY(StartDate, 3);


                Counter := 1;
                REPEAT

                    IF Counter = 1 THEN
                        M1 := GetMonth(Month) + '-' + FORMAT(Year);
                    IF Counter = 2 THEN
                        M2 := GetMonth(Month) + '-' + FORMAT(Year);
                    IF Counter = 3 THEN
                        M3 := GetMonth(Month) + '-' + FORMAT(Year);
                    IF Counter = 4 THEN
                        M4 := GetMonth(Month) + '-' + FORMAT(Year);
                    IF Counter = 5 THEN
                        M5 := GetMonth(Month) + '-' + FORMAT(Year);
                    IF Counter = 6 THEN
                        M6 := GetMonth(Month) + '-' + FORMAT(Year);
                    IF Counter = 7 THEN
                        M7 := GetMonth(Month) + '-' + FORMAT(Year);
                    IF Counter = 8 THEN
                        M8 := GetMonth(Month) + '-' + FORMAT(Year);
                    IF Counter = 9 THEN
                        M9 := GetMonth(Month) + '-' + FORMAT(Year);
                    IF Counter = 10 THEN
                        M10 := GetMonth(Month) + '-' + FORMAT(Year);
                    IF Counter = 11 THEN
                        M11 := GetMonth(Month) + '-' + FORMAT(Year);
                    IF Counter = 12 THEN
                        M12 := GetMonth(Month) + '-' + FORMAT(Year);

                    Month += 1;


                    IF Month = 13 THEN BEGIN
                        Month := 1;
                        Year += 1;
                    END;

                    Counter += 1;

                UNTIL Counter = 13;
            end;
        }
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            DataItemTableView = WHERE("Product Category" = FILTER(<> "Registration Fee"), "Balance (LCY)" = FILTER(<> 0));
            RequestFilterFields = "Product Type", "No.";
            column(No_SavingsAccounts; SavingsAccounts."No.")
            {
            }
            column(Name_SavingsAccounts; SavingsAccounts.Name)
            {
            }
            column(Balance_SavingsAccounts; SavingsAccounts.Balance)
            {
            }
            column(ProductType_SavingsAccounts; SavingsAccounts."Product Type")
            {
            }
            column(MemberNo_SavingsAccounts; SavingsAccounts."Member No.")
            {
            }
            column(ProductName_SavingsAccounts; SavingsAccounts."Product Name")
            {
            }
            column(compname; COMPANYNAME)
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
            dataitem(LedgerEntry; "Savings Ledger Entry")
            {
                DataItemLink = "Account No." = FIELD("No.");
                DataItemTableView = WHERE(Amount = FILTER(< 0));
                column(Amount_LedgerEntry; LedgerEntry.Amount)
                {
                }
                column(v1; v1)
                {
                }
                column(v2; v2)
                {
                }
                column(v3; v3)
                {
                }
                column(v4; v4)
                {
                }
                column(v5; v5)
                {
                }
                column(v6; v6)
                {
                }
                column(V7; V7)
                {
                }
                column(V8; V8)
                {
                }
                column(V9; V9)
                {
                }
                column(V10; V10)
                {
                }
                column(V11; V11)
                {
                }
                column(V12; V12)
                {
                }
                column(OpenBal; OpenBal)
                {
                }

                trigger OnAfterGetRecord()
                var
                    SavLedger: Record "Savings Ledger Entry";
                begin
                    LedgerEntry.RESET;
                    LedgerEntry.SETRANGE("Posting Date", StartDate, EndDate);
                    LedgerEntry.SETRANGE("Document No.", 'OPENBALACC');
                    IF LedgerEntry.FINDFIRST THEN LedgerEntry.CALCSUMS(Amount);
                    //OpenBal:= LedgerEntry.Amount;

                    v1 := 0;
                    v2 := 0;
                    v3 := 0;
                    v4 := 0;
                    v5 := 0;
                    v6 := 0;
                    V7 := 0;
                    V8 := 0;
                    V9 := 0;
                    V10 := 0;
                    V11 := 0;
                    V12 := 0;

                    CurrentDate := CALCDATE('1M', CurrentDate);
                    v1 := UpdateValue(CurrentDate, SavingsAccounts);

                    CurrentDate := CALCDATE('1M', CurrentDate);
                    v2 := UpdateValue(CurrentDate, SavingsAccounts);

                    CurrentDate := CALCDATE('1M', CurrentDate);
                    v3 := UpdateValue(CurrentDate, SavingsAccounts);

                    CurrentDate := CALCDATE('1M', CurrentDate);
                    v4 := UpdateValue(CurrentDate, SavingsAccounts);

                    CurrentDate := CALCDATE('1M', CurrentDate);
                    v5 := UpdateValue(CurrentDate, SavingsAccounts);

                    CurrentDate := CALCDATE('1M', CurrentDate);
                    v6 := UpdateValue(CurrentDate, SavingsAccounts);

                    CurrentDate := CALCDATE('1M', CurrentDate);
                    V7 := UpdateValue(CurrentDate, SavingsAccounts);

                    CurrentDate := CALCDATE('1M', CurrentDate);
                    V8 := UpdateValue(CurrentDate, SavingsAccounts);

                    CurrentDate := CALCDATE('1M', CurrentDate);
                    V9 := UpdateValue(CurrentDate, SavingsAccounts);

                    CurrentDate := CALCDATE('1M', CurrentDate);
                    V10 := UpdateValue(CurrentDate, SavingsAccounts);

                    CurrentDate := CALCDATE('1M', CurrentDate);
                    V11 := UpdateValue(CurrentDate, SavingsAccounts);

                    CurrentDate := CALCDATE('1M', CurrentDate);
                    V12 := UpdateValue(CurrentDate, SavingsAccounts);
                end;

                trigger OnPreDataItem()
                begin

                    CurrentDate := CALCDATE('-1M', StartDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SavLedger.RESET;
                SavLedger.SETRANGE("Account No.", SavingsAccounts."No.");
                SavLedger.SETFILTER(SavLedger."Posting Date", '..%1', StartDate);
                IF SavLedger.FIND('-') THEN
                    SavLedger.CALCSUMS(Amount);
                OpenBal := SavLedger.Amount * -1;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
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
    }

    trigger OnPreReport()
    begin
        IF CompanyInformation.GET THEN
            CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
#pragma warning disable AL0432
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432
    end;

    var
        StartDate: Date;
        EndDate: Date;
        M1: Text[30];
        M2: Text[30];
        M3: Text[30];
        M4: Text[30];
        M5: Text[30];
        M6: Text[30];
        M7: Text;
        M8: Text;
        M9: Text;
        M10: Text;
        M11: Text;
        M12: Text;
        OpenBal: Decimal;
        Month: Integer;
        Year: Integer;
        Counter: Integer;
        CurrentDate: Date;
        DateFilter: Text;
        v1: Decimal;
        v2: Decimal;
        v3: Decimal;
        v4: Decimal;
        v5: Decimal;
        v6: Decimal;
        V7: Decimal;
        V8: Decimal;
        V9: Decimal;
        V10: Decimal;
        V11: Decimal;
        V12: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SavLedger: Record "Savings Ledger Entry";

    procedure GetMonth(M: Integer): Text[30]
    begin

        CASE M OF
            1:
                EXIT('JAN');
            2:
                EXIT('FEB');
            3:
                EXIT('MARCH');
            4:
                EXIT('APRIL');
            5:
                EXIT('MAY');
            6:
                EXIT('JUNE');
            7:
                EXIT('JULY');
            8:
                EXIT('AUG');
            9:
                EXIT('SEPT');
            10:
                EXIT('OCT');
            11:
                EXIT('NOV');
            12:
                EXIT('DEC');
        END;
    end;

    procedure UpdateValue(var CheckDate: Date; var Account: Record "Savings Accounts"): Decimal
    var
        Value: Decimal;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
    begin
        Value := 0;
        DateFilter := FORMAT(CALCDATE('-CM', CheckDate)) + '..' + FORMAT(CALCDATE('CM', CheckDate));

        SavingsLedgerEntry.RESET;
        SavingsLedgerEntry.SETRANGE("Account No.", Account."No.");
        SavingsLedgerEntry.SETFILTER("Posting Date", DateFilter);
        IF SavingsLedgerEntry.FIND('-') THEN begin
            SavingsLedgerEntry.CalcSums(Amount);
            Value := ABS(SavingsLedgerEntry.Amount);
        end;

        EXIT(Value);
    end;

    procedure UpdateValueOpeningBal(var CheckDate: Date; var Account: Record "Savings Accounts"): Decimal
    var
        Value: Decimal;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
    begin
        Value := 0;
        DateFilter := '..' + FORMAT(CheckDate);

        SavingsLedgerEntry.RESET;
        SavingsLedgerEntry.SETRANGE("Account No.", Account."No.");
        SavingsLedgerEntry.SETFILTER("Posting Date", DateFilter);
        IF SavingsLedgerEntry.FIND('-') THEN Value := ABS(SavingsLedgerEntry.Amount);

        EXIT(Value);
    end;
}

