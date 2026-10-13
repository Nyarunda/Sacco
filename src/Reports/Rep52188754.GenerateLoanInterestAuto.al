namespace CentralDB.CentralDB;

report 50436 "Generate Loan Interest Auto"
{
    Caption = 'Generate Loan Interest Auto';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true), "Mobile Loan" = const(false), "Stop Interest Due" = const(false));
            RequestFilterFields = "Loan No.", "Member No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                LRec: Record Loans;
                StopInterest: Boolean;
                PSetup: Record "Product Setup";
            begin



                dWindow.Update(1, Loans."Member Name");
                CurrentRecordNo += 1;
                Exception := false;
                dWindow.Update(3, CurrentRecordNo);
                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                PSetup.Get("Loan Product Type");


                if Installments = 0 then begin
                    Installments := PSetup."Default Installments";
                    Modify();
                    Commit();

                end;

                if "Interest Calculation Method" <> PSetup."Interest Calculation Method" then begin
                    "Interest Calculation Method" := PSetup."Interest Calculation Method";
                    Modify();
                    Commit();

                end;

                ////if Loans."Disbursement Date" = 0D then
                //CurrReport.Skip;

                Loans.CalcFields("Last Int. Due Date");

                StopInterest := false;
                Members.Reset();
                Members.SetLoadFields("No.", "Employer Code");
                if Members.Get(Loans."Member No.") then;

                Customer.SetLoadFields("No.", "Employer Code", "Stop Interest Due");
                if Customer.Get(Members."Employer Code") then
                    if Customer."Stop Interest Due" then
                        StopInterest := true;

                if not StopInterest then begin

                    LRec.Reset;
                    LRec.SetLoadFields("Loan No.", "Outstanding Principal");
                    LRec.SetRange("Loan No.", Loans."Loan No.");
                    LRec.SetFilter("Outstanding Principal", '>0');
                    if LRec.FindFirst then begin

                        if Loans."Last Int. Due Date" < CalcDate('-CM', PDate) then begin

                            if SaccoSetup."Loan Interest Date" = SaccoSetup."loan interest date"::"Loan Anniversary" then begin

                                IntDueDate := Periodic.GetLoanRePaymentDate(Loans, PDate);

                                if IntDueDate = PDate then
                                    Periodic.GenerateLoanMonthlyInterest(Loans."Loan No.", BillDate, PDate, true);
                            end
                            else begin
                                Periodic.GenerateLoanMonthlyInterest(Loans."Loan No.", BillDate, PDate, true);
                            end;
                        end;

                    end;
                end;

            end;

            trigger OnPostDataItem()
            begin
                //dWindow.Close;
                //Message('Process Completed');
                Periodic.PostLoanInterest();
            end;

            trigger OnPreDataItem()
            var
                IntDate: Date;
            begin


                dWindow.Open('Generating Interest:                #1#########\'
                                    + 'Total Loans:                #2#########\'
                                    + 'Counter:                    #3#########\'
                                    + 'Progress:                   @4@@@@@@@@@\'
                                    + 'Press Esc to abort');



                SaccoSetup.Get;

                if BillDate = 0D then
                    BillDate := Today;

                if PDate = 0D then
                    PDate := BillDate;

                /*
                IF BillDate=0D THEN BEGIN
                    BillDate:=TODAY;
                    IF CALCDATE('-CM',BillDate)<>BillDate THEN
                      CurrReport.QUIT;
                END
                ELSE BEGIN
                
                
                  IF CALCDATE('-CM',BillDate)<>BillDate THEN
                    ERROR('Invalid Bill Date');
                END;
                
                
                BillDate:=CALCDATE('-CM',BillDate);
                */

                //Loans.SETFILTER("Date Filter",'..%1',CALCDATE('-1M+CM',BillDate));
                //Loans.SETFILTER("Outstanding Balance",'>0');


                if SaccoSetup."Loan Interest Date" <> SaccoSetup."loan interest date"::"User Defined At Run Time" then begin
                    if SaccoSetup."Loan Interest Date" = SaccoSetup."loan interest date"::"Begining of Month" then begin
                        if PDate <> CalcDate('-CM', PDate) then
                            CurrReport.Quit;
                    end;


                    if SaccoSetup."Loan Interest Date" = SaccoSetup."loan interest date"::"End of Month" then begin
                        if PDate <> CalcDate('CM', PDate) then
                            CurrReport.Quit;
                    end;

                    if SaccoSetup."Loan Interest Date" = SaccoSetup."loan interest date"::"Mid Month" then begin
                        IntDate := Dmy2date(15, Date2dmy(Today, 2), Date2dmy(Today, 3));
                        if PDate <> IntDate then
                            CurrReport.Quit;
                    end;

                    if SaccoSetup."Loan Interest Date" = SaccoSetup."loan interest date"::"Specific Date" then begin
                        SaccoSetup.TestField("Specific Loan Interest Day");

                        IntDate := Dmy2date(SaccoSetup."Specific Loan Interest Day", Date2dmy(Today, 2), Date2dmy(Today, 3));
                        if PDate <> IntDate then
                            CurrReport.Quit;
                    end;

                    SetFilter("Loan Product Type", '<>%1&<>%2&<>%3', 'L16', 'L05', 'L09');
                    NoOfRecords := Loans.Count;
                    dWindow.Update(2, NoOfRecords);

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
                field("Interest Date"; BillDate)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; PDate)
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
        LoanType: Record "Product Setup";
        DocNo: Code[20];
        PDate: Date;
        "Document No.": Code[20];
        LoanAmount: Decimal;
        Members: Record Members;
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        MonthDays: Integer;
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        Periodic: Codeunit "Sacco Activities";
        BillDate: Date;
        Exception: Boolean;
        ProdFact: Record "Product Setup";
        Options: Option "Generate & Post","Generate Only";
        SaccoSetup: Record "Sacco Setup";
        IntDueDate: Date;
        Customer: Record Members;
        Auto: Boolean;
}

