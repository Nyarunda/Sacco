
PageExtension 50206 pageextension50087 extends "Bank Account Card"
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Bank Account Card"(Page 370)".

    layout
    {
        addafter("Search Name")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = Basic;
            }
            field("Cheque Clearing Acc."; Rec."Cheque Clearing Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Bank Type"; Rec."Bank Type")
            {
                ApplicationArea = Basic;
            }
            field("Pending Voucher Amount"; Rec."Pending Voucher Amount")
            {
                ApplicationArea = Basic;
            }
            field("Bank Branch Name"; Rec."Bank Branch Name")
            {
                ApplicationArea = Basic;
            }
            field("Previous Statement No."; Rec."Previous Statement No.")
            {
                ApplicationArea = Basic;
            }
            field("Cashier ID"; Rec."Cashier ID")
            {
                ApplicationArea = Basic;
            }
            field("Max Amount"; Rec."Max Amount")
            {
                ApplicationArea = Basic;
            }
            field("Maximum Credit Limit"; Rec."Maximum Credit Limit")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Bank Clearing Code")
        {
            field("Responsible User"; Rec."Responsible User")
            {
                ApplicationArea = Basic;
            }
            field("PV User"; Rec."PV User")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

