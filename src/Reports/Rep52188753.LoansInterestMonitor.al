namespace CentralDB.CentralDB;

report 50435 "Loans Interest Monitor"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans Interest Monitor.rdlc';
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true), "Mobile Loan" = const(false), "Stop Interest Due" = const(false), "Outstanding Principal" = filter('>0'));
            RequestFilterFields = "Loan No.", "Member No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(Loan_No_; "Loan No.")
            {
            }
            column(Member_No_; "Member No.")
            {
            }
            column(Member_Name; "Member Name")
            {
            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {
            }
            column(Outstanding_Principal; "Outstanding Principal")
            {
            }
            column(ExpectedInt; ExpectedInt)
            {
            }
            column(IntCharged; IntCharged)
            {
            }

            trigger OnAfterGetRecord()
            var
                LRec: Record "Loan Repayment Schedule";
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
                    LRec.SetLoadFields("Loan No.");
                    LRec.SetRange("Loan No.", Loans."Loan No.");
                    LRec.SetRange("Repayment Date", StartDate, EndDate);
                    if LRec.FindFirst then begin

                        ExpectedInt := ROUND(Periodic.GetInterestAmount(Loans."Loan No.", StartDate,StartDate, false), 0.01, '>');

                    end;

                    Loans.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
                    Loans.CalcFields("Interest Due");
                    IntCharged := Loans."Interest Due";
                    Loans.SetFilter("Date Filter", '..%1', EndDate);
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

                if StartDate = 0D then
                    StartDate := Today;

                if EndDate = 0D then
                    EndDate := Today();

                SetFilter("Loan Product Type", '<>%1&<>%2&<>%3', 'L16', 'L05', 'L09');
                NoOfRecords := Loans.Count;
                dWindow.Update(2, NoOfRecords);

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
                    ApplicationArea = Basic;
                }
                field("End Date"; EndDate)
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
        StartDate: Date;
        "Document No.": Code[20];
        LoanAmount: Decimal;
        Members: Record Members;
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        EndDate: Date;
        IntCharged: Decimal;
        ExpectedInt: Decimal;
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        Periodic: Codeunit "Sacco Activities";
        Exception: Boolean;
        ProdFact: Record "Product Setup";
        Options: Option "Generate & Post","Generate Only";
        SaccoSetup: Record "Sacco Setup";
        IntDueDate: Date;
        Customer: Record Members;
}

