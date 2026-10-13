
Report 50259 "Un-Blacklist E-Loan Defaults"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where("Mobile Loan Defaulter" = const(true));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Members."Mobile Loan Defaulter" = true then begin
                    Loans.Reset;
                    Loans.SetRange(Loans."Member No.", Members."No.");
                    Loans.SetFilter(Loans."Loan Product Type", '279');
                    Loans.SetFilter(Loans."Outstanding Principal", '<=0');
                    Loans.SetRange(Loans.Posted, true);
                    if Loans.FindLast then begin
                        LLE.Reset;
                        LLE.SetRange(LLE."Loan No.", Loans."Loan No.");
                        if LLE.FindLast then begin //MESSAGE('%1',CALCDATE('3M',LLE."Posting Date"));
                            if Today >= CalcDate('3M', LLE."Posting Date") then begin
                                Members."Mobile Loan Defaulter" := false;
                                Members.Modify;
                            end;
                        end;
                    end;
                end;
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
        Loans: Record Loans;
        LLE: Record "Credit Ledger Entry";
}

