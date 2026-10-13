table 50337 Nominee
{
    Caption = 'Nominee';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "ID No."; Code[20])
        {
            NotBlank = false;
        }
        field(15; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(17; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin

                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(50000; Relationship; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Relationship;
        }
        field(50001; Beneficiary; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                DateofBirthError: label 'This date cannot be greater than today.';
            begin
                if "Date of Birth" > Today then
                    Error('Invalid Date of Birth. Future Date Detected');
            end;

        }
        field(50003; Email; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "%Allocation"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            var
                NomineeAll: Record Nominee;
            begin
                if "%Allocation" > 100 then
                    Error('Allocation percentage cannot exceed 100%.');


                NomineeAll.Reset();
                NomineeAll.SetRange("No.", "No.");
                NomineeAll.SetFilter("Line No.", '<>%1', "Line No.");
                if NomineeAll.FindFirst() then begin
                    NomineeAll.CalcSums("%Allocation");
                    if NomineeAll."%Allocation" + "%Allocation" > 100 then
                        Error('Total Allocation percentage cannot exceed 100%. Current total is %1%.',
                            NomineeAll."%Allocation" + "%Allocation");
                end;
            end;
        }
        field(50006; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Next of Kin,Benevolent Beneficiary';
            OptionMembers = "Next of Kin","Benevolent Beneficiary";
        }
        field(50007; Deceased; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; Spouse; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Guardian Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Guardian Phone No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Line No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50019; Address; Text[50])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50021; "Action Type"; Option)
        {
            OptionMembers = Insert,Delete,Update;
        }
        field(50022; "Entry No Reference"; text[50])
        {
        }
        field(50024; "NOK Residence"; text[50])
        {
        }
        field(50025; "Modified By"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        Contact: Record Contact;
        ContAltAddrDateRange: Record "Contact Alt. Addr. Date Range";
    begin
    end;

    trigger OnInsert()
    var
        Contact: Record Contact;
    begin
    end;

    trigger OnModify()
    var
        Contact: Record Contact;
    begin
    end;

    trigger OnRename()
    var
        Contact: Record Contact;
    begin
    end;

    var
        PostCode: Record "Post Code";
}

