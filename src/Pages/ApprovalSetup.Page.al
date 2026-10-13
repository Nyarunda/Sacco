Page 50459 "Approval Setup"
{
    ApplicationArea = All;
    Caption = 'Approval Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Approval Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(DueDateFormula; Rec."Due Date Formula")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovalAdministrator; Rec."Approval Administrator")
                {
                    ApplicationArea = Basic;
                }
                field(RequestRejectionComment; Rec."Request Rejection Comment")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenterRequired; Rec."Responsibility Center Required")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Notification)
            {
                Caption = 'Notification';
                group(NotifyUserabout)
                {
                    Caption = 'Notify User about:';
                    field(Approvals; Rec.Approvals)
                    {
                        ApplicationArea = Basic;
                    }
                    field(Cancellations; Rec.Cancellations)
                    {
                        ApplicationArea = Basic;
                    }
                    field(Rejections; Rec.Rejections)
                    {
                        ApplicationArea = Basic;
                    }
                    field(Delegations; Rec.Delegations)
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(OverdueApprovals)
                {
                    Caption = 'Overdue Approvals';
                    field(LastRunDate; Rec."Last Run Date")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Overdue)
            {
                Caption = '&Overdue';
                Image = Overdue;
                action(SendOverdueMails)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Overdue Mails';
                    Image = OverdueMail;

                    trigger OnAction()
                    begin
                        if Confirm(StrSubstNo(Text004, Today), true) then begin
                            //ApprMgtNotification.LaunchCheck(Today);
                            Rec."Last Run Date" := Today;
                            Rec."Last Run Time" := Time;
                            Rec.Modify;
                            CurrPage.Update;
                        end;
                    end;
                }
                action(OverdueLogEntries)
                {
                    ApplicationArea = Basic;
                    Caption = 'Overdue Log Entries';
                    Image = OverdueEntries;
                    RunObject = Page "Overdue Approval Entries";
                }
            }
        }
        area(processing)
        {
            action(UserSetup)
            {
                ApplicationArea = Basic;
                Caption = '&User Setup';
                Image = UserSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Approval User Setup";
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get() then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;

    var
        TempBlob: Record CustomTempBlob;
        //ApprMgtNotification: Codeunit UnknownCodeunit440;
        FileMgt: Codeunit "File Management";
        OverdueTemplateExists: Boolean;
        Text002: label 'Do you want to replace the existing %1?';
        Text003: label 'Do you want to delete the template %1?';
        AppTemplateExists: Boolean;
        Text004: label 'Do you want to run the overdue check by the %1?';

    trigger OnInit()
    begin
        RestrictAccess
    end;


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange("Administration Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Administration Setups"');
    end;


}

