page 50018 "Member Activites"
{
    PageType = CardPart;
    SourceTable = "Sacco Cues";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup(Members)
            {
                Caption = 'Members';

                // 🔹 ACTIVE (Core)
                field(MembersActiveDisplay; MembersActiveDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Members - Active';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        MemberRec: Record Members;
                    begin
                        MemberRec.SetRange("Member Status", MemberRec."Member Status"::Active);
                        Page.Run(Page::"Member List", MemberRec);
                    end;
                }

                // 🔹 LIFECYCLE
                field(MemberWithdrawalApplicationDisplay; MemberWithdrawalApplicationDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Withdrawal Application';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Style = StandardAccent;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        MemberRec: Record Members;
                    begin
                        MemberRec.SetRange("Member Status", MemberRec."Member Status"::"Withdrawal Application");
                        Page.Run(Page::"Member List", MemberRec);
                    end;
                }

                field(MemberWithdrawnDisplay; MemberWithdrawnDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member - Withdrawn';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Style = StandardAccent;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        MemberRec: Record Members;
                    begin
                        MemberRec.SetRange("Member Status", MemberRec."Member Status"::Withdrawn);
                        Page.Run(Page::"Member List", MemberRec);
                    end;
                }

                // 🔹 STATUS
                field(MembersDormantDisplay; MembersDormantDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Members - Dormant';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Style = Unfavorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        MemberRec: Record Members;
                    begin
                        MemberRec.SetRange("Member Status", MemberRec."Member Status"::Dormant);
                        Page.Run(Page::"Member List", MemberRec);
                    end;
                }

                field(MembersClosedDisplay; MembersClosedDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Members - Closed';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Style = Subordinate;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        MemberRec: Record Members;
                    begin
                        MemberRec.SetRange("Member Status", MemberRec."Member Status"::Closed);
                        Page.Run(Page::"Member List", MemberRec);
                    end;
                }

                field(MembersDeceasedDisplay; MembersDeceasedDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Members - Deceased';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Style = Ambiguous;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        MemberRec: Record Members;
                    begin
                        MemberRec.SetRange("Member Status", MemberRec."Member Status"::Deceased);
                        Page.Run(Page::"Member List", MemberRec);
                    end;
                }

                // 🔹 RISK
                field(MembersDefaulterDisplay; MembersDefaulterDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Members - Defaulter';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Style = Unfavorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        MemberRec: Record Members;
                    begin
                        MemberRec.SetRange("Member Status", MemberRec."Member Status"::Defaulter);
                        Page.Run(Page::"Member List", MemberRec);
                    end;
                }

                // 🔹 HIDDEN
                field(MemberFraudDisplay; MemberFraudDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member - Fraud';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Style = StandardAccent;
                    StyleExpr = true;
                    Visible = false;
                }
            }
        }
    }

    var
        MembersActiveDisplay: Decimal;
        MembersDormantDisplay: Decimal;
        MembersClosedDisplay: Decimal;
        MembersDeceasedDisplay: Decimal;
        MemberWithdrawalApplicationDisplay: Decimal;
        MemberWithdrawnDisplay: Decimal;
        MemberFraudDisplay: Decimal;
        MembersDefaulterDisplay: Decimal;

    trigger OnOpenPage()
    begin
        Rec.Reset();

        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        RefreshCueCounts();
    end;

    trigger OnAfterGetRecord()
    begin
        RefreshCueCounts();
    end;

    local procedure RefreshCueCounts()
    begin
        Rec.CalcFields(
            "Members - Active",
            "Members - Dormant",
            "Members - Closed",
            "Members - Deceased",
            "Withdrawal Application",
            "Member - Withdrawn",
            "Member - Fraud",
            "Members - Defaulter");

        MembersActiveDisplay := Rec."Members - Active";
        MembersDormantDisplay := Rec."Members - Dormant";
        MembersClosedDisplay := Rec."Members - Closed";
        MembersDeceasedDisplay := Rec."Members - Deceased";
        MemberWithdrawalApplicationDisplay := Rec."Withdrawal Application";
        MemberWithdrawnDisplay := Rec."Member - Withdrawn";
        MemberFraudDisplay := Rec."Member - Fraud";
        MembersDefaulterDisplay := Rec."Members - Defaulter";
    end;
}