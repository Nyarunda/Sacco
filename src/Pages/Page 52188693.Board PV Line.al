
Page 50356 "Board PV Line"
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
                field("Board/Staff MNo"; Rec."Board MNo")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Listing";

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Members: Record Members;
                    begin

                        Rec."Board MNo" := '';
                        Members.Reset();
                        Members.SetRange("Member Category", Members."Member Category"::"Board Members");
                        if Page.RunModal(Page::"Member Listing", Members) = Action::LookupOK then
                            Rec."Board MNo" := Members."No.";
                        Rec."KRA PIN No." := Members."KRA PIN";


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
                field("Transaction No.";Rec."Transaction No.")
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
                    Caption = 'P.A.Y.E';
                    ApplicationArea = Basic;
                }

                field(WithholdingVAT; Rec."Withholding VAT")
                {
                    ApplicationArea = Basic;
                }
                field("Housing Levy"; Rec."Housing Levy")
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

