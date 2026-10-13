Page 50472 "Mobile Registrations List"
{
    CardPageID = "Mobile Registrations Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Mobile Registrations";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(iDNo; Rec.iDNo)
                {
                    ApplicationArea = Basic;
                }
                field(firstName; Rec.firstName)
                {
                    ApplicationArea = Basic;
                }
                field(middleName; Rec.middleName)
                {
                    ApplicationArea = Basic;
                }
                field(branchCode; Rec.branchCode)
                {
                    ApplicationArea = Basic;
                }
                field(surname; Rec.surname)
                {
                    ApplicationArea = Basic;
                }
                field(pinNo; Rec.pinNo)
                {
                    ApplicationArea = Basic;
                }
                field(address; Rec.address)
                {
                    ApplicationArea = Basic;
                }
                field(MemberGender; Rec."Member Gender")
                {
                    ApplicationArea = Basic;
                }
                field(occupation; Rec.occupation)
                {
                    ApplicationArea = Basic;
                }
                field(phoneNo; Rec.phoneNo)
                {
                    ApplicationArea = Basic;
                }
                field(email; Rec.email)
                {
                    ApplicationArea = Basic;
                }
                field(passportPhoto; Rec.passportPhoto)
                {
                    ApplicationArea = Basic;
                }
                field(frontID; Rec.frontID)
                {
                    ApplicationArea = Basic;
                }
                field(backID; Rec.backID)
                {
                    ApplicationArea = Basic;
                }
                field(signature; Rec.signature)
                {
                    ApplicationArea = Basic;
                }
                field(dateOfBirth; Rec.dateOfBirth)
                {
                    ApplicationArea = Basic;
                }
                field(maritalStatus; Rec.maritalStatus)
                {
                    ApplicationArea = Basic;
                }
                field(applicationNo; Rec.applicationNo)
                {
                    ApplicationArea = Basic;
                }
                field(hudumaNumber; Rec.hudumaNumber)
                {
                    ApplicationArea = Basic;
                }
                field(residence; Rec.residence)
                {
                    ApplicationArea = Basic;
                }
                field(alternativeContact; Rec.alternativeContact)
                {
                    ApplicationArea = Basic;
                }
                field(refererPhoneNo; Rec.refererPhoneNo)
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

