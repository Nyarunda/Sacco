Table 50374 "Mobile Registrations"
{

    fields
    {
        field(1; iDNo; Text[20])
        {
        }
        field(2; firstName; Text[20])
        {
        }
        field(3; middleName; Text[20])
        {
        }
        field(4; branchCode; Text[10])
        {
        }
        field(5; surname; Text[20])
        {
        }
        field(6; pinNo; Text[20])
        {
        }
        field(7; address; Text[20])
        {
        }
        field(8; gender; Text[20])
        {
        }
        field(9; occupation; Text[20])
        {
        }
        field(10; phoneNo; Text[20])
        {
        }
        field(11; email; Text[20])
        {
        }
        field(12; passportPhoto; Text[200])
        {
        }
        field(13; frontID; Text[200])
        {
        }
        field(14; backID; Text[200])
        {
        }
        field(15; signature; Text[200])
        {
        }
        field(16; dateOfBirth; Text[20])
        {
        }
        field(17; maritalStatus; Text[20])
        {
        }
        field(18; applicationNo; Text[20])
        {
        }
        field(19; hudumaNumber; Text[20])
        {
        }
        field(20; residence; Text[20])
        {
        }
        field(21; alternativeContact; Text[20])
        {
        }
        field(22; refererPhoneNo; Text[20])
        {
        }
        field(50050; "Member Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(50051; "Member Gender"; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(50052; "Application Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; iDNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

