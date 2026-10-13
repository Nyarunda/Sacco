page 50792 "Portal Documents Subpage"
{
    PageType = ListPart;
    SourceTable = "Portal Uploads";
    ApplicationArea = All;
    Caption = 'Uploaded Documents';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document type.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document name.';
                }
                field(Format; Rec.Format)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document format.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document status.';
                    StyleExpr = StatusStyle;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the upload date.';
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the upload time.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ViewDocument)
            {
                Caption = 'View Document';
                ApplicationArea = All;
                Image = View;
                ToolTip = 'View the uploaded document.';

                trigger OnAction()
                begin
                    if Rec."Blob Url" <> '' then
                        Hyperlink(Rec."Blob Url")
                    else
                        Message('No document URL available');
                end;
            }
            action(DownloadDocument)
            {
                Caption = 'Download Document';
                ApplicationArea = All;
                Image = Export;
                ToolTip = 'Download the document.';

                trigger OnAction()
                begin
                    if Rec."Blob Url" <> '' then
                        Hyperlink(Rec."Blob Url")
                    else
                        Message('No document URL available');
                end;
            }
            action(ApproveDocument)
            {
                Caption = 'Approve Document';
                ApplicationArea = All;
                Image = Approve;
                ToolTip = 'Approve this document.';
                Enabled = Rec.Status <> Rec.Status::Approved;

                trigger OnAction()
                begin
                    if Confirm('Do you want to approve this document?') then begin
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify(true);
                        CurrPage.Update();
                    end;
                end;
            }
            action(RejectDocument)
            {
                Caption = 'Reject Document';
                ApplicationArea = All;
                Image = Reject;
                ToolTip = 'Reject this document.';
                Enabled = Rec.Status <> Rec.Status::Rejected;

                trigger OnAction()
                begin
                    if Confirm('Do you want to reject this document?') then begin
                        Rec.Status := Rec.Status::Rejected;
                        Rec.Modify(true);
                        CurrPage.Update();
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStatusStyle();
    end;

    local procedure SetStatusStyle()
    begin
        case Rec.Status of
            Rec.Status::Approved:
                StatusStyle := 'Favorable';
            Rec.Status::Rejected:
                StatusStyle := 'Unfavorable';
            Rec.Status::Pending:
                StatusStyle := 'StandardAccent';
        end;
    end;

    var
        StatusStyle: Text;
}