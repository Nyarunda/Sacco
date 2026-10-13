namespace UnitedWomen.UnitedWomen;

page 50006 "Sky Blank Receiver Trans."
{
    ApplicationArea = Basic;
    Caption = 'Sky Blank Receiver Transactions';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sky M-Banking Transactions";
    UsageCategory = Lists;
    SourceTableView = where(Reversed = const(false),
                            "Transaction Type" = filter("Loan Full-Statement" | "Account Full-Statement" | "Account Mini-Statement")
                            );

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction ID"; Rec."Transaction ID")
                {
                    ApplicationArea = Basic;
                }
                field("Receiver Account"; Rec."Receiver Account")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Account"; Rec."Savings Account")
                {
                    ApplicationArea = Basic;
                }
                field("Source Name"; Rec."Source Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account"; Rec."Source Account")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName; MemberName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                }
                field("Destination Account"; Rec."Destination Account")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec."Transaction Amount")
                {
                    ApplicationArea = Basic;
                }
                field(NeedsChange; Rec."Needs Change")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(PostedBy; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(ChangedBy; Rec."Changed By")
                {
                    ApplicationArea = Basic;
                }
                field(DateChanged; Rec."Changed Date")
                {
                    ApplicationArea = Basic;
                }
                field("Originator ID"; Rec."Originator ID")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        MemberName := GetDisplayMemberName();
    end;

    local procedure GetDisplayMemberName(): Text[100]
    var
        SavingsAccount: Record "Savings Accounts";
        Member: Record Members;
        OldMemberNo: Code[20];
    begin
        Rec.CalcFields("Member Name");
        if Rec."Member Name" <> '' then
            exit(Rec."Member Name");

        if Rec."Savings Account" <> '' then
            if SavingsAccount.Get(Rec."Savings Account") then
                exit(SavingsAccount.Name);

        OldMemberNo := GetOldMemberNoFromReference(Rec."Savings Account");
        if OldMemberNo <> '' then begin
            Member.SetRange("Old Member No.", OldMemberNo);
            if Member.FindFirst() then
                exit(Member.Name);
        end;

        exit(Rec."Source Name");
    end;

    local procedure GetOldMemberNoFromReference(AccountReference: Text[100]): Code[20]
    var
        SeparatorPosition: Integer;
    begin
        SeparatorPosition := StrPos(AccountReference, '#');
        if SeparatorPosition <= 1 then
            exit('');

        exit(CopyStr(AccountReference, 1, SeparatorPosition - 1));
    end;

    var
        MemberName: Text[100];
}
