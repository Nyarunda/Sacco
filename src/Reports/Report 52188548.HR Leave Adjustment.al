
Report 50211 "HR Leave Adjustment"
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

                Employee.TestField(Gender);
                //"HR Employees".TESTFIELD("Global Dimension 1 Code");
                //Employee.TESTFIELD("Global Dimension 2 Code");

                //Get current leave period
                HRLeaveCal.Reset;
                HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
                if HRLeaveCal.Find('-') then begin
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


                            HRLeaveLedger.SetRange(HRLeaveLedger."Staff No.", Employee."No.");
                            HRLeaveLedger.SetRange(HRLeaveLedger."Leave Type", HRLeaveTypes.Code);
                            HRLeaveLedger.SetRange(HRLeaveLedger."Leave Entry Type", LeaveEntryType);
                            HRLeaveLedger.SetRange(HRLeaveLedger."Leave Calendar Code", HRLeaveCal."Calendar Code");

                            if not skip then
                                if not HRLeaveLedger.Find('-') then begin
                                    OK := CheckGender(Employee, HRLeaveTypes);
                                    if OK then begin
                                        HRJournalLine.Init;
                                        HRJournalLine."Journal Template Name" := Text0001;
                                        HRJournalLine.Validate("Journal Template Name");

                                        HRJournalLine."Journal Batch Name" := Format(BatchName);
                                        HRJournalLine."Line No." := HRJournalLine."Line No." + 1000;

                                        HRJournalLine."Leave Calendar Code" := HRLeaveCal."Calendar Code";
                                        HRJournalLine.Validate("Leave Calendar Code");

                                        HRJournalLine."Leave Period Start Date" := HRLeaveCal."Start Date";
                                        HRJournalLine.Validate("Leave Period Start Date");

                                        HRJournalLine."Staff No." := Employee."No.";
                                        HRJournalLine.Validate("Staff No.");

                                        HRJournalLine."Posting Date" := PDate;
                                        HRJournalLine.Description := PostingDescription;

                                        HRJournalLine."Leave Entry Type" := LeaveEntryType;
                                        HRJournalLine."Leave Type" := HRLeaveTypes.Code;
                                        HRJournalLine."Document No." := HRLeaveCal."Calendar Code";

                                        HRJournalLine."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                                        HRJournalLine.Validate("Global Dimension 1 Code");

                                        HRJournalLine."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                                        HRJournalLine.Validate("Global Dimension 2 Code");
                                        HRJournalLine."No. of Days" := HRLeaveTypes.Days;
                                        if HRJournalLine."No. of Days" > 0 then
                                            HRJournalLine.Insert(true);
                                    end;
                                end else begin
                                    Error('Allocation has already been done');
                                end;
                        until HRLeaveTypes.Next = 0;
                    end else begin
                        Error('No Leave Type found within the applied filters [%1]', HRLeaveTypes.GetFilters);
                    end;
                end else begin
                    Error('No Leave Period have been created');
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
            area(content)
            {
                field(LeaveEntryType; LeaveEntryType)
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Entry Type';
                }
                field("Posting Date"; PDate)
                {
                    ApplicationArea = Basic;
                }
                field(PostingDescription; PostingDescription)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Description';
                }
                field(BatchName; BatchName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Batch Name';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            PostingDescription := 'Leave Allocation on ' + Format(Today);
            PDate := Today;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Message('Process complete');
    end;

    trigger OnPreReport()
    begin
        if PostingDescription = '' then Error('Please enter posting description');

        if not HRJournalLine.IsEmpty then begin
            if Confirm(Text0002 + Text0003, false, HRJournalLine.Count, UpperCase(HRJournalLine.TableCaption), Text0001, BatchName) = true then begin
                HRJournalLine.DeleteAll;
            end else begin
                Error('Process aborted');
            end;
        end;

        //Get Leave type filter
        LeaveTypeFilter := "HR Leave Types.".GetFilter(Code);
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

