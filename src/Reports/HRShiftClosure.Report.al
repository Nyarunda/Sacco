Report 51130 "HR Shift Closure"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("HR Shift Management"; "HR Shift Management")
        {
            DataItemTableView = where(Status = const(Open));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "HR Shift Management".Status := "HR Shift Management".Status::Closed;
                "HR Shift Management".Modify;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if Confirm('Do you want to Close all open shifts', false) = false then Error('Aborted');
    end;

    var
        ApplicationNoFilter: Code[10];
        Text2000: label 'Please enter shift no';
        HRShiftScheduleLines: Record "HR Shift Schedule Lines";
        Counter: Integer;
}

