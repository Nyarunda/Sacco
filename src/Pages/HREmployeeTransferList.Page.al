Page 50963 "HR Employee Transfer List"
{
    CardPageID = "HR Employee Transfer Card";
    Editable = false;
    InsertAllowed=false;
    DeleteAllowed=false;
    PageType = List;
    SourceTable = "HR Employee Transfer Header";
    SourceTableView = where("Transfer details Updated" = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(RequestNo; Rec."Request No")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(DateRequested; Rec."Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field(TransferdetailsUpdated; Rec."Transfer details Updated")
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

