page 50819 "Coop P2F Transactions"
{
    //was 50672
    ApplicationArea = All;
    Caption = 'Coop P2F Transactions';
    PageType = List;
    SourceTable = "Coop Pay2Fosa";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Transaction ID"; Rec."Transaction ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction ID field.';
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Date field.';
                }
                field("Value Date"; Rec."Value Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Value Date field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Payment Ref"; Rec."Payment Ref")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Ref field.';
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Narration field.';
                }
                field("Exchange Rate"; Rec."Exchange Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                }
                field("Event Type"; Rec."Event Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Event Type field.';
                }
                field(CustomMemoLine1; Rec.CustomMemoLine1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CustomMemoLine1 field.';
                }
                field(CustomMemoLine2; Rec.CustomMemoLine2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CustomMemoLine2 field.';
                }
                field(CustomMemoLine3; Rec.CustomMemoLine3)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CustomMemoLine3 field.';
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field("Cleared Balance"; Rec."Cleared Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cleared Balance field.';
                }
                field("Booked Balance"; Rec."Booked Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Booked Balance field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Institution A/C No"; Rec."Institution A/C No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Institution A/C No field.';
                }
                field("Member Account No."; Rec."Member Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Account No. field.';
                }
                field("Split Account No."; Rec."Split Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Split Account No. field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {

            action("Update P2F")
            {
                ApplicationArea = Basic;
                RunObject = Page "Update P2F Transaction";
                RunPageLink = "Transaction ID" = field("Transaction ID");
            }
            action("Post Single Entry")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to Retry Post P2F Entries?') then begin
                        if Rec.Purpose = Rec.Purpose::" " then
                            B2B.PostP2FTransaction(Rec."Transaction ID")
                        else
                            //B2B.PostP2FSalary(Rec.Purpose);
                             B2B.PostP2FTransaction(Rec."Transaction ID");//mycomment


                    end;
                end;
            }
            action("Post All Entries")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to Retry Post P2F Entries?') then begin
                        if Rec.Purpose = Rec.Purpose::" " then
                            B2B.PostP2FTransaction('')
                        else
                            //B2B.PostP2FSalary(Rec.Purpose);//mycomment
                            B2B.PostP2FTransaction('')
                    end;
                end;
            }
            action("Validate P2F Transactions")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin


                    if not Rec.Posted then
                        B2B.ValidatePay2FosaPaymentAdvise(Rec."Transaction ID", true)


                end;
            }
            action("Commit P2F Transactions")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    //B2B.CommitP2FSalary();
                    //Message('Done');
                end;
            }
        }
    }

    var
        B2B: Codeunit "Coop B2B_P2F";
}
