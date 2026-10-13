Page 50378 "File Movement Card - To Rec."
{
    ApplicationArea = All;
    PageType = Card;
    DeleteAllowed = false;
    SourceTable = "File Movement";
    PromotedActionCategories = 'New,Process,Report,Return';

    layout
    {
        area(content)
        {
            group(General)
            {
                //Editable = PageEdit;
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
                field(Deceased; Rec.Deceased)
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
        area(processing)
        {
            action(Receive)
            {
                ApplicationArea = Basic;
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Log: Record "File Movement Log";
                    UserSetup: Record "User Setup";
                    FLines: Record "File Management Lines";
                begin

                    if Confirm('Are you sure you want to Receive this batch?') then begin
                        UserSetup.Get(UserId);
                        if Rec."Current User" = Rec."Requested By" then
                            Error('Invalid Locations Selected');

                        if not UserSetup."File Movement Admin" then
                            Rec.TestField("Requested By", UserId)
                        else begin
                            if Rec."Requested By" <> UserId then
                                if not Confirm('You are not the Assigned User for this Action. Do you want to proceed with the Issue?') then
                                    Error('Aborted');
                        end;


                        Rec.TestField(Status, Rec.Status::"To Be Received");

                        Rec.Status := Rec.Status::"File Received";
                        Rec."Date Received" := Today;
                        Rec.Modify;
                        SaccoSetup.Get();

                        FLines.Reset();
                        FLines.setrange("Header No.", Rec."No.");
                        FLines.SetRange(Issued, true);
                        FLines.SetRange(Received, true);
                        if FLines.FindFirst() then begin
                            repeat

                                Log.Init();
                                Log."Line No." := 0;
                                Log."Member No." := FLines."Member No.";
                                Log."Member Name" := FLines."Member Name";
                                Log."Source Location" := Rec."Current Location";
                                Log."Source Name" := Rec."Current Name";
                                Log."Source User" := Rec."Current User";
                                Log."Current Location" := Rec."Request Location";
                                Log."Current Name" := Rec."Request Location Name";
                                Log."Current User" := Rec."Requested By";
                                Log."Movement Date" := Rec."Movement Date";
                                Log."File Movement Reference" := Rec."No.";
                                Log."Entry Type" := Rec."Entry Type";
                                Log.Deceased := Rec.Deceased;
                                Log."Expected Return Date" := CalcDate(SaccoSetup."File Keeping Period", Today);
                                if Rec."Request Location" = 'FM_REGISTRY' then begin
                                    Log."Date Returned" := Today;
                                    //Log.Returned := true;
                                end;

                                Log.Insert();


                            until FLines.Next() = 0;
                        end
                        else
                            Error('No File Marked to be Received');


                        Message('Received');
                        //CurrPage.Close();
                    end;
                end;
            }

        }
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
#pragma warning disable AL0432
        UserGroupMember: Record "Security Group Member Buffer";
    begin
        Rec."Entry Type" := Rec."Entry Type"::"File Issue";

        if Rec."Entry Type" = Rec."entry type"::"File Issue" then begin
            UserGroupMember.Reset;
            // UserGroupMember.SetRange(Type, UserGroupMember.Type::"File Movement");
            UserGroupMember.SetRange("User Name", UserId);
            //UserGroupMember.SetRange("Company Name", CompanyName);
            if UserGroupMember.FindFirst then begin
                //UserGroupMember.calcfields("User Group Name");
                UserGroupMember.calcfields("User Name");
                //Rec."Current Location" := UserGroupMember."User Group Code"; //ezra
                // Rec."Current Name" := UserGroupMember."User Group Name";
                Rec."Current User" := UserGroupMember."User Name";
                //GetLines();
            end
            else
                Error('You have not been attached to any department');
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
        SaccoSetup: Record "Sacco Setup";


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

