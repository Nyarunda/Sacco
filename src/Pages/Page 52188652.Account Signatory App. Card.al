
Page 50315 "Account Signatory App. Card"
{
    ApplicationArea = All;
    PageType = Card;
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
                    LookupPageID = "Member Listing";
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Position; Rec.Position)
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
            part(Nextofkingroup; "Next of Kin App. Group")
            {
                SubPageLink = "Principal ID No." = field("ID No."), "No." = field("Code");
            }
        }

    }

    actions
    {
    }
}

