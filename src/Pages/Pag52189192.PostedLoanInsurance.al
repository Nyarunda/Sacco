namespace UnitedWomen.UnitedWomen;
using System.Security.User;
using Microsoft.Finance.GeneralLedger.Journal;

page 50894 "Posted Loan Insurance"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Loan Interest Buffer";
    SourceTableView = where(Posted = const(true), Source = filter(Insurance));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(LoanProducttype; Rec."Loan Product type Name")
                {
                    ApplicationArea = Basic;
                }
                field(IssuedDate; Rec."Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field(AnnualInterest; Rec."Annual Interest %")
                {
                    ApplicationArea = Basic;
                    Caption = 'Insurance %';
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerCode; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(InterestDate; Rec."Interest Date")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(InterestAmount; Rec."Interest Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Insurance Amount';
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(BalAccountType; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(BalAccountNo; Rec."Bal. Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingBalance; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {

            action("Generate Loan Insurance")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Generate Loan Insurance";
            }
            action("Post Interest")
            {
                ApplicationArea = Basic;
                Image = Post;
                Caption = 'Post Insurance';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SUSBuffer: Record "Suspend Interest Accounts";
                begin
                    if Confirm('Are you sure you want to Post Generated Lines') then begin
                        UserSetup.Get(UserId);
                        UserSetup.TestField("General Journal Template");
                        UserSetup.TestField("General Journal Batch");

                        JTemplate := UserSetup."General Journal Template";
                        JBatch := UserSetup."General Journal Batch";

                        SaccoActivities.JournalInit(JTemplate, JBatch);

                        IntBuffer.Reset;
                        IntBuffer.SetRange(Posted, false);
                        if IntBuffer.FindFirst then begin
                            if Confirm(Format(IntBuffer.Count) + ' line(s) will be posted. Continue?') then
                                repeat
                                    if IntBuffer.Source = IntBuffer.Source::Insurance then
                                        TransType := TransType::"Insurance Due"
                                    else
                                        TransType := TransType::"Interest Due";
                                    ExtDocNo := IntBuffer."Loan No.";
                                    SaccoActivities.JournalInsert(
                                        JTemplate,
                                        JBatch,
                                        IntBuffer."Loan No.",
                                        IntBuffer."Posting Date",
                                        Accttype::Credit,
                                        IntBuffer."Account No",
                                        CopyStr(IntBuffer.Description, 1, 50),
                                        IntBuffer."Bal. Account Type",
                                        IntBuffer."Bal. Account No.",
                                        IntBuffer."Interest Amount",
                                        ExtDocNo,
                                        IntBuffer."Loan No.",
                                        Transtype,
                                        IntBuffer."Global Dimension 1 Code",
                                        IntBuffer."Global Dimension 2 Code",
                                        true,
                                        TChannel::"Interest Billing",
                                        IntBuffer."Dimension Set ID"
                                        );

                                    IntBuffer.Posted := true;
                                    IntBuffer.Modify;

                                    SaccoActivities.JournalPost(JTemplate, JBatch);
                                until IntBuffer.Next = 0;

                        end;


                        SUSBuffer.Reset;
                        SUSBuffer.SetRange(Posted, false);
                        if SUSBuffer.FindFirst then begin
                            if Confirm(Format(SUSBuffer.Count) + ' line(s) will be posted. Continue?') then
                                repeat

                                    SaccoActivities.JournalInsert(
                                        JTemplate,
                                        JBatch,
                                        SUSBuffer."Loan No.",
                                        SUSBuffer."Interest Date",
                                        Accttype::Credit,
                                        SUSBuffer."Account No.",
                                        SUSBuffer."Loan No.",
                                        Accttype::"G/L Account",
                                        '14901',
                                        // SUSBuffer."Suspended Account No.",
                                        SUSBuffer."Interest Amount",
                                        ExtDocNo,
                                        SUSBuffer."Loan No.",
                                        Transtype,
                                        SUSBuffer."Global Dimension 1 Code",
                                        SUSBuffer."Global Dimension 2 Code",
                                        true,
                                        TChannel::"Interest Billing",
                                        Rec."Dimension Set ID"
                                        );

                                    SUSBuffer.Posted := true;
                                    SUSBuffer."Suspended Account No." := '14901';
                                    SUSBuffer.Modify;

                                    SaccoActivities.JournalPost(JTemplate, JBatch);
                                until SUSBuffer.Next = 0;

                        end;
                    end;
                end;
            }
            action("Clear Unposted Interest")
            {
                ApplicationArea = Basic;
                Caption = 'Clear unposted Insurance';

                trigger OnAction()
                var
                    susBuffer: Record "Suspend Interest Accounts";
                begin
                    if Confirm('Are you sure you want to Clear Unposted Interest') then begin
                        UserSetup.Get(UserId);
                        UserSetup.TestField("General Journal Template");
                        UserSetup.TestField("General Journal Batch");

                        JTemplate := UserSetup."General Journal Template";
                        JBatch := UserSetup."General Journal Batch";


                        IntBuffer.Reset;
                        IntBuffer.SetRange(Posted, false);
                        if IntBuffer.FindFirst then begin
                            IntBuffer.DeleteAll;
                        end;

                        susBuffer.Reset;
                        susBuffer.SetRange(Posted, false);
                        if susBuffer.FindFirst then begin
                            susBuffer.DeleteAll;
                        end;


                    end;
                end;
            }
            action("Generate Manual Interest")
            {
                ApplicationArea = Basic;
                Visible = false;
                RunObject = Report "Generate Manual Interest";
            }
            action("Suspended Interest")
            {
                ApplicationArea = Basic;
                Visible = false;
                RunObject = page "Loans Suspended Interest";
            }
            action("Reverse Interest")
            {
                ApplicationArea = Basic;
                Caption = 'Reverse Insurance';
                RunObject = report "Loan Interest Reversal";
            }
        }
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Bill Interest" then
            Error('You do not have permission to Loan Insurance Billing. Contact your administrator');
    end;

    var
        IntBuffer: Record "Loan Interest Buffer";
        SaccoActivities: Codeunit "Sacco Activities";
        UserSetup: Record "User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        ExtDocNo: Code[20];
        TransType: Enum "Transaction Type Enum";
        TChannel: Enum "Transaction Channel";
}
