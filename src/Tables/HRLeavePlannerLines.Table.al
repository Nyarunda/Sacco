Table 51017 "HR Leave Planner Lines"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "No of Days"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 1;
            trigger OnValidate()
            var
                HRLeaveAppln: Record "HR Leave Application.";
                PlannerLines: Record "HR Leave Planner Lines";
                TotalPlannedDays: Decimal;
            begin
                "Return Date" := HRLeaveAppln.DetermineLeaveReturnDate("Start Date", "No of Days");
                "End Date" := HRLeaveAppln.DeterminethisLeaveEndDate("Return Date");
                // Make sure that number of days applied for is not more than the balance days available

                LeaveHeader.Get("Leave Planner No");
                if LeaveHeader."Leave Balance" <= 0 then
                    Error(NoLeaveBalanceErr);

                PlannerLines.Reset();
                PlannerLines.SetRange("Leave Planner No", "Leave Planner No");
                PlannerLines.SetRange("Employee No", "Employee No");
                if PlannerLines.FindSet() then
                    repeat
                        if PlannerLines."Entry No." <> "Entry No." then
                            TotalPlannedDays += PlannerLines."No of Days";
                    until PlannerLines.Next() = 0;

                TotalPlannedDays += "No of Days";

                if TotalPlannedDays > LeaveHeader."Leave Balance" then
                    Error(LeaveBalanceExceededErr, TotalPlannedDays, LeaveHeader."Leave Balance");
            end;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Return Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Leave Planner No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Intended Purpose"; Text[100])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; "Leave Planner No", "Employee No", "Entry No.")
        {
            Clustered = true;
        }
    }


    var
        HRSetup: Record "HR Setup.";
        UserSetup: Record "User Setup";
        HREmp: Record Employee;
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types.";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        ////SMTP: Codeunit UnknownCodeunit400;
        LeaveGjline: Record "HR Leave Journal Line.";
        "LineNo.": Integer;
        ApprovalComments: Record "Approval Comment Line";
        URL: Text[500];
        sDate: Record Date;
        //Customized: Record UnknownRecord39003946;
        //HREmailParameters: Record UnknownRecord39003942;
        HRJournalBatch: Record "HR Leave Journal Batch.";
        LeaveHeader: Record "HR Leave Planner Header";
        Names: Text[100];
        TEXT001: label 'Days Approved cannot be more than applied days';
        LeaveBalanceExceededErr: Label 'Total planned days (%1) cannot exceed your available leave balance (%2).';
        NoLeaveBalanceErr: Label 'You cannot plan leave because your available leave balance is zero.';
}

