
Page 50219 "Member Accounts List"
{
    ApplicationArea = Basic;
    CardPageID = "Member Account Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Savings Accounts";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(OldAccountNo; Rec."Old Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(ProductCategory; Rec."Product Category")
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(ProductName; Rec."Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field("Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Piggy Bank Issued"; Rec."Piggy Bank Issued")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LastTransactionDate; Rec."Last Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(OldMemberNo; Rec."Old Member Number")
                {
                    ApplicationArea = Basic;
                    Caption = 'Old Member No.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field(MonthlyContribution; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionalMobileNo; Rec."Transactional Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field(BalanceLCY; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Savings Ledger Entries";
                }

                field("Member ID"; Rec."Member ID")
                {
                    ApplicationArea = Basic;
                }
                field("Member Staff No."; Rec."Member Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field(MobilePhoneNo; Rec."Transactional Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field(PayrollStaffNo; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Loans Guaranteed"; Rec."Loans Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field(Duplicates; Rec.Duplicates)
                {
                    ApplicationArea = Basic;
                }
                field("Registration Date"; Rec."Member Registration Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }

        area(factboxes)
        {
            part(Control16; "Savings Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }


    actions
    {

        area(navigation)
        {
            action("Member Loans")
            {
                ApplicationArea = Basic;
                Promoted = true;
                Image = EntryStatistics;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Loans Statistics";
                RunPageLink = "Member No." = field("Member No.");
            }
            action("MLoan Analysis")
            {
                ApplicationArea = Basic;
                Promoted = true;
                Image = EntryStatistics;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                    Accounts: Record "Savings Accounts";

                begin
                    Accounts.Reset();
                    Accounts.SetRange("Member No.", Rec."Member No.");
                    Accounts.SetRange("Product Category", Accounts."Product Category"::"Ordinary Savings");
                    if Accounts.FindFirst() then
                        Report.Run(Report::"MLoan Member Analysis", true, false, Accounts);
                end;
            }

            action("Mobile Loan Limit")
            {
                ApplicationArea = Basic;
                Promoted = true;
                Image = EntryStatistics;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;
                trigger OnAction()
                var
                    myInt: Integer;
                    Accounts: Record "Savings Accounts";
                    Sky: Codeunit "Sky MBanking";
                    LoanProduct: Record "Product Setup";
                    QualAmt: Decimal;
                    Remark: Text;
                    ResCode: TExt;

                begin


                    LoanProduct.Reset();
                    LoanProduct.SetRange("Available on Mobile", true);
                    if LoanProduct.FindFirst() then begin
                        repeat
                            QualAmt := 0;
                            Remark := '';
                            ResCode := '';
                            if LoanProduct."Product ID" = 'L43' then
                                Sky.GetDividendLoanQualifiedAmount(Rec."No.", LoanProduct."Product ID", QualAmt, Remark)
                            else
                                Sky.GetLoanQualifiedAmount(Rec."No.", LoanProduct."Product ID", QualAmt, Remark, ResCode);

                            Message(LoanProduct.Description + ' Limit: %1', QualAmt);
                        until LoanProduct.Next() = 0;
                    end;

                end;
            }


        }
    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        PRoduct: Record "Product Setup";
    begin

        if Rec."Member ID" = '' then begin
            Rec.CalcFields("ID No.");
            Rec."Member ID" := Rec."ID No.";
            /* Rec.Modify();
            Commit(); */

        end;

        if Rec."Old Member Number" = '' then begin
            Rec.CalcFields("Old Member No.");
            if Rec."Old Member No." <> '' then begin
                Rec."Old Member Number" := Rec."Old Member No.";
                Rec.Modify();
                Commit();
            end;
        end;

        if PRoduct.Get(Rec."Product Type") then begin
            if Rec."Global Dimension 1 Code" = '' then begin
                Rec."Global Dimension 1 Code" := PRoduct."Global Dimension 1 Code";
                // Rec.Modify();
            end;

        end;


    end;
}

