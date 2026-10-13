
Page 50232 "Standing Order Lines"
{
    PageType = ListPart;
    SourceTable = "Standing Order Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DestinationAccountType; Rec."Destination Account Type")
                {
                    ApplicationArea = Basic;
                    ValuesAllowed = "G/L Account", External, Internal, Credit;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(DestinationAccountNo; Rec."Destination Account No.")
                {
                    ApplicationArea = Basic;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Members: Record Members;
                        Accounts: Record "Savings Accounts";
                        Loans: Record Loans;
                    begin
                        Rec."Destination Account No." := '';
                        if Rec."Destination Account Type" = Rec."Destination Account Type"::Credit then begin

                            Loans.Reset();
                            Loans.SetRange(Posted, true);
                            if Page.RunModal(Page::"Loans List", Loans) = Action::LookupOK then
                                Rec."Destination Account No." := Loans."Loan Account";
                        end
                        else
                            if Rec."Destination Account Type" = Rec."Destination Account Type"::Internal then begin
                                Accounts.Reset();
                                Accounts.SetRange("Member No.", Rec."Member No.");
                                if Page.RunModal(Page::"Member Accounts List", Accounts) = Action::LookupOK then
                                    Rec."Destination Account No." := Accounts."No.";
                            end;

                        Rec.Validate("Destination Account No.");
                    end;
                }
                field(DestinationAccountName; Rec."Destination Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(BankCode; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(BankName; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field(Priority; Rec.Priority)
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

