Page 50359 "Portal Change Request"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Portal Change Request";
    PromotedActionCategories = 'New,Process,Report,Member,Rights';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CRID; Rec."CR ID")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Field"; Rec.Field)
                {
                    ApplicationArea = Basic;
                }
                field(CurrentValue; Rec."Current Value")
                {
                    ApplicationArea = Basic;
                }
                field(NewValue; Rec."New Value")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Processedby; Rec."Processed by")
                {
                    ApplicationArea = Basic;
                }
                field(DateProcessed; Rec."Date Processed")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Show Member Card")
            {
                ApplicationArea = Basic;
                Image = ChangeLog;
                Promoted = true;
                PromotedCategory = category4;

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."Member No.");
                    if Members.FindFirst then
                        Page.Run(50188, Members);
                end;
            }
            action("Mark As Processed")
            {
                ApplicationArea = Basic;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this as processed') then begin
                        Rec.Status := Rec.Status::Effected;
                        Rec."Processed by" := UserId;
                        Rec."Date Processed" := Today;
                        Rec.Modify;
                    end;
                end;
            }
            action("Reject ")
            {
                ApplicationArea = Basic;
                Image = "Reject";
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this as Rejected') then begin
                        Rec.Status := Rec.Status::Rejected;
                        Rec."Processed by" := UserId;
                        Rec."Date Processed" := Today;
                        Rec.Modify;

                    end;
                end;
            }
        }
    }

    var
        Members: Record Members;
}

