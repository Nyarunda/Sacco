namespace UnitedWomen.UnitedWomen;

page 51253 "Swart Savings Ledger API"
{
    PageType = API;
    APIPublisher = 'swartdata';
    APIGroup = 'analytics';
    APIVersion = 'v1.0';
    EntityName = 'savingsLedgerEntry';
    EntitySetName = 'savingsLedgerEntries';
    SourceTable = "Savings Ledger Entry";
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
                field(memberNo; Rec."Member No.") { ApplicationArea = All; }
                field(savingsAccountNo; Rec."Account No.") { ApplicationArea = All; }
                field(savingsProductCode; Rec."Product Type") { ApplicationArea = All; }
                field(productCategory; Rec."Product Category") { ApplicationArea = All; }
                field(postingDate; Rec."Posting Date") { ApplicationArea = All; }
                field(documentNo; Rec."Document No.") { ApplicationArea = All; }
                field(externalDocumentNo; Rec."External Document No.") { ApplicationArea = All; }
                field(description; Rec.Description) { ApplicationArea = All; }
                field(amount; Rec.Amount) { ApplicationArea = All; }
                field(amountLcy; Rec."Amount (LCY)") { ApplicationArea = All; }
                field(debitAmount; Rec."Debit Amount") { ApplicationArea = All; }
                field(creditAmount; Rec."Credit Amount") { ApplicationArea = All; }
                field(remainingAmount; Rec."Remaining Amount") { ApplicationArea = All; }
                field(branchCode; Rec."Global Dimension 2 Code") { ApplicationArea = All; }
                field(activityCode; Rec."Global Dimension 1 Code") { ApplicationArea = All; }
                field(userId; Rec."User ID") { ApplicationArea = All; }
                field(sourceCode; Rec."Source Code") { ApplicationArea = All; }
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
        Rec.CalcFields("Product Type", "Product Category");
    end;
}
