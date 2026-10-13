page 59990 "Security Sub. Replacements"
{
    PageType = ListPart;
    SourceTable = "Security Sub. Replacement";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Guarantor Type"; Rec."Guarantor Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        AutoAssignOutgoingMemberOnPage();
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Substituted Member"; Rec."Substituted Member")
                {
                    ApplicationArea = Basic;
                    Caption = 'Outgoing Guarantor';

                    trigger OnValidate()
                    begin
                        AutoAssignOutgoingMemberOnPage();
                    end;
                }
                field("Available Guarantorship"; Rec."Available Guarantorship")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Collateral Reg. No."; Rec."Collateral Reg. No.")
                {
                    ApplicationArea = Basic;
                }
                field("Replacement Amount"; Rec."Replacement Amount")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        AutoAssignOutgoingMemberOnPage();
                    end;
                }
            }
        }
    }

    local procedure AutoAssignOutgoingMemberOnPage()
    var
        CandidateMemberNo: Code[20];
    begin
        if Rec."Substituted Member" <> '' then
            exit;

        CandidateMemberNo := FindBestOutgoingMemberOnPage();
        if CandidateMemberNo = '' then
            exit;

        Rec.Validate("Substituted Member", CandidateMemberNo);
    end;

    local procedure FindBestOutgoingMemberOnPage(): Code[20]
    var
        CandidateLines: Record "Security Sub. Lines";
        SelectedMemberNo: Code[20];
        CandidateMemberNo: Code[20];
        CandidateUsage: Integer;
        BestUsage: Integer;
    begin
        BestUsage := 2147483647;

        CandidateLines.Reset();
        CandidateLines.SetRange("Header No.", Rec."Header No.");
        CandidateLines.SetRange("Loan No.", Rec."Loan No.");
        CandidateLines.SetRange(Substituted, true);
        if CandidateLines.FindSet() then
            repeat
                CandidateMemberNo := CandidateLines."Member No";
                if CandidateMemberNo = '' then
                    continue;

                CandidateUsage := GetReplacementUsageCountOnPage(CandidateMemberNo);
                if CandidateUsage < BestUsage then begin
                    BestUsage := CandidateUsage;
                    SelectedMemberNo := CandidateMemberNo;
                end;
            until CandidateLines.Next() = 0;

        exit(SelectedMemberNo);
    end;

    local procedure GetReplacementUsageCountOnPage(MemberNo: Code[20]): Integer
    var
        ReplacementCount: Record "Security Sub. Replacement";
    begin
        ReplacementCount.Reset();
        ReplacementCount.SetRange("Header No.", Rec."Header No.");
        ReplacementCount.SetRange("Loan No.", Rec."Loan No.");
        ReplacementCount.SetRange("Substituted Member", MemberNo);
        if Rec."Line No." <> 0 then
            ReplacementCount.SetFilter("Line No.", '<>%1', Rec."Line No.");

        exit(ReplacementCount.Count());
    end;
}
