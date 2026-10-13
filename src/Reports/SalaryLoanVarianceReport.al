Report 50355 "Salary Loan Variance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Salary Loan Variance.rdlc';

    dataset
    {
        dataitem("Lines"; "Salary Lines")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("Member No.");
                DataItemTableView = Where(Posted = const(true));


                column(Loan_No_; "Loan No.")
                {
                }
                column(Loan_Product_Type_Name; "Loan Product Type Name")
                {
                }
                column(Member_No_; "Member No.")
                {
                }
                column(Member_Name; "Member Name")
                {
                }
                column(Expected; Expected)
                {
                }
                column(Paid; Paid)
                {
                }
                column(Variance; Variance)
                {
                }

                trigger OnAfterGetRecord()
                var
                    SActivities: Codeunit "Sacco Activities";
                    LRec: Record Loans;
                    myInt: Integer;
                    ExpectedAmt: Decimal;
                    AmtPaid: Decimal;
                    DefAmount: Decimal;
                    DaysInArrear: Integer;
                    ArrearsDate: Date;
                begin
                    Expected := 0;
                    Paid := 0;

                    if PSetup.get(Loans."Loan Product Type") then begin


                        LRec.Reset();
                        LRec.SetRange("Loan No.", Loans."Loan No.");
                        LRec.SetFilter("Date Filter", '%1', PDate);
                        if LRec.FindFirst() then begin
                            LRec.calcfields("Interest Paid", "Principal Paid");
                            Paid := LRec."Interest Paid" + Lrec."Principal Paid";
                        end;


                        LRec.Reset();
                        LRec.SetRange("Loan No.", Loans."Loan No.");
                        LRec.SetFilter("Date Filter", '..%1', PDate - 1);
                        LRec.SetFilter("Outstanding Principal", '>0');
                        if LRec.FindFirst() then begin
                            LRec.calcfields("Outstanding Interest");
                            SActivities.GetDefaultedAmountMinusOne(Loans."Loan No.", calcdate('-1M+CM', SalMonth), ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, PDate - 1);
                            Expected := DefAmount + LRec."Outstanding Interest";
                        end;

                        if PSetup."Skip Salary Cutoff Date" then begin
                            LRec.Reset();
                            LRec.SetRange("Loan No.", Loans."Loan No.");
                            LRec.SetFilter("Disbursement Date", '..%1', PDate - 1);
                            LRec.SetFilter("Date Filter", '..%1', PDate - 1);
                            LRec.SetFilter("Outstanding Principal", '>0');
                            if LRec.FindFirst() then begin
                                LRec.calcfields("Outstanding Interest", "Outstanding Principal");
                                DefAmount := LRec.Repayment - LRec."Outstanding Interest";
                                if DefAmount > LRec."Outstanding Principal" then
                                    DefAmount := LRec."Outstanding Principal";

                                Expected += DefAmount;
                            end;

                        end
                        else begin

                            LRec.Reset();
                            LRec.SetRange("Loan No.", Loans."Loan No.");
                            LRec.SetFilter("Disbursement Date", '..%1', LBalDate);
                            LRec.SetFilter("Date Filter", '..%1', PDate - 1);
                            LRec.SetFilter("Outstanding Principal", '>0');
                            if LRec.FindFirst() then begin
                                LRec.calcfields("Outstanding Interest", "Outstanding Principal");
                                DefAmount := LRec.Repayment - LRec."Outstanding Interest";
                                if DefAmount > LRec."Outstanding Principal" then
                                    DefAmount := LRec."Outstanding Principal";

                                Expected += DefAmount;
                            end;

                        end;
                    end;

                    Variance := Expected - Paid;
                    if Expected <= 0 then
                        CurrReport.Skip();

                end;

                trigger OnPredataitem()
                var
                    myInt: Integer;
                begin
                    SetRange("Repay Mode", SalHead."Income Type");
                end;
            }
            trigger OnAfterGetRecord()
            begin
                RNo := RNo + 1;
                SalHead.get(Lines."Salary Header No.");
                PDate := SalHead."Posting date";
                LBalDate := SalHead."Loan Balance Date";
                SalMonth := SalHead."Salary Month";


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

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        Company: Record "Company Information";
        RNo: Integer;
        Variance: Decimal;
        Paid: Decimal;
        Expected: Decimal;
        SaccoAccount: Record "Savings Accounts";
        PSetup: Record "Product Setup";
        LBalDate: Date;
        PDate: Date;
        SalMonth: Date;
        SalHead: Record "Salary Header";
        BosaLoan: Decimal;
}

