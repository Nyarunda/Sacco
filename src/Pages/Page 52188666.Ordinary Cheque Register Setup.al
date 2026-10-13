
Page 50329 "Ordinary Cheque Register Setup"
{
    PageType = Card;
    SourceTable = "Ordinary Cheque Register";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(OrdinaryChequeNo; Rec."Ordinary Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(Issued; Rec.Issued)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(BranchCode; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
            }
            field(BankerCh; BankerCh)
            {
                ApplicationArea = Basic;
                Caption = 'Starting No.';
            }
            field(NoOfLeaves; NoOfLeaves)
            {
                ApplicationArea = Basic;
                Caption = 'No. of Leaves';
            }
            field(Control8; BranchCode)
            {
                ApplicationArea = Basic;
                Caption = 'Branch Code';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            }
            field(Source; Rec.Source)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Generate)
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to generate ordinary cheque No. ?', false) = false then
                        exit;

                    i := 0;

                    repeat
                        i := i + 1;

                        BankerR.Init;
                        BankerR."Ordinary Cheque No." := BankerCh;
                        BankerR."Branch Code" := BranchCode;
                        BankerR.Source := Rec.Source;
                        BankerR.Insert;

                        BankerCh := IncStr(BankerCh);
                    until i = NoOfLeaves;
                end;
            }
        }
    }

    var
        BankerCh: Code[20];
        NoOfLeaves: Integer;
        i: Integer;
        BankerR: Record "Ordinary Cheque Register";
        BranchCode: Code[20];
}

