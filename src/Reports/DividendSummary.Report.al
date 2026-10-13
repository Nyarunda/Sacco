Report 50199 "Dividend Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Dividend Summary.rdl';

    dataset
    {
        dataitem(Customer; Members)//UnknownTable50305
        {
            DataItemTableView = sorting("No.") where(Type = filter(Member | Group));//used entry number in place of numberbecause it is the primary key in table Dividend Posting
            RequestFilterFields = Status;
            column(ReportForNavId_6836; 6836)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(Customer__No__; "No.")//used account number in place of number not sure if is account number or member number but account number appers in the table i vahe used
            {
            }
            column(Customer_Name; name)
            {
            }
            column(FirstYear; FirstYear)
            {
            }
            column(SecondYear; SecondYear)
            {
            }
            column(ThirdYear; ThirdYear)
            {
            }
            column(FourthYear; FourthYear)
            {
            }
            column(Total; TotalMember)
            {
            }
            column(FirstYearEarned; FirstYearEarned)
            {
            }
            column(SecondYearEarned; SecondYearEarned)
            {
            }
            column(ThirdYearEarned; ThirdYearEarned)
            {
            }
            column(FourthYearEarned; FourthYearEarned)
            {
            }

            trigger OnAfterGetRecord()
            begin


                DivPeriod.Reset;
                FirstYear := 0;
                SecondYear := 0;
                ThirdYear := 0;
                FourthYear := 0;

                FirstYearEarned := 0;
                SecondYearEarned := 0;
                ThirdYearEarned := 0;
                FourthYearEarned := 0;

                if DivPeriod.FindSet then begin
                    repeat

                        Evaluate(FromDate, Format(DivPeriod."Start Date"));
                        Evaluate(ToDate, Format(DivPeriod."End Date"));

                        DateFilter := FromDate + '..' + ToDate;
                        //Balance
                        memberLedgerEntries.Reset;
                        memberLedgerEntries.SetRange("Member No.", Customer."No.");
                        //memberLedgerEntries.SetRange(CurrentTransactionType, memberLedgerEntries."transaction type"::Dividend);
                        //memberLedgerEntries.SetFilter("Posting Date", DateFilter);
                        Dividend := 0;
                        memberLedgerEntries.CalcSums(Amount);
                        Dividend := memberLedgerEntries.Amount;

                        memberLedgerEntries.Reset;
                        memberLedgerEntries.SetRange("Member No.", Customer."No.");
                        //memberLedgerEntries.SetRange("Transaction Type", memberLedgerEntries."transaction type"::InterestOnDeposits);
                        //memberLedgerEntries.SetFilter("Posting Date", DateFilter);
                        InterestOnDeposit := 0;
                        memberLedgerEntries.CalcSums(Amount);
                        InterestOnDeposit := memberLedgerEntries.Amount;


                        if DivPeriod.Year = '2018' then begin
                            //Balance at the end of the year
                            FirstYear := Dividend + InterestOnDeposit;

                            //Dividend and interest earned
                            memberLedgerEntries.Reset;
                            memberLedgerEntries.SetRange("Member No.", Customer."No.");
                            //memberLedgerEntries.SetRange("Transaction Type", memberLedgerEntries."transaction type"::Dividend);
                            //memberLedgerEntries.SetFilter("Document No.", 'GDIV_2018|DIVTAX_2018');
                            //memberLedgerEntries.SetRange(Posted, false);//Reversed,false
                            DividendEarned := 0;
                            memberLedgerEntries.CalcSums(Amount);
                            DividendEarned := memberLedgerEntries.Amount;

                            memberLedgerEntries.Reset;
                            memberLedgerEntries.SetRange("Member No.", Customer."No.");
                            //memberLedgerEntries.SetRange("Transaction Type", memberLedgerEntries."transaction type"::InterestOnDeposits);
                            //memberLedgerEntries.SetFilter("Document No.", 'GDIV_2018|INTTAX_2018');
                            //memberLedgerEntries.SetRange(Posted, false);//Reversed,false
                            InterestOnDepositEarned := 0;
                            memberLedgerEntries.CalcSums(Amount);
                            InterestOnDepositEarned := memberLedgerEntries.Amount;

                            FirstYearEarned := DividendEarned + InterestOnDepositEarned;
                        end;


                        if DivPeriod.Year = '2019' then begin
                            //Balance at the end of the year
                            SecondYear := Dividend + InterestOnDeposit;

                            //Dividend and interest earned
                            memberLedgerEntries.Reset;
                            memberLedgerEntries.SetRange("Member No.", Customer."No.");//avvount no to vendor ni
                            //memberLedgerEntries.SetRange("Transaction Type", memberLedgerEntries."transaction type"::Dividend);
                            //memberLedgerEntries.SetRange("Document No.", 'DIV2019');
                            //memberLedgerEntries.SetRange(Posted, false);//Reversed,false
                            DividendEarned := 0;
                            memberLedgerEntries.CalcSums(Amount);
                            DividendEarned := memberLedgerEntries.Amount;

                            memberLedgerEntries.Reset;
                            memberLedgerEntries.SetRange("Member No.", Customer."No.");
                            //memberLedgerEntries.SetRange("Transaction Type", memberLedgerEntries."transaction type"::InterestOnDeposits);
                            //memberLedgerEntries.SetRange("Document No.", 'DIV2019');
                            //memberLedgerEntries.SetRange(Posted, false);//Reversed,false
                            InterestOnDepositEarned := 0;
                            memberLedgerEntries.CalcSums(Amount);
                            InterestOnDepositEarned := memberLedgerEntries.Amount;

                            SecondYearEarned := DividendEarned + InterestOnDepositEarned;

                        end;
                        if DivPeriod.Year = '2020' then begin
                            //Balance at the end of the year
                            ThirdYear := Dividend + InterestOnDeposit;

                            //Dividend and interest earned
                            memberLedgerEntries.Reset;
                            memberLedgerEntries.SetRange("Member No.", Customer."No.");
                            //memberLedgerEntries.SetRange("Transaction Type", memberLedgerEntries."transaction type"::Dividend);
                            //memberLedgerEntries.SetRange("Document No.", 'DIV2020');
                            //memberLedgerEntries.SetRange(Posted, false);//Reversed,false
                            DividendEarned := 0;
                            memberLedgerEntries.CalcSums(Amount);
                            DividendEarned := memberLedgerEntries.Amount;

                            memberLedgerEntries.Reset;
                            memberLedgerEntries.SetRange("Member No.", Customer."No.");
                            //memberLedgerEntries.SetRange("Transaction Type", memberLedgerEntries."transaction type"::InterestOnDeposits);
                            //memberLedgerEntries.SetRange("Document No.", 'DIV2020');
                            //memberLedgerEntries.SetRange(Posted, false);//Reversed,false
                            InterestOnDepositEarned := 0;
                            memberLedgerEntries.CalcSums(Amount);
                            InterestOnDepositEarned := memberLedgerEntries.Amount;

                            ThirdYearEarned := DividendEarned + InterestOnDepositEarned;
                        end;
                        if DivPeriod.Year = '2021' then begin
                            //Balance at the end of the year
                            FourthYear := Dividend + InterestOnDeposit;

                            //Dividend and interest earned
                            memberLedgerEntries.Reset;
                            memberLedgerEntries.SetRange("Member No.", Customer."No.");
                            //memberLedgerEntries.SetRange("Transaction Type", memberLedgerEntries."transaction type"::Dividend);
                            //memberLedgerEntries.SetRange("Document No.", 'DIV2021');
                            //memberLedgerEntries.SetRange(Posted, false);//Reversed,false
                            DividendEarned := 0;
                            memberLedgerEntries.CalcSums(Amount);
                            DividendEarned := memberLedgerEntries.Amount;

                            memberLedgerEntries.Reset;
                            memberLedgerEntries.SetRange("Member No.", Customer."No.");
                            //memberLedgerEntries.SetRange("Transaction Type", memberLedgerEntries."transaction type"::InterestOnDeposits);
                            //memberLedgerEntries.SetRange("Document No.", 'DIV2021');
                            //memberLedgerEntries.SetRange(Posted, false);//Reversed,false
                            InterestOnDepositEarned := 0;
                            memberLedgerEntries.CalcSums(Amount);
                            InterestOnDepositEarned := memberLedgerEntries.Amount;

                            FourthYearEarned := DividendEarned + InterestOnDepositEarned;
                        end;
                        if DivPeriod.Year = '2022' then
                            TotalMember := Dividend + InterestOnDeposit;

                    until DivPeriod.Next = 0;
                    FirstYear := ROUND(FirstYear, 0.01);
                    SecondYear := ROUND(SecondYear, 0.01);
                    ThirdYear := ROUND(ThirdYear, 0.01);
                    FourthYear := ROUND(FourthYear, 0.01);


                end;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No.");
                FNo := FNo + 1;
                Company.Get();
                Company.CalcFields(Company.Picture);
                GenSetUp.Get;
                //Customer.SETRANGE("No.",'NEG016283');
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
        DateFilter: Text[100];
        DivProg: Record "Dividends Progression";
        InterestOnDeposit: Decimal;
        CustomerCaptionLbl: label 'Customer';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Dividend: Decimal;
        DivPeriod: Record "Dividend Periods";// UnknownRecord52211 should be DividendAllPeriods----> Aziz will provide updated
        FromDate: Text;
        ToDate: Text;
        GenSetUp: Record "Sacco Setup";
        memberLedgerEntries: Record "Savings Ledger Entry";
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[10];
        BATCH_NAME_DIV: Code[10];
        BATCH_NAME_INT: Code[10];
        //createGLLine: Codeunit "Sacco Activities";//UnknownCodeunit50027 - should be Surestep factory
        FirstYear: Decimal;
        SecondYear: Decimal;
        ThirdYear: Decimal;
        FourthYear: Decimal;
        TotalMember: Decimal;
        LastFieldNo: Integer;
        FNo: Integer;
        Company: Record "Company Information";
        FirstYearEarned: Decimal;
        SecondYearEarned: Decimal;
        ThirdYearEarned: Decimal;
        FourthYearEarned: Decimal;
        DividendEarned: Decimal;
        InterestOnDepositEarned: Decimal;
}

