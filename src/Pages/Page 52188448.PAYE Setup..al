
Page 50095 "PAYE Setup."
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = PAYE;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Control7)
            {
                field(TierCode; Rec."Tier Code")
                {
                    ApplicationArea = Basic;
                }
                field(PAYETier; Rec."PAYE Tier")
                {
                    ApplicationArea = Basic;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        RestrictAccess
    end;


    procedure RestrictAccess()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}
