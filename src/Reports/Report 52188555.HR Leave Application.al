
Report 50218 "HR Leave Application"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Leave Application.rdlc';

    dataset
    {
        dataitem("HR Leave Application."; "HR Leave Application.")
        {
            RequestFilterFields = "Application Code", Status;
            column(ReportForNavId_3725; 3725)
            {
            }
            column(Description_HRLeaveApplication; Description)
            {
            }
            column(Names; Names)
            {
            }
            column(GManager; '')
            {
            }
            column(SupervisorNames; SupervisorNames)
            {
            }
            column(LastDAte; LastDate)
            {
            }
            column(LeaveTaken; dLeft)
            {
            }
            column(Reliever_HRLeaveApplication; Reliever)
            {
            }
            column(RelieverName_HRLeaveApplication; "Reliever Name")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; 0)
            {
            }
            column(UserId; UserId)
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(Company_Phone; CI."Phone No.")
            {
            }
            column(HR_Leave_Application__Application_Date_; "Application Date")
            {
            }
            column(HR_Leave_Application__Application_Code_; "Application Code")
            {
            }
            column(HR_Leave_Application__Employee_No_; "Applicant Staff No.")
            {
            }
            column(HR_Leave_Application__Job_Tittle_; "Job Tittle")
            {
            }
            column(HR_Leave_Application__Leave_Type_; "Leave Type")
            {
            }
            column(HR_Leave_Application__Days_Applied_; "Days Applied")
            {
            }
            column(HR_Leave_Application__Start_Date_; "Start Date")
            {
            }
            column(HR_Leave_Application__Return_Date_; "Return Date")
            {
            }
            column(HR_Leave_Application__Cell_Phone_Number_; "Cell Phone Number")
            {
            }
            column(HR_Leave_Application__Request_Leave_Allowance_; "Request Leave Allowance")
            {
            }
            column(HREmp_FullName; Names)
            {
            }
            column(HR_Leave_Application__E_mail_Address_; "E-mail Address")
            {
            }
            column(HR_Leave_Application__Details_of_Examination_; "Details of Examination")
            {
            }
            column(HR_Leave_Application__Date_of_Exam_; "Date of Exam")
            {
            }
            column(HR_Leave_Application__Number_of_Previous_Attempts_; "Number of Previous Attempts")
            {
            }
            column(HR_Leave_Application__Leave_Allowance_Amount_; "Leave Allowance Amount")
            {
            }
            column(HR_Leave_ApplicationCaption; HR_Leave_ApplicationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Leave_Application_FormCaption; Leave_Application_FormCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Leave_Application__Application_Date_Caption; FieldCaption("Application Date"))
            {
            }
            column(HR_Leave_Application__Application_Code_Caption; FieldCaption("Application Code"))
            {
            }
            column(HR_Leave_Application__Employee_No_Caption; FieldCaption("Applicant Staff No."))
            {
            }
            column(Leave_Being_Applied_For_Caption; Leave_Being_Applied_For_CaptionLbl)
            {
            }
            column(No_of_Leave_Days_Applied_ForCaption; No_of_Leave_Days_Applied_ForCaptionLbl)
            {
            }
            column(HR_Leave_Application__Start_Date_Caption; FieldCaption("Start Date"))
            {
            }
            column(HR_Leave_Application__Return_Date_Caption; FieldCaption("Return Date"))
            {
            }
            column(HR_Leave_Application__Cell_Phone_Number_Caption; FieldCaption("Cell Phone Number"))
            {
            }
            column(HR_Leave_Application__Request_Leave_Allowance_Caption; FieldCaption("Request Leave Allowance"))
            {
            }
            column(HR_Leave_Application__Job_Tittle_Caption; FieldCaption("Job Tittle"))
            {
            }
            column(Contact_Information_while_on_LeaveCaption; Contact_Information_while_on_LeaveCaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(Leave_Applicant_DetailsCaption; Leave_Applicant_DetailsCaptionLbl)
            {
            }
            column(For_study_leave_applicants__please_complete_this_section_Caption; For_study_leave_applicants__please_complete_this_section_CaptionLbl)
            {
            }
            column(HR_Leave_Application__E_mail_Address_Caption; FieldCaption("E-mail Address"))
            {
            }
            column(HR_Leave_Application__Details_of_Examination_Caption; FieldCaption("Details of Examination"))
            {
            }
            column(HR_Leave_Application__Date_of_Exam_Caption; FieldCaption("Date of Exam"))
            {
            }
            column(HR_Leave_Application__Number_of_Previous_Attempts_Caption; FieldCaption("Number of Previous Attempts"))
            {
            }
            column(Not_to_be_approved_unless_the_form_has_been_issued_with_a_number_from_the_Head_of_Support_Services_department_Caption; Not_to_be_approved_unless_the_form_has_been_issued_with_a_number_from_the_Head_of_Support_Services_department_CaptionLbl)
            {
            }
            column(Completed_form_to_be_sent_to_the_HR_department_Caption; Completed_form_to_be_sent_to_the_HR_department_CaptionLbl)
            {
            }
            column(Five_working_days_are_equivalent_to_one_week_s_leave_Caption; Five_working_days_are_equivalent_to_one_week_s_leave_CaptionLbl)
            {
            }
            column(NotesCaption; NotesCaptionLbl)
            {
            }
            column(HR_Leave_Application__Leave_Allowance_Amount_Caption; FieldCaption("Leave Allowance Amount"))
            {
            }
            column(failed_or_referred_Caption; failed_or_referred_CaptionLbl)
            {
            }
            column(Designation_HRLeaveApplication; "HR Leave Application.".Designation)
            {
            }
            column(Department_HR; HREmp."Global Dimension 2 Code")
            {
            }
            column(DaysReimbursed_HRLeaveApplication; "HR Leave Application."."Days Reimbursed")
            {
            }
            column(TotalTaken_HRLeaveApplication; "HR Leave Application."."Total Taken")
            {
            }
            column(AllocatedDays_HRLeaveApplication; "HR Leave Application."."Allocated Days")
            {
            }
            column(ReImbursedDays_HRLeaveApplication; "HR Leave Application."."Re-Imbursed Days")
            {
            }
            column(TotalLeaveDays_HRLeaveApplication; "HR Leave Application."."Total Leave Days")
            {
            }
            column(DaysTaken_HRLeaveApplication; "HR Leave Application."."Days Taken")
            {
            }
            column(LeaveBalance_HRLeaveApplication; "HR Leave Application."."Leave Balance")
            {
            }
            dataitem("Approval Comment Line"; "Approval Comment Line")
            {
                DataItemLink = "Document No." = field("Application Code");
                DataItemTableView = sorting("Entry No.");
                column(ReportForNavId_8731; 8731)
                {
                }
                column(Approval_Comment_Line_Document_No_; "Document No.")
                {
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = field("Application Code");
                DataItemTableView = sorting("Table ID", "Document Type", "Document No.", "Sequence No.") order(descending) where(Status = const(Approved));
                column(ReportForNavId_1171; 1171)
                {
                }
                column(ApproverName; ApproverName)
                {
                }
                column(Approved_ByCaption; Approved_ByCaptionLbl)
                {
                }
                column(Approval_Entry_Table_ID; "Table ID")
                {
                }
                column(Approval_Entry_Document_Type; "Document Type")
                {
                }
                column(Approval_Entry_Document_No_; "Document No.")
                {
                }
                column(Approval_Entry_Sequence_No_; "Sequence No.")
                {
                }
                column(Approval_Entry_Approver_ID; "Approver ID")
                {
                }
                dataitem("User Setup"; "User Setup")
                {
                    DataItemLink = "User ID" = field("Approver ID");
                    DataItemTableView = sorting("User ID");
                    column(ReportForNavId_7968; 7968)
                    {
                    }
                    column(SignatureCaption; SignatureCaptionLbl)
                    {
                    }
                    column(User_Setup_User_ID; "User ID")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    /*
                    HREmp.RESET;
                    HREmp.SETRANGE(HREmp."User ID",Table454."Approver ID");
                    IF HREmp.FIND('-') THEN
                    ApproverName:=HREmp.FullName
                    ELSE
                    ApproverName:='';
                    */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                HREmp.Get("HR Leave Application."."Applicant Staff No.");

                LastDate := CalcDate('CY', Today);
                SupervisorNames := GetSupervisor("HR Leave Application."."Applicant Supervisor");

                GetLeaveStats("Leave Type", "HR Leave Application."."Applicant Staff No.");
                dLeft := LeaveBalance - "HR Leave Application."."Days Taken";
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
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        HREmp: Record Employee;
        CI: Record "Company Information";
        ApproverName: Text[50];
        HR_Leave_ApplicationCaptionLbl: label 'HR Leave Application';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Leave_Application_FormCaptionLbl: label 'Leave Application Form';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        Leave_Being_Applied_For_CaptionLbl: label 'Leave Being Applied For:';
        No_of_Leave_Days_Applied_ForCaptionLbl: label 'No of Leave Days Applied For';
        Contact_Information_while_on_LeaveCaptionLbl: label 'Contact Information while on Leave';
        Employee_NameCaptionLbl: label 'Employee Name';
        Leave_Applicant_DetailsCaptionLbl: label 'Leave Applicant Details';
        For_study_leave_applicants__please_complete_this_section_CaptionLbl: label '*For study leave applicants, please complete this section:';
        Not_to_be_approved_unless_the_form_has_been_issued_with_a_number_from_the_Head_of_Support_Services_department_CaptionLbl: label 'Not to be approved unless the form has been issued with a number from the Head of Support Services department.';
        Completed_form_to_be_sent_to_the_HR_department_CaptionLbl: label 'Completed form to be sent to the HR department.';
        Five_working_days_are_equivalent_to_one_week_s_leave_CaptionLbl: label 'Five working days are equivalent to one week’s leave.';
        NotesCaptionLbl: label 'Notes';
        failed_or_referred_CaptionLbl: label '(failed or referred)';
        To_be_filled_by_supervisorCaptionLbl: label 'To be filled by supervisor';
        General_CommentsCaptionLbl: label 'General Comments';
        Approved_ByCaptionLbl: label 'Approved By';
        SignatureCaptionLbl: label 'Signature';
        LastDate: Date;
        SupervisorNames: Text;
        dTaken: Decimal;
        dLeft: Decimal;
        ReimbursedDays: Decimal;
        AllocatedDays: Decimal;
        TotalLeaveDays: Decimal;
        LeaveEarned: Decimal;
        LeaveTaken: Decimal;
        LeaveBalance: Decimal;


    procedure GetSupervisor(var sUserID: Code[40]) SupervisorName: Text[200]
    var
        UserSetup: Record "User Setup";
    begin
        SupervisorName := '';

        if sUserID <> '' then begin
            UserSetup.Reset;
            if UserSetup.Get(sUserID) then begin


                HREmp.SetRange(HREmp."User ID", sUserID);
                if HREmp.Find('-') then
                    SupervisorName := HREmp.FullName;


            end else begin
                Error('User' + ' ' + sUserID + ' ' + 'does not exist in the user setup table');
                SupervisorName := '';
            end;
        end;
    end;


    procedure GetLeaveStats(LeaveType: Text[50]; EmployeeNo: Code[10])
    begin



        ReimbursedDays := "HR Leave Application."."Re-Imbursed Days";
        AllocatedDays := "HR Leave Application."."Allocated Days";
        TotalLeaveDays := "HR Leave Application."."Total Leave Days";

        LeaveEarned := "HR Leave Application."."Earned Days";
        LeaveTaken := "HR Leave Application."."Total Taken";
        LeaveBalance := "HR Leave Application."."Leave Balance";
    end;
}

