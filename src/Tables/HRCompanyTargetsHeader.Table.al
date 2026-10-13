Table 50981 "HR Company Targets Header"
{

    fields
    {
        field(1; "Appraisal no"; Code[20])
        {
        }
        field(2; "Appraisal Period"; Date)
        {
            TableRelation = "HR Appraisal Period"."Appraisal Period";
        }
        field(3; "Appraisal Date"; Date)
        {
        }
        field(4; "Employee No"; Code[20])
        {
            TableRelation = "HR Succession Job Rotation"."Line No.";
        }
        field(5; "Financial Targeted Score"; Decimal)
        {
            CalcFormula = sum("HR Individual Target Line"."Targeted Score" where("Perspective Type" = filter("Financial Stewardship")));
            FieldClass = FlowField;
        }
        field(7; "Achieved Financial  Score"; Decimal)
        {
            FieldClass = Normal;
        }
        field(8; "Unachieved Targets"; Decimal)
        {
        }
        field(9; "Employee Name"; Text[100])
        {
        }
        field(10; "Training Targeted Score"; Decimal)
        {
            CalcFormula = sum("HR Individual Target Line"."Targeted Score" where("Perspective Type" = filter("Training and Development")));
            FieldClass = FlowField;
        }
        field(11; "Service Delivery Target Score"; Decimal)
        {
            CalcFormula = sum("HR Individual Target Line"."Targeted Score" where("Perspective Type" = filter("Service Delivery")));
            FieldClass = FlowField;
        }
        field(12; "Customer Target Score"; Decimal)
        {
            CalcFormula = sum("HR Individual Target Line"."Targeted Score" where("Perspective Type" = filter("Customer and Sales")));
            FieldClass = FlowField;
        }
        field(13; "Customer Achieved  Score"; Decimal)
        {
        }
        field(14; "Service Delivery Achieved"; Decimal)
        {
        }
        field(15; "Training Achieved  Score"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Appraisal no")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

