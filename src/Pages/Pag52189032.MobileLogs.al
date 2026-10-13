namespace CentralDB.CentralDB;

page 50734 "Mobile Logs"
{
    ApplicationArea = All;
    Caption = 'Mobile Logs';
    PageType = List;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Mbanking Eloan Logs";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ToolTip = 'Specifies the value of the Entry No field.', Comment = '%';
                }
                field("Guid"; Rec."Guid")
                {
                    ToolTip = 'Specifies the value of the Guid field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Time"; Rec."Time")
                {
                    ToolTip = 'Specifies the value of the Time field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field(LoanType; Rec.LoanType)
                {
                    ToolTip = 'Specifies the value of the LoanType field.', Comment = '%';
                }
                field(LoanPeriod; Rec.LoanPeriod)
                {
                    ToolTip = 'Specifies the value of the LoanPeriod field.', Comment = '%';
                }
                field(Msg; Rec.Msg)
                {
                    ToolTip = 'Specifies the value of the Msg field.', Comment = '%';
                }
                field(PhoneNo; Rec.PhoneNo)
                {
                    ToolTip = 'Specifies the value of the PhoneNo field.', Comment = '%';
                }
                field(ReferenceID; Rec.ReferenceID)
                {
                    ToolTip = 'Specifies the value of the ReferenceID field.', Comment = '%';
                }
                field(ResCode; Rec.ResCode)
                {
                    ToolTip = 'Specifies the value of the ResCode field.', Comment = '%';
                }
                field(Response; Rec.Response)
                {
                    ToolTip = 'Specifies the value of the ResCode field.', Comment = '%';
                }
                field(SpotCashID; Rec.SpotCashID)
                {
                    ToolTip = 'Specifies the value of the SpotCashID field.', Comment = '%';
                }

            }
        }
    }
}
