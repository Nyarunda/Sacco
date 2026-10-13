
report 50475 "Manual Generate Rollover Fee"
{
    ApplicationArea = All;
    Caption = 'Manual Generate Rollover Fee';
    UsageCategory = History;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Loan Product Type" = filter('L30'), "Total Outstanding Balance" = filter(> 0), Installments = filter(< 4));
            RequestFilterFields = "Loan No.";

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                Sky: Codeunit "Sky MBanking";
            begin
                if CheckDate = 0D then
                    Error('Date is required');

                Sky.RollOver2(CheckDate, Loans."Loan No.");
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
                    field(CheckDate; CheckDate)
                    {
                        ApplicationArea = basic;
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
        CheckDate: Date;
}
