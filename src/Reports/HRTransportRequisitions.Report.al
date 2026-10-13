Report 51119 "HR Transport Requisitions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Transport Requisitions.rdlc';

    dataset
    {
        dataitem("HR Transport Requisition Head"; "HR Transport Requisition Head")
        {
            RequestFilterFields = "Transport Request No", "Employee No";
            column(ReportForNavId_9002; 9002)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
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
            column(PurposeofTrip_HRTransportRequisition; "HR Transport Requisition Head"."Purpose of Trip")
            {
            }
            column(TimeofTrip_HRTransportRequisition; "HR Transport Requisition Head"."Time of Trip")
            {
            }
            column(PickupPoint_HRTransportRequisition; "HR Transport Requisition Head"."Pickup Point")
            {
            }
            column(From_HRTransportRequisition; "HR Transport Requisition Head".From)
            {
            }
            column(Destination_HRTransportRequisition; "HR Transport Requisition Head".Destination)
            {
            }
            column(EmployeeName_HRTransportRequisition; "HR Transport Requisition Head"."Employee Name")
            {
            }
            column(EmployeeNo_HRTransportRequisition; "HR Transport Requisition Head"."Employee No")
            {
            }
            column(TransportRequestNo_HRTransportRequisition; "HR Transport Requisition Head"."Transport Request No")
            {
            }
            column(DaysApplied_HRTransportRequisition; "HR Transport Requisition Head"."Days Applied")
            {
            }
            column(DepartureDate_HRTransportRequisition; "HR Transport Requisition Head"."Departure Date")
            {
            }
            column(ReturnDate_HRTransportRequisition; "HR Transport Requisition Head"."Return Date")
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
}

