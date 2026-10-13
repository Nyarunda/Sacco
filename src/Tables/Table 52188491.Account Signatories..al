
Table 50154 "Account Signatories."
{
    //Caption = 'Team Salesperson';

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "ID No."; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            var
                Members: Record Members;
            begin
                if "ID No." <> '' then begin
                    Members.Reset;
                    Members.SetRange("ID No.", "ID No.");
                    if Members.FindFirst then begin
                        "Member No." := Members."No.";
                        Validate("Member No.");
                    end;
                end;
            end;
        }
        field(50003; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(50004; "Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                DateofBirthError: label 'This date cannot be greater than today.';
            begin
                if "Date Of Birth" > Today then
                    Error(DateofBirthError);

                if CalcDate('18Y', "Date of Birth") > Today then
                    Error('Minimum Age is 18 Years');
            end;
        }
        field(50005; "Staff/Payroll"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; Signatory; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Must Sign"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Must be Present"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; Picture; Blob)
        {
            Caption = 'Picture';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50011; Signature; Blob)
        {
            Caption = 'Signature';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50012; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Member No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;

            trigger OnValidate()
            var
                Members: Record Members;
                ImageData: Record "Member Images";
            begin
                if Members.Get("Member No.") then begin
                    Name := Members.Name;
                    "ID No." := Members."ID No.";
                    "Date Of Birth" := Members."Date of Birth";
                    "Staff/Payroll" := Members."Payroll/Staff No.";

                    ImageData.Reset;
                    ImageData.SetRange(ImageData."Member No.", Members."No.");
                    if ImageData.Find('-') then begin
                        ImageData.CalcFields(Picture, Signature);
                        Picture := ImageData.Picture;
                        Signature := ImageData.Signature;
                    end;
                end;
            end;
        }
        field(50018; "ID Type"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; Designation; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; Gender; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Phone No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; Created; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; Position; Option)
        {
            OptionMembers = " ",Chairperson,Secretary,Treasurer,Member;
            DataClassification = ToBeClassified;
        }
        field(50024; "Type"; Option)
        {
            OptionMembers = Signatory,Agent,Authorized;
            DataClassification = ToBeClassified;
        }

    }


    keys
    {
        key(Key1; "Code", "ID No.", Name, Type)
        {
            Clustered = true;
        }
        key(Key2; "ID No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        Members: Record Members;
    begin
        if Members.get(code) then
            Error('Action Not Approved');
    end;
}

