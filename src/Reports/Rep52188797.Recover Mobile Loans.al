namespace CentralDB.CentralDB;

report 50479 "Recover Mobile Loans"
{
    Caption = 'Recover Mobile Loans';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Total Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Loan Product Type", "Member No.", "Application Date";

            trigger OnAfterGetRecord()
            var
                SaccoActivities: Codeunit "Sacco Activities";
            begin
                SaccoActivities.RecoverMobileLoan("Loan No.");
            end;
            
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(DocNo; DocNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Document No.';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        DocNo: Code[20];
        DivPosting: Record "Defaulter Recovery Buffer";
}
