Report 50270 "Get Dashboard"
{
    ProcessingOnly = true;

    dataset
    {
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

    trigger OnPostReport()
    begin
        Message('Process Completed');

        DashBoard.Reset;
        DashBoard.SetRange(Date, Date);
        if DashBoard.FindFirst then
            Page.Run(52018595, DashBoard);
    end;

    trigger OnPreReport()
    begin
        if Date = 0D then
            Date := Today;

        if DashBoard.Get(Date) then begin
            if Confirm('Dashboard Already Exists. Do you want to regenerate?') then begin
                DashBoard.Get(Date);
                DashBoard.Delete;
                DashboardLines.Reset;
                DashboardLines.SetRange(Date, Date);
                if DashboardLines.FindFirst then
                    DashboardLines.DeleteAll;

                GetDashboard;
            end;
        end
        else begin
            GetDashboard;
        end;
    end;

    var
        Date: Date;
        DashBoard: Record DashBoard;
        GLAccount: Record "G/L Account";
        Members: Record "Savings Accounts";
        ProductFactory: Record "Product Setup";
        DashboardLines: Record "Dashboard Lines";
        BankAccount: Record "Bank Account";
        Loans: Record Loans;
        i: Integer;

    local procedure GetDashboard()
    var
        LoanBal: Decimal;
        DimensionValue: Record "Dimension Value";
        BankBal: Decimal;
    begin

        DashBoard.Init;
        DashBoard.Date := Date;

        GLAccount.Get('49999');
        GLAccount.SetFilter("Date Filter", '..%1', Date);
        GLAccount.CalcFields("Net Change");
        DashBoard."Total Income" := GLAccount."Net Change";

        GLAccount.Get('69999');
        GLAccount.SetFilter("Date Filter", '..%1', Date);
        GLAccount.CalcFields("Net Change");
        DashBoard."Total Expense" := GLAccount."Net Change";

        GLAccount.Get('12999');
        GLAccount.SetFilter("Date Filter", '..%1', Date);
        GLAccount.CalcFields("Net Change");
        DashBoard."Loan Portfolio" := GLAccount."Net Change";

        GLAccount.Get('12025');
        GLAccount.SetFilter("Date Filter", '..%1', Date);
        GLAccount.CalcFields("Net Change");
        DashBoard."Loan Portfolio" += GLAccount."Net Change";


        Members.Reset;
        Members.SetRange(Status, Members.Status::Dormant);
        Members.SetRange("Product Category", Members."product category"::"Deposit Contribution");
        if Members.FindFirst then
            DashBoard."Dormant Accounts" := Members.Count;

        Members.Reset;
        Members.SetRange(Status, Members.Status::Active);
        Members.SetRange("Product Category", Members."product category"::"Deposit Contribution");
        if Members.FindFirst then
            DashBoard."Active Accounts" := Members.Count;


        GLAccount.Get('15099');
        GLAccount.SetFilter("Date Filter", '..%1', Date);
        GLAccount.CalcFields("Net Change");
        DashBoard.Assets := GLAccount."Net Change";
        DashBoard.Insert;


        /*
        BankAccount.RESET;
        BankAccount.SETRANGE("Bank Type",BankAccount."Bank Type"::Treasury);
        BankAccount.SETFILTER("Date Filter",'..%1',Date);
        IF BankAccount.FINDFIRST THEN BEGIN
        
            DashboardLines.INIT;
            DashboardLines.Date := Date;
            DashboardLines.Description := '- TREASURY BALANCE - ';
            DashboardLines.Value := 0;
            DashboardLines.Type:=DashboardLines.Type::"Treasury Balances";
            DashboardLines.INSERT;
            REPEAT
                BankAccount.CALCFIELDS("Net Change (LCY)");
                DashboardLines.INIT;
                DashboardLines.Date := Date;
                DashboardLines.Description := BankAccount.Name;
                DashboardLines.Value := BankAccount."Net Change (LCY)";
                DashboardLines.Type:=DashboardLines.Type::"Treasury Balances";
                DashboardLines.INSERT;
            UNTIL BankAccount.NEXT=0;
        END;
        */
        DimensionValue.Reset;
        DimensionValue.SetRange("Dimension Code", 'BRANCH');
        if DimensionValue.FindFirst then begin

            DashboardLines.Init;
            DashboardLines.Date := Date;
            DashboardLines.Description := '- BANK BALANCE - ';
            DashboardLines.Value := 0;
            DashboardLines.Type := DashboardLines.Type::"Treasury Balances";
            DashboardLines.Insert;
            repeat

                BankBal := 0;
                BankAccount.Reset;
                BankAccount.SetRange("Global Dimension 2 Code", DimensionValue.Code);
                BankAccount.SetFilter("Date Filter", '..%1', Date);
                if BankAccount.FindFirst then begin
                    repeat
                        BankAccount.CalcFields("Net Change (LCY)");
                        BankBal += BankAccount."Net Change (LCY)";
                        ;
                    until BankAccount.Next = 0;

                end;

                DashboardLines.Init;
                DashboardLines.Date := Date;
                DashboardLines.Description := DimensionValue.Code;
                DashboardLines.Value := BankAccount.Count;
                DashboardLines.Balance := BankBal;
                DashboardLines.Type := DashboardLines.Type::"Treasury Balances";
                DashboardLines.Insert;
            until DimensionValue.Next = 0;
        end;

        DashboardLines.Init;
        DashboardLines.Date := Date;
        DashboardLines.Description := '- LOAN STATUS - ';
        DashboardLines.Value := 0;
        DashboardLines.Type := DashboardLines.Type::"Loans Category";
        DashboardLines.Insert;


        for i := 1 to 5 do begin
            Loans.Reset;
            if i = 1 then
                Loans.SetRange("Loans Category-SASRA", Loans."loans category-sasra"::Performing);
            if i = 2 then
                Loans.SetRange("Loans Category-SASRA", Loans."loans category-sasra"::Watch);
            if i = 3 then
                Loans.SetRange("Loans Category-SASRA", Loans."loans category-sasra"::Substandard);
            if i = 4 then
                Loans.SetRange("Loans Category-SASRA", Loans."loans category-sasra"::Doubtful);
            if i = 5 then
                Loans.SetRange("Loans Category-SASRA", Loans."loans category-sasra"::Loss);
            Loans.SetFilter("Date Filter", '..%1', Date);
            Loans.SetFilter("Outstanding Principal", '>0');
            if Loans.FindFirst then begin
                LoanBal := 0;

                repeat
                    Loans.CalcFields("Outstanding Principal");
                    LoanBal += Loans."Outstanding Principal";
                until Loans.Next = 0;

                Loans.CalcFields("Loans Category-SASRA");

                DashboardLines.Init;
                DashboardLines.Date := Date;
                DashboardLines.Description := Format(Loans."Loans Category-SASRA");
                ;
                DashboardLines.Value := Loans.Count;
                DashboardLines.Type := DashboardLines.Type::"Loans Category";
                DashboardLines.Balance := LoanBal;
                DashboardLines.Guid := CreateGuid;
                DashboardLines.Insert;

            end;
        end;

    end;
}

