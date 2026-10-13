
Table 50249 "Journal Line Dimension"
{

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
        }
        field(2; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
        }
        field(3; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = if ("Table ID" = filter(81 | 221)) "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"))
            else
            if ("Table ID" = const(83)) "Item Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"))
            //else if ("Table ID"=const(89)) Table234.Field2 where (Field1=field("Journal Template Name"))
            else
            if ("Table ID" = const(207)) "Res. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"))
            else
            if ("Table ID" = const(246)) "Requisition Wksh. Name".Name where("Worksheet Template Name" = field("Journal Template Name"))
            else
            if ("Table ID" = const(5621)) "FA Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"))
            else
            if ("Table ID" = const(5635)) "Insurance Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(4; "Journal Line No."; Integer)
        {
            Caption = 'Journal Line No.';
        }
        field(5; "Allocation Line No."; Integer)
        {
            Caption = 'Allocation Line No.';
        }
        field(6; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            NotBlank = true;
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                if not DimMgt.CheckDim("Dimension Code") then
                    Error(DimMgt.GetDimErr);
                "Dimension Value Code" := '';
            end;
        }
        field(7; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension Code"));

            trigger OnValidate()
            begin
                if not DimMgt.CheckDimValue("Dimension Code", "Dimension Value Code") then
                    Error(DimMgt.GetDimErr);
            end;
        }
        field(8; "New Dimension Value Code"; Code[20])
        {
            Caption = 'New Dimension Value Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension Code"));

            trigger OnValidate()
            begin
                if not DimMgt.CheckDimValue("Dimension Code", "New Dimension Value Code") then
                    Error(DimMgt.GetDimErr);
            end;
        }
    }

    keys
    {
        key(Key1; "Table ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        GLSetup: Record "General Ledger Setup";
        DimMgt: Codeunit DimensionManagement;
}

