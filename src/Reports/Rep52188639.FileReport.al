report 50302 "File Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/FileMovement.rdlc';

    ApplicationArea = All;
    Caption = 'File Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(FileMovement; "File Movement")
        {
            column(CurrentLocation; "Current Location")
            {
            }
            column(CurrentName; "Current Name")
            {
            }
            column(CurrentUser; "Current User")
            {
            }
            column(DateIssued; "Date Issued")
            {
            }
            column(DateReceived; "Date Received")
            {
            }
            column(EntryType; "Entry Type")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(MovementDate; "Movement Date")
            {
            }
            column(No; "No.")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(OverdueDate; "Overdue Date")
            {
            }
            column(Purpose; Purpose)
            {
            }
            column(ReasonForDelay; "Reason For Delay")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(RequestLocation; "Request Location")
            {
            }
            column(RequestLocationName; "Request Location Name")
            {
            }
            column(RequestedBy; "Requested By")
            {
            }
            column(Select; Select)
            {
            }
            column(SelectedBy; "Selected By")
            {
            }
            column(Status; Status)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            trigger OnAfterGetRecord()
            var
                notify: Record "Notification Entry";
                MyNotify: Codeunit "Notification Management";
            begin
                notify.reset;
                notify.setrange(ID);
                if "Overdue Date" > Today then
                    notify.Insert();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
