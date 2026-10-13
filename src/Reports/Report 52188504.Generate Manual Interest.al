
Report 50167 "Generate Manual Interest"
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
                field(PDate; PDate)
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; LoanNo)
                {
                    ApplicationArea = Basic;
                    TableRelation = Loans where("Total Outstanding Balance" = filter(<> 0));
                }
                field(Amt; Amt)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Desc)
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

    trigger OnPreReport()
    begin


        SaccoActivities.GenerateManualLoanInterest(LoanNo, PDate, Amt, Desc);
    end;

    var
        SaccoActivities: Codeunit "Sacco Activities";
        LoanNo: Code[20];
        PDate: Date;
        Amt: Decimal;
        Desc: Text;
}

