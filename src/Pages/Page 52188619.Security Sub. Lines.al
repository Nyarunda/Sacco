
Page 50282 "Security Sub. Lines"
{
    PageType = ListPart;
    SourceTable = "Security Sub. Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(GuarantorType; Rec."Guarantor Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Members: Record Members;
                        Accounts: Record "Savings Accounts";
                    begin
                        Rec."Account No." := '';
                        if Rec."Guarantor Type" = Rec."Guarantor Type"::Collateral then begin
                            Members.Reset();
                            Members.setfilter(type, '<>%1', Members.Type::" ");
                            if Page.RunModal(Page::"Member List", Members) = Action::LookupOK then
                                Rec."Account No." := Members."No.";
                        end
                        else
                            if Rec."Guarantor Type" = Rec."Guarantor Type"::Guarantor then begin
                                Accounts.Reset();
                                Accounts.setfilter("Product Category", '%1|%2|%3', Accounts."Product Category"::"Deposit Contribution", Accounts."Product Category"::"Micro Member Deposit", Accounts."Product Category"::"Micro Group Deposit");
                                if Page.RunModal(Page::"Member Accounts List", Accounts) = Action::LookupOK then
                                    Rec."Account No." := Accounts."No.";
                            end
                            else
                                if Rec."Guarantor Type" = Rec."Guarantor Type"::Lien then begin
                                    Accounts.Reset();
                                    Accounts.setfilter("Product Category", '<>%1&<>%2&<>%3', Accounts."Product Category"::"Deposit Contribution", Accounts."Product Category"::"Micro Member Deposit", Accounts."Product Category"::"Micro Group Deposit");
                                    if Page.RunModal(Page::"Member Accounts List", Accounts) = Action::LookupOK then
                                        Rec."Account No." := Accounts."No.";
                                end;

                        Rec.Validate("Account No.");
                    end;
                }

                field(CollateralRegNo; Rec."Collateral Reg. No.")
                {
                    ApplicationArea = Basic;
                }
                field("Name/Details"; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(AvailableGuarantorship; Rec."Available Guarantorship")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AmountGuaranteed; Rec."Amount Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field(CurrentCommitted; Rec."Current Committed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Substituted; Rec.Substituted)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Substituted Member"; Rec."Substituted Member")
                {
                    ApplicationArea = Basic;
                    Caption = 'Outgoing Guarantor';
                    Editable = false;
                    LookupPageId = "Member Listing";
                }
                field(OutstandingPrincipal; Rec."Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(Receipt; Rec.Receipt)
                {
                    Visible = false;
                    ApplicationArea = Basic;
                }
            }
            group(Control20)
            {
                fixed(Control19)
                {
                    group(DepositsCollateralLimit)
                    {
                        Caption = 'Deposits/Collateral Limit';
                        field("Guarantor Details"; Rec."Guarantor Deposits")
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group(GuaranteedinApplication)
                    {
                        Caption = 'Guaranteed in Application';
                        field(ApplicationAmountGuaranteed; Rec."Application Amount Guaranteed")
                        {
                            ApplicationArea = Basic;
                            Editable = false;
                        }
                    }
                    group(GuarantorDetails)
                    {
                        Caption = 'Total Guarantor Commitment';
                        field(TotalGuarantorCommitment; Rec."Total Guarantor Commitment")
                        {
                            ApplicationArea = Basic;
                            Editable = false;
                        }
                    }
                }
            }
            group(Control12)
            {
                fixed(Control11)
                {
                    group(RequestedAmount)
                    {
                        Caption = 'Requested Amount';
                        field("Guarantorship Summary"; RequestedAmount)
                        {
                            ApplicationArea = Basic;
                            Editable = false;
                        }
                    }
                    group(TotalGuaranteed)
                    {
                        Caption = 'Total Guaranteed';
                        field(Control7; TotalGuaranteed)
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group("Guarantorship Balance")
                    {
                        Caption = 'Guarantorship Balance';
                        field(GuarantorshipBalance; GuarantorshipBalance)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Bal. Account Name';
                            Editable = false;
                        }
                    }
                }
            }
        }
    }

    actions
    {
    }

    var
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
        CompInfo: Record "Company Information";
        TotalGuaranteed: Decimal;
        RequestedAmount: Decimal;
        ApprovedAmount: Decimal;
        GuarantorshipBalance: Decimal;
        GCount: Integer;
        GAmount: Decimal;
        MicroDef: Text;
}

