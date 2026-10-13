
Table 50138 "EFT Lines."
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Tax Area';
            TableRelation = "Tax Area";
        }
        field(50000; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Tax,EFT;
        }
        field(50002; "Date Entered"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Time Entered"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Savings,Credit';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit;
        }
        field(50007; "Account No."; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                BankAccount: Record "Bank Account";
            begin
                /*
                //*
                CASE "Account Type" OF
                 "Account Type"::"Bank Account":
                   BEGIN
                     IF BankAccount.GET("Account No.") THEN
                       "Account Name":=BankAccount.Name;
                     END;
                END;
                */

            end;
        }
        field(50008; "Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50009; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Record Total"; Decimal)
        {
            Editable = false;
            //FieldClass = FlowField;
        }
        field(50012; "Record Count"; Integer)
        {
            Editable = false;
            //FieldClass = FlowField;
        }
        field(50013; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Cash Deposit,Cash Withdrawal,Credit Receipt,Credit Cheque,Bankers Cheque,Cheque Deposit,Cheque Withdrawal,Salary Processing,Electronic Fund Transfer,RTGS';
            OptionMembers = "Cash Deposit","Cash Withdrawal","Credit Receipt","Credit Cheque","Bankers Cheque","Cheque Deposit","Cheque Withdrawal","Salary Processing","Electronic Fund Transfer",RTGS;

            trigger OnValidate()
            begin
                //"Transaction Type":='';
            end;
        }
        field(50014; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50020; "Created By"; Code[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50021; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Pending,Rejected,Approved,Transferred';
            OptionMembers = Open,Pending,Rejected,Approved,Transferred;
        }
        field(50022; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Date Transferred"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50025; "Time Transferred"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50026; "Transferred By"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Salary Processing No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Salary Options"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Add To Existing","Replace Lines";
        }
        field(50029; "Transaction Type"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //getCharges;
            end;
        }
        field(50030; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50031; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50032; "Responsibility Centre"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'LookUp to Responsibility Center BR';
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(50033; "Standing Order EFT Done"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Document No. Filter"; Code[250])
        {
            FieldClass = FlowFilter;
        }
        field(50035; "Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", "Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

