table 50471 "Vote Transfer"
{
    DrillDownPageID = 50671;
    LookupPageID = 50671;

    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Source Vote"; Code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                "Source Vote Name" := '';

                GLAccount.RESET;
                IF GLAccount.GET("Source Vote") THEN BEGIN
                    "Source Vote Name" := GLAccount.Name;
                END;
                IF "Source Vote" <> '' THEN BEGIN

                    TESTFIELD("Budget Name");
                    TESTFIELD(Amount);

                    TotalComm := 0;
                    TotalBudAmount := 0;

                    //Get total Commmited amount and Total Expensed Amount............A  (TotalComm)
                    Commitment.RESET;
                    Commitment.SETRANGE(Commitment."G/L Account No.", "Source Vote");
                    Commitment.SETRANGE(Commitment.Budget, "Budget Name");
                    Commitment.SETRANGE(Commitment."Shortcut Dimension 1 Code", "Source Dimmension 1");
                    Commitment.SETRANGE(Commitment."Shortcut Dimension 2 Code", "Source Dimension 2");
                    Commitment.SETFILTER(Commitment.Amount, '>%1', 0);
                    IF Commitment.FIND('-') THEN BEGIN
                        //Add all entries
                        REPEAT
                            TotalComm := TotalComm + Commitment.Amount;
                        UNTIL Commitment.NEXT = 0;
                        //ERROR('%1',TotalComm);
                    END;


                    GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Name", "Budget Name");
                    GLBudgetEntry.SETRANGE(GLBudgetEntry."G/L Account No.", "Source Vote");
                    GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 1 Code", "Source Dimmension 1");
                    GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 2 Code", "Source Dimension 2");
                    IF GLBudgetEntry.FIND('-') THEN BEGIN
                        REPEAT
                            TotalBudAmount := TotalBudAmount + GLBudgetEntry.Amount;
                        UNTIL GLBudgetEntry.NEXT = 0;

                    END ELSE BEGIN
                        ERROR('No Budget exists within the supplied parameters ' +
                              'Budget Name %1,\Source Vote %2 \Dim 1: %3, \Dim 2: %4, \Dim 3: %5, \Dim 4: %6 \Dim 5: %7 \Dim 6: %8',
                                "Budget Name", "Source Vote", "Source Dimmension 1", "Source Dimension 2")
                    END;

                    //Less A from B      .........................................C (RemainingBudget)
                    RemainingBudget := TotalBudAmount - TotalComm;

                    //Amount to transfer should not exceed  C
                    IF Amount > RemainingBudget THEN BEGIN
                        diff := Amount - RemainingBudget;
                        ERROR('Amount to Transfer Exceed the budgetted amount by %1', diff);
                    END;


                END;
            end;
        }
        field(4; "Destination Vote"; Code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin

                "Destination Vote Name" := '';

                GLAccount.RESET;
                IF GLAccount.GET("Destination Vote Name") THEN BEGIN
                    "Destination Vote Name" := GLAccount.Name;
                END;
            end;
        }
        field(5; "Budget Name"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(6; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                fn_CheckAmount;
            end;
        }
        field(7; "Source Dimmension 1"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Source Dimmension 1");
            end;
        }
        field(8; "Destination Dimmension 1"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode1(1, "Destination Dimmension 1");
            end;
        }
        field(10; "Source Dimmension 2"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(11; "Destination Dimmension 2"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(12; Remarks; Text[200])
        {
        }
        field(13; "Raised By"; Code[20])
        {
        }
        field(14; "Raised Date"; Date)
        {
        }
        field(15; "Approved By"; Code[20])
        {
        }
        field(16; "Approved Date"; Date)
        {
        }
        field(17; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(18; Posted; Boolean)
        {
        }
        field(19; "Posted Date"; Date)
        {
        }
        field(20; "Posted By"; Code[20])
        {
        }
        field(21; "Source Dimension 2"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Source Dimmension 2");
            end;
        }
        field(22; "Destination Dimension 2"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode1(2, "Destination Dimmension 2");
            end;
        }
        field(23; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(24; "Responsibility Center"; Code[40])
        {
            TableRelation = "Responsibility Center";
        }
        field(25; "USER ID"; Code[50])
        {
        }
        field(26; "Source Vote Name"; Text[100])
        {
            Editable = false;
        }
        field(27; "Destination Vote Name"; Text[100])
        {
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Source Dimmension 1", "Source Dimension 2");
            end;
        }
        field(481; "Dimmension Set ID1"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Destination Dimmension 1", "Destination Dimension 2");
            end;
        }
    }

    keys
    {
        key(Key1; No)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if No = '' then begin

            NSetup.Get;
            NSetup.TestField("Loan Nos.");
            No := NoSeries.GetNextNo(NSetup."Vote Transfer", WorkDate(), true);

        end;

        "USER ID" := USERID;
    end;

    var
        NoSeries: Codeunit "No. Series";
        GLAccount: Record "G/L Account";
        TotalComm: Decimal;
        TotalBudAmount: Decimal;
        Commitment: Record Committment;
        NSetup: Record "Sales & Receivables Setup";
        GLBudgetEntry: Record "G/L Budget Entry";
        RemainingBudget: Decimal;
        diff: Decimal;
        DimMgt: Codeunit DimensionManagement;

    local procedure fn_CheckAmount()
    var
        GLBudgetEntry: Record "G/L Budget Entry";
    begin
        GLBudgetEntry.RESET;
        GLBudgetEntry.SETCURRENTKEY("Budget Name", "G/L Account No.", Date);
        GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Name", "Budget Name");
        GLBudgetEntry.SETRANGE(GLBudgetEntry."G/L Account No.", "Source Vote");
        GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 1 Code", "Source Dimmension 1");
        GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 2 Code", "Source Dimension 2");
        IF GLBudgetEntry.FIND('-') THEN BEGIN
            GLBudgetEntry.CALCSUMS(GLBudgetEntry.Amount);
            IF Amount > GLBudgetEntry.Amount THEN ERROR('Amount exceeds budgetted amount by %1', (Amount - GLBudgetEntry.Amount))
        END;
    end;

    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', 'Vote Tr', No));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Source Dimmension 1", "Destination Dimmension 1");
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;

    procedure ShowDimensions1()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', 'Vote Tr', No));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimmension Set ID1", "Source Dimension 2", "Destination Dimension 2");
    end;

    procedure ValidateShortcutDimCode1(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimmension Set ID1");
    end;

    procedure LookupShortcutDimCode1(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;
}

