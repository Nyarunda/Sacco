
Table 50136 "Standing Order Register."
{

    fields
    {
        field(1; "No."; Code[20])
        {
            TableRelation = "Tax Area";
        }
        field(50000; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Tax,STO;
        }
        field(50003; "Date Processed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50007; "Source Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(50008; "Source Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Staff/Payroll No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Allow Partial Deduction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Deduction Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Successfull,Partial Deduction,Failed';
            OptionMembers = " ",Successfull,"Partial Deduction",Failed;
        }
        field(50013; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(50014; "Amount Deducted"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Effective/Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; Duration; DateFormula)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(50017; Frequency; DateFormula)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(50018; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; Remarks; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; EFT; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Transfered to EFT"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Standing Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Destination Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,External,Fixed Asset,IC Partner,Internal,Credit';
            OptionMembers = "G/L Account",Customer,Vendor,External,"Fixed Asset","IC Partner",Internal,Credit;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Standing Order Reg. Nos.");
            "No." := NoSeries.GetNextNo(NoSetup."Standing Order Reg. Nos.", WorkDate(), true);
        end;
    end;

    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
}

