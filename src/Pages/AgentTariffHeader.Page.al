Page 50536 "Agent Tariff Header"
{
    CardPageID = "Agent Tariff Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Agent Tarriff Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Trans Type Agents")
                {
                    ApplicationArea = Basic;
                }
                field(ChargeExciseDuty; Rec."Charge Excise Duty")
                {
                    ApplicationArea = Basic;
                }
                field(DailyLimit; Rec."Daily Limit")
                {
                    ApplicationArea = Basic;
                }
                field(WeeklyLimit; Rec."Weekly Limit")
                {
                    ApplicationArea = Basic;
                }
                field(MonthlyLimit; Rec."Monthly Limit")
                {
                    ApplicationArea = Basic;
                }
                field(YearlyLimit; Rec."Yearly Limit")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionLimit; Rec."Transaction Limit")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

