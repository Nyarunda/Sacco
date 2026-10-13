
Page 50230 "Standing Orders List"
{
    ApplicationArea = Basic;
    CardPageID = "Standing Order Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Standing Order Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(CreatedBy; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field(SourceAccountNo; Rec."Source Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(SourceAccountName; Rec."Source Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Type"; Rec."Destination Account Type")
                {
                    ApplicationArea = Basic;
                    ValuesAllowed = "G/L Account", External, Internal, Credit;
                }
                field(PayrollStaffNo; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field(IncomeType; Rec."Income Type")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(EffectiveStartDate; Rec."Effective/Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(NextRunDate; Rec."Next Run Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        Usersetup: Record "User Setup";
    begin

        UserSetup.Get(UserId);
        if not UserSetup."STO processing" then
            Error('You do not have any permissions for STO processing to access. Contact the administrator!');
    end;
}

