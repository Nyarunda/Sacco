
/// <summary>
/// Page Account Transfer Source (ID 50239).
/// </summary>
Page 50239 "Account Transfer Source"
{
    PageType = ListPart;
    SourceTable = "Source Account Transfer";

    layout
    {
        area(content)
        {
            repeater(Control13)
            {
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Listing";
                }
                field(AccountType; Rec."Source Account Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Type';
                }
                field(LoanNo; Rec."Source Loan No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan No.';
                    Enabled = Rec."Source Account Type" = Rec."Source Account Type"::Credit;
                }
                field(AccountNo; Rec."Source Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account No.';
                    Enabled = Rec."Source Account Type" <> Rec."Source Account Type"::Credit;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Members: Record Members;
                        Accounts: Record "Savings Accounts";
                        Customer: Record Customer;
                        Vendor: Record "Savings Accounts";
                        GLAcc: Record "G/L Account";
                        CAccount: Record "Credit Accounts";
                        Bank: Record "Bank Account";
                    begin
                        if Rec."Source Account Type" = Rec."Source Account Type"::"G/L Account" then begin
                            Rec."Source Account No." := '';
                            GLAcc.Reset();
                            if Page.RunModal(Page::"Chart of Accounts", GLAcc) = Action::LookupOK then
                                Rec."Source Account No." := GLAcc."No.";
                        end
                        else
                            if Rec."Source Account Type" = Rec."Source Account Type"::Customer then begin
                                Rec."Source Account No." := '';
                                Customer.Reset();
                                if Page.RunModal(Page::"Customer Listing", Customer) = Action::LookupOK then
                                    Rec."Source Account No." := Customer."No.";
                            end
                            else
                                if Rec."Source Account Type" = Rec."Source Account Type"::Vendor then begin
                                    Rec."Source Account No." := '';
                                    Vendor.Reset();
                                    if Page.RunModal(Page::"Vendor List", Vendor) = Action::LookupOK then
                                        Rec."Source Account No." := Vendor."No.";
                                end
                                else
                                    if Rec."Source Account Type" = Rec."Source Account Type"::"Bank Account" then begin
                                        Rec."Source Account No." := '';
                                        Bank.Reset();
                                        if Page.RunModal(Page::"Bank Account List", Bank) = Action::LookupOK then
                                            Rec."Source Account No." := Bank."No.";
                                    end

                                    else
                                        if Rec."Source Account Type" = Rec."Source Account Type"::Savings then begin

                                            Rec."Source Account No." := '';
                                            Accounts.Reset();
                                            if Rec."Member No." <> '' then
                                                Accounts.SetRange("Member No.", Rec."Member No.");
                                            if Page.RunModal(Page::"Member Accounts List", Accounts) = Action::LookupOK then
                                                Rec."Source Account No." := Accounts."No.";
                                        end
                                        else
                                            if Rec."Source Account Type" = Rec."Source Account Type"::Credit then begin
                                                CAccount.Reset();
                                                CAccount.SetRange("Member No.", Rec."Member No.");
                                                if Page.RunModal(Page::"Credit Accounts List", CAccount) = Action::LookupOK then
                                                    Rec."Source Account No." := CAccount."No.";
                                            end;

                        Rec.Validate("Source Account No.");
                    end;

                }

                field(ProductName; Rec."Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec."Description")
                {
                    ApplicationArea = Basic;
                }
                field(ExternalDocumentNo; Rec."External Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountName; Rec."Source Account Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Name';
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field(AvailableBalance; Rec."Available Balance")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Source Transaction Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction Type';
                }

                field(SourceAmount; Rec."Source Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Debit  Amount';
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ApplicationArea = Basic;
                    // Caption = 'Principle Amount';
                }
                field("Principle Amount"; Rec."Principle Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Arrears Amount"; Rec."Arrears Amount")
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

