Report 51132 OSIncident
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/OSIncident.rdlc';

    dataset
    {
        dataitem("HR OSIncident"; "HR OSIncident")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(IncidentNo_OSIncident; "HR OSIncident"."Incident No")
            {
            }
            column(IncidentDesc_OSIncident; "HR OSIncident"."Incident Description")
            {
            }
            column(Address_OSIncident; "HR OSIncident".Address)
            {
            }
            column(DateofBirth_OSIncident; "HR OSIncident"."Date of Birth")
            {
            }
            column(JobTitle_OSIncident; "HR OSIncident"."Job Title")
            {
            }
            column(HomePhoneNo_OSIncident; "HR OSIncident"."Home Phone No.")
            {
            }
            column(Section_OSIncident; "HR OSIncident".Section)
            {
            }
            column(TypeofIncident_OSIncident; "HR OSIncident"."Type of Incident")
            {
            }
            column(LocationCode_OSIncident; "HR OSIncident"."Location Name")
            {
            }
            column(PartofBodyAffected_OSIncident; "HR OSIncident"."Part of Body Affected")
            {
            }
            column(DateofIncident_OSIncident; "HR OSIncident"."Date of Incident")
            {
            }
            column(Time_OSIncident; "HR OSIncident".Time)
            {
            }
            column(DateNotificationReceived_OSIncident; "HR OSIncident"."Date Notification Received")
            {
            }
            column(FirstWitnessName_OSIncident; "HR OSIncident"."First Witness Name")
            {
            }
            column(FirstWitnessAddress_OSIncident; "HR OSIncident"."First Witness Address")
            {
            }
            column(SecondWitnessName_OSIncident; "HR OSIncident"."Second Witness Name")
            {
            }
            column(SecondWitnessAddress_OSIncident; "HR OSIncident"."Second Witness Address")
            {
            }
            column(FirstAidGiven_OSIncident; "HR OSIncident"."First Aid Given")
            {
            }
            column(TakenHome_OSIncident; "HR OSIncident"."Taken Home")
            {
            }
            column(ReturntoWorkonsameday_OSIncident; "HR OSIncident"."Return to Work on same day")
            {
            }
            column(WentAbsent_OSIncident; "HR OSIncident"."Went Absent")
            {
            }
            column(TakentoHospital_OSIncident; "HR OSIncident"."Taken to Hospital")
            {
            }
            column(Admitted_OSIncident; "HR OSIncident".Admitted)
            {
            }
            column(NoSeries_OSIncident; "HR OSIncident"."No. Series")
            {
            }
            column(EmployeeNo_OSIncident; "HR OSIncident"."Employee No")
            {
            }
            dataitem("HR OSInjured Person"; "HR OSInjured Person")
            {
                DataItemLink = "Incident No" = field("Incident No");
                column(ReportForNavId_27; 27)
                {
                }
                column(EmployeeNo_OSInjuredPerson; "HR OSInjured Person"."Employee No")
                {
                }
                column(InjuredPerson_OSInjuredPerson; "HR OSInjured Person"."Injured Person")
                {
                }
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
}

