Report 51108 "HR Leave Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Leave Schedule.rdlc';

    dataset
    {
        dataitem(Date; Date)
        {
            DataItemTableView = sorting("Period Start") order(ascending) where("Period Type" = filter(Month));

            column(Period_Start; "Period Start") { }
            column(Period_Name; "Period Name") { }
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyPic; CompanyInfo.Picture) { }
            column(TheYear; TheYear) { }
            dataitem(LeavePlannerLine; "HR Leave Planner Lines")
            {
                column(Employee_No; "Employee No") { }
                column(EmployeeName; Employee.FullName()) { }
                column(Start_Date; "Start Date") { }
                column(No_of_Days; "No of Days") { }
                column(End_Date; "End Date") { }
                column(Return_Date; "Return Date") { }
                trigger OnPreDataItem()
                begin
                    SetRange("Start Date", Date."Period Start", Date."Period End");
                end;

                trigger OnAfterGetRecord()
                begin
                    if Employee.Get("Employee No") then;
                    if HRLeavePlannerHdr.Get("Leave Planner No") then
                        if HRLeavePlannerHdr.Status <> HRLeavePlannerHdr.Status::Approved then
                            CurrReport.Skip();
                end;
            }
            trigger OnPreDataItem()
            var
                YearStart: Date;
                YearEnd: Date;
            begin
                YearStart := DMY2Date(1, 1, TheYear);
                YearEnd := DMY2Date(31, 12, TheYear);
                SetRange("Period Start", YearStart, YearEnd);
            end;

        }

    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group(General)
                {
                    field("The Year"; TheYear)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            TheYear := Date2DMY(Today, 3);
        end;
    }





    trigger OnPreReport()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequireHRPayrollAccess();

        if TheYear < 2000 then Error('The year must have a value');
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        TheYear: Integer;
        Employee: Record Employee;
        HRLeavePlannerHdr: Record "HR Leave Planner Header";
        CompanyInfo: Record "Company Information";
}
