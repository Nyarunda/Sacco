table 50485 "Share Transfer"
{
    Caption = 'Share Transfer';
    DataClassification = ToBeClassified;
    DrillDownPageID = "Share Trading List";
    LookupPageID = "Share Trading List";

    fields
    {
        field(1; No; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    NoSetup.Get(0);
                    NoSeries.TestManual(No);
                    Remarks := '';
                end;
            end;
        }
        field(2; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Transaction Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges".Code where(Type = const("Share Trading"));
        }
        field(4; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Remarks; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Charge Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Accounts" where("Product Category" = filter("Deposit Contribution" | "Share Capital" | "Fixed Deposit" | "Junior Savings" | "Ordinary Savings"));
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(9; "Created By"; Code[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup";
        }
        field(10; "Transaction Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(12; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(13; "Total Debits"; Decimal)
        {
            CalcFormula = sum("Share Transfer Lines"."Source Amount" where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(14; "Total Credits"; Decimal)
        {
            CalcFormula = sum("Share Transfer Lines"."Source Amount" where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(15; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;

            trigger OnValidate()
            var
                Lines: Record "Share Transfer Lines";
            begin
                Lines.Reset();
                Lines.setrange(Lines."No.", Rec.No);
                Lines.SetRange(Lines."Member No.", Rec."Member No");
                if Lines.FindFirst() then
                    Lines.Delete();

                Validate("Transfer Type");
            end;
        }
        field(16; "Transfer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Self,Other';
            OptionMembers = Self,Other;

            trigger OnValidate()
            begin
                TransDestin.Reset;
                TransDestin.SetRange(TransDestin."No.", No);
                if TransDestin.Find('-') then
                    TransDestin.DeleteAll;

                TransSource.Reset;
                TransSource.SetRange(TransSource."No.", No);
                if TransSource.Find('-') then
                    TransSource.DeleteAll;
            end;
        }
        field(17; "Send SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }

        field(50013; "Document Attached"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Document Attached" then
                    "Document Attached By" := UserId;
            end;
        }
        field(50014; "Document Attached By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Portal Transfer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; Amount; Decimal)
        {
            CalcFormula = sum("Share Transfer Lines"."Source Amount" where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(51200; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = true;
            TableRelation = "Dimension Set Entry";
            trigger OnLookup()
            var
                OldDimSetID: Integer;
                IsHandled: Boolean;
                DimMgt: Codeunit DimensionManagement;
            begin

                OldDimSetID := "Dimension Set ID";
                "Dimension Set ID" :=
                  DimMgt.EditDimensionSet(
                    Rec, "Dimension Set ID", No, "Global Dimension 1 Code", "Global Dimension 2 Code");

                //IsChanged := OldDimSetID <> "Dimension Set ID";
            end;

            trigger OnValidate()
            var
                DimMgt: Codeunit DimensionManagement;
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
            end;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."Share Transfer Nos");
            No := NoSeries.GetNextNo(NoSetup."Share Transfer Nos", WorkDate(), true);
        end;

        "Transaction Date" := Today;
        "Transaction Time" := Time;
        "Created By" := UserId;


        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");


            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";

            if Remarks = '' then
                Remarks := 'Share Transfer';
        end;
    end;

    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        SavingsREC: Record "Savings Accounts";
        TransSource: Record "Source Account Transfer";
        TransDestin: Record "Destination Account Transfers";
        Members: Record Members;
}

