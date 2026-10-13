
Page 50147 "Teller Transactions - Posted"
{
    ApplicationArea = Basic;
    CardPageID = "Teller Transaction Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Teller Transaction";
    SourceTableView = where(Posted = const(true));
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TransactionNo; Rec."Transaction No.")
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
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionDate; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
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
            action("Clear Lien")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Clear this Lien?') then begin
                        Rec.TestField(Type, Rec.Type::Lien);
                        Rec."Cheque Status" := Rec."cheque status"::Honoured;
                        Rec.Modify;
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    Var
        UserSetup: Record "User Setup";
    begin
        Rec.SetRange(Cashier, UserId);

        UserSetup.Get(UserId);
        if not UserSetup.Teller then
            Error('You do not have any permissions for teller to access this report. Contact the administrator!');
    end;
}

