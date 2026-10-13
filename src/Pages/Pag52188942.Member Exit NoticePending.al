page 50644 "Member Exit Notice Pending"
{
    ApplicationArea = All;
    Caption = 'Member Exit Notice HOD Credit';
    CardPageID = "Member Exit Notice Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Member Exit Notice";
    SourceTableView = where(Status = const(Pending), "Notice Stage" = const("HOD Credit"));
    UsageCategory = Lists;

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
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(MaturityDate; Rec."Maturity Date")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Member Exit Stage"; Rec."Member Exit Stage")
                {
                    ApplicationArea = Basic;
                }
                field(Reasonforwithdrawal; Rec."Reason for withdrawal")
                {
                    ApplicationArea = Basic;
                }
                field(WithdrawaNoticelDate; Rec."Withdrawa Noticel Date")
                {
                    ApplicationArea = Basic;
                }
                field(EnteredBy; Rec."Entered By")
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
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Letter of Withdrawal"; Rec."Letter of Withdrawal")
                {

                }
                field("Guarantor Substituted"; Rec."Guarantor Substituted")
                {

                }
                field("Loans Offset"; Rec."Loans Offset")
                {

                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            exit;

        if not UserSetup."HOD Credit" then
            Error('You do not have permission to access HOD Credit approval.');
    end;

}

