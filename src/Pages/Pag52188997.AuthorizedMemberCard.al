namespace CentralDB.CentralDB;

page 50699 "Authorized Member Card"
{
    ApplicationArea = All;
    Caption = 'Authorized Member Card';
    PageType = Card;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Account Signatories.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(DateOfBirth; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(StaffPayroll; Rec."Staff/Payroll")
                {
                    ApplicationArea = Basic;
                }
                field(PhoneNo; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(Signatory; Rec.Signatory)
                {
                    ApplicationArea = Basic;
                }
                field(MustSign; Rec."Must Sign")
                {
                    ApplicationArea = Basic;
                }
                field(MustbePresent; Rec."Must be Present")
                {
                    ApplicationArea = Basic;
                }
                group(Control14)
                {
                    field(Picture; Rec.Picture)
                    {
                        ApplicationArea = Basic;
                    }
                    field(Signature; Rec.Signature)
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
        }
    }

    actions
    {
    }
}
