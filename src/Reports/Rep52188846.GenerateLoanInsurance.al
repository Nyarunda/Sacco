namespace UnitedWomen.UnitedWomen;
using System.Security.User;

report 50548 "Generate Loan Insurance"
{
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true), "Mobile Loan" = const(false), "Stop Insurance" = const(false));
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


                Loans.CalcFields("Last Int. Due Date");

                StopInterest := false;
                Members.Reset();
                Members.SetLoadFields("No.", "Employer Code");
                Members.Get(Loans."Member No.");
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

                        //if Loans."Last Ins. Due Date" < CalcDate('-CM', PDate) then begin
                        if SaccoSetup."Loan Insurance Date" = SaccoSetup."loan insurance date"::"Loan Anniversary" then begin
                            IntDueDate := Periodic.GetLoanRePaymentDate(Loans, PDate);
                            if IntDueDate = PDate then
                                Periodic.GenerateLoanMonthlyInsurance(Loans."Loan No.", BillDate, PDate);
                        end
                        else begin
                            Periodic.GenerateLoanMonthlyInsurance(Loans."Loan No.", BillDate, PDate);
                        end;
                        //end;
                    end;

                end;

            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
                Message('Process Completed');
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


                if SaccoSetup."Loan Insurance Date" <> SaccoSetup."Loan Insurance Date"::"User Defined At Run Time" then begin
                    if SaccoSetup."Loan Insurance Date" = SaccoSetup."loan insurance date"::"Begining of Month" then begin
                        if PDate <> CalcDate('-CM', PDate) then
                            CurrReport.Quit;
                    end;


                    if SaccoSetup."Loan Insurance Date" = SaccoSetup."loan insurance date"::"End of Month" then begin
                        if PDate <> CalcDate('CM', PDate) then
                            CurrReport.Quit;
                    end;


                    if SaccoSetup."Loan Insurance Date" = SaccoSetup."loan insurance date"::"Mid Month" then begin
                        IntDate := Dmy2date(15, Date2dmy(Today, 2), Date2dmy(Today, 3));
                        if PDate <> IntDate then
                            CurrReport.Quit;
                    end;


                    if SaccoSetup."Loan Insurance Date" = SaccoSetup."loan insurance date"::"Specific Date" then begin
                        SaccoSetup.TestField("Specific Loan Insurance Day");

                        IntDate := Dmy2date(SaccoSetup."Specific Loan Insurance Day", Date2dmy(Today, 2), Date2dmy(Today, 3));
                        if PDate <> IntDate then
                            CurrReport.Quit;
                    end;




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
}