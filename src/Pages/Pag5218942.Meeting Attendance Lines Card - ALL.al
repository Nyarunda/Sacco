namespace CentralDB.CentralDB;

page 50744 "Meeting Attendance Lines Card"
{
    ApplicationArea = All;
    Caption = 'Capture Meeting Attendance Member Card';
    PageType = Card;
    DeleteAllowed = false;
    SourceTable = "Meeting Attendance Lines";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Header No."; Rec."Header No.")
                {
                    ToolTip = 'Specifies the value of the Header No. field.', Comment = '%';
                    trigger OnValidate()
                    var
                        MHeader: Record "Meeting Attendance Header";
                    begin

                    end;
                }
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                }
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the ID No. field.', Comment = '%';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ToolTip = 'Specifies the value of the Mobile Phone No. field.', Comment = '%';
                }
                field("Regstration Date"; Rec."Regstration Date")
                {
                    ToolTip = 'Specifies the value of the Regstration Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                    Editable = false;
                }
                field(Reason; Rec.Reason)
                {
                    ToolTip = 'Specifies the value of the Reason field.', Comment = '%';
                }
                field("FOSA Account"; Rec."FOSA Account")
                {
                    ToolTip = 'Specifies the value of the FOSA Account field.', Comment = '%';
                }
                field("Date Attended."; Rec."Date Attended.")
                {
                    ToolTip = 'Specifies the value of the Date Attended field.', Comment = '%';
                }
                field(Attended; Rec.Attended)
                {
                    ToolTip = 'Specifies the value of the Attended field.', Comment = '%';
                    Editable = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec.Attended then
                            CurrPage.Editable := false;
                    end;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ToolTip = 'Specifies the value of the Captured By field.', Comment = '%';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action("Mark As Addimitted")
            {
                ApplicationArea = All;
                Caption = 'Mark As Addimitted', comment = 'NLB="YourLanguageCaption"';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                begin

                    Rec.testfield(Attended, false);

                    SaccoSetup.Get();
                    Members.Get(Rec."Member No");
                    Rec.Attended := true;

                    Msg := 'Dear ' + Sky.FirstName(Members.Name) + ',' + SaccoSetup."AGM Msg" + '.';
                    MemberActivities.SendSms(Smssource::AGM, Members."Mobile Phone No.", Msg, Members."No.", Members."No.", false, false);
                    Commit;
                    Rec.Modify();

                    Message('Complete');

                    CurrPage.Close();
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Rec.Attended then
            CurrPage.Editable := false;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if Rec.Attended then
            CurrPage.Editable := false;
    end;

    var
        SaccoSetup: Record "Sacco Setup";
        Sky: Codeunit "Sky MBanking";
        Members: Record Members;
        MemberActivities: Codeunit "Member Activities";
        Msg: Text;
        SMSSource: Enum "SMS Source Enum";
        Text000: Label 'Meeting %1 has been completed, choose a different one!!!';
}

