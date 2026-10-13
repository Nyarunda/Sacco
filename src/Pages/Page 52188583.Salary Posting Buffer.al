
Page 50571 "Salary Posting Buffer"
{
    PageType = ListPart;
    SourceTable = "Salary Posting";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo; Rec."Document No.")
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec."Debit Amount" := 0;
                        Rec."Credit Amount" := 0;
                        if Rec.Amount > 0 then
                            Rec."Debit Amount" := Rec.Amount;
                        if Rec.Amount < 0 then
                            Rec."Credit Amount" := Rec.Amount * -1;
                    end;
                }
                field(DebitAmount; Rec."Debit Amount")
                {
                    ApplicationArea = Basic;
                }
                field(CreditAmount; Rec."Credit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Running Balance"; Rec."Running Balance")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(ProductTypeName; Rec."Product Type Name")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ExternalDocumentNo; Rec."External Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(BalAccountType; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(BalAccountNo; Rec."Bal. Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(LoanProduct; Rec."Loan Product")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

