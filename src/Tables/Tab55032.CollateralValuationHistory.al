table 55032 "Collateral Valuation History"
{
    Caption = 'Collateral Valuation History';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Valuation History";
    LookupPageId = "Valuation History";

    fields
    {
        field(10; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeries.TestManual(SalesSetup."Valuation History No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(1; "Col. Reg. No."; Code[20])
        {
            Caption = 'Col. Reg. No.';
            TableRelation = "Loan Collateral Register";
            trigger OnValidate()
            var
                LSecurity: Record "Loan Collateral Register";
            begin
                LSecurity.Get("Col. Reg. No.");
                "Original Charged Value" := LSecurity."Charged Value";
                "Original Valuation Value" := LSecurity."Collateral Value";
            end;
        }
        field(2; "Valuation Date"; Date)
        {
            Caption = 'Valuation Date';
        }
        field(3; "Valuation Value"; Decimal)
        {
            Caption = 'Valuation Value';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //if "Valuation Value" > 
            end;
        }
        field(4; "Charged Value"; Decimal)
        {
            Caption = 'Charged Value';
        }
        field(5; User; Code[80])
        {
            Caption = 'User Name';
            Editable = false;
        }
        field(6; "Date Charged"; Date)
        {
            Editable = false;
        }
        field(7; Remarks; Text[100])
        {
        }
        field(8; "Original Charged Value"; Decimal)
        {
            Editable = false;
        }
        field(9; "Original Valuation Value"; Decimal)
        {
            Editable = false;
        }
        field(11; Posted; Boolean)
        {
        }
        field(29; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
            Editable = false;
        }
        field(30; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(43; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(45; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(46; Valuer; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(47; "Valuer Code"; code[30])
        {
            TableRelation = vendor;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                Vend.get("Valuer Code");
                Valuer := Vend.Name;
            end;
        }
    }
    keys
    {
        key(PK; "No.", "Col. Reg. No.", "Valuation Date")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Valuation History No.");
            "No." := NoSeries.GetNextNo(SalesSetup."Valuation History No.", WorkDate(), true);
        end;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";

    procedure UpdateChanges(var ColHist: Record "Collateral Valuation History")
    var
        myInt: Integer;
        ColReg: Record "Loan Collateral Register";
    begin

        ColReg.Reset();
        ColReg.SetRange(ColReg."No.", ColHist."Col. Reg. No.");
        if ColReg.FindLast() then begin
            if ColHist."Valuation Date" <> 0D then
                ColReg."Last Valuation Date" := ColHist."Valuation Date";
            if ColHist."Charged Value" <> 0 then
                ColReg."Charged Value" := ColHist."Charged Value";
            if ColHist."Valuation Value" <> 0 then
                ColReg.Validate("Collateral Value", ColHist."Valuation Value");
            ColReg."Valuer Code" := ColHist."Valuer Code";
            ColReg.Valuer := ColHist.Valuer;
            ColReg.Modify();
            Message('Completed');
        end;

    end;
}
