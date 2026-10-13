Page 50465 "File Movement Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "File Movement";

    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PageEdit;
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(CurrentLocation; Rec."Current Location")
                {
                    ApplicationArea = Basic;

                }
                field(CurrentName; Rec."Current Name")
                {
                    ApplicationArea = Basic;
                }
                field(CurrentUser; Rec."Current User")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(RequestLocation; Rec."Request Location")
                {
                    ApplicationArea = Basic;
                }
                field(RequestLocationName; Rec."Request Location Name")
                {
                    ApplicationArea = Basic;
                }
                field(RequestedBy; Rec."Requested By")
                {
                    ApplicationArea = Basic;
                }

                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = Basic;
                }
                field(MovementDate; Rec."Movement Date")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Delay"; Rec."Reason For Delay")
                {
                    ApplicationArea = Basic;
                }
            }

            part(Control18; "File Management Lines")
            {
                SubPageLink = "Header No." = field("No."), "Current Location" = field("Current Location");
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Rec.Status = Rec.Status::"File Received" then
            pageEdit := false
        else
            PageEdit := true;



        if Rec."Entry Type" = Rec."Entry Type"::"File Request" then
            RequestBool := true
        else
            RequestBool := false;

    end;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        UserGroupMember: Record "User Group Members";
    begin
       begin
        Rec."Entry Type" := Rec."Entry Type"::"File Issue";

        if Rec."Entry Type" = Rec."entry type"::"File Issue" then begin
            UserGroupMember.Reset;
            //UserGroupMember.SetRange(Type, UserGroupMember.Type::"File Movement");
            UserGroupMember.SetRange("User Name", UserId);
            UserGroupMember.SetRange("Company Name", CompanyName);
            if UserGroupMember.FindFirst then begin
                UserGroupMember.calcfields("User Group Name");
                UserGroupMember.calcfields("User Name");
                Rec."Current Location" := UserGroupMember."User Group Code";
                Rec."Current Name" := UserGroupMember."User Group Name";
                Rec."Current User" := UserGroupMember."User Name";
                //GetLines();
            end
            else
                Error('You have not been attached to any department');
        end;
    end;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin

        if Rec.Status = Rec.Status::"File Received" then
            pageEdit := false
        else
            PageEdit := true;


        if Rec."Entry Type" = Rec."Entry Type"::"File Request" then
            RequestBool := true
        else
            RequestBool := false;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        IssueBool := false;
        TransferBool := false;

        if Rec.Status = Rec.Status::"File Received" then
            pageEdit := false
        else
            PageEdit := true;



        if Rec."Entry Type" = Rec."Entry Type"::"File Request" then
            RequestBool := true
        else
            RequestBool := false;

    end;

    var
        PageEdit: Boolean;
        RequestBool: Boolean;
        IssueBool: Boolean;
        TransferBool: Boolean;


    procedure GetLines()
    var
        Logs: Record "File Movement Log";
        Lines: Record "File Management Lines";
    begin
        Lines.Reset();
        Lines.SetRange("Header No.", Rec."No.");
        if Lines.FindFirst() then begin
            if not Confirm('Are you sure you want to suggest lines? Existing Lines will be deleted') then
                Error('Aborted');
            Lines.DeleteAll();

        end;


        Logs.Reset();
        Logs.SetRange("Current Location", Rec."Current Location");
        Logs.SetFilter("Member No.", '<>%1', '');
        if Logs.FindFirst() then begin
            repeat
                Lines.Init();
                Lines."Header No." := Rec."No.";
                Lines."Current Location" := Rec."Current Location";
                Lines."Member No." := Logs."Member No.";
                Lines."Member Name" := Logs."Member Name";
                Lines.Insert();
            until Logs.Next() = 0;
        end;

    end;

}

