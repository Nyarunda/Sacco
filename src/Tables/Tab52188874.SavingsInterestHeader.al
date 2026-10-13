table 50576 "Savings Interest Header"
{
    // DrillDownPageID = 39004400;
    //LookupPageID = 39004400;

    fields
    {
        field(1; "No."; Code[30])
        {
            Editable = false;


            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    NoSetup.GET;
                    NoSeriesMgt.TestManual(NoSetup."FOSA Interest Nos.");
                    "No. Series" := '';
                END;
                IF UserSetup.GET(USERID) THEN BEGIN
                    "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                    //"Responsibility Center" := UserSetup."Responsibility Centre";
                END;
            end;
        }
        field(2; "Posting Date"; Date)
        {
        }
        field(3; "Document No."; Code[30])
        {
            Editable = true;
        }
        field(4; "Distributed Amount"; Decimal)
        {
            CalcFormula = Sum("Savings Interest Lines"."Interest Amount" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; Posted; Boolean)
        {
            Editable = false;
        }
        field(6; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(7; Cashier; Code[30])
        {
            Editable = false;
            TableRelation = "User Setup";
        }
        field(8; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending Approval,,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",,Approved,Rejected;
        }
        field(9; "Posted By"; Code[30])
        {
            Editable = false;
        }
        field(10; "Time Posted"; Time)
        {
            Editable = false;
        }
        field(11; Description; Text[30])
        {
        }
        field(12; "Responsibility Center"; Code[20])
        {
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(13; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(14; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(15; "Start Date"; Date)
        {

            trigger OnValidate()
            begin
                IF "Start Date" = 0D THEN BEGIN
                    "End Date" := 0D;
                    "Document No." := '';
                    Description := '';
                    "Posting Date" := 0D
                END
                ELSE BEGIN

                    // IF Type=Type::" " THEN
                    // ERROR('Type Must have a value');

                    CASE Type OF
                        Type::Monthly:
                            BEGIN
                                "End Date" := CALCDATE('<CM>', "Start Date");
                                "Document No." := FORMAT("End Date", 0, '<Month Text>') + ' - ' + FORMAT(DATE2DMY("End Date", 3));
                                Description := FORMAT("End Date", 0, '<Month Text>') + ' - ' + FORMAT(DATE2DMY("End Date", 3));
                                "Posting Date" := CALCDATE('<CM>', "Start Date");

                            END;
                        Type::Yearly:
                            BEGIN
                                "End Date" := CALCDATE('<CY>', "Start Date");
                                "Document No." := 'INTEREST ' + FORMAT(DATE2DMY("End Date", 3));
                                Description := 'Account Interest ' + FORMAT(DATE2DMY("End Date", 3));
                                "Posting Date" := CALCDATE('<CY>', "Start Date");

                            END;
                    END;
                END;
            end;
        }
        field(16; "End Date"; Date)
        {
            Editable = false;
        }
        field(17; "No of Accs."; Integer)
        {
            CalcFormula = Count("Savings Interest Lines" WHERE(No = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; Type; Option)
        {
            OptionCaption = ' ,Monthly,Yearly';
            OptionMembers = " ",Monthly,Yearly;

            trigger OnValidate()
            begin
                VALIDATE("Start Date");
            end;
        }
        field(19; "Old Interest Total"; Decimal)
        {
            CalcFormula = Sum("Savings Interest Lines"."Old Interest Amount" WHERE(No = FIELD("No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Start Date", "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            NoSetup.Get;
            NoSetup.TestField("FOSA Interest Nos.");
            "No." := NoSeriesMgt.GetNextNo(NoSetup."FOSA Interest Nos.", WorkDate(), true);
        END;

        Cashier := USERID;
        "Document No." := "No.";
        UserSetup.GET(USERID);
        //BEGIN
        UserSetup.TESTFIELD("Global Dimension 1 Code");
        UserSetup.TESTFIELD("Global Dimension 2 Code");
        // UserSetup.TESTFIELD("Responsibility Centre");
        "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        //"Responsibility Center" := UserSetup."Responsibility Centre";
        //END;
    end;

    var
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        NoSetup: Record "Sales & Receivables Setup";
        CUST: Record Members;
}
