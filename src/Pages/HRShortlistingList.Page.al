Page 50914 "HR Shortlisting List"
{
    ApplicationArea = All;
    CardPageID = "HR Shortlisting Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Employee Requisitions";
    SourceTableView = where("Approval Status" = const(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Overdue; Overdue)
                {
                    ApplicationArea = Basic;
                    Caption = 'Overdue';
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(RequisitionNo; Rec."Requisition No.")
                {
                    ApplicationArea = Basic;
                }
                field(RequisitionDate; Rec."Requisition Date")
                {
                    ApplicationArea = Basic;
                }
                field(JobID; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                }
                field(JobDescription; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                }
                field(RequiredPositions; Rec."Required Positions")
                {
                    ApplicationArea = Basic;
                }
                field(NoofJobApplications; Rec."No. of Job Applications")
                {
                    ApplicationArea = Basic;
                }
                field(ClosingDate; Rec."Closing Date")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovalStatus; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(CompletionStatus; Rec."Completion Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755005; Outlook)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."Closing Date" <= Today then begin
            Overdue := Overdue::Yes;
        end else begin
            Overdue := Overdue::" ";
        end;
    end;

    var
        Overdue: Option " ",Yes;
        RecordIDText: Text;
}

