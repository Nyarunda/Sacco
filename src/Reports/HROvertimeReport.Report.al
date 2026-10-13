Report 51101 "HR Overtime Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Overtime Report.rdlc';

    dataset
    {
        dataitem("HR Overtime Header"; "HR Overtime Header")
        {
            RequestFilterFields = "Application Code", "Staff No.", Status, Converted, "Application Date";
            column(ReportForNavId_9002; 9002)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(StartDate; StartDate)
            {

            }
            column(EndDate; EndDate)
            {

            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(HR_Jobs_UserID; UserId)
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(StaffNo_HROvertimeHeader; "HR Overtime Header"."Staff No.")
            {
            }
            column(StaffName_HROvertimeHeader; "HR Overtime Header"."Staff Name")
            {
            }
            column(ConvertTo_HROvertimeHeader; "HR Overtime Header"."Convert To?")
            {
            }
            column(ApplicationCode_HROvertimeHeader; "HR Overtime Header"."Application Code")
            {
            }
            column(ApplicationDate_HROvertimeHeader; "HR Overtime Header"."Application Date")
            {
            }
            column(OverTime_Amount; "OverTime Amount")
            {

            }
            column(Total_Overtime_Hours; "Total Overtime Hours")
            {

            }
            dataitem("HR Overtime Lines"; "HR Overtime Lines")
            {
                DataItemLink = "Application Code" = field("Application Code");
                column(ReportForNavId_5; 5)
                {
                }
                column(OvertimeHours_HROvertimeLines; "HR Overtime Lines"."Overtime Hours")
                {
                }
                column(Date_HROvertimeLines; "HR Overtime Lines".Date)
                {
                }
                column(StartTime_HROvertimeLines; "HR Overtime Lines"."Start Time")
                {
                }
                column(EndTime_HROvertimeLines; "HR Overtime Lines"."End Time")
                {
                }
                column(WorkDone_HROvertimeLines; "HR Overtime Lines"."Work Done")
                {
                }
                column(OvertimeType_HROvertimeLines; "HR Overtime Lines"."Overtime Type")
                {
                }
                trigger OnPreDataItem()
                begin
                    if (StartDate <> 0D) and (EndDate <> 0D) then
                        "HR Overtime Lines".SetRange(Date, StartDate, EndDate);
                end;
            }
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
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            StartDate := CalcDate('-CM', Today);
            EndDate := CalcDate('CM', Today);
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CI.Reset;
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HR_JobsCaptionLbl: label 'HR Jobs';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Job_StatisticsCaptionLbl: label 'HR Job Statistics';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        MyUserID: Text;
        UserSetup: Record "User Setup";
        StartDate: Date;
        EndDate: Date;
}

