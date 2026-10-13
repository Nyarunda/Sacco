Report 51121 "HR Training Needs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/HR Training Needs.rdlc';

    dataset
    {
        dataitem("HR Training Needs"; "HR Training Needs")
        {
            RequestFilterFields = "Code", "Bondage Start Date", "Responsibility Center";
            column(ReportForNavId_1905; 1905)
            {
            }
            column(Location_HRTrainingNeeds; "HR Training Needs"."Re-Assessment Date")
            {
                IncludeCaption = true;
            }
            column(GlobalDimension2Code_HRTrainingNeeds; "HR Training Needs"."Responsibility Center")
            {
                IncludeCaption = true;
            }
            column(Closed_HRTrainingNeeds; "HR Training Needs"."Bondage Start Date")
            {
                IncludeCaption = true;
            }
            column(QualificationCode_HRTrainingNeeds; "HR Training Needs"."Bondage Duration")
            {
                IncludeCaption = true;
            }
            column(QualificationType_HRTrainingNeeds; "HR Training Needs"."Bondage Release Date")
            {
                IncludeCaption = true;
            }
            column(QualificationDescription_HRTrainingNeeds; "HR Training Needs"."Inclusive of Non Working Days")
            {
                IncludeCaption = true;
            }
            column(ProviderName_HRTrainingNeeds; "HR Training Needs"."External Provider Name")
            {
                IncludeCaption = true;
            }
            column(Code_HRTrainingNeeds; "HR Training Needs".Code)
            {
                IncludeCaption = true;
            }
            column(StartDate_HRTrainingNeeds; "HR Training Needs"."Start Date")
            {
                IncludeCaption = true;
            }
            column(EndDate_HRTrainingNeeds; "HR Training Needs"."End Date")
            {
                IncludeCaption = true;
            }
            column(DurationUnits_HRTrainingNeeds; "HR Training Needs".Duration1)
            {
                IncludeCaption = true;
            }
            column(Duration_HRTrainingNeeds; "HR Training Needs"."Total Costs")
            {
                IncludeCaption = true;
            }
            column(CostOfTraining_HRTrainingNeeds; "HR Training Needs".Location)
            {
                IncludeCaption = true;
            }
            column(Description_HRTrainingNeeds; "HR Training Needs".Description)
            {
                IncludeCaption = true;
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
            column(name; VN)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Ven.Get("HR Training Needs".Provider);
                VN := Ven.Name;
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
        VN: Text[50];
        Ven: Record "Savings Accounts";
        HR_Training_NeedsCaptionLbl: label 'HR Training Needs';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Training_NeedsCaptionLbl: label 'Training Needs';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        Name_of_Training_CourseCaptionLbl: label 'Name of Training Course';
        From__Date_CaptionLbl: label 'From (Date)';
        Duration_CaptionLbl: label 'Duration ';
        To__Date_CaptionLbl: label 'To (Date)';
        Cost_of_TrainingCaptionLbl: label 'Cost of Training';
        LocationCaptionLbl: label 'Location';
        ProviderCaptionLbl: label 'Provider';
        Brief_Description_of_Training_CourseCaptionLbl: label 'Brief Description of Training Course';
        Qualifications_to_be_attained_at_the_end_of_the_Training_CourseCaptionLbl: label 'Qualifications to be attained at the end of the Training Course';
}

