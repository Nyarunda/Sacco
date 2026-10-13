Report 51117 "HR Disciplinary Cases"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Disciplinary Cases.rdlc';

    dataset
    {
        dataitem("HR Disciplinary Cases NCA"; "HR Disciplinary Cases NCA")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Case Number", "Disciplinary Stage Status";
            column(ReportForNavId_6666; 6666)
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(DisciplinaryRemarks_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Disciplinary Remarks")
            {
            }
            column(DisciplinaryStageStatus_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Disciplinary Stage Status")
            {
            }
            column(TakenActionDescription_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Taken Action Description")
            {
            }
            column(RecommendedActionDescription_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Recommended Action Description")
            {
            }
            column(PolicyDescription_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Policy Description")
            {
            }
            column(BodyHandlingName_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Body Handling Name")
            {
            }
            column(DescriptionofComplaint_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Description of Complaint")
            {
            }
            column(TypeComplaint_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Type Complaint")
            {
            }
            column(AccusedEmployeeName_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Accused Employee Name")
            {
            }
            column(AccussedBy_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Accussed By")
            {
            }
            column(AccusedEmployee_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Accused Employee")
            {
            }
            column(CaseNumber_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Case Number")
            {
            }
            column(AccuserName_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Reporter Name")
            {
            }
            column(Accuser_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA".Reporter)
            {
            }
            column(Witness1Name_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Witness #1 Name")
            {
            }
            column(Witness2Name_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Witness #2  Name")
            {
            }
            column(Witness1_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Witness #1")
            {
            }
            column(Witness2_HRDisciplinaryCasesNCA; "HR Disciplinary Cases NCA"."Witness #2")
            {
            }

            trigger OnAfterGetRecord()
            begin
                No := No + 1;
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
        CI: Record "Company Information";
        Int: Integer;
        HR_Transport_RequisitionsCaptionLbl: label 'HR Transport Requisitions';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        TRANSPORT_REQUESTCaptionLbl: label 'TRANSPORT REQUEST';
        Travelling_Staff_DetailsCaptionLbl: label 'Travelling Staff Details';
        No: Integer;
}

