Table 50309 "Dividend Simulation Header"
{

    fields
    {
        field(1; "No."; Code[10])
        {
            Editable = false;

            trigger OnValidate()
            begin
                //*
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeries.TestManual(SeriesSetup."Dividend Simulation Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Start Date"; Date)
        {

            trigger OnValidate()
            begin
                if xRec."Start Date" <> 0D then
                    if Confirm(ConfirmChange, false) then
                        ClearDividendLines("No.")
                    else
                        Error(ExitProcessErr);
            end;
        }
        field(3; "End Date"; Date)
        {

            trigger OnValidate()
            begin
                if xRec."End Date" <> 0D then
                    if Confirm(ConfirmChange, false) then
                        ClearDividendLines("No.")
                    else
                        Error(ExitProcessErr);
            end;
        }
        field(4; Deposits; Decimal)
        {
            CalcFormula = sum("Dividend Simulation Lines".Amount where("Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Weighted Amount"; Decimal)
        {
            CalcFormula = sum("Dividend Simulation Lines"."Weighted Amount" where("Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Total Payout"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                /* CALCFIELDS(Deposits,"Weighted Amount");
                 IF (Deposits<>0) AND ("Weighted Amount"<>0) AND ("Total Payout"<> 0)  THEN
                    Rate:= ("Total Payout"/"Weighted Amount")*100;
                 */

            end;
        }
        field(7; Rate; Decimal)
        {

            trigger OnLookup()
            begin
                /*CALCFIELDS(Deposits,"Weighted Amount");
                IF (Deposits<>0) AND ("Weighted Amount"<>0) AND ("Total Payout"<> 0)  THEN
                   Rate:= ("Total Payout"/"Weighted Amount")*100;*/

            end;

            trigger OnValidate()
            begin
                TestField("All Products", false);

                DividendCalculationBuffer.Reset;
                DividendCalculationBuffer.SetRange(DividendCalculationBuffer."Document No.", "No.");
                if DividendCalculationBuffer.FindSet then
                    DividendCalculationBuffer.DeleteAll;
            end;
        }
        field(8; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Rejected,Approved,Transferred';
            OptionMembers = Open,Pending,Rejected,Approved,Transferred;
        }
        field(9; "Product Type"; Code[10])
        {
            TableRelation = "Product Setup" where("Product Class" = const(Savings));

            trigger OnValidate()
            var
                ProductFactory: Record "Product Setup";
                CustomerPostingGroup: Record "Customer Posting Group";
            begin
                if ProductFactory.Get("Product Type") then begin
                    "Product Name" := ProductFactory."Description";
                    if CustomerPostingGroup.Get(ProductFactory."Product Posting Group") then begin
                        "G/L Account" := CustomerPostingGroup."Payables Account";
                        if "G/L Account" = '' then
                            "G/L Account" := CustomerPostingGroup."Receivables Account";
                    end;
                end;
            end;
        }
        field(10; "Product Name"; Text[80])
        {
            Editable = false;
        }
        field(11; "G/L Account"; Code[20])
        {
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(12; "No. Series"; Code[10])
        {
        }
        field(13; "Created By"; Code[50])
        {
        }
        field(14; "All Products"; Boolean)
        {

            trigger OnValidate()
            begin

                if "All Products" then
                    Rate := 0;
            end;
        }
        field(15; "Total Pay"; Decimal)
        {
            CalcFormula = sum("Dividend Simulation Lines"."Pay Out" where("Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Total W/Tax"; Decimal)
        {
            CalcFormula = sum("Dividend Simulation Lines"."W/Tax" where("Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Total Net"; Decimal)
        {
            CalcFormula = sum("Dividend Simulation Lines"."Net Pay" where("Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
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
        //*
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Dividend Simulation Nos");
            "No." := NoSeries.GetNextNo(SeriesSetup."Dividend Simulation Nos", WorkDate(), true);
        end;

        "Created By" := UserId;
    end;

    var
        ExitProcessErr: label 'You have selected to abort process date Change will be rolled back';
        ConfirmChange: label 'The Change you want to will  affect any processed data do you wish to continue?';
        SeriesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        DividendCalculationBuffer: Record "Dividend Simulation Lines";

    local procedure ClearDividendLines(No: Code[20])
    var
        DividendSimulationLines: Record "Dividend Simulation Lines";
    begin
        DividendSimulationLines.Reset;
        DividendSimulationLines.SetRange(DividendSimulationLines."No.", No);
        if DividendSimulationLines.Find('-') then
            DividendSimulationLines.DeleteAll;
    end;
}

