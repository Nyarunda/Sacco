page 51005 P9OLD
{
    Caption = 'P9OLD';
    PageType = List;
    SourceTable = "prEmployee P9 Info";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Basic Pay field.';
                }
                field(Allowances; Rec.Allowances)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allowances field.';
                }
                field(Benefits; Rec.Benefits)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Benefits field.';
                }
                field("Value Of Quarters"; Rec."Value Of Quarters")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Value Of Quarters field.';
                }
                field("Defined Contribution"; Rec."Defined Contribution")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Defined Contribution field.';
                }
                field("Owner Occupier Interest"; Rec."Owner Occupier Interest")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Owner Occupier Interest field.';
                }
                field("Gross Pay"; Rec."Gross Pay")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gross Pay field.';
                }
                field("Taxable Pay"; Rec."Taxable Pay")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Taxable Pay field.';
                }
                field("Tax Charged"; Rec."Tax Charged")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Charged field.';
                }
                field("Insurance Relief"; Rec."Insurance Relief")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insurance Relief field.';
                }
                field("Tax Relief"; Rec."Tax Relief")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Relief field.';
                }
                field(PAYE; Rec.PAYE)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PAYE field.';
                }
                field(NSSF; Rec.NSSF)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NSSF field.';
                }
                field(NHIF; Rec.NHIF)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NHIF field.';
                }
                field(Deductions; Rec.Deductions)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deductions field.';
                }
                field("Net Pay"; Rec."Net Pay")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Pay field.';
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Month field.';
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Year field.';
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll Period field.';
                }
                field(Pension; Rec.Pension)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pension field.';
                }
                field(HELB; Rec.HELB)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HELB field.';
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll Code field.';
                }
            }
        }
    }
}
