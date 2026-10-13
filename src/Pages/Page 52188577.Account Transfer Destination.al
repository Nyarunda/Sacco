
Page 50240 "Account Transfer Destination"
{
    PageType = ListPart;
    SourceTable = "Destination Account Transfers";

    layout
    {
        area(content)
        {
            repeater(Control10)
            {
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Listing";
                }
                field(AccountType; Rec."Destination Account Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Type';
                }
                field(LoanNo; Rec."Destination Loan No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan No.';
                    Enabled = Rec."Destination Account Type" = Rec."Destination Account Type"::Credit;
                }
                field(AccountNo; Rec."Destination Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account No.';


                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Members: Record Members;
                        Accounts: Record "Savings Accounts";
                        Customer: Record Customer;
                        Vendor: Record "Savings Accounts";
                        CAccount: Record "Credit Accounts";
                        GLAcc: Record "G/L Account";
                        Bank: Record "Bank Account";
                    begin
                        if Rec."Destination Account Type" = Rec."Destination Account Type"::"G/L Account" then begin
                            Rec."Destination Account No." := '';
                            GLAcc.Reset();
                            if Page.RunModal(Page::"Chart of Accounts", GLAcc) = Action::LookupOK then
                                Rec."Destination Account No." := GLAcc."No.";
                        end
                        else
                            if Rec."Destination Account Type" = Rec."Destination Account Type"::Customer then begin
                                Rec."Destination Account No." := '';
                                Customer.Reset();
                                if Page.RunModal(Page::"Customer Listing", Customer) = Action::LookupOK then
                                    Rec."Destination Account No." := Customer."No.";
                            end
                            else
                                if Rec."Destination Account Type" = Rec."Destination Account Type"::Vendor then begin
                                    Rec."Destination Account No." := '';
                                    Vendor.Reset();
                                    if Page.RunModal(Page::"Vendor List", Vendor) = Action::LookupOK then
                                        Rec."Destination Account No." := Vendor."No.";
                                end
                                else
                                    if Rec."Destination Account Type" = Rec."Destination Account Type"::"Bank Account" then begin
                                        Rec."Destination Account No." := '';
                                        Bank.Reset();
                                        if Page.RunModal(Page::"Bank Account List", Bank) = Action::LookupOK then
                                            Rec."Destination Account No." := Bank."No.";
                                    end

                                    else
                                        if Rec."Destination Account Type" = Rec."Destination Account Type"::Savings then begin

                                            Rec."Destination Account No." := '';
                                            Accounts.Reset();
                                            Accounts.SetRange("Member No.", Rec."Member No.");
                                            if Rec."Member No." <> '' then
                                                Accounts.SetRange("Member No.", Rec."Member No.");
                                            if Page.RunModal(Page::"Member Accounts List", Accounts) = Action::LookupOK then
                                                Rec."Destination Account No." := Accounts."No.";
                                        end
                                        else
                                            if Rec."Destination Account Type" = Rec."Destination Account Type"::Credit then begin
                                                CAccount.Reset();
                                                CAccount.SetRange("Member No.", Rec."Member No.");
                                                if Page.RunModal(Page::"Credit Accounts List", CAccount) = Action::LookupOK then
                                                    Rec."Destination Account No." := CAccount."No.";

                                            end;
                        Rec.Validate("Destination Account No.");
                    end;
                }

                field(ProductName; Rec."Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Destination Transaction Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction Type';
                }
                field(ExternalDocumentNo; Rec."External Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountName; Rec."Destination Account Name")
                {
                    ApplicationArea = Basic;
                    Caption = ' Account Name';
                }

                field(DestinationAmount; Rec."Destination Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Credit Amount';
                }
                field("PloughBack Amount"; Rec."PloughBack Amount")
                {
                    ApplicationArea = Basic;
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

