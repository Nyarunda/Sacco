
Page 50094 "Payroll Periods."
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Payroll Periods";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control11)
            {
                field(PeriodMonth; Rec."Period Month")
                {
                    ApplicationArea = Basic;
                }
                field(PeriodYear; Rec."Period Year")
                {
                    ApplicationArea = Basic;
                }
                field(PeriodName; Rec."Period Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateOpened; Rec."Date Opened")
                {
                    ApplicationArea = Basic;
                }
                field(OpenedBy; Rec."Opened By")
                {
                    ApplicationArea = Basic;
                }
                field(DateClosed; Rec."Date Closed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ClosedBy; Rec."Closed By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ClosePeriod)
            {
                ApplicationArea = Basic;
                Caption = 'Close Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin


                    fnGetOpenPeriod;

                    Question := 'Once a period has been closed it can NOT be opened.\It is assumed that you have PAID out salaries.\'
                    + 'Do still want to close [' + strPeriodName + ']?';

                    Answer := Dialog.Confirm(Question, false);
                    if Answer = true then begin
                        Clear(PayrollProcessing);
                        PayrollProcessing.ClosePayrollPeriod(dtOpenPeriod);
                        Message('Process Complete');
                    end
                    else begin
                        Message('You have selected NOT to Close the period');
                    end
                end;
            }

            action(NewPeriod)
            {
                ApplicationArea = Basic;
                Caption = 'New Period';
                Image = NewProperties;
                Promoted = true;
                PromotedCategory = Process;
                Visible = NewPeriodVisible;

                trigger OnAction()

                begin
                    if Confirm('Are you sure you want to open a new period?') then begin
                        Page.Run(50224);
                    end;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        RestrictAccess
    end;

    trigger OnOpenPage()
    begin
        Rec.RESET;
        IF NOT Rec.GET THEN
            NewPeriodVisible := true
        else
            NewPeriodVisible := false;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.RESET;
        IF NOT Rec.GET THEN
            NewPeriodVisible := true
        else
            NewPeriodVisible := false;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        Rec.RESET;
        IF NOT Rec.GET THEN
            NewPeriodVisible := true
        else
            NewPeriodVisible := false;
    end;

    var
        PayrollPeriods: Record "Payroll Periods";
        strPeriodName: Text[30];
        Question: Text[250];
        Answer: Boolean;
        PayrollProcessing: Codeunit "Payroll Processing";
        dtOpenPeriod: Date;
        NewPeriodVisible: Boolean;


    procedure RestrictAccess()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;


    procedure fnGetOpenPeriod()
    begin

        PayrollPeriods.Reset;
        PayrollPeriods.SetRange(PayrollPeriods.Closed, false);
        if PayrollPeriods.Find('-') then begin
            strPeriodName := PayrollPeriods."Period Name";
            dtOpenPeriod := PayrollPeriods."Date Opened";
        end;
    end;

}
