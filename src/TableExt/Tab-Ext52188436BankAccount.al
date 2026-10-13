
TableExtension 50079 tableextension52188415 extends "Bank Account"
{
    fields
    {

        //Unsupported feature: Code Insertion on ""Bank Acc. Posting Group"(Field 21)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        //IF "Bank Acc. Posting Group"<> '' THEN
        //ERROR('Editing Posting Not Allowed');
        */
        //end;
        field(50000; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(50001; "Cheque Clearing Acc."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Bank Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Normal,Cash,Fixed Deposit,SMPA,Chq Collection,Cashier,Treasury,ATM,MR';
            OptionMembers = Normal,Cash,"Fixed Deposit",SMPA,"Chq Collection",Cashier,Treasury,ATM,MR;

            trigger OnValidate()
            begin

                //TestNoEntriesExist(FIELDCAPTION("Bank Type"));
            end;
        }
        field(50003; "Pending Voucher Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Bank Branch Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Previous Statement No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Cashier ID"; Code[80])
        {
            CalcFormula = lookup("Banking User Setup"."User Name" where("Default  Bank" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Banking User Setup";
        }
        field(50009; "Max Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50090; "GL Account"; Code[20])
        {
            CalcFormula = lookup("Bank Account Posting Group"."G/L Account No." where(Code = field("Bank Acc. Posting Group")));
            FieldClass = FlowField;
        }
        field(50091; "Responsible User"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50092; "PV User"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }

        field(50093; "Maximum Credit Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
    }
    trigger OnModify()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("Edit Bank Accounts", false);
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst() then Error('You do not have permission [Edit Bank Accounts]');
    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        Error('Not Allowed');
    end;
}

