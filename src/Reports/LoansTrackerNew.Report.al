Report 50195 "Loans Tracker"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans Tracker New.rdlc';

    dataset
    {
        dataitem("Loans Register"; Loans)
        {

            //DataItemTableView = sorting("Member No.") order(descending) where("Approved Amount"=filter(>0),Posted=const(Yes));
            DataItemTableView = sorting("Member No.") order(descending) where("Approved Amount" = filter(> 0), Posted = filter(true));
            RequestFilterFields = "Loan No.", "Member No.", "Outstanding Principal", "Loan Product Type", "Employer Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo__E_Mail_; CompanyInfo."E-Mail")
            {
            }
            //column(PaymentDueDate_LoansRegister;"Loans Register"."Payment Due Date") WILL BE CALCULATED MANUALLY
            column(PaymentDueDate_LoansRegister; "Loans Register"."Last Pay Date")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Member No.")
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Member Name")
            {
            }
            column(Phoneno; Phoneno)
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan No.")
            {
            }
            //column(CurrentShares_LoansRegister;"Loans Register"."Current Shares")
            column(CurrentShares_LoansRegister; "Loans Register"."Free Shares")
            {
            }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
            {
            }
            column(RepaymentStartDate_LoansRegister; "Loans Register"."Repayment Start Date")
            {
            }
            //column(InstalmentPeriod_LoansRegister;"Loans Register"."Instalment Period")
            column(InstalmentPeriod_LoansRegister; "Loans Register"."Installment Period")
            {
            }
            column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
            {
            }
            column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Principal")
            {
            }
            column(LoansCategoryNEW_LoansRegister; "Loans Register"."Loans Category-SASRA")
            {
            }
            column(Repayment_LoansRegister; "Loans Register".Repayment)
            {
            }
            column(LoanStatus_LoansRegister; "Loans Register".Status)
            {
            }
            //column(DaysInArrearsNEW_LoansRegister;"Loans Register"."Days In Arrears -NEW")
            column(DaysInArrearsNEW_LoansRegister; DaysInArrears)
            {
            }
            //column(AmountInArrearsNEW_LoansRegister;"Loans Register"."Amount In Arrears-NEW") USE FUNCTION GETDEFAULTERAMOUNT
            column(AmountInArrearsNEW_LoansRegister; "Loans Register"."Total Arrears")
            {
            }
            //column(Interest_LoansRegister;"Loans Register".Interest)
            column(Interest_LoansRegister; "Loans Register"."Outstanding Interest")
            {
            }
            column(month_1; Month[1])
            {
            }
            column(month_2; Month[2])
            {
            }
            column(month_3; Month[3])
            {
            }
            column(month_4; Month[4])
            {
            }
            column(month_5; Month[5])
            {
            }
            column(month_6; Month[6])
            {
            }
            column(month_7; Month[7])
            {
            }
            column(month_8; Month[8])
            {
            }
            column(month_9; Month[9])
            {
            }
            column(month_10; Month[10])
            {
            }
            column(month_11; Month[11])
            {
            }
            column(month_12; Month[12])
            {
            }
            column(monthname1; MonthCaption[1])
            {
            }
            column(monthname2; MonthCaption[2])
            {
            }
            column(monthname3; MonthCaption[3])
            {
            }
            column(monthname4; MonthCaption[4])
            {
            }
            column(monthname5; MonthCaption[5])
            {
            }
            column(monthname6; MonthCaption[6])
            {
            }
            column(monthname7; MonthCaption[7])
            {
            }
            column(monthname8; MonthCaption[8])
            {
            }
            column(monthname9; MonthCaption[9])
            {
            }
            column(monthname10; MonthCaption[10])
            {
            }
            column(monthname11; MonthCaption[11])
            {
            }
            column(monthname12; MonthCaption[12])
            {
            }
            //column(DaysinArrears;"Loans Register"."Days In Arrears")
            column(DaysinArrears; DaysInArrears)
            {
            }
            //column(Arrears2;"Loans Register"."Principle In Arrears")
            column(Arrears2; "Loans Register"."Principal Arrears")
            {
            }
            column(arrears; arrears)
            {
            }
            column(Filters; Filters)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Loans Register"."Disbursement Date" = 0D then
                    CurrReport.Skip;
                if "Loans Register"."Repayment Start Date" = 0D then
                    CurrReport.Skip;
                if "Loans Register".Installments = 0 then
                    CurrReport.Skip;

                //SFactory.CalculateArrears("Loans Register"."Loan No.");
                /*
                SFactory.CalculateArrears("Loan  No."); Also on the following reports and pages:
                ----PAGES
                Loans Sub-Page List
                ----REPORTS
                Insider Lending
                Insider Lending -Board
                Insider Lending -Housing
                Loans Tracker
                Loans Above 1 million
                */
                month1 := 0;
                month2 := 0;
                month3 := 0;
                month4 := 0;
                month5 := 0;
                month6 := 0;
                month7 := 0;
                month8 := 0;
                month9 := 0;
                month10 := 0;
                month11 := 0;
                month12 := 0;
                arears := 0;
                arrears := 0;
                DaysInArrears := 0;


                //Phone Number
                Phoneno := '';
                if cust.Get("Loans Register"."Member No.") then begin
                    Phoneno := cust."Phone No.";
                    if cust."Phone No." = '' then
                        Phoneno := cust."Mobile Phone No.";
                end;

                //Arrears
                /*loansSchedule.Reset;
                loansSchedule.SetRange("Loan No.", "Loans Register"."Loan No.");
                loansSchedule.SetRange("Instalment Fully Settled", false);
                loansSchedule.CalcSums("Monthly Repayment", "Principal Paid", "Interest Paid");
                arrears := ROUND((loansSchedule."Monthly Repayment") - (loansSchedule."Principle Amount Paid" + loansSchedule."Interest Paid"), 0.01);
                */
                //DaysinArrears := Today - CalcDate('CM', "Loans Register"."Last Pay Date");
                arrears := "Loans Register"."Total Arrears";
                DateIterator := monthstartDate;

                for iterator := 1 to 12 do begin
                    Month[iterator] := 0;
                    Memberleg.Reset;
                    Memberleg.SetRange("Member No.", "Loans Register"."Member No.");
                    Memberleg.SetRange("Loan No.", "Loans Register"."Loan No.");
                    Memberleg.SetRange(Reversed, false);
                    Memberleg.SetFilter("Transaction Type", '%1|%2', Memberleg."transaction type"::"Principal Repayment", Memberleg."transaction type"::"Interest Paid");
                    Memberleg.SetFilter(Amount, '<0');
                    Memberleg.SetRange("Posting Date", CalcDate('-CM', DateIterator), CalcDate('CM', DateIterator));
                    if Memberleg.FindFirst then begin
                        Memberleg.CalcSums(Amount);
                        Month[iterator] := Memberleg.Amount * -1;
                    end;

                    MonthCaption[iterator] := Format(DateIterator, 0, '<Month Text> <Year4>');
                    DateIterator := CalcDate('1D', CalcDate('CM', DateIterator));

                end;

            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
                if (monthstartDate = 0D) then
                    Error('Month start date must have a value!');
                Filters := "Loans Register".GetFilters;

                "Loans Register".SetRange(Posted, true);
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
                    Caption = 'Options';
                    field("Month Start Date"; monthstartDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Month Start Date';
                    }
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
        CompanyInfo: Record "Company Information";
        month1: Decimal;
        month2: Decimal;
        month3: Decimal;
        month4: Decimal;
        month5: Decimal;
        month6: Decimal;
        month7: Decimal;
        month8: Decimal;
        month9: Decimal;
        month10: Decimal;
        month11: Decimal;
        month12: Decimal;
        arears: Decimal;
        Memberleg: Record "Credit Ledger Entry";
        month1Datefilter: Text;
        month2Datefilter: Text;
        month3Datefilter: Text;
        month4Datefilter: Text;
        month5Datefilter: Text;
        month6Datefilter: Text;
        month1StartDate: Date;
        month2StartDate: Date;
        month3StartDate: Date;
        month4StartDate: Date;
        month5StartDate: Date;
        month6StartDate: Date;
        month7StartDate: Date;
        month8StartDate: Date;
        month9StartDate: Date;
        month10StartDate: Date;
        month11StartDate: Date;
        month12StartDate: Date;
        monthstartDate: Date;
        Filters: Text;
        Phoneno: Code[80];
        Cust: Record Members;
        arrears: Decimal;
        loansSchedule: Record "Loan Repayment Schedule";
        DaysinArrears: Integer;
        MonthCaption: array[12] of Text;
        Month: array[12] of Decimal;
        iterator: Integer;
        DateIterator: Date;
    //SFactory: Codeunit UnknownCodeunit50027;
}

