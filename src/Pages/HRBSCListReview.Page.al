Page 50856 "HR BSC List Review"
{
    //CardPageID = "HR BSC Appraisal Header-Superv";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Individual Targets Header";
    SourceTableView = where("Appraisal Type" = filter("Appraisal Review"),
                            Status = filter(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AppraisalNo; Rec."Appraisal No")
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
                field(AppraisalYear; Rec."Appraisal Year")
                {
                    ApplicationArea = Basic;
                }
                field(FinanceRating; Rec."Finance Rating")
                {
                    ApplicationArea = Basic;
                }
                field(CustomerRating; Rec."Customer Rating")
                {
                    ApplicationArea = Basic;
                }
                field(TrainingRating; Rec."Training Rating")
                {
                    ApplicationArea = Basic;
                }
                field(ServiceRating; Rec."Service Rating")
                {
                    ApplicationArea = Basic;
                }
                field(OverallRating; Rec."Overall Rating")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //SETFILTER("User ID",USERID);
    end;
}

