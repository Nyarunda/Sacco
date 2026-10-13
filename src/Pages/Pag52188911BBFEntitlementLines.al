Page 50613 "BBF Entitlement Lines"
{
    Caption = 'GFE Entitlement Lines';
    DeleteAllowed = true;
    PageType = ListPart;
    SourceTable = "BBF Entitlement Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EntryNo; Rec."Entry No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(HeaderNo; Rec."Header No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Claim Type"; Rec."Claim Type")
                {
                    ApplicationArea = Basic;
                }

                field("Death Certificate No."; Rec."Death Certificate No.")
                {
                    ApplicationArea = Basic;
                    //Enabled = DemiseDet;
                }
                field("Relationship Type"; Rec."Relationship Type")
                {
                    ApplicationArea = Basic;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }

                field(BBFEntitlementCode; Rec."BBF Entitlement Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(BBFEntitlementClaimed; Rec."BBF Entitlement Claimed")
                {
                    ApplicationArea = Basic;
                }
                field(BBFEntitlementPaid; Rec."BBF Entitlement Paid")
                {
                    ApplicationArea = Basic;
                }

                field(Deceased; Rec.Deceased)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Beneficiary; Rec.Beneficiary)
                {
                    ApplicationArea = Basic;
                }
                field(DateofBirth; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Allocation; Rec."%Allocation")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}
