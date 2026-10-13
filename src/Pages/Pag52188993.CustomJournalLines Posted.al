//namespace CentralDB.CentralDB;

//using Microsoft.Finance.GeneralLedger.Journal;

page 50717 "Posted Custom Journal Lines"
{
    ApplicationArea = All;
    Caption = 'Custom Journal Lines';
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Sacco Journal Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;

                    ToolTip = 'Specifies the entry''s posting date.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a document number for the journal line.';
                    ShowMandatory = true;
                }

                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a credit amount.';
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Suite;
                    LookupPageId = "Member Listing";
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                    end;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;

                    ToolTip = 'Specifies the account number that the entry on the journal line will be posted to.';

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;

                    ToolTip = 'Specifies a description of the entry.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Loan No."; Rec."Loan No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a debit amount.';
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a credit amount.';

                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                }


            }
        }
    }

}
