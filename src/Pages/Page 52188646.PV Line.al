
Page 50309 "PV Line"
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
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec.Validate("Account Type");
                    end;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        UpdateControls();
                    end;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Listing";
                    Editable = Rec."Account Type" = Rec."Account Type"::Savings;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;


                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Members: Record Members;
                        Accounts: Record "Savings Accounts";
                        Customer: Record Customer;
                        Vendor: Record "Savings Accounts";
                        Vend: Record Vendor;
                        GLAcc: Record "G/L Account";
                        Bank: Record "Bank Account";
                    begin

                        if Rec."Account Type" = Rec."Account Type"::"G/L Account" then begin
                            Rec."Account No." := '';
                            GLAcc.Reset();
                            if Page.RunModal(Page::"Chart of Accounts", GLAcc) = Action::LookupOK then
                                Rec."Account No." := GLAcc."No.";
                        end
                        else
                            if Rec."Account Type" = Rec."Account Type"::Customer then begin
                                Rec."Account No." := '';

                                Customer.Reset();
                                if Rec.Type <> ' ' THEN
                                    Customer.SetFilter(Type, Rec.Type);
                                if Customer.FindFirst() then
                                    if Page.RunModal(33, Customer) = Action::LookupOK then
                                        Rec."Account No." := Customer."No.";
                            end
                            else
                                if Rec."Account Type" = Rec."Account Type"::Vendor then begin
                                    Rec."Account No." := '';
                                    Vend.Reset();
                                    if Page.RunModal(Page::"Vendor List", Vend) = Action::LookupOK then begin
                                        Rec."Account No." := Vend."No.";
                                        Rec."KRA PIN No." := Vend."KRA Pin No.";
                                        Rec.Validate("Account No.", Vend."No.");
                                    end;
                                end
                                else
                                    if Rec."Account Type" = Rec."Account Type"::"Bank Account" then begin
                                        Rec."Account No." := '';
                                        Bank.Reset();
                                        //if Page.RunModal(Page::"Bank Account List", Vendor) = Action::LookupOK then
                                        if Page.RunModal(Page::"Bank Account List", Bank) = Action::LookupOK then
                                            Rec."Account No." := Bank."No.";
                                    end

                                    else
                                        if Rec."Account Type" = Rec."Account Type"::Savings then begin

                                            Rec."Account No." := '';
                                            Accounts.Reset();
                                            if Rec."Member No." <> '' then
                                                Accounts.SetRange("Member No.", Rec."Member No.");
                                            if Page.RunModal(Page::"Member Accounts List", Accounts) = Action::LookupOK then
                                                Rec."Account No." := Accounts."No.";

                                            UpdateControls();

                                        end
                                        else
                                            if Rec."Account Type" = Rec."Account Type"::Credit then begin
                                                Members.Reset();
                                                if Rec."Member No." <> '' then
                                                    Members.SetRange("No.", Rec."Member No.");
                                                if Page.RunModal(Page::"Member Listing", Members) = Action::LookupOK then
                                                    Rec."Account No." := Members."No.";
                                            end;
                        Rec.Validate("Account No.");
                    end;

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
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    Caption = 'Withholding Tax 3%';
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("VAT Tax Code"; Rec."VAT Tax Code")
                {
                    Caption = 'Withholding VAT 2%';
                    ApplicationArea = Basic;
                }
                field("Withholding Tax 5%"; Rec."Withholding Tax 5%")
                {
                    Caption = 'Withholding Tax 5%';
                    applicationArea = Basic;
                }
                field(TaxAmount; Rec."Tax Amount")
                {
                    ApplicationArea = Basic;
                }
                field(WithholdingTax; Rec."Withholding Tax")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax 5% Amt"; Rec."Withholding Tax 5% Amt")
                {
                    ApplicationArea = Basic;
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
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank No"; Rec."Bank No")
                {
                    ApplicationArea = Basic;
                }
                field("Payee Bank Name"; Rec."Payee Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Transaction Code"; Rec."Bank Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Member Exit No."; Rec."Member Exit No.")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Activity Code';
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch Code';
                }
                field("Purchase Invoice No"; Rec."Purchase Invoice No")
                {
                    ApplicationArea = Basic;
                    visible = false;
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
            }
        }
    }


    actions
    {
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        UpdateControls();
    end;

    local procedure UpdateControls()
    var
        myInt: Integer;
    begin

    end;

    var
        EditMembNo: Boolean;
}
