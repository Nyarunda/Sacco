Page 50940 "HR Employees Factbox"
{
    PageType = CardPart;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            field(PersonalDetails; PersonalDetails)
            {
                ApplicationArea = Basic;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field(No; Rec."No.")
            {
                ApplicationArea = Basic;
            }
            field(FirstName; Rec."First Name")
            {
                ApplicationArea = Basic;
            }
            field(MiddleName; Rec."Middle Name")
            {
                ApplicationArea = Basic;
            }
            field(LastName; Rec."Last Name")
            {
                ApplicationArea = Basic;
            }
            field(EMail; Rec."E-Mail")
            {
                ApplicationArea = Basic;
            }
            field(CompanyEMail; Rec."Company E-Mail")
            {
                ApplicationArea = Basic;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
            }
            field(JobDetails; JobDetails)
            {
                ApplicationArea = Basic;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field(JobTitle; Rec."Job Title")
            {
                ApplicationArea = Basic;
            }
            field(LeaveDetails; LeaveDetails)
            {
                ApplicationArea = Basic;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field(ReimbursedLeaveDays; Rec."Reimbursed Leave Days")
            {
                ApplicationArea = Basic;
                Importance = Promoted;
            }
            field(AllocatedLeaveDays; Rec."Allocated Leave Days")
            {
                ApplicationArea = Basic;
                Importance = Promoted;
            }
            field(TotalLeaveDays; Rec."Total (Leave Days)")
            {
                ApplicationArea = Basic;
                Importance = Promoted;
            }
            field("Leave Earned"; LeaveEarned)
            {
                ApplicationArea = Basic;
            }
            field(TotalLeaveTaken; Rec."Total Leave Taken")
            {
                ApplicationArea = Basic;
                Editable = false;
                Importance = Promoted;
            }
            field(LeaveBalance; Rec."Leave Balance")
            {
                ApplicationArea = Basic;
                Enabled = false;
                Importance = Promoted;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        HRLeaveTypes.Reset;
        HRLeaveTypes.SetRange("Is Annual Leave", true);
        HRLeaveTypes.SetRange("Employee Category", Rec."Employee Category");
        if HRLeaveTypes.FindFirst then begin
            Rec.SetFilter("Leave Type Filter", HRLeaveTypes.Code);
            Rec.CalcFields("Reimbursed Leave Days", "Allocated Leave Days", "Total Leave Taken");

            if Rec."Total (Leave Days)" <> Rec."Reimbursed Leave Days" + Rec."Allocated Leave Days" then begin
                Rec."Total (Leave Days)" := Rec."Reimbursed Leave Days" + Rec."Allocated Leave Days";
            end;

            //Month := Date2dmy(Today, 2);
            Month := 12;//Date2dmy(Today, 2);
            LeaveEarned := ROUND(Rec."Allocated Leave Days" * Month / 12, 1, '<');
            LeaveEarned += Rec."Reimbursed Leave Days";


            if Rec."Leave Balance" <> LeaveEarned + Rec."Total Leave Taken" then begin
                Rec."Leave Balance" := LeaveEarned + Rec."Total Leave Taken";
            end;

        end;
    end;

    var
        PersonalDetails: label 'Personal Details';
        BankDetails: label 'Bank Details';
        JobDetails: label 'Job Details';
        LeaveDetails: label 'Leave Details';
        HRLeaveTypes: Record "HR Leave Types.";
        Month: Integer;
        LeaveEarned: Decimal;
}

