page 50898 "Contact Person App. Card"
{
    PageType = Card;
    SourceTable = "Contact Person Application";
    ApplicationArea = All;
    Caption = 'Contact Person Application';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.") { ApplicationArea = All; }
                field("Member No."; Rec."Member No.") { ApplicationArea = All; }
                field("Member Name"; Rec."Member Name") { ApplicationArea = All; }
                field("Contact Person Name"; Rec."Contact Person Name") { ApplicationArea = All; }
                field("Contact Person Relation"; Rec."Contact Person Relation") { ApplicationArea = All; }
                field("Contact Person Phone"; Rec."Contact Person Phone") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
                field("Application Date"; Rec."Application Date") { ApplicationArea = All; }
                field("Application Time"; Rec."Application Time") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Approve")
            {
                ApplicationArea = All;
                Caption = 'Approve';
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Approved;
                    Rec."Approved By" := UserId;
                    Rec."Approved Date" := Today();
                    Rec."Approved Time" := Time();
                    Rec.Modify(true);
                end;
            }
            action("Reject")
            {
                ApplicationArea = All;
                Caption = 'Reject';
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Rejected;
                    Rec."Rejected By" := UserId;
                    Rec."Rejected Date" := Today();
                    Rec."Rejected Time" := Time();
                    Rec.Modify(true);
                end;
            }
            action("Post Change")
            {
                ApplicationArea = All;
                Caption = 'Post Change';
                trigger OnAction()
                var
                    NextOfKin: Record "Next of Kin.";
                begin
                    // Update Next of Kin for the member
                    if Rec.Status = Rec.Status::Approved then begin
                        NextOfKin.Reset();
                        NextOfKin.SetRange("No.", Rec."Member No.");
                        if NextOfKin.FindFirst() then begin
                            NextOfKin.Name := Rec."Contact Person Name";
                            NextOfKin.Relationship := Rec."Contact Person Relation";
                            NextOfKin."Mobile Phone No." := Rec."Contact Person Phone";
                            NextOfKin.Modify(true);
                        end else begin
                            NextOfKin.Init();
                            NextOfKin."No." := Rec."Member No.";
                            NextOfKin.Name := Rec."Contact Person Name";
                            NextOfKin.Relationship := Rec."Contact Person Relation";
                            NextOfKin."Mobile Phone No." := Rec."Contact Person Phone";
                            NextOfKin.Insert(true);
                        end;
                        Message('Next of Kin updated for member %1.', Rec."Member No.");
                    end else
                        Error('Application must be approved before posting changes.');
                end;
            }
        }
    }
}
