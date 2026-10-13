
Page 50128 "HR Leave Applications List"
{
    ApplicationArea = Basic;
    CardPageID = "HR Leave Application Card";
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Leave Application.";
    SourceTableView = where(Status = filter(<> Approved));
    //UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                field(ApplicationNo; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                }
                field(ApplicantStaffNo; Rec."Applicant Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                }
                field(DaysApplied; Rec."Days Applied")
                {
                    ApplicationArea = Basic;
                }
                field(StartDate; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(ReturnDate; Rec."Return Date")
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755006; "HR Leave Factbox")
            {
                SubPageLink = "No." = field("Applicant Staff No.");
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        HREmp.Reset;
        if HREmp.Get(Rec."Applicant Staff No.") then begin
            EmpName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        end else begin
            EmpName := 'n/a';
        end;
    end;

    trigger OnOpenPage()
    Var
        Usersetup: Record "User Setup";
    begin
        if Usersetup.Get(UserId) then
            if Usersetup."Is HR" then
                exit;

        Rec.SetRange("Applicant User ID", UserId);
    end;

    var
        EmpName: Text;
        HREmp: Record Employee;


    procedure TESTFIELDS()
    begin
        Rec.TestField("Leave Type");
        Rec.TestField("Days Applied");
        Rec.TestField("Start Date");
        Rec.TestField(Reliever);
        Rec.TestField("Applicant Supervisor");
    end;


}
