
Page 50316 "Account Signatories"
{
    // CardPageID = "Account Signatory Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    Caption = 'Can Transact Account';
    SourceTable = "Account Signatories.";
    SourceTableView = where(Type = filter(<> Authorized));

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
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
                    Visible = false;

                }
                field(StaffPayroll; Rec."Staff/Payroll")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(PhoneNo; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Signatory; Rec.Signatory)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(MustSign; Rec."Must Sign")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(MustbePresent; Rec."Must be Present")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

