
Table 50270 "Sacco Logs"
{

    fields
    {
        field(1; UserName; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Password; Text[200])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                EncPassword := '';

                //if Password<>'' then
                //EncPassword := CopyStr(Encryption.Encrypt(Password),1,150);
            end;
        }
        field(3; EncPassword; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; UserName)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Encryption: Codeunit "Cryptography Management";
}

