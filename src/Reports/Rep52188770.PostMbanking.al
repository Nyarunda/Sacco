namespace CentralDB.CentralDB;

report 50452 "Post Mbanking"
{
    Caption = 'Post Mbanking Loans';
    ProcessingOnly = true;
    dataset
    {
        dataitem("Sky Mobile Loans"; "Sky Mobile Loans")
        {
            DataItemTableView = where(Posted = const(False), Status = filter(Pending));

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                Sky: COdeunit "Sky MBanking";
                Stop: Boolean;
            begin
                Stop := false;
                Sky.ProcessMobileLoan("Sky Mobile Loans"."Entry No", stop);

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
