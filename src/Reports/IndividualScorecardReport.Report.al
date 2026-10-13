Report 51136 "Individual Scorecard Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Individual Scorecard Report.rdlc';

    dataset
    {
        dataitem("HR Individual Targets Header"; "HR Individual Targets Header")
        {
            RequestFilterFields = "Appraisal No";
            column(ReportForNavId_1; 1)
            {
            }
            column(AppraisalNo_HRIndividualTargetsHeader; "HR Individual Targets Header"."Appraisal No")
            {
            }
            column(AppraisalPeriod_HRIndividualTargetsHeader; "HR Individual Targets Header"."Appraisal Period")
            {
            }
            column(AppraisalDate_HRIndividualTargetsHeader; "HR Individual Targets Header"."Appraisal Date")
            {
            }
            column(EmployeeNo_HRIndividualTargetsHeader; "HR Individual Targets Header"."Employee No")
            {
            }
            column(FinancialTargetedScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Financial Targeted Score")
            {
            }
            column(AchievedFinancialScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Achieved Financial  Score")
            {
            }
            column(UnachievedTargets_HRIndividualTargetsHeader; "HR Individual Targets Header"."Unachieved Targets")
            {
            }
            column(EmployeeName_HRIndividualTargetsHeader; "HR Individual Targets Header"."Employee Name")
            {
            }
            column(LearningTargetedScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Training Targeted Score")
            {
            }
            column(OperationalTargetScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Service Delivery Target Score")
            {
            }
            column(ClientMemberTargetScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Customer Target Score")
            {
            }
            column(ClientMemberAchievedScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Customer Achieved  Score")
            {
            }
            column(OperationalAchieved_HRIndividualTargetsHeader; "HR Individual Targets Header"."Service Delivery Achieved")
            {
            }
            column(LearningAchievedScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Training Achieved  Score")
            {
            }
            column(Status_HRIndividualTargetsHeader; "HR Individual Targets Header".Status)
            {
            }
            column(ResponsibilityCenter_HRIndividualTargetsHeader; "HR Individual Targets Header"."Responsibility Center")
            {
            }
            column(GlobalDimension1Code_HRIndividualTargetsHeader; "HR Individual Targets Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_HRIndividualTargetsHeader; "HR Individual Targets Header"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_HRIndividualTargetsHeader; "HR Individual Targets Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_HRIndividualTargetsHeader; "HR Individual Targets Header"."Shortcut Dimension 4 Code")
            {
            }
            column(AppraisalType_HRIndividualTargetsHeader; "HR Individual Targets Header"."Appraisal Type")
            {
            }
            column(Noseries_HRIndividualTargetsHeader; "HR Individual Targets Header"."No series")
            {
            }
            column(AppraisalYear_HRIndividualTargetsHeader; "HR Individual Targets Header"."Appraisal Year")
            {
            }
            column(FinanceRating_HRIndividualTargetsHeader; "HR Individual Targets Header"."Finance Rating")
            {
            }
            column(ClientMemberRating_HRIndividualTargetsHeader; "HR Individual Targets Header"."Customer Rating")
            {
            }
            column(LearningRating_HRIndividualTargetsHeader; "HR Individual Targets Header"."Training Rating")
            {
            }
            column(OperationalRating_HRIndividualTargetsHeader; "HR Individual Targets Header"."Service Rating")
            {
            }
            column(OverallRating_HRIndividualTargetsHeader; "HR Individual Targets Header"."Overall Rating")
            {
            }
            column(FinancePercScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Finance Perc Score")
            {
            }
            column(ClientMemberPercScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Customer Perc Score")
            {
            }
            column(LearningPercScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Training Perc Score")
            {
            }
            column(OperationalPercScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Service Perc Score")
            {
            }
            column(OverallPercScore_HRIndividualTargetsHeader; "HR Individual Targets Header"."Overall Perc Score")
            {
            }
            column(Finance_HRIndividualTargetsHeader; "HR Individual Targets Header".Finance)
            {
            }
            column(ClientMember_HRIndividualTargetsHeader; "HR Individual Targets Header".Customer)
            {
            }
            column(Learning_HRIndividualTargetsHeader; "HR Individual Targets Header".Training)
            {
            }
            column(Operational_HRIndividualTargetsHeader; "HR Individual Targets Header".Service)
            {
            }
            column(UserID_HRIndividualTargetsHeader; "HR Individual Targets Header"."User ID")
            {
            }
            column(QuarterReviews_HRIndividualTargetsHeader; "HR Individual Targets Header"."Supervisor ID")
            {
            }
            column(AppraisalStage_HRIndividualTargetsHeader; "HR Individual Targets Header"."Supervisor Name")
            {
            }
            column(SupervisorID_HRIndividualTargetsHeader; "HR Individual Targets Header"."Lock appraisal")
            {
            }
            dataitem("HR Individual Target Line"; "HR Individual Target Line")
            {
                RequestFilterFields = "Appraisal No";
                column(ReportForNavId_43; 43)
                {
                }
                column(LineNo_HRIndividualTargetLine; "HR Individual Target Line"."Line No")
                {
                }
                column(AppraisalNo_HRIndividualTargetLine; "HR Individual Target Line"."Appraisal No")
                {
                }
                column(PerspectiveCode_HRIndividualTargetLine; "HR Individual Target Line"."Perspective Code")
                {
                }
                column(PerspectiveDescription_HRIndividualTargetLine; "HR Individual Target Line"."Perspective Description")
                {
                }
                column(TargetedScore_HRIndividualTargetLine; "HR Individual Target Line"."Targeted Score")
                {
                }
                column(PerspectiveType_HRIndividualTargetLine; "HR Individual Target Line"."Perspective Type")
                {
                }
                column(AchievedScore_HRIndividualTargetLine; "HR Individual Target Line"."Achieved Score")
                {
                }
                column(UnachievedTargets_HRIndividualTargetLine; "HR Individual Target Line"."Unachieved Targets")
                {
                }
                column(AppraiseeComments_HRIndividualTargetLine; "HR Individual Target Line"."Appraisee Comments")
                {
                }
                column(Objective_HRIndividualTargetLine; "HR Individual Target Line".Objective)
                {
                }
                column(CompanyTarget_HRIndividualTargetLine; "HR Individual Target Line"."Company Target")
                {
                }
                column(StartDate_HRIndividualTargetLine; "HR Individual Target Line"."Start Date")
                {
                }
                column(EndDate_HRIndividualTargetLine; "HR Individual Target Line"."End Date")
                {
                }
                column(SelfRating_HRIndividualTargetLine; "HR Individual Target Line"."Self Rating")
                {
                }
                column(SupervisorRating_HRIndividualTargetLine; "HR Individual Target Line"."Supervisor Rating")
                {
                }
                column(AgreedRating_HRIndividualTargetLine; "HR Individual Target Line"."Agreed Rating")
                {
                }
                column(AppraisalPeriod_HRIndividualTargetLine; "HR Individual Target Line"."Appraisal Period")
                {
                }
                column(AppraisalType_HRIndividualTargetLine; "HR Individual Target Line"."Appraisal Type")
                {
                }
                column(Status_HRIndividualTargetLine; "HR Individual Target Line".Status)
                {
                }
                column(AppraiserComments_HRIndividualTargetLine; "HR Individual Target Line"."Appraiser Comments")
                {
                }
                column(ReviewLineReference_HRIndividualTargetLine; "HR Individual Target Line"."Review Line Reference")
                {
                }
                column(Score_HRIndividualTargetLine; "HR Individual Target Line".Score)
                {
                }
                column(Attributes_HRIndividualTargetLine; "HR Individual Target Line".test)
                {
                }
                column(Strategy_HRIndividualTargetLine; "HR Individual Target Line".Strategy)
                {
                }
                column(Measures_HRIndividualTargetLine; "HR Individual Target Line".Measures)
                {
                }
                column(Baseline_HRIndividualTargetLine; "HR Individual Target Line".Baseline)
                {
                }
                column(Q1_HRIndividualTargetLine; "HR Individual Target Line".Change)
                {
                }
                column(Q2_HRIndividualTargetLine; "HR Individual Target Line"."Agreed Mid Year Rating")
                {
                }
                column(Q3_HRIndividualTargetLine; "HR Individual Target Line"."Agreed End Year Rating")
                {
                }
                column(Q4_HRIndividualTargetLine; "HR Individual Target Line"."Mid Year Self Rating")
                {
                }
                column(QuarterAverage_HRIndividualTargetLine; "HR Individual Target Line"."Mid Year Supervisor Rating")
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

