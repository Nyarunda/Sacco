namespace UnitedWomen.UnitedWomen;

page 51250 "Swart Members API"
{
    PageType = API;
    APIPublisher = 'swartdata';
    APIGroup = 'analytics';
    APIVersion = 'v1.0';
    EntityName = 'member';
    EntitySetName = 'members';
    SourceTable = Members;
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
                field(memberNo; Rec."No.") { ApplicationArea = All; }
                field(memberName; Rec.Name) { ApplicationArea = All; }
                field(status; Rec."Member Status") { ApplicationArea = All; }
                field(dateJoined; Rec."Registration Date") { ApplicationArea = All; }
                field(gender; Rec.Gender) { ApplicationArea = All; }
                field(dateOfBirth; Rec."Date of Birth") { ApplicationArea = All; }
                field(branchCode; Rec."Global Dimension 2 Code") { ApplicationArea = All; }
                field(activityCode; Rec."Global Dimension 1 Code") { ApplicationArea = All; }
                field(employerCode; Rec."Employer Code") { ApplicationArea = All; }
                field(employerName; Rec."Employer Name") { ApplicationArea = All; }
                field(memberCategory; Rec."Member Category") { ApplicationArea = All; }
                field(phoneNumber; Rec."Mobile Phone No.") { ApplicationArea = All; }
                field(email; Rec."E-Mail") { ApplicationArea = All; }
                field(nationalId; Rec."ID No.") { ApplicationArea = All; }
                field(relationshipOfficer; Rec."Relationship Officer") { ApplicationArea = All; }
                field(relationshipOfficerName; Rec."Relationship Officer Name") { ApplicationArea = All; }
                field(accountManager; Rec."Account Manager") { ApplicationArea = All; }
                field(systemCreatedAt; Rec.SystemCreatedAt) { ApplicationArea = All; }
                field(systemModifiedAt; Rec.SystemModifiedAt) { ApplicationArea = All; }
            }
        }
    }
}
