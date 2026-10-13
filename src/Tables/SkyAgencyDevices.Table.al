Table 50387 "Sky Agency Devices"
{

    fields
    {
        field(1; "Device ID"; Code[10])
        {
        }
        field(2; "Serial Number"; Text[100])
        {
        }
        field(3; IMEI; Text[100])
        {
        }
        field(4; Make; Text[100])
        {
        }
        field(5; Model; Text[100])
        {
        }
        field(6; "Board ID"; Text[100])
        {
        }
        field(7; Version; Text[250])
        {
        }
        field(8; Firmware; Text[100])
        {
        }
        field(9; "Processor ID"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Device ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

