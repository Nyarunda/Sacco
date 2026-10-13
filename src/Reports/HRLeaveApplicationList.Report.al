Report 50350 "HR Leave Application List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Leave Application List.rdlc';

    dataset
    {
        dataitem("HR Leave Application."; "HR Leave Application.")
        {
            RequestFilterFields = "Application Code", "Leave Type", Status, "Start Date", "Return Date";
            column(ReportForNavId_3725; 3725)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
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
            column(CI_Address2; CI."Address 2")
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI_Name; CI.Name)
            {
            }
            column(CI_PostCode; CI."Post Code")
            {
            }
            column(UserId; UserId)
            {
            }
            column(HR_Leave_Application__Application_Code_; "Application Code")
            {
            }
            column(HR_Leave_Application__Application_Date_; "Application Date")
            {
            }
            column(HR_Leave_Application__Employee_No_; "Applicant Staff No.")
            {
            }
            column(HR_Leave_Application__Job_Tittle_; "Job Tittle")
            {
            }
            column(name; name)
            {
            }
            column(dleft; dleft)
            {
            }
            column(HR_Leave_Application_Supervisor; "Applicant Supervisor")
            {
            }
            column(Names_HRLeaveApplication; Names)
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
            column(HR_Leave_Application_Reliever; Reliever)
            {
            }
            column(HR_Leave_Application__Reliever_Name_; "Reliever Name")
            {
            }
            column(HR_Leave_ApplicationCaption; HR_Leave_ApplicationCaptionLbl)
            {
            }
            column(EndDate_HRLeaveApplication; "End Date")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Leave_Application__Application_Code_Caption; FieldCaption("Application Code"))
            {
            }
            column(HR_Leave_Application__Application_Date_Caption; FieldCaption("Application Date"))
            {
            }
            column(HR_Leave_Application__Employee_No_Caption; FieldCaption("Applicant Staff No."))
            {
            }
            column(HR_Leave_Application__Job_Tittle_Caption; FieldCaption("Job Tittle"))
            {
            }
            column(HR_Leave_Application_SupervisorCaption; FieldCaption("Applicant Supervisor"))
            {
            }
            column(HR_Leave_Application__Leave_Type_Caption; FieldCaption("Leave Type"))
            {
            }
            column(HR_Leave_Application__Days_Applied_Caption; FieldCaption("Days Applied"))
            {
            }
            column(HR_Leave_Application__Start_Date_Caption; FieldCaption("Start Date"))
            {
            }
            column(HR_Leave_Application__Return_Date_Caption; FieldCaption("Return Date"))
            {
            }
            column(HR_Leave_Application_RelieverCaption; FieldCaption(Reliever))
            {
            }
            column(HR_Leave_Application__Reliever_Name_Caption; FieldCaption("Reliever Name"))
            {
            }
            column(Leave_Balance; "Leave Balance")
            {

            }
            column(Picture; CI.Picture)
            {
            }
            column(Status; Status)
            { }
            column(Posted; Posted)
            { }

            trigger OnAfterGetRecord()
            begin
                // name:='';
                dleft := 0;
                HREMP.Reset;
                if HREMP.Get("Applicant Staff No.") then begin
                    // HREMP.CALCFIELDS(HREMP."Leave Balance");
                    name := HREMP.FullName;
                    if ("Start Date" <> 0D) then
                        dleft := HREMP.GetLeaveBalance(HREMP."No.", "Leave Type", ("Start Date" - 1));
                    if Posted then
                        dleft -= "Days Applied";

                end else begin
                    name := '';
                    dleft := 0;
                end;
                //   message('%1',dleft);
                /*
               HREMP.RESET;
               HREMP.SETRANGE(HREMP."No.","Employee No");
               IF HREMP.FIND ('-') THEN BEGIN

               name:=HREMP."First Name"+' '+HREMP."Middle Name"+' '+HREMP."Last Name";
               END;
              // message('%1 and %2 and %3',HREMP."No.",HREMP."First Name","HR Leave Application"."Employee No");
         */

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
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();

        CI.Reset;
        CI.Get;
        CI.CalcFields(CI.Picture);
    end;

    var
        HR_Leave_ApplicationCaptionLbl: label 'HR Leave Application';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        CI: Record "Company Information";
        HREMP: Record Employee;
        name: Text[150];
        dleft: Decimal;
}
