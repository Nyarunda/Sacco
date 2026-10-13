Page 50162 "Sky Mobile Loans"
{
    ApplicationArea = Basic;
    /* DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false; */
    PageType = List;
    SourceTable = "Sky Mobile Loans";
    SourceTableView = where("Mobile Loan" = const(Yes));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Channel; Rec.Channel)
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(StaffNo; Rec."Staff No")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(RequestedAmount; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(LoanPeriod; Rec."Loan Period")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo; Rec.DocumentNo)
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedAmount; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field(LoanProductType; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(SessionID; Rec."Session ID")
                {
                    ApplicationArea = Basic;
                }
                field(DateEntered; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field(TimeEntered; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field(TelephoneNo; Rec."Telephone No")
                {
                    ApplicationArea = Basic;
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = Basic;
                }
                field(Control25; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(Deactivated; Rec.Deactivated)
                {
                    ApplicationArea = Basic;
                }
                field(DeactivatedBy; Rec."Deactivated By")
                {
                    ApplicationArea = Basic;
                }
                field(DateDeactivated; Rec."Date Deactivated")
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
            action("Activate/Deactivate Application")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    Rec.TestField(Posted, false);
                    if Rec.Deactivated then begin
                        if Confirm('Are you sure you want to deactivate this application') then begin
                            Rec.Deactivated := false;
                            Rec."Deactivated By" := UserId;
                            Rec."Date Deactivated" := Today;
                            Rec.Status := Rec.Status::Pending;
                            Rec.Modify;
                        end;
                    end
                    else begin
                        if Confirm('Are you sure you want to activate this application') then begin
                            Rec.Deactivated := true;
                            Rec."Deactivated By" := UserId;
                            Rec."Date Deactivated" := Today;
                            Rec.Status := Rec.Status::Failed;
                            Rec.Modify;
                        end;
                    end;
                end;
            }
            action("Refresh Qualifying Amount")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to Recalculate Qualifying Shares?') then begin
                        Members.Reset;
                        Members.SetRange(Members."No.", Rec."Member No.");
                        if Members.FindFirst then begin
                            Report.Run(2000002, false, true, Members);
                            Message('Process Completed');
                        end;
                    end;
                end;
            }


            action("Post Mobile")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    StatusChangePermissions: Record "Sky Permissions";
                    Sky: COdeunit "SpotCash Mbanking";
                    SkyMBanking: Codeunit "Sky MBanking";
                    Stop: Boolean;
                begin
                    StatusChangePermissions.Reset;
                    StatusChangePermissions.SetRange("User ID", UserId);
                    StatusChangePermissions.SetRange("Update Paybill Transaction", true);
                    if not StatusChangePermissions.FindFirst then
                        Error('You do not have the following permission: "Update Paybill Transaction"');

                    Rec.TestField(Posted, false);
                    if Confirm('Are you sure you want to post this transaction?') then begin
                        SkyMBanking.ProcessMobileLoan(Rec."Entry No", stop);
                    end;
                end;
            }

        }
    }

    var
        Members: Record Members;
}

