page 50090 "Payslip Data"
{
    Caption = 'Payslip Data';
    PageType = List;
    SourceTable = "Payslip Data";

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
                field(PAYE; Rec.PAYE)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PAYE field.';
                }
                field(Pension; Rec.Pension)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pension field.';
                }
                field("Insurance Certificate"; Rec."Insurance Certificate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insurance Certificate field.';
                }
                field("Suspend Pay"; Rec."Suspend Pay")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Suspend Pay field.';
                }
                field("Suspension Reasons"; Rec."Suspension Reasons")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Suspension Reasons field.';
                }
                field("Disable Personal Relief"; Rec."Disable Personal Relief")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Disable Personal Relief field.';
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Disable Personal Relief field.';
                }
            }
        }
    }
}
