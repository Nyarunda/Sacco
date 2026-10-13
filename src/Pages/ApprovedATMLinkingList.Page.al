Page 50443 "Approved ATM Linking List"
{
    CardPageID = "Approved ATM Linking Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ATM Linking Applications";
    SourceTableView = where(Status = filter(Approved));

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
                field(ATMApplicationNo; Rec."ATM Application No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field(BranchCode; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field(CustomerID; Rec."Customer ID")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
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
            action("Mark as Charged")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    SLedger: Record "Savings Ledger Entry";
                begin

                    SLedger.Reset;
                    SLedger.SetRange("Document No.", Rec."ATM Application No.");
                    SLedger.SetRange("Account No.", Rec."Account No");
                    if SLedger.FindFirst then begin
                        if Confirm('Are you sure you want to mark as charged?') then begin
                            Rec."ATM Charges Applied" := true;
                            Rec.Modify;
                            Message('Marked As Charged');
                        end;
                    end
                    else
                        Error('Document not Charged');
                end;
            }
        }
    }
}

