Page 50928 "HR Commitee Members"
{
    PageType = List;
    SourceTable = "HR Commitee Members";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(CommitteeMemberNo; Rec."Committee Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(Role; Rec.Role)
                {
                    ApplicationArea = Basic;
                }
                field(DateAppointed; Rec."Date Appointed")
                {
                    ApplicationArea = Basic;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

