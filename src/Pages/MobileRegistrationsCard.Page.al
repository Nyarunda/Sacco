Page 50468 "Mobile Registrations Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Mobile Registrations";

    layout
    {
        area(content)
        {
            group(General)
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
                field(gender; Rec.gender)
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
                field(MemberMaritalStatus; Rec."Member Marital Status")
                {
                    ApplicationArea = Basic;
                }
                field(MemberGender; Rec."Member Gender")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send To Application")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to send this entry to application?') then
                        VirtualApplication(Rec);

                end;
            }
        }
    }

    local procedure VirtualApplication(VirtualRegistrations: Record "Mobile Registrations")
    var
        MemberApplication: Record "Member Registration";
    begin

        MemberApplication.Init;
        MemberApplication."No." := '';
        MemberApplication."ID No." := VirtualRegistrations.iDNo;
        MemberApplication.Validate("ID No.");
        MemberApplication."Mobile Phone No." := VirtualRegistrations.phoneNo;
        MemberApplication.Validate("Mobile Phone No.");
        MemberApplication.Validate("First Name", VirtualRegistrations.firstName);
        MemberApplication.Validate("Middle Name", VirtualRegistrations.middleName);
        MemberApplication.Validate(surname, VirtualRegistrations.surname);
        MemberApplication.Gender := VirtualRegistrations."Member Gender";
        Evaluate(MemberApplication."Date of Birth", VirtualRegistrations.dateOfBirth);
        //MemberApplication."Member Department" := VirtualRegistrations."Member Marital Status";
        //MemberApplication."Sub-Location" := VirtualRegistrations.address;
        MemberApplication."E-Mail" := VirtualRegistrations.email;
        MemberApplication."Application Date" := VirtualRegistrations."Application Date";
        MemberApplication.Insert(true);

        Message('record inserted');
    end;
}

