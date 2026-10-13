Report 50263 "Top Performers Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Top Performers Report.rdlc';

    dataset
    {
        dataitem("Top Balances"; "Top Balances")
        {
            DataItemTableView = sorting(Balance) order(descending);
            column(ReportForNavId_1; 1)
            {
            }
            column(AccountNo; "Top Balances"."Account No.")
            {
            }
            column(Name; "Top Balances".Name)
            {
            }
            column(Balance; "Top Balances".Balance)
            {
            }
            column(Product; "Top Balances".Product)
            {
            }
            column(UserName; "Top Balances".UserName)
            {
            }
            column(MemberNo; "Top Balances"."Member No.")
            {
            }
            column(Title; Title)
            {
            }

            trigger OnAfterGetRecord()
            begin

                j += 1;
                if j > TopNo then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            var
                Cust: Record Members;
                TBal: Decimal;
            begin

                if AsAt = 0D then
                    AsAt := Today;

                Top.Reset;
                Top.SetRange(UserName, UserId);
                if Top.FindFirst then
                    Top.DeleteAll;

                Title := '';
                Title += Format(Category) + ' ' + Branch;

                if Category = Category::Savings then begin
                    Cust.Reset;
                    if Branch <> '' then
                        Cust.SetRange("Global Dimension 2 Code", Branch);
                    if Cust.FindFirst then begin


                        CurrentRecordNo := 0;
                        NoOfRecords := Cust.Count;
                        dWindow.Open('Generating Balances:      @1@@@@@@@@@\'
                                                    + 'Counter   #2#########'
                                                    + 'Total     #3#########'
                                                    + 'Product   #4#########'
                                                    + 'Press Esc to abort');
                        repeat

                            TBal := 0;
                            ProductFactory.Reset;
                            //ProductFactory.SETRANGE("Include Top Performers",TRUE);
                            if ProductFactory.FindFirst then begin
                                repeat

                                    Savings.Reset;
                                    Savings.SetFilter("Date Filter", '..%1', AsAt);
                                    Savings.SetRange("Member No.", Cust."No.");
                                    Savings.SetRange("Product Type", ProductFactory."Product ID");
                                    if Savings.FindFirst then begin
                                        Savings.CalcFields("Balance (LCY)");
                                        TBal += Savings."Balance (LCY)";
                                    end;
                                until ProductFactory.Next = 0;
                            end;


                            Top.Init;
                            Top."Account No." := Cust."No.";
                            Top."Member No." := Cust."No.";
                            Top.Name := Cust.Name;
                            Top.Balance := TBal;
                            Top.UserName := UserId;
                            Top.Product := 'SAVINGS';
                            Top.Insert;


                            dWindow.Update(2, CurrentRecordNo);
                            dWindow.Update(3, NoOfRecords);
                            dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                        until Cust.Next = 0;
                    end;
                end;

                if Category = Category::Credit then begin
                    Cust.Reset;
                    Cust.SetFilter("Date Filter", '..%1', AsAt);
                    if Branch <> '' then
                        Cust.SetRange("Global Dimension 2 Code", Branch);
                    if Cust.FindFirst then begin

                        CurrentRecordNo := 0;
                        NoOfRecords := Cust.Count;
                        dWindow.Open('Generating Balances:      @1@@@@@@@@@\'
                                                    + 'Counter   #2#########'
                                                    + 'Total     #3#########'
                                                    + 'Product   #4#########'
                                                    + 'Press Esc to abort');
                        repeat



                            TBal := 0;
                            Loans.Reset;
                            Loans.SetFilter("Date Filter", '..%1', AsAt);
                            Loans.SetRange("Member No.", Cust."No.");
                            if Loans.FindFirst then begin
                                repeat

                                    Loans.CalcFields("Outstanding Principal");
                                    TBal += Loans."Outstanding Principal";

                                until Loans.Next = 0;
                            end;

                            Top.Init;
                            Top."Account No." := Cust."No.";
                            Top."Member No." := Cust."No.";
                            Top.Name := Cust.Name;
                            Top.Balance := TBal;
                            Top.UserName := UserId;
                            Top.Product := 'LOANS';
                            Top.Insert;


                            dWindow.Update(2, CurrentRecordNo);
                            dWindow.Update(3, NoOfRecords);
                            dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                        until Cust.Next = 0;
                    end;
                end;

                if TopNo = 0 then
                    TopNo := 50;


                Title += ' Top ' + Format(TopNo) + ' AsAt ' + Format(AsAt);


                "Top Balances".SetRange(UserName, UserId);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Category; Category)
                {
                    ApplicationArea = Basic;
                }
                field(Branch; Branch)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
                }
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
                }
                field("Top ?"; TopNo)
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
        Savings: Record "Savings Accounts";
        Loans: Record Loans;
        ProductFactory: Record "Product Setup";
        SaccoProduct: Code[20];
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        Top: Record "Top Balances";
        AsAt: Date;
        j: Integer;
        TopNo: Integer;
        Title: Text;
        Category: Option Savings,Credit;
        Branch: Code[20];
}

