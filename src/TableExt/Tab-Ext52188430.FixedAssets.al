tableextension 50065 "Fixed Assets" extends "Fixed Asset"
{

    fields
    {
        field(90000; Custodian; Text[200])
        {
            Caption = 'Custodian';
            DataClassification = ToBeClassified;
        }
        field(50013; "Year of Purchase"; Date)
        {
            Caption = 'Year of Purchase';
            DataClassification = ToBeClassified;
        }
        field(50017; "Depart. / Section"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Acquisition Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50019; "Asset Type"; Option)
        {
            OptionMembers = Owned,Leased;
        }
        field(50063; "Static Book Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50065; "Book Value"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("FA Ledger Entry".Amount where("FA No." = field("No."),
                                                              //"Depreciation Book Code" = field("Depreciation Book Code"),
                                                              "Part of Book Value" = const(true),
                                                              "FA Posting Date" = field("FA Posting Date Filter")));
            Caption = 'Book Value';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50064; "Revaluation Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Active Life Time"; Integer)
        {
        }
        field(50077; "Asset Tag"; Text[20])
        {
        }
        field(50078; "Custom Depreciation"; Option)
        {
            OptionMembers = " ","Reducing Balance","Straight Line";

            trigger OnValidate()
            var
                Method: Enum "FA Depreciation Method";
            begin
                "Custom Depreciation" := "Custom Depreciation"::" ";
                //if "Custom Depreciation" = "Custom Depreciation"::"Reducing Balance" then
            end;
        }

    }
    trigger OnInsert()
    var
        UserSetup: Record "User Setup";
        FASubCalss: Record "FA Subclass";
        FABooK: Record "FA Depreciation Book";
    begin

        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Fixed Asset", true);
        if not UserSetup.findfirst then
            error('You do not have the permission to capture fixed assets. Contact system admin.!');

        if FASubCalss.Get("FA Subclass Code") then begin

            FABooK.Reset();
            FABooK.SetRange("FA No.", "No.");
            if FABooK.FindFirst() then begin
                FABooK."Depreciation Method" := FABooK."Depreciation Method"::"Declining-Balance 1";
                FABooK."Declining-Balance %" := FASubCalss."Depreciation Rate";
                FABooK.Modify();
            end;
        end;
    end;

}
