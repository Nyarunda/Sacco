table 50437 "PR Salary Advance"
{
    Caption = 'PR Salary Advance';
    DataClassification = ToBeClassified;
    DrillDownPageId = "PR Salary Advance List";
    LookupPageId = "PR Salary Advance List";

    fields
    {
        field(1; "No."; code[20])
        {
            Caption = '';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Staff No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                StaffPayrollDtls: Record "Staff Payroll Details";
                SavAcc: Record "Savings Accounts";
                PRPeriod: Record "Payroll Periods";
                PRADV: Record "PR Salary Advance";
                ErrAdvance: label 'Staff No. %1 has an existing Mid-Month Salary application within the period %2';

            begin
                if "Staff No." <> xRec."Staff No." then begin
                    HREmp.Reset;
                    if HREmp.Get("Staff No.") then begin
                        "Staff Name" := HREmp.FullName;
                        "Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
                        "Member No." := HREmp."Member No";
                    end else begin
                        "Staff Name" := '';
                        "Global Dimension 1 Code" := '';
                        "Global Dimension 2 Code" := '';
                    end;
                    if StaffPayrollDtls.Get("Staff No.") then
                        "Basic Pay" := StaffPayrollDtls."Basic Pay";

                end;
                SavAcc.Reset();
                SavAcc.SetRange("Payroll/Staff No.", "Staff No.");
                SavAcc.SetRange("Salary Processing", true);
                if SavAcc.FindFirst() then "Salary Acc No." := SavAcc."No.";

                //Get current Open period
                PRPeriod.Reset();
                PRPeriod.SetRange(Closed, false);
                if PRPeriod.FindFirst() then begin
                    "Period Month" := PRPeriod."Period Month";
                    "Period Year" := PRPeriod."Period Year";
                    "Payroll Period" := PRPeriod."Date Opened";

                end;

                //check for an existing application in the same period
                PRADV.Reset();
                PRADV.SetRange("Staff No.", Rec."Staff No.");
                PRADV.SetRange("Payroll Period", Rec."Payroll Period");
                if PRADV.FindFirst() then Error(ErrAdvance, "Staff No.", "Payroll Period");

            end;
        }
        field(4; "Staff Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(5; "Advance Amount Requested"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Advance Amount Requested" > 2 / 3 * "Basic Pay" then Error('Advance amount cannot be more than 2 thirds of your Basic pay');

            end;
        }
        field(6; "Reasons for Advance Amount"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Responsibility Center"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(9; Status; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Date Posted"; Date)
        {
        }
        field(12; "Time Posted"; Time)
        {
        }
        field(13; "Posted By"; Code[100])
        {
        }
        field(14; "Global Dimension 1 Code"; Code[10])
        {
            CaptionClass = '1,1,1';
            Editable = false;
        }
        field(15; "Global Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,1,2';
            Editable = false;
        }
        field(16; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(17; "Salary Acc No."; code[50])
        { }
        field(18; "Basic Pay"; Decimal)
        {
            Editable = false;
        }
        field(19; "Period Month"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Period Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Periods"."Date Opened";
        }
        field(22; "Member No."; code[20])
        {
            DataClassification = ToBeClassified;

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
                    Rec, "Dimension Set ID", "No.", "Global Dimension 1 Code", "Global Dimension 2 Code");

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
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        UserSetup.Get(UserId);

        if "No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField(HRSetup."Salary Advance Nos.");

            "No." := NoSeries.GetNextNo(HRSetup."Salary Advance Nos.", WorkDate(), true);
        end;


        "Responsibility Center" := UserSetup."Responsibility Center";
        "Created By" := UserId;
        "Application Date" := Today;
    end;

    var
        UserSetup: Record "User Setup";
        NoSeries: Codeunit "No. Series";
        HRSetup: Record "HR Setup.";
        HREmp: Record Employee;
        BasicPay: Decimal;
}
