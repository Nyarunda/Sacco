report 50196 "File Movement Report"
{
    ApplicationArea = All;
    Caption = 'File Movement Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/File Movement Report.rdlc';

    dataset
    {

        dataitem(FileMovementLog; "File Movement Log")
        {
            RequestFilterFields = "Current Location", "Current User", "Source Location", "Source User";
            column(LineNo; "Line No.")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(SourceLocation; "Source Location")
            {
            }
            column(SourceName; "Source Name")
            {
            }
            column(SourceUser; "Source User")
            {
            }
            column(CurrentLocation; "Current Location")
            {
            }
            column(CurrentName; "Current Name")
            {
            }
            column(CurrentUser; "Current User")
            {
            }
            column(MovementDate; "Movement Date")
            {
            }
            column(FileMovementReference; "File Movement Reference")
            {
            }
            column(Days; Days)
            {
            }
            column(DueDate; DueDate)
            {
            }
            column(Status; Status)
            {
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                DueDate := 0D;
                Status := False;

                Logs.Reset();
                Logs.SetRange("Member No.", FileMovementLog."Member No.");
                if Logs.FindLast() then begin
                    if Logs."Current User" <> FileMovementLog."Current User" then
                        CurrReport.Skip();
                end;
                Days := today - FileMovementLog."Movement Date";
                DueDate := Logs."Expected Return Date";
                //Status := Logs.Returned;

            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetRange("Current User", UserName);
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

                group(User)
                {
                    field(UserName; UserName)
                    {
                        ApplicationArea = Basic;
                        TableRelation = "User Setup";
                    }
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


    var
        UserName: Code[50];
        Members: Record Members;
        Days: Integer;
        Logs: Record "File Movement Log";
        DueDate: Date;
        Status: Boolean;
}
