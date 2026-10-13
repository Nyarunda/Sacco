namespace UnitedWomen.UnitedWomen;

page 51254 "Swart Credit Ledger API"
{
    PageType = API;
    APIPublisher = 'swartdata';
    APIGroup = 'analytics';
    APIVersion = 'v1.0';
    EntityName = 'creditLedgerEntry';
    EntitySetName = 'creditLedgerEntries';
    SourceTable = "Credit Ledger Entry";
    ODataKeyFields = SystemId;
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(systemId; Rec.SystemId) { ApplicationArea = All; }
                field(entryNo; Rec."Entry No.") { ApplicationArea = All; }
                field(loanNo; Rec."Loan No.") { ApplicationArea = All; }
                field(memberNo; Rec."Member No.") { ApplicationArea = All; }
                field(loanAccountNo; Rec."Account No.") { ApplicationArea = All; }
                field(loanProductCode; Rec."Loan Type") { ApplicationArea = All; }
                field(postingDate; Rec."Posting Date") { ApplicationArea = All; }
                field(documentNo; Rec."Document No.") { ApplicationArea = All; }
                field(externalDocumentNo; Rec."External Document No.") { ApplicationArea = All; }
                field(transactionType; Rec."Transaction Type") { ApplicationArea = All; }
                field(description; Rec.Description) { ApplicationArea = All; }
                field(principalAmount; PrincipalAmount) { ApplicationArea = All; }
                field(interestAmount; InterestAmount) { ApplicationArea = All; }
                field(penaltyAmount; PenaltyAmount) { ApplicationArea = All; }
                field(insuranceAmount; InsuranceAmount) { ApplicationArea = All; }
                field(totalAmount; Rec.Amount) { ApplicationArea = All; }
                field(totalAmountLcy; Rec."Amount (LCY)") { ApplicationArea = All; }
                field(debitAmount; Rec."Debit Amount") { ApplicationArea = All; }
                field(creditAmount; Rec."Credit Amount") { ApplicationArea = All; }
                field(outstandingAmount; Rec."Remaining Amount") { ApplicationArea = All; }
                field(branchCode; Rec."Global Dimension 2 Code") { ApplicationArea = All; }
                field(activityCode; Rec."Global Dimension 1 Code") { ApplicationArea = All; }
                field(userId; Rec."User ID") { ApplicationArea = All; }
                field(transactionNo; Rec."Transaction No.") { ApplicationArea = All; }
                field(channel; Rec.Channel) { ApplicationArea = All; }
                field(reversed; Rec.Reversed) { ApplicationArea = All; }
                field(systemCreatedAt; Rec.SystemCreatedAt) { ApplicationArea = All; }
                field(systemModifiedAt; Rec.SystemModifiedAt) { ApplicationArea = All; }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Loan Type");
        SetComponentAmounts();
    end;

    var
        PrincipalAmount: Decimal;
        InterestAmount: Decimal;
        PenaltyAmount: Decimal;
        InsuranceAmount: Decimal;

    local procedure SetComponentAmounts()
    begin
        Clear(PrincipalAmount);
        Clear(InterestAmount);
        Clear(PenaltyAmount);
        Clear(InsuranceAmount);

        case Rec."Transaction Type" of
            Rec."Transaction Type"::"Loan Disbursement",
            Rec."Transaction Type"::"Principal Repayment":
                PrincipalAmount := Rec."Amount (LCY)";
            Rec."Transaction Type"::"Interest Due",
            Rec."Transaction Type"::"Interest Paid":
                InterestAmount := Rec."Amount (LCY)";
            Rec."Transaction Type"::"Penalty Due",
            Rec."Transaction Type"::"Penalty Paid":
                PenaltyAmount := Rec."Amount (LCY)";
            Rec."Transaction Type"::"Insurance Due",
            Rec."Transaction Type"::"Insurance Paid":
                InsuranceAmount := Rec."Amount (LCY)";
        end;
    end;
}
