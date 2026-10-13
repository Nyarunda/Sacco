
Page 50264 "Loan Posted List"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Posted Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Loans;
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
                    StyleExpr = StyleTxt;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(DisbursementDate; Rec."Disbursement Date")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field("Last Pay Date"; Rec."Last Pay Date")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(LoanProductType; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(LoanProductTypeName; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(AnnualInterest; Rec."Annual Interest %")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }

                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }

                field(RequestedAmount; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(ApprovedAmount; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field("Top Up Amount"; Rec."Top Up Amount")
                {
                    editable = false;
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(Loan; Rec."Schedule Repayment")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(scheduleBalance; Rec."Schedule Balance")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field("Principal Repayment"; Rec."Principal Repayment")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(OutstandingPrincipal; Rec."Outstanding Principal")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(OpenAt; Rec."Booking Branch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Open At';
                    StyleExpr = StyleTxt;
                }
                field(OutstandingInterest; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field("Insurance Due"; Rec."Insurance Due")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field("Penalty Due"; Rec."Penalty Due")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field("Loans Category-SASRA"; Rec."Loans Category-SASRA")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field(StopInterestDue; Rec."Stop Interest Due")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(AccountManager; Rec."Loan Officer")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(LoanRestructured; Rec."Loan Restructured")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field(LoanRescheduled; Rec."Loan Rescheduled")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field("Loan Suspended"; Rec."Loan Suspended")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field("Loan Suspension Start Date"; Rec."Loan Suspension Start Date")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }
                field("Loan Suspension End Date"; Rec."Loan Suspension End Date")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleTxt;
                }

                field("Debt Collector Type"; Rec."Debt Collector Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Debt Collector"; Rec."Debt Collector")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Debt Collector Name"; Rec."Debt Collector Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Debt Coll. Date"; Rec."Debt Coll. Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Total Arrears"; Rec."Total Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("SASRA Months Arrears"; Rec."SASRA Months Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
            }
        }
        area(factboxes)
        {
            part(Control10; "Loans Statistics FactBox")
            {
                SubPageLink = "Loan No." = field("Loan No.");
            }
        }
    }

    actions
    {
    }

    procedure SetUserInteractions()
    begin


        if Rec."Loans Category-SASRA" = Rec."Loans Category-SASRA"::Performing then
            StyleTxt := 'Favorable';

        if Rec."Loans Category-SASRA" = Rec."Loans Category-SASRA"::Watch then
            StyleTxt := 'StrongAccent';

        if Rec."Loans Category-SASRA" = Rec."Loans Category-SASRA"::Substandard then
            StyleTxt := 'Ambiguous';

        if Rec."Loans Category-SASRA" = Rec."Loans Category-SASRA"::Doubtful then
            StyleTxt := 'Subordinate';

        if Rec."Loans Category-SASRA" = Rec."Loans Category-SASRA"::Loss then
            StyleTxt := 'Unfavorable';
    end;


    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        LoanType: record "Product Setup";
    begin
        SetUserInteractions();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetUserInteractions();
    end;

    trigger OnOpenPage()
    begin
        SetUserInteractions();
    end;

    trigger OnInit()
    begin

        UserSetup.Get(UserId);
        if not UserSetup."View Staff Accounts" then begin
            Rec.FilterGroup(2);
            Rec.SetFilter("Member Category", '<>%1', Rec."member category"::"Staff Members");
        end;
    end;

    var
        UserSetup: Record "User Setup";
        StyleTxt: Text;
}
