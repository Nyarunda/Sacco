
Page 50246 "Salary Lines"
{
    PageType = ListPart;
    SourceTable = "Salary Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Accounts List";
                }
                field(StaffNo; Rec."Staff No.")
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
                    Editable = true;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(AccountNotFound; Rec."Account Not Found")
                {
                    ApplicationArea = Basic;
                }
                field(BlockedAccounts; Rec."Blocked Accounts")
                {
                    ApplicationArea = Basic;
                }
                field(MultipleSalary; Rec."Multiple Salary")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(EmployerCode; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(PostingTime; Rec."Posting Time")
                {
                    ApplicationArea = Basic;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic;
                }
                field("Multiple Salary"; Rec."Multiple Salary")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

