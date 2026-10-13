Page 50936 "HR OSSafety Rules"
{
    CardPageID = "HR OSSafety Rules Card";
    PageType = List;
    SourceTable = "HR OSSafety Rules";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SafetyNo; Rec."Safety No")
                {
                    ApplicationArea = Basic;
                }
                field(SafetyRules; Rec."Safety Rules")
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

