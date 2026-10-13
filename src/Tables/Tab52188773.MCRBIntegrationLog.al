table 50552 "MCRB Integration Log"
{
    Caption = 'MCRB Integration Log';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "EntryID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "ReportType"; Enum "CRB Report Type")
        {
            DataClassification = ToBeClassified;

        }
        field(3; "RequestTimestamp"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "ResponseTimestamp"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "RequestJSON"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "ResponseJSON"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "HTTPStatusCode"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "APIResponseCode"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "ErrorMessage"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "ProcessingStatus"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pending,Success,Failed;
        }
        field(12; "JsonPDFReport"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "IdentityScrubPDFReport"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "CreditinfoMobilePDFReport"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "FullEnhancedCreditinfoPDF"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "FullJsonPDFReport"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "CreditSummaryPDFReport"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "AccountHistoryPDFReport"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "IdentityPDFReport"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "CreditInfoPDFReport"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "CreditInfoEnhancedPDFReport"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "RequestID"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(29; "LoanNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "MemberNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(100; "CRB Status Code"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(101; "CRB Status Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "EntryID", RequestID)
        {
            Clustered = true;
        }
    }
}
