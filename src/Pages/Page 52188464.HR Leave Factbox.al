
Page 50127 "HR Leave Factbox"
{
    PageType = CardPart;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            label(Control1102755011)
            {
                ApplicationArea = Basic;
                CaptionClass = Text1;
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
            field(JobTitle; Rec."Job Title")
            {
                ApplicationArea = Basic;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
            }
            field(EMail; Rec."E-Mail")
            {
                ApplicationArea = Basic;
            }
            field(Text3; Text3)
            {
                ApplicationArea = Basic;
            }
            field(Text2; Text2)
            {
                ApplicationArea = Basic;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("Brought Froward Leave Days"; Rec."Brought Froward Leave Days")
            {
                ApplicationArea = Basic;
                Importance = Promoted;
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
            field(AnnualLeaveBalance; AnnualLeaveBalance)
            {
                ApplicationArea = Basic;
                Editable = false;
                Importance = Promoted;
                Caption = 'Annual Leave Balance';
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        LastDateLastMonth: Date;
        FirstOfThisMonth: Date;
        MonthNo: Integer;
    begin
        AnnualLeaveBalance := 0;
        LeaveEarned := 0;

        Rec.CalcFields(CurrYearStart, Rec.CurrYearEnd);
        Rec.SetRange("Date Filter", Rec.CurrYearStart, Rec.CurrYearEnd);

        LeaveTypes.Reset();
        LeaveTypes.SetRange("Is Annual Leave", true);
        LeaveTypes.SetRange("Employee Category", Rec."Employee Category");

        if not LeaveTypes.FindFirst() then
            exit;

        Rec.SetRange("Leave Type Filter", LeaveTypes.Code);
        Rec.CalcFields("Reimbursed Leave Days", "Allocated Leave Days", "Total Leave Taken", "Brought Froward Leave Days");

        Rec."Total (Leave Days)" := Rec."Reimbursed Leave Days" + Rec."Allocated Leave Days";

        FirstOfThisMonth := DMY2Date(1, Date2DMY(Today, 2), Date2DMY(Today, 3));
        LastDateLastMonth := FirstOfThisMonth - 1;

        MonthNo := Date2DMY(LastDateLastMonth, 2);

        LeaveEarned := Round((Rec."Allocated Leave Days" * MonthNo / 12), 1, '=');
        
        LeaveEarned += Rec."Reimbursed Leave Days" + Rec."Brought Froward Leave Days";

        if Rec."Total Leave Taken" < 0 then
            Rec."Leave Balance" := LeaveEarned + Rec."Total Leave Taken"
        else
            Rec."Leave Balance" := LeaveEarned - Rec."Total Leave Taken";

        AnnualLeaveBalance := Rec."Leave Balance";
    end;


    var
        Text1: label 'Employee Details';
        Text2: label 'Employeee Leave Details';
        Text3: label '==============================';
        LeaveTypes: Record "HR Leave Types.";
        Month: Integer;
        LeaveEarned: Decimal;
        AnnualLeaveBalance: Decimal;
}

