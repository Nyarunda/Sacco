
Page 50196 "CheckOff List"
{
    ApplicationArea = Basic;
    CardPageID = "CheckOff Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Monthly Checkoff Header";
    SourceTableView = where(Posted = const(false));
    UsageCategory = History;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(NoSeries; Rec."No. Series")
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
                field(EnteredBy; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(CHKLineAmount; Rec."CHK Line Amount")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerCode; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerName; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                }
                field(TotalCount; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("Entered By", UserId);
    end;
}

