Page 50965 "HR Employee Transfer List Effe"
{
    CardPageID = "HR Employee Transfer Card Effe";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Employee Transfer Header";
    SourceTableView = where("Transfer details Updated" = const(true));

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
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    StyleExpr = true;
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

