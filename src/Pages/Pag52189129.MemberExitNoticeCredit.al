namespace UnitedWomen.UnitedWomen;

page 50831 "Member Exit Notice - Credit"
{
    Caption = 'Member Withdrawal Notice';
    ApplicationArea = Basic;
    CardPageID = "Member Exit Notice Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Member Exit Notice";
    SourceTableView = where("Notice Stage" = filter("Credit Department 1"));
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
        myInt: Integer;
    begin
        //SetRange("Entered By", UserId);
    end;

}
