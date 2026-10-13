table 50584 "Collateral Allocation"
{
    Caption = 'Collateral Allocation';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Loan Collateral Allocation";
    LookupPageId =  "Loan Collateral ALlocation";

    fields
    {
        field(1; "Collateral No."; Code[20])
        {
            Caption = 'Collateral No.';
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            TableRelation = Members;
        }
        field(3; "Collateral Allocation"; Decimal)
        {
            Caption = 'Collateral Allocation';
            trigger OnValidate()
            var
                CollateralAll: Record "Collateral Allocation";
                CollateralReg: Record "Loan Collateral Register";
            begin
                if CollateralReg.Get("Collateral No.") then begin
                    CollateralAll.SetRange("Collateral No.", Rec."Collateral No.");
                    CollateralAll.CalcSums("Collateral Allocation");
                    if (CollateralAll."Collateral Allocation" + "Collateral Allocation") > CollateralReg."Charged Value" then
                        Error('Total Allocation percentage cannot exceed %1', CollateralReg."Charged Value");
                end;

            end;
        }
        field(4; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(5; Status; Option)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Loan Collateral Register".Status);
            OptionCaption = 'Open,Pending,Approved,Rejected,Returned';
            OptionMembers = Open,Pending,Approved,Rejected,Returned;


        }
    }
    keys
    {
        key(PK; "Collateral No.", "Entry No.")
        {
            Clustered = true;
        }
    }
}
