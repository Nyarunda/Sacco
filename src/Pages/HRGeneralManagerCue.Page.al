Page 51080 "HR General Manager Cue"
{
    PageType = CardPart;
    SourceTable = "HR Manager Cue";

    layout
    {
        area(content)
        {
            cuegroup(EmployeeCues)
            {
                Caption = 'Employee Cues';
                field(PendingApprovals; Rec."Pending Approvals")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovedJobPosistions; Rec."Approved Job Posistions")
                {
                    ApplicationArea = Basic;
                }
                field(RequisitionsPendingApproval; Rec."Requisitions Pending Approval")
                {
                    ApplicationArea = Basic;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = Basic;
                    Caption = 'All Active Employees';
                    //Image = Stack;
                }
            }
            cuegroup(Control17)
            {
                field(Female; Rec.Female)
                {
                    ApplicationArea = Basic;
                    Caption = 'Female Employees';
                    //Image = Stack;
                }
                field(Male; Rec.Male)
                {
                    ApplicationArea = Basic;
                    Caption = 'Male Employees';
                    //Image = Stack;
                }
                field(ContractsDue; Rec."Contracts Due")
                {
                    ApplicationArea = Basic;
                }
                field(ProbationDue; Rec."Probation Due")
                {
                    ApplicationArea = Basic;
                }
            }
            cuegroup(Control18)
            {
                field(UpcomingBirthdays; Rec."Upcoming Birthdays")
                {
                    ApplicationArea = Basic;
                }
                field(LeaveResumeDue; Rec."Leave Resume Due")
                {
                    ApplicationArea = Basic;
                }
                field(UpcomingLeave; Rec."Upcoming Leave")
                {
                    ApplicationArea = Basic;
                }
                field(UpcomingCompanyActivities; Rec."Upcoming Company Activities")
                {
                    ApplicationArea = Basic;
                }
            }
            cuegroup(Control19)
            {
                field(UpcomingStaffSeparation; Rec."Upcoming Staff Separation")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}