
Page 50181 "Cheque Book Application List"
{
    CardPageID = "Cheque Application";
    DeleteAllowed = false;
    Editable = true;
    PageType = List;
    SourceTable = "Cheque Book Application_";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ChequeAccountNo; Rec."Cheque Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(StaffNo; Rec."Staff No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApplicationExported; Rec."Application Exported")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Select; Rec.Select)
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
            action("Export Applications")
            {
                ApplicationArea = Basic;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ChqAppl.Reset;
                    ChqAppl.SetRange(ChqAppl."Application Exported", false);
                    ChqAppl.SetRange(Select, true);
                    Xmlport.Run(39004249, true, false, ChqAppl);
                end;
            }
        }
    }

    var
        ChqAppl: Record "Cheque Book Application_";
}

