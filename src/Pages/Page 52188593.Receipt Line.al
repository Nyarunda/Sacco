
/// <summary>
/// Page Receipt Line (ID 50256).
/// </summary>
Page 50256 "Receipt Line"
{
    PageType = ListPart;
    SourceTable = "Document Line";
    SourceTableView = sorting("Line No.") order(ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = LinesEditable;

                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(postingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Payment & Receipt Types" where(Type = const(Receipt));
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if Loans.Get(Rec."Loan No.") then
                            if Loans."Loan Product Type Name" <> '' then
                                Rec.Description := Loans."Loan Product Type Name"
                            else
                                Rec.Description := 'Loan Repayment';
                        Rec."Account No." := Loans."Loan Account";
                    end;
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
                    begin
                        if Rec."Account Type" = Rec."account type"::Credit then begin
                            Rec.TestField(Rec."Loan No.");
                            Loans.Get(Rec."Loan No.");
                            Loans.CalcFields("Total Outstanding Balance");
                            if Rec.Amount > Loans."Total Outstanding Balance" then
                                Error('This will lead to Overpayment of this Loan. Current Total Loan Balance is %1', Loans."Total Outstanding Balance");
                        end;
                    end;
                }
                field("Principal Due"; Rec."Principal Due")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Due"; Rec."Interest Due")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Due"; Rec."Insurance Due")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Due"; Rec."Penalty Due")
                {
                    ApplicationArea = Basic;
                }
                field("External Doc."; Rec."External Doc.")
                {
                    ApplicationArea = Basic;
                    Caption = 'External Document No.';
                }
                /* 
                field(Arrears; Rec.Arrears)
                {
                    ApplicationArea = Basic;
                }
                field("Interest Arrears"; Rec."Interest Arrears")
                {
                    ApplicationArea = Basic;
                }
               
                field(TaxableAmount;Rec."Taxable Amount")
                {
                    ApplicationArea = Basic;
                }*/
                /*
                field(TaxAmount;Rec."Tax Amount")
                {
                    ApplicationArea = Basic;
                }
                field(WithholdingTax;Rec."Withholding Tax")
                {
                    ApplicationArea = Basic;
                }
                field(VATAmount;Rec."VAT Amount")
                {
                    ApplicationArea = Basic;
                }
                field(WithholdingVAT;Rec."Withholding VAT")
                {
                    ApplicationArea = Basic;
                }
            
                field(NetAmount;Rec."Net Amount")
                {
                    ApplicationArea = Basic;
                }*/
                /*
                field(AppliestoDocType;"Applies-to Doc. Type")
                {
                    ApplicationArea = Basic;
                }
                field(AppliestoDocNo;"Applies-to Doc. No.")
                {
                    ApplicationArea = Basic;
                }
                field(AppliestoID;"Applies-to ID")
                {
                    ApplicationArea = Basic;
                }
                */
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                /*field("Sales Invoice No";Rec."Sales Invoice No")
                {
                    ApplicationArea = Basic;
                }*/
                field("Posted in G/L Entry"; Rec."Posted in G/L Entry")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies whether a matching G/L Entry exists for this batch no., transaction no., and member no.';
                }
                field("Posted in G/L Entry Reversed"; Rec."Posted in G/L Entry Reversed")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the Reversed value from the matching G/L Entry for this batch no., transaction no., and member no.';
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateLineControls();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateLineControls();
    end;

    var
        Loans: Record Loans;
        ReceiptHeader: Record "Receipt Header";
        LinesEditable: Boolean;

    local procedure UpdateLineControls()
    begin
        LinesEditable := not Rec.Posted;
        if ReceiptHeader.Get(Rec."Header No.") then
            LinesEditable := LinesEditable and (not ReceiptHeader.Posted);

        CurrPage.Editable := LinesEditable;
    end;
}
