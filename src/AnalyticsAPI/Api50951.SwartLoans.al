namespace UnitedWomen.UnitedWomen;

page 51251 "Swart Loans API"
{
    PageType = API;
    APIPublisher = 'swartdata';
    APIGroup = 'analytics';
    APIVersion = 'v1.0';
    EntityName = 'loan';
    EntitySetName = 'loans';
    SourceTable = Loans;
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
                field(loanNo; Rec."Loan No.") { ApplicationArea = All; }
                field(memberNo; Rec."Member No.") { ApplicationArea = All; }
                field(memberName; Rec."Member Name") { ApplicationArea = All; }
                field(loanProductCode; Rec."Loan Product Type") { ApplicationArea = All; }
                field(loanProductName; Rec."Loan Product Type Name") { ApplicationArea = All; }
                field(applicationDate; Rec."Application Date") { ApplicationArea = All; }
                field(disbursementDate; Rec."Disbursement Date") { ApplicationArea = All; }
                field(originalLoanAmount; Rec."Requested Amount") { ApplicationArea = All; }
                field(approvedAmount; Rec."Approved Amount") { ApplicationArea = All; }
                field(outstandingPrincipal; Rec."Outstanding Principal") { ApplicationArea = All; }
                field(outstandingInterest; Rec."Outstanding Interest") { ApplicationArea = All; }
                field(totalOutstandingBalance; Rec."Total Outstanding Balance") { ApplicationArea = All; }
                field(repaymentFrequency; Rec."Repayment Frequency") { ApplicationArea = All; }
                field(numberOfInstallments; Rec.Installments) { ApplicationArea = All; }
                field(maturityDate; Rec."Completion Date") { ApplicationArea = All; }
                field(loanStatus; Rec.Status) { ApplicationArea = All; }
                field(daysInArrears; Rec."SASRA Days Arrears") { ApplicationArea = All; }
                field(monthsInArrears; Rec."SASRA Months Arrears") { ApplicationArea = All; }
                field(principalArrears; Rec."Principal Arrears") { ApplicationArea = All; }
                field(branchCode; Rec."Booking Branch") { ApplicationArea = All; }
                field(activityCode; Rec."Global Dimension 1 Code") { ApplicationArea = All; }
                field(relationshipOfficer; Rec."Relationship Officer") { ApplicationArea = All; }
                field(loanOfficer; Rec."Loan Officer") { ApplicationArea = All; }
                field(systemCreatedAt; Rec.SystemCreatedAt) { ApplicationArea = All; }
                field(systemModifiedAt; Rec.SystemModifiedAt) { ApplicationArea = All; }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SetFilter("Date Filter", '..%1', WorkDate());
        Rec.CalcFields(
            "Outstanding Principal",
            "Outstanding Interest",
            "Total Outstanding Balance",
            "SASRA Days Arrears",
            "SASRA Months Arrears",
            "Principal Arrears");
    end;
}
