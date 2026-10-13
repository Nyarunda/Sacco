xmlport 50084 "Import Training Needs"
{
    Format = VariableText;
    Direction = Both;


    Caption = 'Import Training Needs';
    schema
    {

        textelement(RootNodeName)
        {
            tableelement(HRTrainingNeeds; "HR Training Needs")
            {
                AutoUpdate = true;
                fieldelement(Code; HRTrainingNeeds."Code")
                {

                }
                fieldelement(Description; HRTrainingNeeds.Description)
                {
                }
                fieldelement(StartDate; HRTrainingNeeds."Start Date")
                {
                }
                fieldelement(EndDate; HRTrainingNeeds."End Date")
                {
                }
                fieldelement(Duration1; HRTrainingNeeds."Duration Units")
                {
                }
                fieldelement(TotalCosts; HRTrainingNeeds."Total Costs")
                {
                }
                fieldelement(Location; HRTrainingNeeds.Location)
                {
                }
                fieldelement(ReAssessmentDate; HRTrainingNeeds."Re-Assessment Date")
                {
                }
                fieldelement(NeedSource; HRTrainingNeeds."Need Source")
                {
                }
                fieldelement(Provider; HRTrainingNeeds.Provider)
                {
                }
                fieldelement(Posted; HRTrainingNeeds.Posted)
                {
                }
                fieldelement(GlobalDimension1Code; HRTrainingNeeds."Global Dimension 1 Code")
                {
                }
                fieldelement(GlobalDimension2Code; HRTrainingNeeds."Global Dimension 2 Code")
                {
                }
                fieldelement(Closed; HRTrainingNeeds.Closed)
                {
                }
                fieldelement(QualificationCode; HRTrainingNeeds."Qualification Code")
                {
                }
                fieldelement(QualificationType; HRTrainingNeeds."Qualification Type")
                {
                }
                fieldelement(QualificationDescription; HRTrainingNeeds."Qualification Description")
                {
                }
                fieldelement(ProviderName; HRTrainingNeeds."Provider Name")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
