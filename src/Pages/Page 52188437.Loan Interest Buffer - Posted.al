
Page 50081 "Loan Interest Buffer - Posted"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Loan Interest Buffer";
    SourceTableView = where(Posted = const(true));
    UsageCategory = History;

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
                field(LoanProducttype; Rec."Loan Product type")
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
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No")
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

            action("Delete Posted Loan")
            {
                Caption = 'Delete Posted Loan';
                PromotedCategory = Report;
                Promoted = true;
                RunObject = Report "Delete Posted Loan";

            }
        }
    }

    var
        IntBuffer: Record "Loan Interest Buffer";
        SaccoActivities: Codeunit "Sacco Activities";
        UserSetup: Record "User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        AcctType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Savings,Credit;
        BalAcctType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Savings,Credit;
        ExtDocNo: Code[20];
        TransType: Option " ","Loan Disbursement","Principal Repayment","Interest Due","Interest Paid","Appraisal Due","Appraisal Paid","Penalty Due","Penalty Paid";
}

