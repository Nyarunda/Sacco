namespace CentralDB.CentralDB;

page 50673 "Board Committee Card"
{
    ApplicationArea = All;
    Caption = 'Board Committee Card';
    PageType = Card;
    SourceTable = "Board Committees";


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Approval Sequence"; Rec."Approval Sequence")
                {
                    ToolTip = 'Specifies the value of the Approval Sequence field.';
                }
            }
            part(BoardCommitteeLines; "Board Committee Members")
            {
                SubPageLink = Committee = field(COde);
            }
        }
    }
}
