
PageExtension 50095 pageextension50095 extends "Requests to Approve"
{
    layout
    {
        modify(Details)
        {
            Visible = false;
        }
        modify(ToApprove)
        {
            Visible = false;
        }
        addfirst(Control1)
        {

            field("Document Type"; Rec."Custom Document Type")
            {
                ApplicationArea = Basic;
            }
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = Basic;
            }
            field("Tracker ID"; Rec."Tracker ID")
            {
                ApplicationArea = Basic;
            }
            field(Name; Rec.Name)
            {
                ApplicationArea = Basic;
            }
            field(Name2; Rec.Name2)
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Due Date")
        {
        }
    }


    /*
    actions
    {
        // Adding a new action group 'MyNewActionGroup' in the 'Creation' area

        addlast(Creation)
        {
            group(MyNewActionGroup)
            {
                action(OpenDocument)
                {
                    Caption = 'Open Document';

                    trigger OnAction();
                    var
                        PageMan: Codeunit "Page Management";
                        PageID: Integer;

                    begin
                        PageID := 0;

                       //// IF PageID = 0 THEN
                           // PageID := PageMan.GetDefaultCardPageID(ApprovalTracker."Table ID");


                        ////IF PageID = 0 THEN
                            //PageID := PageMan.GetDefaultLookupPageID(ApprovalTracker."Table ID");

                    end;
                }
            }
        }
    }
    */


    var
        UserGroup: Record "Workflow User Group";
        UserSetup: Record "User Setup";
        UserGroupMember: Record "Workflow User Group Member";
        Approver: Code[200];


    //Unsupported feature: Code Modification on "OnOpenPage".


    trigger OnOpenPage()
    var
        CustomApprover: Code[200];
        WUserGroup: Record "Workflow User Group";
        WUserGroupMember: Record "Workflow User Group Member";
    begin

        CustomApprover := UserId;
        WUserGroupMember.Reset();
        WUserGroupMember.SetRange("User Name", UserId);
        if WUserGroupMember.FindSet() then
            repeat
                CustomApprover += '|' + WUserGroupMember."Workflow User Group Code";
            until WUserGroupMember.Next() = 0;


        Rec.FilterGroup(2);
        Rec.Setfilter("Approver ID", CustomApprover);

        Rec.FilterGroup(0);
        Rec.SetRange(Status, Rec.Status::Open);
    end;


}

