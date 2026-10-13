page 50017 "Loan Activities"
{
    PageType = CardPart;
    SourceTable = "Sacco Cues";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup(Loans)
            {
                Caption = 'Loans';

                field(LoansApplicationDisplay; LoansApplicationDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans - Application';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Image = Document;
                    Style = Subordinate;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Appriasal: Record "Member Salary Appraisal";
                    begin
                        Appriasal.SetRange(Status, Appriasal.Status::Open);
                        Page.Run(Page::"Salary Appraisal", Appriasal);
                    end;
                }

                field(LoanAppraisalPendingDisplay; LoanAppraisalPendingDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal - Pending';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Style = Ambiguous;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Appraisal: Record "Member Salary Appraisal";
                    begin
                        Appraisal.SetRange(Status, Appraisal.Status::Pending);
                        Page.Run(Page::"Salary Appraisal", Appraisal);
                    end;
                }

                field(LoanAppraisalCompletedDisplay; LoanAppraisalCompletedDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal - Completed';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Appraisal: Record "Member Salary Appraisal";
                    begin
                        Appraisal.SetRange("Appraisal Completed", true);
                        Page.Run(Page::"Completed Salary Appraisal", Appraisal);
                    end;
                }

                field(LoansPendingDisplay; LoansPendingDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans - Pending';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Style = Ambiguous;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Loans: Record Loans;
                    begin
                        Loans.SetRange(Status, Loans.Status::Pending);
                        Loans.SetRange(Posted, false);
                        Page.Run(Page::"Loan Application List", Loans);
                    end;
                }

                field(LoansApprovedDisplay; LoansApprovedDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans - Approved';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Loans: Record Loans;
                    begin
                        Loans.SetRange(Status, Loans.Status::Approved);
                        Loans.SetRange(Posted, false);
                        Page.Run(Page::"Loan Application List", Loans);
                    end;
                }

                field(LoansRejectedDisplay; LoansRejectedDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans - Rejected';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Style = Unfavorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Loans: Record Loans;
                    begin
                        Loans.SetRange(Status, Loans.Status::Rejected);
                        Loans.SetRange(Posted, false);
                        Page.Run(Page::"Loan Application List", Loans);
                    end;
                }

                field(LoansPostedDisplay; LoansPostedDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans - Posted';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Loan Posted List");
                    end;
                }

                field(NonPerformingLoansDisplay; NonPerformingLoansDisplay)
                {
                    ApplicationArea = Basic;
                    Caption = 'Non-performing Loans';
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    BlankZero = true;
                    Style = Unfavorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Loans: Record Loans;
                    begin
                        Loans.FilterGroup(2);
                        Loans.SetFilter("Loans Category-SASRA", '%1|%2|%3',
                            Loans."Loans Category-SASRA"::Substandard,
                            Loans."Loans Category-SASRA"::Doubtful,
                            Loans."Loans Category-SASRA"::Loss);
                        Loans.SetRange(Posted, true);
                        Loans.FilterGroup(0);
                        Page.Run(Page::"Loan Posted List", Loans);
                    end;
                }
            }
        }
    }

    var
        LoansApplicationDisplay: Decimal;
        LoanAppraisalPendingDisplay: Decimal;
        LoanAppraisalCompletedDisplay: Decimal;
        LoansPendingDisplay: Decimal;
        LoansApprovedDisplay: Decimal;
        LoansRejectedDisplay: Decimal;
        LoansPostedDisplay: Decimal;
        NonPerformingLoansDisplay: Decimal;

    trigger OnOpenPage()
    begin
        Rec.Reset();

        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        Rec.SetFilter("User Filter", UserId);
        RefreshCueCounts();
    end;

    trigger OnAfterGetRecord()
    begin
        RefreshCueCounts();
    end;

    local procedure RefreshCueCounts()
    var
        Appraisal: Record "Member Salary Appraisal";
        LoansRec: Record Loans;
    begin
        Rec.CalcFields(
            "Loans - Application",
            "Loans - Pending",
            "Loans - Approved",
            "Loans - Rejected",
            "Loans - Posted");

        LoansApplicationDisplay := Rec."Loans - Application";
        LoansPendingDisplay := Rec."Loans - Pending";
        LoansApprovedDisplay := Rec."Loans - Approved";
        LoansRejectedDisplay := Rec."Loans - Rejected";
        LoansPostedDisplay := Rec."Loans - Posted";

        Appraisal.SetRange(Status, Appraisal.Status::Pending);
        LoanAppraisalPendingDisplay := Appraisal.Count();

        Appraisal.Reset();
        Appraisal.SetRange("Appraisal Completed", true);
        LoanAppraisalCompletedDisplay := Appraisal.Count();

        LoansRec.SetFilter("Loans Category-SASRA", '%1|%2|%3',
            LoansRec."Loans Category-SASRA"::Substandard,
            LoansRec."Loans Category-SASRA"::Doubtful,
            LoansRec."Loans Category-SASRA"::Loss);
        LoansRec.SetRange(Posted, true);
        NonPerformingLoansDisplay := LoansRec.Count();
    end;
}
