Page 50989 "HR Medical Scheme Members List"
{
    //CardPageID = "HR Medical Scheme Members Card";
    PageType = List;
    SourceTable = "HR Medical Scheme Members";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SchemeNo; Rec."Scheme No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(FirstName; Rec."First Name")
                {
                    ApplicationArea = Basic;
                }
                field(LastName; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                }
                field(SchemeJoinDate; Rec."Scheme Join Date")
                {
                    ApplicationArea = Basic;
                }
                field(CummAmountSpent; Rec."Cumm.Amount Spent")
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

