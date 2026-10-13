
Page 50200 "Monthly Advice Buffer"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Monthly Advice";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AdviceDate; Rec."Advice Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(PayrollNo; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Advice Source"; Rec."Advice Source")
                {
                    ApplicationArea = basic;
                    Caption = 'Reporting Name';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(ProductName; Rec."Product Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Period"; Rec."Loan Period")
                {
                    ApplicationArea = Basic;
                }
                field(LoanBalance; Rec."Loan Balance")
                {
                    ApplicationArea = Basic;
                }
                field(Principal; Rec.Principal)
                {
                    ApplicationArea = Basic;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic;
                }

                field("Amount On"; Rec."Amount On")
                {
                    Caption = 'Repayment';
                    ApplicationArea = Basic;
                }

                field("Advice Type"; Rec."Advice Type")
                {
                    ApplicationArea = Basic;
                }

                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerCode; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Change Balance"; Rec."Change Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Current Balance"; Rec."Current Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Contribution"; Rec."Cummulative Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Sort Order"; Rec."Sort Order")
                {
                    ApplicationArea = Basic;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }



}

