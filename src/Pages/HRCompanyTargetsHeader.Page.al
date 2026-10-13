Page 51031 "HR Company Targets Header"
{
    PageType = Card;
    SourceTable = "HR Company Targets Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Appraisalno; Rec."Appraisal no")
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalPeriod; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalDate; Rec."Appraisal Date")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(FinancialTargetedScore; Rec."Financial Targeted Score")
                {
                    ApplicationArea = Basic;
                }
                field(AchievedFinancialScore; Rec."Achieved Financial  Score")
                {
                    ApplicationArea = Basic;
                }
                field(UnachievedTargets; Rec."Unachieved Targets")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(TrainingTargetedScore; Rec."Training Targeted Score")
                {
                    ApplicationArea = Basic;
                }
                field(ServiceDeliveryTargetScore; Rec."Service Delivery Target Score")
                {
                    ApplicationArea = Basic;
                }
                field(CustomerTargetScore; Rec."Customer Target Score")
                {
                    ApplicationArea = Basic;
                }
                field(CustomerAchievedScore; Rec."Customer Achieved  Score")
                {
                    ApplicationArea = Basic;
                }
                field(ServiceDeliveryAchieved; Rec."Service Delivery Achieved")
                {
                    ApplicationArea = Basic;
                }
                field(TrainingAchievedScore; Rec."Training Achieved  Score")
                {
                    ApplicationArea = Basic;
                }
            }
            /*part(Control1000000016;"HR Company Target Line")
            {
                SubPageLink = "Appraisal No"=field("Appraisal no");
            }*/
        }
    }

    actions
    {
    }
}

