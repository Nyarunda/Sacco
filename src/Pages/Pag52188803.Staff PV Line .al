
Page 50485 "Staff PV Line"
{
    PageType = ListPart;
    SourceTable = "Document Line";
    AutoSplitKey = true;

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
                field("Member-No."; Rec."Board MNo")
                {
                    Caption = 'Staff MNo';
                    ApplicationArea = Basic;
                    //LookupPageId = "Member Listing";

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Members: Record Members;
                    begin

                        Rec."Board MNo" := '';
                        Members.Reset();
                        Members.SetRange("Member Category", Members."Member Category"::"Staff Members");
                        if Page.RunModal(Page::"Member Listing", Members) = Action::LookupOK then
                            Rec."Board MNo" := Members."No.";


                        Rec.Validate("Board MNo");
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Expense GL"; Rec."Expense GL")
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
                field("KRA PIN No."; Rec."KRA PIN No.")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(TaxableAmount; Rec."Taxable Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TaxAmount; Rec."Tax Amount")
                {
                    ApplicationArea = Basic;
                }
                field(WithholdingTax; Rec."Withholding Tax")
                {
                    ApplicationArea = Basic;
                    Caption = 'P.A.Y.E';
                }
                field(VATAmount; Rec."VAT Amount")
                {
                    ApplicationArea = Basic;
                }
                field(WithholdingVAT; Rec."Withholding VAT")
                {
                    ApplicationArea = Basic;
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

