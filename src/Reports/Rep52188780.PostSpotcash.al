//namespace CentralDB.CentralDB;

report 50462 "Post Spotcash"
{
    Caption = 'Post Spotcash';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = where(Number = const(1));

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                Spotcash: Codeunit "SpotCash Mbanking";
            begin

                SpotCash.PostTransactions;

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
}

