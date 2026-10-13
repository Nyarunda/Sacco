
Page 50357 "Petty Cash Line"
{
    PageType = ListPart;
    SourceTable = "Document Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Payment & Receipt Types" where(Type = filter(Payment));
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Listing";
                    Visible = false;

                }
                field("KRA PIN No."; Rec."KRA PIN No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec."Net Amount" := Rec.Amount;
                    end;
                }
                field(TaxableAmount; Rec."Taxable Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(TaxAmount; Rec."Tax Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(WithholdingTax; Rec."Withholding Tax")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(VATAmount; Rec."VAT Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

                field(WithholdingVAT; Rec."Withholding VAT")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(NetAmount; Rec."Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field(AppliestoDocType; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = Basic;
                }
                field(AppliestoDocNo; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = Basic;
                }
                field(AppliestoID; Rec."Applies-to ID")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                    Visible=false;
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
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

