
Page 50570 "NSSF Setup"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = NSSF;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TierCode; Rec."Tier Code")
                {
                    ApplicationArea = Basic;
                }
                field(LowerLimit; Rec."Lower Limit")
                {
                    ApplicationArea = Basic;
                }
                field(UpperLimit; Rec."Upper Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Amount"; Rec."Employee Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Amount"; Rec."Employer Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Use Percentage"; Rec."Use Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("% Amount"; Rec."% Amount")
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
