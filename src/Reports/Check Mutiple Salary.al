report 55020 "Check Mutiple Salary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Check Mutiple Salary.rdlc';
    //ProcessingOnly = true;

    dataset
    {
        dataitem("Salary Lines"; "Salary Lines")
        {
            //DataItemTableView = WHERE(Posted = CONST(true));
            column(No_SalaryLines; "Salary Lines"."No.")
            {
            }
            column(AccountNo_SalaryLines; "Salary Lines"."Account No.")
            {
            }
            column(StaffNo_SalaryLines; "Salary Lines"."Staff No.")
            {
            }
            column(Name_SalaryLines; "Salary Lines".Name)
            {
            }
            column(Amount_SalaryLines; "Salary Lines".Amount)
            {
            }
            column(AccountNotFound_SalaryLines; "Salary Lines"."Account Not Found")
            {
            }
            column(MultipleSalary_SalaryLines; "Salary Lines"."Multiple Salary")
            {
            }

            trigger OnAfterGetRecord()
            begin


                SalaryLine.RESET;
                SalaryLine.SETRANGE(SalaryLine.Processed, FALSE);
                SalaryLine.SETRANGE(SalaryLine."Salary Header No.", "Salary Lines"."Salary Header No.");
                SalaryLine.SETRANGE(SalaryLine."Account No.", "Salary Lines"."Account No.");
                IF SalaryLine.COUNT > 1 THEN BEGIN
                    "Salary Lines"."Multiple Salary" := TRUE;
                    "Salary Lines".MODIFY;
                END ELSE BEGIN
                    "Salary Lines"."Multiple Salary" := FALSE;
                    "Salary Lines".MODIFY;
                END;
                IF "Salary Lines"."Multiple Salary" = FALSE
                  THEN
                    CurrReport.SKIP;
            end;

            trigger OnPostDataItem()
            begin
                if SalaryHeader.Get("Salary Lines"."Salary Header No.") then begin
                    SalaryHeader."Mutiple Salaries Checked" := true;
                    SalaryHeader.Modify();
                end;

                MESSAGE('Mutiple Salary validation Completed sucessfully');
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
        SalaryLine: Record "Salary Lines";
        SalaryHeader: Record "Salary Header";
}

