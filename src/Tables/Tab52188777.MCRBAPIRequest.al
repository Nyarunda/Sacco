table 50550 "MCRB API Request"
{
    Caption = 'MCRB API Request';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "RequestID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "ReportType"; enum "CRB Report Type")
        {
            DataClassification = ToBeClassified;

        }
        field(3; "IdentityNumber"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "IdentityType"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "LoanAmount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "ReportReason"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "MobileScore"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "LoanNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "MemberNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "RequestID", LoanNo)
        {
            Clustered = true;
        }
    }
}

