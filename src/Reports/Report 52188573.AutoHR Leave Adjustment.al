
Report 50236 "AutoHR Leave Adjustment"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = sorting("No.") order(ascending) where(Status = filter(Active));
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Date2dmy(Today, 1) <> 1 then CurrReport.Skip;

                Employee.TestField(Gender);

                //Get current leave period
                HRLeaveCal.Reset;
                HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
                if HRLeaveCal.Find('-') then begin

                    if (HRLeaveCal."Start Date" <> CalcDate('-CY', Today)) and (HRLeaveCal."End Date" <> CalcDate('CY', Today)) then
                        exit;

                    HRLeaveTypes.Reset;
                    if LeaveTypeFilter <> '' then begin
                        HRLeaveTypes.SetRange(HRLeaveTypes.Code, LeaveTypeFilter);
                    end;

                    if HRLeaveTypes.Find('-') then begin
                        repeat

                            skip := false;

                            if HRLeaveTypes."Employee Category" <> HRLeaveTypes."employee category"::" " then
                                if HRLeaveTypes."Employee Category" <> Employee."Employee Category" then
                                    skip := true;

                            HRLeaveLedger.Reset;
                            HRLeaveLedger.SetRange(HRLeaveLedger."Staff No.", Employee."No.");
                            HRLeaveLedger.SetRange(HRLeaveLedger."Leave Type", HRLeaveTypes.Code);
                            HRLeaveLedger.SetRange(HRLeaveLedger."Leave Entry Type", LeaveEntryType);
                            HRLeaveLedger.SetRange(HRLeaveLedger."Leave Posting Description", PostingDescription);

                            if not skip then
                                if not HRLeaveLedger.Find('-') then begin
                                    OK := CheckGender(Employee, HRLeaveTypes);
                                    if OK then begin
                                        HRJournalLine.Init;
                                        HRJournalLine."Journal Template Name" := Text0001;
                                        HRJournalLine.Validate("Journal Template Name");

                                        HRJournalLine."Journal Batch Name" := Format(Batchname::POSITIVE);
                                        HRJournalLine."Line No." := HRJournalLine."Line No." + 1000;

                                        HRJournalLine."Leave Calendar Code" := HRLeaveCal."Calendar Code";
                                        HRJournalLine.Validate("Leave Calendar Code");

                                        HRJournalLine."Leave Period Start Date" := HRLeaveCal."Start Date";
                                        HRJournalLine.Validate("Leave Period Start Date");

                                        HRJournalLine."Staff No." := Employee."No.";
                                        HRJournalLine.Validate("Staff No.");

                                        HRJournalLine."Posting Date" := Today;
                                        HRJournalLine.Description := PostingDescription;

                                        HRJournalLine."Leave Entry Type" := Leaveentrytype::Postive;
                                        HRJournalLine."Leave Type" := HRLeaveTypes.Code;
                                        HRJournalLine."Document No." := HRLeaveCal."Calendar Code";

                                        HRJournalLine."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                                        HRJournalLine.Validate("Global Dimension 1 Code");

                                        HRJournalLine."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                                        HRJournalLine.Validate("Global Dimension 2 Code");
                                        HRJournalLine."No. of Days" := 2;//HRLeaveTypes.Days;
                                        if HRJournalLine."No. of Days" > 0 then
                                            HRJournalLine.Insert(true);
                                    end;
                                end else begin
                                    CurrReport.Skip;
                                end;
                        until HRLeaveTypes.Next = 0;
                    end;
                end;
            end;
        }
        dataitem("HR Leave Types."; "HR Leave Types.")
        {
            RequestFilterFields = "Code";
            column(ReportForNavId_2; 2)
            {
            }
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

        trigger OnOpenPage()
        begin
            // PostingDescription:='Leave Allocation on ' + FORMAT(TODAY);
            // PDate:=TODAY;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        HRJournalLine.Reset;
        HRJournalLine.SetRange(HRJournalLine."Journal Template Name", Text0001);
        HRJournalLine.SetRange(HRJournalLine."Journal Batch Name", Format(Batchname::POSITIVE));
        if HRJournalLine.Find('-') then
            Codeunit.Run(Codeunit::"HR Leave Jnl.-Post", HRJournalLine);

        Message('Process complete');
    end;

    trigger OnPreReport()
    begin
        PostingDescription := 'Leave Allocation (' + Format(CalcDate('-CM', Today)) + '..' + Format(CalcDate('CM', Today)) + ')';

        HRJournalLine.Reset;
        HRJournalLine.SetRange(HRJournalLine."Journal Template Name", Text0001);
        HRJournalLine.SetRange(HRJournalLine."Journal Batch Name", Format(Batchname::POSITIVE));
        if HRJournalLine.Find('-') then
            HRJournalLine.DeleteAll;

        //Get Leave type filter
        LeaveTypeFilter := 'ANNUAL';
    end;

    var
        AllocationDone: Boolean;
        HRLeaveTypes: Record "HR Leave Types.";
        HRLeaveLedger: Record "HR Leave Ledger Entries.";
        LeaveEntryType: Option Postive,Negative,Reimbursement;
        OK: Boolean;
        HRJournalLine: Record "HR Leave Journal Line.";
        PostingDescription: Text;
        BatchName: Option POSITIVE,NEGATIVE;
        JournalTemplate: Code[20];
        Text0001: label 'LEAVE';
        Text0002: label 'There are [%1] entries in [%2  TABLE], Journal Template Name - [%3], Journal Batch Name [%4]';
        Text0003: label '\\Do you want to proceed and overwite these entries?';
        LeaveTypeFilter: Text;
        i: Integer;
        HRLeaveCal: Record "HR Leave Calendar.";
        PDate: Date;
        skip: Boolean;


    procedure CheckGender(Emp: Record Employee; LeaveType: Record "HR Leave Types.") Allocate: Boolean
    begin
        Allocate := false;

        if Emp.Gender = Emp.Gender::Female then begin
            if LeaveType.Gender = LeaveType.Gender::Female then Allocate := true;
        end;

        if Emp.Gender = Emp.Gender::Male then begin
            if LeaveType.Gender = LeaveType.Gender::Male then Allocate := true;
        end;

        if LeaveType.Gender = LeaveType.Gender::Both then Allocate := true;


        exit(Allocate);
    end;
}

