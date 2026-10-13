
TableExtension 50018 tableextension50018 extends "FA Depreciation Book"
{
    fields
    {

        field(50050; "Customized Depr. Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Last Transaction Date"; Date)
        {
            AutoFormatType = 1;
            CalcFormula = Max("FA Ledger Entry"."Posting Date" WHERE("FA No." = FIELD("FA No."),
                                                              "Depreciation Book Code" = FIELD("Depreciation Book Code"),
                                                              "FA Posting Category" = CONST(" "),
                                                              "FA Posting Date" = FIELD("FA Posting Date Filter")));
            Caption = 'Acquisition Cost';
            Editable = false;
            FieldClass = FlowField;
        }
    }


    trigger OnInsert()
    var
        myInt: Integer;
        FASubClass: Record "FA Subclass";
        FA: Record "Fixed Asset";
        FADepreciationBook: Record "FA Depreciation Book";
    begin
        "Depreciation Starting Date" := CalcDate('1Y-CY', today);
    end;
}

