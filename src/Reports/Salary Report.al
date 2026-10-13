report 50530 "Salary Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Salary Report.rdlc';

    dataset
    {
        dataitem("Salary Header"; "Salary Header")
        {
            column(Picture; CompanyInfo.Picture)
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            } */
            column(us; USERID)
            {
            }
            column(date; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompName; COMPANYNAME)
            {
            }
            column(No; "Salary Header".No)
            {
            }
            column(DocNo; "Salary Header"."Document No")
            {
            }
            column(AmountHeader; "Salary Header".Amount)
            {
            }
            column(IncomeType; "Salary Header"."Income Type")
            {
            }
            column(EnteredBy; "Salary Header"."Entered By")
            {
            }
            dataitem("Salary Lines"; "Salary Lines")
            {
                DataItemLink = "Salary Header No." = FIELD(No);
                column(Account; "Salary Lines"."Account No.")
                {
                }
                column(StaffNo; "Salary Lines"."Staff No.")
                {
                }
                column(Name; "Salary Lines".Name)
                {
                }
                column(ID; "Salary Lines"."ID No.")
                {
                }
                column(Amount; "Salary Lines".Amount)
                {
                }
            }

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
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
        CompanyInfo: Record "Company Information";
        Name: Text[50];
}

