
Table 50231 "Payroll Remittance Accounts"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Employee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Employee;
        }
        field(3; "Bank  Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Bank Name" := '';
                "Branch Code" := '';
                "Branch Name" := '';
                /*
                BankCodes.RESET;
                BankCodes.SETRANGE(BankCodes."Bank Code","Bank  Code");
                IF BankCodes.FIND('-') THEN BEGIN
                    "Bank Name":=BankCodes."Bank Name";
                END;
                */

            end;
        }
        field(4; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Branch Name" := '';
                /*
                BankCodes.RESET;
                BankCodes.SETRANGE(BankCodes."Bank Code","Bank  Code");
                BankCodes.SETRANGE(BankCodes."Branch Code","Branch Code");
                IF BankCodes.FIND('-') THEN BEGIN
                    "Branch Name":=BankCodes."Branch Name";
                END;
                */

            end;
        }
        field(6; "Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "A/C  Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Percentage to Transfer"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                currAmount: Decimal;
                Total: Decimal;
            begin
                /*
                HREmployeeBankAcc.reset;
                HREmployeeBankAcc.setrange(HREmployeeBankAcc."Employee Code","Employee Code");
                if HREmployeeBankAcc.find('-') then
                begin
                    Total:=0;
                    currAmount:=HREmployeeBankAcc."Amount to Transfer (%)";
                    repeat
                        Total += HREmployeeBankAcc."Amount to Transfer (%)";
                    until HREmployeeBankAcc.next = 0;
                    if total + curramount > 100 then error('Percentage of amount to tranfer exceed 100%');
                end;
                */

            end;
        }
        field(50000; "Sacco Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Payment to"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Bank,Sacco,Cash;
        }
        field(50003; "Total % Allocation"; Decimal)
        {
            CalcFormula = sum("Payroll Remittance Accounts"."Percentage to Transfer" where("Employee Code" = field("Employee Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

