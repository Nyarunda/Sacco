Page 50970 "HR Effected Asset Transfer"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "HR Asset Transfer Header";
    SourceTableView = where(Status = const(Approved),
                            Transfered = const(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentDate; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Raisedby; Rec."Raised by")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CurrentHolder; Rec."Current Holder")
                {
                    ApplicationArea = Basic;
                }
                field(CurrentHolderName; Rec."Current Holder Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AssettoTransfer; Rec."Asset to Transfer")
                {
                    ApplicationArea = Basic;
                }
                field(AssetDescription; Rec."Asset Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SerialNo; Rec."Serial No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NewHolder; Rec."New Holder")
                {
                    ApplicationArea = Basic;
                }
                field(NewHolderName; Rec."New Holder Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Transfered; Rec.Transfered)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateTransfered; Rec."Date Transfered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TransferedBy; Rec."Transfered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TimeTransferred; Rec."Time Transferred")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control16; Links)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Jobs,"Employee Req",Employees,Promotion,Confirmation,"Employee Transfer","Asset Transfer","Transport Req",Overtime,"Training App","Leave App";
                begin

                    DocumentType := Documenttype::"Asset Transfer";
                    //ApprovalEntries.Setfilters(Database::"HR Asset Transfer Header",DocumentType,"No.");
                    //ApprovalEntries.Run;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Updatecontrol;
    end;

    trigger OnAfterGetRecord()
    begin
        Updatecontrol;
    end;

    trigger OnInit()
    begin
        Edit := true;
        Line := true;
    end;

    var
        //RecHeader: Record UnknownRecord39003971;
        //ApprovalEntries: Page "Approval Entries";
        Edit: Boolean;
        Line: Boolean;


    procedure Updatecontrol()
    begin
        /*
        IF Status=Status::Open THEN BEGIN
        Edit:=TRUE;
        Line:=TRUE;
        END ELSE IF Status=Status::"Pending Approval" THEN BEGIN
        Edit:=FALSE;
        Line:=FALSE;
        END ELSE IF Status=Status::Approved THEN BEGIN
        Edit:=FALSE;
        Line:=FALSE;
        END
         */

    end;
}

