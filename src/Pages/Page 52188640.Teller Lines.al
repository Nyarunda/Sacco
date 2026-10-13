
/// <summary>
/// Page Teller Lines (ID 50303).
/// </summary>
Page 50303 "Teller Lines"
{
    PageType = ListPart;
    SourceTable = "Teller Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    var
                        Members: Record Members;
                        Accounts: Record "Savings Accounts";
                    begin
                        Rec."Account No." := '';
                        // Validate("Account No.");

                    end;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Members: Record Members;
                        Accounts: Record "Savings Accounts";
                        CrAccount: record "Credit Accounts";
                    begin
                        Rec."Account No." := '';
                        if Rec.Type = Rec.Type::Credit then begin

                            CrAccount.Reset();
                            CrAccount.SetRange("Member No.", Rec."Member No.");
                            if Page.RunModal(Page::"Credit Accounts List", CrAccount) = Action::LookupOK then
                                Rec."Account No." := CrAccount."No.";
                        end
                        else
                            if Rec.Type = Rec.Type::Savings then begin
                                Accounts.Reset();
                                Accounts.SetRange("Member No.", Rec."Member No.");
                                if Page.RunModal(Page::"Member Accounts List", Accounts) = Action::LookupOK then
                                    Rec."Account No." := Accounts."No.";
                            end;

                        Rec.Validate("Account No.");
                    end;
                }
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionNo; Rec."Transaction No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = basic;
                    Editable = false;
                }
                field(PrincipalDue; Rec."Principal Due")
                {
                    ApplicationArea = Basic;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(OutstandingInterest; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(OutstandingPenalty; Rec."Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPrincipal; Rec."Outstanding Principal")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TotalBalance; Rec."Total Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }

            }
        }
    }

    actions
    {
    }
}

