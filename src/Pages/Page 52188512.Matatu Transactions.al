
Page 50175 "Matatu Transactions"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Matatu Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EntryNo; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNumber; Rec."Member Number")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(MemberIdNo; Rec."Member Id No")
                {
                    ApplicationArea = Basic;
                }
                field(MemberPhoneNo; Rec."Member PhoneNo")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec.TransactionType)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionDate; Rec.TransactionDate)
                {
                    ApplicationArea = Basic;
                }
                field(TransactiomTime; Rec.TransactiomTime)
                {
                    ApplicationArea = Basic;
                }
                field(AttachedDocumentLink; Rec."Attached Document Link")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(AgentCode; Rec.AgentCode)
                {
                    ApplicationArea = Basic;
                }
                field(Account; Rec.Account)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(DocumentNo; Rec.DocumentNo)
                {
                    ApplicationArea = Basic;
                }
                field(VehiclePlatesNo; Rec."Vehicle Plates No")
                {
                    ApplicationArea = Basic;
                }
                field(VehicleFleetNo; Rec."Vehicle Fleet No")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionPosted; Rec."Transaction Posted")
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(TimePosted; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionDescription; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field(DepositorsName; Rec."Depositors Name")
                {
                    ApplicationArea = Basic;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic;
                }
                field(ReversedBy; Rec."Reversed By")
                {
                    ApplicationArea = Basic;
                }
                field(DateReversed; Rec."Date Reversed")
                {
                    ApplicationArea = Basic;
                }
                field(ReversalRequestBy; Rec."Reversal Request By")
                {
                    ApplicationArea = Basic;
                }
                field(MarkedForReversal; Rec."Marked For Reversal")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Reverse Transaction")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    SaccoActivities: Codeunit "Sacco Activities";
                begin
                    if Confirm('Are you sure you want to reverse this transaction?') then begin
                        if Confirm('Are you ABSOLUTELY sure you want to reverse this transaction. This cannot be UN-DONE?') then begin
                            Rec.TestField(Posted, true);
                        end;
                    end;
                end;
            }
            action("AGent Transactions Report")
            {
                ApplicationArea = Basic;
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Micro Schedule";
            }
        }
    }
}

