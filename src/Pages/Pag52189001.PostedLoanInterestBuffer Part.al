page 50014 "Posted Loan Interest Part"
{
    ApplicationArea = All;
    Caption = 'Posted Loan Interest Buffer Part';
    PageType = ListPart;
    SourceTable = "Loan Interest Buffer";
    SourceTableView = where(Posted = const(true));
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No."; Rec."Loan No.") { ApplicationArea = Basic; }
                field("Loan Product type"; Rec."Loan Product type") { ApplicationArea = Basic; }
                field("Issued Date"; Rec."Issued Date") { ApplicationArea = Basic; }
                field("Annual Interest %"; Rec."Annual Interest %") { ApplicationArea = Basic; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = Basic; }
                field("Account No"; Rec."Account No") { ApplicationArea = Basic; }
                field("Employer Code"; Rec."Employer Code") { ApplicationArea = Basic; }
                field(Name; Rec.Name) { ApplicationArea = Basic; }
                field("Account Type"; Rec."Account Type") { ApplicationArea = Basic; }
                field("Interest Date"; Rec."Interest Date") { ApplicationArea = Basic; }
                field(Description; Rec.Description) { ApplicationArea = Basic; }
                field("Interest Amount"; Rec."Interest Amount") { ApplicationArea = Basic; }
                field("User ID"; Rec."User ID") { ApplicationArea = Basic; }
                field("Bal. Account Type"; Rec."Bal. Account Type") { ApplicationArea = Basic; }
                field("Bal. Account No."; Rec."Bal. Account No.") { ApplicationArea = Basic; }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code") { ApplicationArea = Basic; }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code") { ApplicationArea = Basic; }
                field("Outstanding Interest"; Rec."Outstanding Interest") { ApplicationArea = Basic; }
                field("Outstanding Balance"; Rec."Outstanding Balance") { ApplicationArea = Basic; }
                field(Blocked; Rec.Blocked) { ApplicationArea = Basic; }
                field(Posted; Rec.Posted) { ApplicationArea = Basic; }
                field(Reversed; Rec.Reversed) { ApplicationArea = Basic; }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = '&Functions';

                action("Mark Reversed")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ConfirmText: Label 'Are you sure you want to mark these selected loans as reversed?';
                        TempLoanInterest: Record "Loan Interest Buffer" temporary;
                    begin
                        if Confirm(ConfirmText, true) then begin
                            GetSelectedRecords(TempLoanInterest);

                            if TempLoanInterest.FindSet() then
                                repeat
                                    Rec.Reset();
                                    Rec.SetRange("Loan No.", TempLoanInterest."Loan No.");
                                    Rec.SetRange("Posting Date", TempLoanInterest."Posting Date");
                                    if Rec.FindFirst() then begin
                                        Rec.Reversed := true;
                                        Rec.Modify();
                                    end;
                                until TempLoanInterest.Next() = 0;
                        end;
                    end;
                }
            }
        }
    }

    procedure GetSelectedRecords(var TempLoanInterest: Record "Loan Interest Buffer" temporary)
    var
        LoanInterest: Record "Loan Interest Buffer";
    begin
        CurrPage.SetSelectionFilter(LoanInterest);
        if LoanInterest.FindSet() then
            repeat
                TempLoanInterest := LoanInterest;
                TempLoanInterest.Insert();
            until LoanInterest.Next() = 0;
    end;
}