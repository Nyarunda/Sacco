
report 50457 "Generate Rollover Fee"
{
    ApplicationArea = All;
    Caption = 'Generate Rollover Fee';
    UsageCategory = History;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; "Integer")
        {
            DataItemTableView = where(Number = filter(1));

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                Sky: Codeunit "Sky MBanking";
            begin
                if CheckDate = 0D then
                    CheckDate := Today;

                Sky.RollOver(CheckDate);
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
