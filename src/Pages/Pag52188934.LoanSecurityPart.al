page 50636 "Loan Security Part"
{
    ApplicationArea = All;
    Caption = 'Loan Security Part';
    PageType = ListPart;
    SourceTable = "Loan Security";

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

                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll No."; Rec."Staff/Payroll No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Gua. Employer Code"; Rec."Gua. Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field(SecurityDetails; Rec."Security Details")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Current Guarantor Deposits"; Rec."Current Guarantor Deposits")
                {
                    Caption = 'Deposits';
                    ApplicationArea = Basic;
                    Editable = false;
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
                field(TotalCommitted; Rec."Total Committed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CurrentCommitted; Rec."Current Committed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Substituted; Rec.Substituted)
                {
                    ApplicationArea = Basic;
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
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;

                }
                field(Signature; Rec.Signature)
                {
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

        /* area(factboxes)
         {
             part(Control3;Rec."Picture & Signature")
             {
                 SubPageLink = "Member No." = field("Member No");
             }
             part(Control66;Rec."Info Base")
             {
                 SubPageLink = "Member No." = field("Member No");
             }
         }*/
    }

    actions
    {
        area(processing)
        {
            action("Suggest Micro Guarantors")
            {
                ApplicationArea = Basic;
#pragma warning disable AL0729
                Promoted = true;
#pragma warning restore AL0729
#pragma warning disable AL0729
                PromotedIsBig = true;
#pragma warning restore AL0729

                trigger OnAction()
                var
                    Loan: Record Loans;
                    Members: Record Members;
                    Accounts: Record "Savings Accounts";
                begin
                    GCount := 0;
                    if Loan.Get(Rec."Loan No.") then begin
                        Message(Loan."Group Code");
                        if Loan."Group Code" <> '' then begin
                            Members.Reset;
                            Members.SetFilter("No.", '<>%1', Loan."Member No.");
                            Members.SetFilter("Group No.", Loan."Group Code");
                            if Members.FindFirst then begin

                                repeat
                                    Accounts.Reset;
                                    Accounts.SetRange("Group No.", Members."Group No.");
                                    Accounts.SetRange("Product Category", Accounts."product category"::"Micro Member Deposit");
                                    Accounts.SetFilter("Member No.", Members."No.");
                                    if Accounts.Find('-') then begin
                                        repeat
                                            GAmount := ROUND(Loan."Approved Amount" / Members.Count, 0.01, '>');
                                            LoanGua.Init;
                                            LoanGua."Loan No." := Loan."Loan No.";
                                            LoanGua.Validate("Guarantor Type", LoanGua."guarantor type"::Guarantor);
                                            LoanGua.Validate("Account No.", Accounts."No.");
                                            if GAmount > LoanGua."Available Guarantorship" then
                                                GAmount := LoanGua."Available Guarantorship";
                                            LoanGua.Validate("Amount Guaranteed", GAmount);
                                            LoanGua.Insert(true);
                                            GCount += 1;
                                        until Accounts.Next = 0;
                                    end;
                                until Members.Next = 0;
                            end;
                        end;
                    end;
                    Message('%1 Accounts Added', GCount);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalculateGuarantorshipSummary;
    end;

    trigger OnAfterGetRecord()
    begin

        if Loan.Get(Rec."Loan No.") then begin
            if (Loan.Posted) or (Loan.Status = Loan.Status::Approved) then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;
        end;

        CalculateGuarantorshipSummary;
    end;

    trigger OnClosePage()
    begin

        if Loan.Get(Rec."Loan No.") then begin
            MicroDef := '';

            if ProdFac.Get(Loan."Loan Product Type") then begin
                if not Loan."Self Guarantee" then
                    if ProdFac."Minimum Guarantors" > 0 then begin
                        LoanGua.Reset;
                        LoanGua.SetRange(LoanGua."Loan No.", Loan."Loan No.");
                        LoanGua.SetFilter("Guarantor Type", '%1', LoanGua."guarantor type"::Guarantor);
                        if LoanGua.Find('-') then begin
                            repeat
                                Loan.Reset;
                                Loan.SetFilter("Outstanding Principal", '>0');
                                Loan.SetRange("Member No.", LoanGua."Member No");
                                Loan.SetFilter("Loans Category-SACCO", '<>%1&<>%2', Loan."Loans Category-SACCO"::Perfoming, Loan."Loans Category-SACCO"::Watch);
                                if Loan.FindFirst then begin
                                    repeat
                                        MicroDef += '\ - ' + Loan."Member No." + ' - ' + Loan."Member Name" + '-' + Loan."Loan Product Type" + '-' + Format(Loan."Loans Category-SACCO");
                                    until Loan.Next = 0;
                                end;
                            until LoanGua.Next = 0;
                        end;
                    end;
            end;

            if MicroDef <> '' then begin
                Message('The following Guarantor(s) are Defaulters: \' + MicroDef);
            end;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CalculateGuarantorshipSummary;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CalculateGuarantorshipSummary;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CalculateGuarantorshipSummary;
    end;

    trigger OnOpenPage()
    begin

        if Loan.Get(Rec."Loan No.") then begin
            if Loan.Posted then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;
        end;

        CalculateGuarantorshipSummary;
    end;

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
        Loan: Record Loans;
        ProdFac: Record "Product Setup";
        LoanGua: Record "Loan Security";
        picture: record "Member Images";
        Signature: Record "Member Images";


    procedure CalculateGuarantorshipSummary()
    begin

        RequestedAmount := 0;
        ApprovedAmount := 0;
        TotalGuaranteed := 0;
        GuarantorshipBalance := 0;

        if Loan.Get(Rec."Loan No.") then begin
            RequestedAmount := Loan."Requested Amount";
            ApprovedAmount := Loan."Approved Amount";
        end;

        LoanGua.Reset;
        LoanGua.SetRange("Loan No.", Rec."Loan No.");
        LoanGua.SetRange(Substituted, false);
        if LoanGua.Find('-') then begin
            repeat
                TotalGuaranteed += LoanGua."Amount Guaranteed";
            until LoanGua.Next = 0;
        end;

        GuarantorshipBalance := RequestedAmount - TotalGuaranteed;
    end;

}