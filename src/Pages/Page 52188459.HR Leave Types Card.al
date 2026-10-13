
Page 50122 "HR Leave Types Card"
{
    PageType = Card;
    SourceTable = "HR Leave Types.";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Days; Rec.Days)
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field(InclusiveofNonWorkingDays; Rec."Inclusive of Non Working Days")
                {
                    ApplicationArea = Basic;
                }
                field(IsAnnualLeave; Rec."Is Annual Leave")
                {
                    ApplicationArea = Basic;
                }
                field(CarryForwardAllowed; Rec."Carry Forward Allowed")
                {
                    ApplicationArea = Basic;
                }
                field(MaxCarryForwardDays; Rec."Max Carry Forward Days")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        fn_SetVisible;
    end;

    var

        CarryForwardVisible: Boolean;

    local procedure fn_SetVisible()
    begin
        //Dann - To hide fields to prevent setup errors and hide uneccessary fields
        CarryForwardVisible := false;
        case Rec.Balance of
            Rec.Balance::"Carry Forward":
                begin
                    CarryForwardVisible := true;
                end;
        end;
    end;
}

