
Page 50304 "Bankers Cheq. Application List"
{
    ApplicationArea = Basic;
    CardPageID = "Bankers Cheq. Application Card";
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Bankers Cheque Application";
    UsageCategory = Tasks;

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
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(NoSeries; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(BeginingChequeNo; Rec."Begining Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(ChequeRegisterGenerated; Rec."Cheque Register Generated")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
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
                field(NoofLeaves; Rec."No of Leaves")
                {
                    ApplicationArea = Basic;
                }
                field(BankAccount; Rec."Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field(LeafLimitAmount; Rec."Leaf Limit Amount")
                {
                    ApplicationArea = Basic;
                }
                field(BankersChequeType; Rec."Bankers Cheque Type")
                {
                    ApplicationArea = Basic;
                }

                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Cheque mangemennt" then
            Error('You do not have any permissions for Cheque Clearing. Contact the administrator!');
    end;
}

