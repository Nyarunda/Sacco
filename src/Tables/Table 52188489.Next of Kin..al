
Table 50152 "Next of Kin."
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "ID No."; Code[20])
        {
            NotBlank = false;
        }
        field(3; "Member No"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if (Type = const(Member)) Members."No.";

            trigger OnValidate()

            var
                Members: Record Members;
            begin
                if "Member No" <> '' then begin
                    if not Members.Get("Member No") then
                        Error('Invalid Member No. %1', "Member No");
                    "ID No." := Members."ID No.";
                    Name := Members.Name;
                    "Date of Birth" := Members."Date of Birth";
                    Email := Members."E-mail";
                    "Mobile Phone No." := Members."Mobile Phone No.";
                    Relationship := '';
                end;
            end;
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
        field(50003; Email; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "%Allocation"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            var
                TotalA: Decimal;
                NOK: Record "Next of Kin.";
            begin
                TotalA := 0;

                NOK.RESET;
                NOK.SETRANGE(NOK."No.", "No.");
                IF NOK.FIND('-') THEN BEGIN
                    REPEAT
                        TotalA := TotalA + NOK."%Allocation"
                    UNTIL NOK.NEXT = 0;
                END;

                TotalA := TotalA + "%Allocation";
                IF TotalA > 100 THEN
                    ERROR('Total allocation cannot be more than 100%.');


            end;
        }
        field(50006; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Member,Non-Member';
            OptionMembers = "",Member,"Non-Member";
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
        field(50009; "Next Of Kin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Employee No."; code[50])
        {
            DataClassification = ToBeClassified;
            tablerelation = Employee."No.";
        }
        field(50017; "Principal ID No."; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50018; GuardianName; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; NokType; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Line No."; Integer)
        {
        }
        field(50021; "Action Type"; Option)
        {
            OptionMembers = Insert,Delete,Update;
        }
        field(50022; "Entry No Reference"; text[50])
        {
        }
        field(50023; Address; text[50])
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
        key(Key1; "No.", "ID No.", Name, "Principal ID No.", "Line No.")
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

