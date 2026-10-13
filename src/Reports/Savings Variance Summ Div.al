report 50053 "Savings Variance Summ Div"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Savings Variance Summ Div.rdlc';

    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            DataItemTableView = SORTING("Member No.")
                                WHERE("Product Category" = CONST("Deposit Contribution"));
            RequestFilterFields = "No.", "Registration Date", "Date Filter", "Employer Code";
            column(RegDate; RegDate)
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            column(EmployerCode; EmployerCode)
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
            column(RegistrationDate_SavingsAccounts; SavingsAccounts."Registration Date")
            {
            }
            column(EmployerCode_SavingsAccounts; SavingsAccounts."Employer Code")
            {
            }
            column(Credits; SavingsAccounts."Credit Amount")
            {
            }
            column(MonthlyContribution; MonthlyContribution)
            {
            }
            column(Variance; MonthlyContribution - SavingsAccounts."Credit Amount")
            {
            }
            column(AmountReceivedInPreviousMonth; AmountReceivedInPreviousMonth)
            {
            }
            column(PositiveAdjustmentsForCurrentMonth; PositiveAdjustmentsForCurrentMonth)
            {
            }
            column(NewMembersAmountsWithinTheMonth; NewMembersAmountsWithinTheMonth)
            {
            }
            column(NegativeAdjustmentsForCurrentMonth; NegativeAdjustmentsForCurrentMonth)
            {
            }
            column(PreviousMonthStartDate; PreviousMonthStartDate)
            {
            }
            column(PreviousMonthEndDate; PreviousMonthEndDate)
            {
            }
            column(nememb; nememb)
            {
            }

            trigger OnAfterGetRecord()
            begin
                NewContributionForMonthII := 0;
                InitializeVariables;
                //LastMonth;
                MonitorChangeLogEntry;
                NewMembers;
                GetNegativeAdjustmentsForCurrentMonth;


                //EVALUATE(PreviousMonthStartDate,PreviousMonthStartDateS);
                //EVALUATE(PreviousMonthEndDate,PreviousMonthEndDateS);
                Myfilter := FORMAT(PreviousMonthStartDate) + '..' + FORMAT(PreviousMonthEndDate);
                //ERROR(Myfilter);
                SavAcc.RESET;
                SavAcc.SETRANGE("No.", SavingsAccounts."No.");
                SavAcc.SETFILTER("Date Filter", Myfilter);
                //SavAcc.SETRANGE("Date Filter",PreviousMonthStartDate,PreviousMonthEndDate);//CALCDATE('-1M',SavingsAccounts.GETRANGEMIN("Date Filter")),SavingsAccounts.GETRANGEMIN("Date Filter"));
                IF SavAcc.FINDFIRST THEN BEGIN
                    SavAcc.CALCFIELDS("Credit Amount");
                    AmountReceivedInPreviousMonth := SavAcc."Credit Amount";
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF PreviousMonthStartDate = 0D THEN ERROR('Kind specify Previous Month Start Date');
                IF PreviousMonthEndDate = 0D THEN ERROR('Kind specify Previous Month End Date');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Previous Month Start Date"; PreviousMonthStartDate)
                {
                    ApplicationArea = All;
                }
                field("Previous Month End Date"; PreviousMonthEndDate)
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

        IF CompanyInformation.GET THEN;
        /*CompanyInformation.CALCFIELDS(CompanyInformation.Picture);*/
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
#pragma warning disable AL0432
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432

        IF SavingsAccounts.GETFILTER(SavingsAccounts."Date Filter") = '' THEN
            ERROR('Please specify a date filter before proceeding');


        RegDate := SavingsAccounts.GETFILTER("Registration Date");
        DateFilter := SavingsAccounts.GETFILTER("Date Filter");
        EmployerCode := SavingsAccounts.GETFILTER("Employer Code");

        IF EmployerCode <> '' THEN
            IF Customer.GET(EmployerCode) THEN
                EmployerCode += ' ' + Customer.Name;

    end;

    var
        CompanyInformation: Record "Company Information";
        MyHomePage: Text[255];
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        RegDate: Text;
        DateFilter: Text;
        MonthlyContribution: Decimal;
        ChangeLogEntry: Record "Change Log Entry";
        TotalExpectedMonthlyContribution: Decimal;
        TotalReceivedContribution: Decimal;
        SavAcc: Record "Savings Accounts";
        AmountReceivedInPreviousMonth: Decimal;
        PositiveAdjustmentsForCurrentMonth: Decimal;
        NewMembersAmountsWithinTheMonth: Decimal;
        NegativeAdjustmentsForCurrentMonth: Decimal;
        Customer: Record Customer;
        EmployerCode: Code[50];
        NewContributionForMonthII: Decimal;
        OldContributionForMonthII: Decimal;
        PreviousMonthStartDate: Date;
        PreviousMonthStartDateS: Text;
        PreviousMonthEndDate: Date;
        PreviousMonthEndDateS: Text;
        Myfilter: Text;
        nememb: Integer;

    local procedure InitializeVariables()
    begin
        MonthlyContribution := 0;
        AmountReceivedInPreviousMonth := 0;
        PositiveAdjustmentsForCurrentMonth := 0;
        NewMembersAmountsWithinTheMonth := 0;
        NegativeAdjustmentsForCurrentMonth := 0;
    end;

    local procedure MonitorChangeLogEntry()
    var
        NewContributionForMonth: Decimal;
        OldContributionForMonth: Decimal;
    begin
        /*ChangeLogEntry.RESET;
        ChangeLogEntry.SETRANGE("Table Caption",'Savings Accounts');
        ChangeLogEntry.SETRANGE("Field Caption",'Monthly Contribution');
        ChangeLogEntry.SETRANGE("Primary Key Field 1 Value",SavingsAccounts."No.");
        ChangeLogEntry.SETRANGE("Type of Change",ChangeLogEntry."Type of Change"::Modification);
        //ChangeLogEntry.SETFILTER("Date and Time",'>%1',CREATEDATETIME(SavingsAccounts.GETRANGEMAX("Date Filter"),235900T));
        IF ChangeLogEntry.FINDFIRST THEN  BEGIN
          IF ChangeLogEntry."Date and Time" > CREATEDATETIME(SavingsAccounts.GETRANGEMAX("Date Filter"),235900T) THEN
            EVALUATE(MonthlyContribution,ChangeLogEntry."Old Value")
          ELSE
          MonthlyContribution := SavingsAccounts."Monthly Contribution";
        
          IF (ChangeLogEntry."Date and Time" < CREATEDATETIME(SavingsAccounts.GETRANGEMAX("Date Filter"),235900T)) AND
             (ChangeLogEntry."Date and Time" > CREATEDATETIME(SavingsAccounts.GETRANGEMIN("Date Filter"),000000T)) THEN
             BEGIN
              EVALUATE(NewContributionForMonth,ChangeLogEntry."New Value");
              EVALUATE(OldContributionForMonth,ChangeLogEntry."Old Value");
              // add value if the savings account was credited with new amount with and increase
              IF NewContributionForMonth > OldContributionForMonth THEN
                IF SavingsAccounts."Credit Amount" = NewContributionForMonth THEN
                  PositiveAdjustmentsForCurrentMonth := SavingsAccounts."Credit Amount";
             END;
        END ELSE
        MonthlyContribution := SavingsAccounts."Monthly Contribution";
        */

        SavingsAccounts.CALCFIELDS("Credit Amount");
        ChangeLogEntry.RESET;
        ChangeLogEntry.SETRANGE("Table Caption", 'Savings Accounts');
        ChangeLogEntry.SETRANGE("Field Caption", 'Monthly Contribution');
        ChangeLogEntry.SETRANGE("Primary Key Field 1 Value", SavingsAccounts."No.");
        ChangeLogEntry.SETRANGE("Type of Change", ChangeLogEntry."Type of Change"::Modification);
        ChangeLogEntry.SETFILTER("Date and Time", '>%1', CREATEDATETIME(SavingsAccounts.GETRANGEMAX("Date Filter"), 235900T));
        IF ChangeLogEntry.FINDFIRST THEN BEGIN

            EVALUATE(MonthlyContribution, ChangeLogEntry."Old Value");
            IF (ChangeLogEntry."Date and Time" < CREATEDATETIME(SavingsAccounts.GETRANGEMAX("Date Filter"), 235900T)) AND
                 (ChangeLogEntry."Date and Time" > CREATEDATETIME(SavingsAccounts.GETRANGEMIN("Date Filter"), 000000T)) THEN BEGIN
                EVALUATE(NewContributionForMonth, ChangeLogEntry."New Value");
                EVALUATE(OldContributionForMonth, ChangeLogEntry."Old Value");
                // add value if the savings account was credited with new amount with and increase
                IF SavingsAccounts."Credit Amount" > OldContributionForMonth THEN
                    //IF SavingsAccounts."Credit Amount" = NewContributionForMonth THEN
                    PositiveAdjustmentsForCurrentMonth := SavingsAccounts."Credit Amount" - OldContributionForMonth;//SavingsAccounts."Credit Amount";

            END;
        END ELSE
            MonthlyContribution := SavingsAccounts."Monthly Contribution";

    end;

    local procedure NewMembers()
    var
        t: Text;
    begin
        SavAcc.RESET;
        SavAcc.SETRANGE("No.", SavingsAccounts."No.");
        SavAcc.SETRANGE("Registration Date", PreviousMonthStartDate, PreviousMonthEndDate);//SavingsAccounts.GETRANGEMIN("Date Filter"),SavingsAccounts.GETRANGEMAX("Date Filter"));
        //SavAcc.SETRANGE("Registration Date",SavingsAccounts.GETRANGEMIN("Date Filter"),SavingsAccounts.GETRANGEMAX("Date Filter"));
        SavAcc.SETFILTER("Date Filter", '%1..%2', SavingsAccounts.GETRANGEMIN("Date Filter"), SavingsAccounts.GETRANGEMAX("Date Filter"));
        IF SavAcc.FINDFIRST THEN BEGIN
            SavAcc.CALCFIELDS("Credit Amount");
            NewMembersAmountsWithinTheMonth := SavAcc."Credit Amount";
        END;
    end;

    local procedure LastMonth()
    begin
        // EVALUATE(PreviousMonthStartDate,PreviousMonthStartDateS);
        // EVALUATE(PreviousMonthEndDate,PreviousMonthEndDateS);
        // Myfilter:=PreviousMonthStartDateS+'..'+PreviousMonthEndDateS;
        // SavAcc.RESET;
        // SavAcc.SETRANGE("No.",SavingsAccounts."No.");
        // SavAcc.SETFILTER("Date Filter",Myfilter);
        // //SavAcc.SETRANGE("Date Filter",CALCDATE('-1M',SavingsAccounts.GETRANGEMIN("Date Filter")),SavingsAccounts.GETRANGEMIN("Date Filter"));
        // IF SavAcc.FINDFIRST THEN
        //  BEGIN
        //    SavAcc.CALCFIELDS("Credit Amount");
        //    AmountReceivedInPreviousMonth := SavAcc."Credit Amount";
        //  END;
    end;

    local procedure GetNegativeAdjustmentsForCurrentMonth()
    begin
        IF SavingsAccounts."Credit Amount" < MonthlyContribution THEN
            NegativeAdjustmentsForCurrentMonth := (MonthlyContribution - SavingsAccounts."Credit Amount");
    end;
}

