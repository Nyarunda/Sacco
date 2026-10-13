namespace AL_.AL_;

report 50481 "Send Birthday SMS"
{
    Caption = 'Send Birthday SMS';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where("Member Status" = filter(active | Dormant));
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                MemberActivities: Codeunit "Member Activities";
            begin
                IF (TIME > 080000T) AND (TIME < 180000T) THEN
                    if (Members."No." <> '') and (Members."No." <> 'N/A') then
                        MemberActivities.SendBirthDaySms(Members);
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
