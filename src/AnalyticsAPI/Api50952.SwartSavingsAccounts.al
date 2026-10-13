namespace UnitedWomen.UnitedWomen;

page 51252 "Swart Savings Accounts API"
{
    PageType = API;
    APIPublisher = 'swartdata';
    APIGroup = 'analytics';
    APIVersion = 'v1.0';
    EntityName = 'savingsAccount';
    EntitySetName = 'savingsAccounts';
    SourceTable = "Savings Accounts";
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
                field(savingsAccountNo; Rec."No.") { ApplicationArea = All; }
                field(accountName; Rec.Name) { ApplicationArea = All; }
                field(memberNo; Rec."Member No.") { ApplicationArea = All; }
                field(savingsProductCode; Rec."Product Type") { ApplicationArea = All; }
                field(savingsProductName; Rec."Product Name") { ApplicationArea = All; }
                field(productCategory; Rec."Product Category") { ApplicationArea = All; }
                field(accountStatus; Rec.Status) { ApplicationArea = All; }
                field(openingDate; Rec."Registration Date") { ApplicationArea = All; }
                field(currentBalance; Rec.Balance) { ApplicationArea = All; }
                field(currentBalanceLcy; Rec."Balance (LCY)") { ApplicationArea = All; }
                field(branchCode; Rec."Global Dimension 2 Code") { ApplicationArea = All; }
                field(activityCode; Rec."Global Dimension 1 Code") { ApplicationArea = All; }
                field(memberCategory; Rec."Member Category") { ApplicationArea = All; }
                field(systemCreatedAt; Rec.SystemCreatedAt) { ApplicationArea = All; }
                field(systemModifiedAt; Rec.SystemModifiedAt) { ApplicationArea = All; }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SetFilter("Date Filter", '..%1', WorkDate());
        Rec.CalcFields(Balance, "Balance (LCY)", "Member Category");
    end;
}
