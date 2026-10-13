Table 55017 "prEmployee Transactions"
{

    fields
    {
        field(1; "Employee Code"; Code[30])
        {
            //TableRelation = "HR Employees"."No.";
        }
        field(2; "Transaction Code"; Code[30])
        {
            //TableRelation = "prTransaction Codes"."Transaction Code";

        }
        field(3; "Transaction Name"; Text[100])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Balance; Decimal)
        {
        }
        field(6; "Original Amount"; Decimal)
        {
        }
        field(7; "Period Month"; Integer)
        {
        }
        field(8; "Period Year"; Integer)
        {
        }
        field(9; "Payroll Period"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(10; "#of Repayments"; Integer)
        {
        }
        field(11; Membership; Code[20])
        {
        }
        field(12; "Reference No"; Text[100])
        {
            //TableRelation = "SACCO Account"."No." where ("Payroll/Staff No"=field("Employee Code"));
        }
        field(13; integera; Integer)
        {
        }
        field(14; "Employer Amount"; Decimal)
        {
        }
        field(15; "Employer Balance"; Decimal)
        {
        }
        field(16; "Stop for Next Period"; Boolean)
        {
        }
        field(17; "Amortized Loan Total Repay Amt"; Decimal)
        {
        }
        field(18; "Start Date"; Date)
        {
        }
        field(19; "End Date"; Date)
        {
        }
        field(20; "Loan Number"; Code[30])
        {

        }
        field(21; "Payroll Code"; Code[20])
        {
            //TableRelation = "prPayroll Type";
        }
        field(22; "No of Units"; Decimal)
        {

            trigger OnValidate()
            begin
                Amount := xRec.Amount * "No of Units";
                /*
               IF EmpPayroll.GET("Employee Code") THEN BEGIN
               IF PrTransCode.GET("Transaction Code") THEN BEGIN
               EVALUATE(Myformula,PrTransCode.Formula);
               Amount:=ROUND(Myformula* EmpPayroll."Basic Pay"*"No of Units",0.05,'>')
               END;
               END;
               */

            end;
        }
        field(23; Suspended; Boolean)
        {
        }
        field(25; "Loan Account No"; Code[30])
        {
        }
        field(27; "PV Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }

        field(41; Stopped; Boolean)
        {
        }
        field(42; "Subledger Account"; Code[10])
        {

        }
        field(43; Subledger; Option)
        {
            OptionCaption = ' ,Customer,Vendor';
            OptionMembers = " ",Customer,Vendor;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Period Month", "Period Year", "Reference No")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Transaction Code", "Transaction Name")
        {
        }
    }

    var
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        blnIsLoan: Boolean;
        objEmpTrans: Record "prEmployee Transactions";
        transType: Text[30];
        strExtractedFrml: Text[30];
        curTransAmount: Decimal;
        empCode: Text[30];
        Myformula: Decimal;
}

