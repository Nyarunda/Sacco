table 50565 "TransUnion Parsed Error"
{
    // Parsed TransUnion validation errors for better readability

    DataClassification = SystemMetadata;
    Caption = 'TransUnion Parsed Error';

    fields
    {
        field(1; "Parent Entry No."; Integer)
        {
            Caption = 'Parent Entry No.';
            DataClassification = SystemMetadata;
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }

        field(10; "Account Number"; Code[50])
        {
            Caption = 'Account Number';
            DataClassification = SystemMetadata;
        }

        field(20; "Field Name"; Text[100])
        {
            Caption = 'Field Name';
            DataClassification = SystemMetadata;
        }

        field(30; "Field Value"; Text[250])
        {
            Caption = 'Field Value';
            DataClassification = SystemMetadata;
        }

        field(40; "Error Message"; Text[500])
        {
            Caption = 'Error Message';
            DataClassification = SystemMetadata;
        }

        field(50; "Error Code"; Code[20])
        {
            Caption = 'Error Code';
            DataClassification = SystemMetadata;
        }

        field(60; "Resolution Suggestion"; Text[500])
        {
            Caption = 'Resolution Suggestion';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Parent Entry No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        // Auto-generate resolution suggestions based on error codes
        GenerateResolutionSuggestion();
    end;

    local procedure GenerateResolutionSuggestion()
    begin
        case "Error Code" of
            'ENF051':
                "Resolution Suggestion" := 'Check account status value. Must be one of: A, B, C, D, E, F, G, H, J, K, L, M, N, P';
            'ENF001':
                "Resolution Suggestion" := 'Field is mandatory and cannot be empty';
            'ENF002':
                "Resolution Suggestion" := 'Invalid date format. Use YYYYMMDD format';
            'ENF003', 'ENF030':
                "Resolution Suggestion" := 'Invalid amount format. Use integer format representing cents (e.g., 3125.45 becomes 312545)';
            '2':
                "Resolution Suggestion" := 'Amount field must be integer representing cents with assumed decimal point (e.g., KES 3,125.45 = 312545)';
            else
                "Resolution Suggestion" := 'Review field value and ensure it meets TransUnion requirements';
        end;

        // Add field-specific suggestions
        case "Field Name" of
            'primaryIdentificationDocumentType':
                "Resolution Suggestion" += ' Valid document types: 001=National ID, 002=Passport, etc.';
            'clientType':
                "Resolution Suggestion" += ' Valid values: A=Individual, B=Corporate';
            'currencyOfFacility':
                "Resolution Suggestion" += ' Use ISO currency codes like KES, USD, EUR';
            'Original Amount', 'originalAmount':
                "Resolution Suggestion" += ' System automatically converts KES 450,000.00 to 45000000 (cents format).';
            'Current Balance', 'currentBalance':
                "Resolution Suggestion" += ' System automatically converts KES 335,364.49 to 33536449 (cents format).';
            'Payment Amount', 'paymentAmount':
                "Resolution Suggestion" += ' System automatically converts KES 0.00 to 0 (cents format).';
        end;
    end;
}