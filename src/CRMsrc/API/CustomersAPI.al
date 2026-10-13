page 50421 "Customers API"
{
    APIVersion = 'v1.0';
    APIPublisher = 'YourCompany';
    APIGroup = 'crm';
    EntityCaption = 'Customer';
    EntitySetCaption = 'Customers';
    PageType = API;
    EntitySetName = 'Customer';
    EntityName = 'Customer';
    SourceTable = "CRM Customer";
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }

                field(number; Rec."No.")
                {
                    Caption = 'Number';
                }

                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }

                field(email; Rec.Email)
                {
                    Caption = 'Email';
                }

                field(phoneNumber; Rec."Phone No.")
                {
                    Caption = 'Phone Number';
                }

                field(customerType; Rec."Customer Type")
                {
                    Caption = 'Customer Type';
                }

                field(status; Rec."Customer Status")
                {
                    Caption = 'Customer Status';
                }


                field(registrationDate; Rec."Registration Date")
                {
                    Caption = 'Registration Date';
                }

                /*
                field(memberNumber; Rec."Member No.")
                {
                    Caption = 'Member Number';
                }

                field(organization; Rec.Organization)
                {
                    Caption = 'Organization';
                }

                field(lastContactDate; Rec."Last Contact Date")
                {
                    Caption = 'Last Contact Date';
                }

                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }

                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                */
            }
        }
    }
}