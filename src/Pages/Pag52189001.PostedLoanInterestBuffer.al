namespace CentralDB.CentralDB;

page 50703 "Posted Loan Interest Buffer"
{
    ApplicationArea = All;
    Caption = 'Posted Loan Interest Buffer';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Loan Interest Buffer";
    SourceTableView = where(Posted = const(true));
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
            group(Control8)
            {
                visible = false;
                ShowCaption = false;
                part(Part; "Posted Loan Interest Part")
                {
                    ApplicationArea = Basic, Suite;
                }

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
                        Text000: label 'Are you sure you want to mark as reversed all these loans?';
                    begin
                        /* if Confirm(Text000, true) then begin

                            Rec.Reset();
                            Rec.SetRange(Posted, true);
                            if Rec.FindSet() then
                                repeat
                                    Rec.Reversed := true;
                                    Rec.Modify;
                                until Rec.Next() = 0;
                        end */
                    end;
                }
            }
        }
    }


}

