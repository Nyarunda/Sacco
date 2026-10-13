page 50486 "HR-PayrollModule"

{

    Caption = 'Human Resource', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(SaccoNewsActivities; "Sacco News Activities Part")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control13; "Common Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control1; "Loan Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control12; "Member Activites")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control56; "User Tasks Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }

            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control45; "Self Service")
            {
                ApplicationArea = RelationshipMgmt;
            }
            /*part(Control16; "Team Member Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }*/
        }
    }

    actions
    {
        area(reporting)
        {

        }

        area(sections)
        {
            group(Action257)
            {
                Caption = 'Registry';

                group(Membership)
                {
                    Caption = 'Membership';

                    action(Action64)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Member List';
                        Image = "Order";


                        RunObject = Page "Member List";
                        ToolTip = 'List of all SACCO Members';
                    }


                }


            }

  
             


            group(Action457)
            {
                Caption = 'Savings';

                group(Accounts)
                {
                    Caption = 'Member Accounts';

                    action(MAccounts)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Accounts List';
                        Image = CustomerContact;


                        RunObject = Page "Member Accounts List";
                    }
                }
            }



            group(AdvancedHR)
            {
                Caption = 'Advanced HR';
                group("Jobs Management")
                {

                    action("HR Jobs")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Jobs List";
                    }
                    action("HR Job Qualifications")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Job Qualifications";
                    }
                    action("HR Job Requirements")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Job Requirements";
                    }
                    action("HR Responsibilities")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Job Responsibilities";
                    }
                }
                group("Employee Recruitment")
                {

                    action("Employee Requisitions")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Employee Requisitions List";
                    }
                    action("Job Applications")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Job Applications List";
                    }
                    action("Shortlisting")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Shortlisting List";
                    }
                    action("Applicants Qualified")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Job Applicants Qualified L";
                    }
                    action("Applicants Unqualified")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Job Applicants Unqualified";
                    }

                    action("Successful Job Applicants")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR  App Qualified Applicants";
                    }
                    action("Job Applicants Uploaded")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Job Applicants Uploaded";
                    }
                    action("Employee Requisitions Approved")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Employee Requisitions List";
                    }
                }


                group("Training Management")
                {

                    action("Training Needs")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Training Needs List";
                    }
                    action("Training Applications")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Training Application List";
                    }
                    action("Approved Training Applications")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Training App List -Approved";
                    }
                    action("Training Feedback")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Training Feedback";
                    }
                }

                group("HR Transport Management")
                {
                    action("HR Vehicle List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        RunObject = Page "HR Vehicle List";
                    }
                    action("HR Transport Application List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        RunObject = Page "HR Trasport Application List";
                    }


                }
                group("HR Fuel Requisition")
                {
                    Visible = false;
                    action(FuelRequisition)
                    {
                        ApplicationArea = RelationshipMgmt;
                        RunObject = page "Fuel Requisition List";
                    }


                }

                group("Company Activites")
                {

                    action("Company Activities/Welfare")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Company Activities List";
                    }
                    action("Closed Company Activites")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Company Activities List Clo";
                    }
                }

                group("Medical Schemes Management")
                {
                    Visible = false;

                    action("Medical Schemes")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Medical Schemes List";
                    }
                    action("Medical Scheme Members")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Medical Scheme Members List";
                    }
                    action("Medical Claims")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Medical Claims List";
                    }
                }

                group("Performance Management")
                {

                    action("360 Appraisals List - Appraisee")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Appraisal Balance Score Card List';

                        RunObject = Page "HR 360 Appraisals List";
                    }
                    action("360 Appraisals List - Supervisor")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Appraisal Balance Score -Supervisor';

                        RunObject = Page "HR360AppraisalList-Super";
                    }
                    action("360 Appraisals List - Evaluation")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Appraisal Balance Score -Evaluation';


                        RunObject = Page "HR 360 Appraisals List - EV";
                    }
                    action("Approve Appraisals")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Approve Appraisals List";
                    }
                    /*
                    action("BSC Targets")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List Targets";
                    }
                    action("BSC Targets Supervisor")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List Targets-Supervisor";
                    }

                    action("BSC Qaurter 1")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List Qaurter 1";
                    }
                    action("BSC Review")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List Review";
                    }
                    action("BSC Qaurter 3")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List Qaurter 3";
                    }
                    action("BSC Targets Approved")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List Targets-Approved";
                    }
                    action("BSC End Year")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List End Year";
                    }
                    action("BSC Closed")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR BSC List Closed";
                    }
                    action("Appraissal Appeal")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR Appraissal Appeal";
                    }
                    action("Appraisal Period Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        
                        
                        RunObject = Page "HR Appraisal Period Setup";
                    }
                      */
                    group(Repors)
                    {
                        action("Employee Appraisal Reports")
                        {
                            ApplicationArea = RelationshipMgmt;


                            RunObject = report "Employee Appraisal  Report";
                        }
                    }
                }

                group("Disciplinary Management")
                {


                    action("Disciplinary Cases")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Disciplinary Cases List";
                    }

                    action("Closed Disciplinary Cases")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Disciplinary Cases ListClsd";
                    }
                    /* action("Disciplinary Actions List")
                     {
                         ApplicationArea = RelationshipMgmt;


                         //RunObject = Page "HR Disciplinary Cases List N";
                     }
                     action("Disciplinary WIthdrawal")
                     {
                         ApplicationArea = RelationshipMgmt;


                         //RunObject = Page hr dis;
                     }
                     action("Disciplinary Appeal")
                     {
                         ApplicationArea = RelationshipMgmt;


                         //RunObject = Page Appeal;
                     }*/
                    action("Employee Grievance")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Employee Grievance List";
                    }
                }


                group("Asset Transfers")
                {

                    action("Asset Transfer")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Asset Transfer List";
                    }
                    action("Effected Asset Transfer")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR EffectedAsset Transfer List";
                    }
                }

                group("Employee Transfers")
                {

                    action("Employee Transfer")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Employee Transfer List";
                    }
                    action("Effected Employee Transfer")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Employee Transfer List Effe";
                    }
                }

                group("Overtime Management")
                {

                    action("Overtime List")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Overtime List";
                    }
                    action("Overtime List - Converted")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Overtime List - Converted";
                    }
                    action("Overtime Rates")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Overtime Rates List";
                    }
                }
                group("Employee Exit")
                {

                    action("Exit Interview List")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "HR Exit Interview list";
                    }
                    action("Closed Exit Interview List")
                    {
                        ApplicationArea = RelationshipMgmt;


                        RunObject = Page "Closed HR Exit Interview list";
                    }
                }


            }

            group(Action13)
            {
                Caption = 'HR & Payroll';

                group(EmployeeManagement)
                {
                    Caption = 'Employee Management';

                    action("Employee List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Employee List';
                        Image = CustomerContact;


                        RunObject = Page "Employee List";
                    }
                    action("Employee List - Contract")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Employee List - Contract';


                        RunObject = Page "Employee List - Contract";
                    }
                    action("Employee List - Interns")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Employee List - Interns';


                        RunObject = Page "Employee List - Interns";
                    }


                }

                group(HRPayrollSetups)
                {
                    Caption = 'HR & PayrollSetups';

                    action(HRSetups)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = '***** HR Setups *****';
                        Image = CustomerContact;


                    }
                    action("Human Resources Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Human Resources Setup';


                        RunObject = Page "Human Resources Setup";
                    }
                    action("HR Advanced Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Advanced Setup';


                        RunObject = Page "HR Advanced Setup";
                    }
                    action("HR Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR General Setup';


                        RunObject = Page "HR Setup";
                    }
                    action("HR Leave Types")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Types';


                        RunObject = Page "HR Leave Types";
                    }
                    action("HR Leave Jnl. Template List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Jnl. Template List';


                        RunObject = Page "HR Leave Jnl. Template List";
                    }
                    action("HR Leave Batches")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Batches';


                        RunObject = Page "HR Leave Batches";
                    }
                    action("HR Leave Journal Lines")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Journal Lines';


                        RunObject = Page "HR Leave Journal Lines";
                    }
                    action("HR Leave Calendsr.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Calendar.';


                        RunObject = Page "HR Leave Calendsr.";
                    }


                    action(PayrollSetups)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = '***** Payroll Setups *****';
                        Image = CustomerContact;


                    }
                    action("Payroll Posting Group.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Posting Group';


                        RunObject = Page "Payroll Posting Group.";
                    }
                    action("Payroll Codes List.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Codes List';


                        RunObject = Page "Payroll Codes List.";
                    }
                    action("Payroll Rates.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Rates.';


                        RunObject = Page "Payroll Rates.";
                    }
                    action("PAYE Setup.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'PAYE Setup.';


                        RunObject = Page "PAYE Setup.";
                    }
                    action("SetNHIF Setupup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'NHIF Setup';


                        RunObject = Page "NHIF Setup";
                    }
                    action("NSSF Setup")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'NSSF Setup';


                        RunObject = Page "NSSF Setup";
                    }

                }

                group(LeaveManagement)
                {
                    Caption = 'Leave Management';

                    action("HR Leave Applications List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Applications List';
                        Image = CustomerContact;


                        RunObject = Page "HR Leave Applications List";
                    }
                    action("HR Leave App. - Pending")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave App. - Pending';


                        RunObject = Page "HR Leave App. - Pending";
                    }
                    action("HR Leave App. - Approved")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave App. - Approved';


                        RunObject = Page "HR Leave App. - Approved";
                    }
                    action("HR Leave Statement")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Statement';


                        RunObject = Report "HR Leave Statement";
                    }
                    action("HR Leave Planner")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Leave Planner List';
                        RunObject = Page "HR Leave Planner List";
                    }

                    action("HR Leave Schedule")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Schedule';
                        RunObject = Report "HR Leave Schedule";
                    }

                }

                group(HReports)
                {
                    Caption = 'HR Reports';

                    action("HR Employee List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Employee List';
                        Image = "Order";
                        RunObject = Report "HR Employee List";
                    }

                    action("HRLeave Application List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Leave Applications List';
                        Image = "Order";


                        RunObject = Report "HR Leave Application List";
                    }
                    action("HR Leave Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Leave Summary';
                        Image = "Order";


                        RunObject = Report "HR Leave Summary";
                    }
                    action("HR Leave Balances")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'HR Leave Balances';
                        Image = "Order";


                        RunObject = Report "HR Leave Balances";
                    }
                    action("Leave Planner Report")
                    {
                        ApplicationArea = relationshipmgmt;
                        RunObject = report "Leave Planner Report";
                    }
                    action("Timesheet Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        image = Timesheet;
                        Caption = 'HR Timesheet Report';

                        RunObject = report "Timesheets Report";
                    }

                }

                group(Payroll)
                {
                    Caption = 'Payroll';

                    action("Staff Payroll List.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Staff Payroll List.';
                        Image = "Order";


                        RunObject = Page "Staff Payroll List.";
                    }
                    action("Payroll Periods.")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Periods.';
                        Image = "Order";


                        RunObject = Page "Payroll Periods.";
                    }

                    action("Payroll Periods Transaction")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Period Transaction';
                        Image = "Order";


                        RunObject = page "Payroll Period transactions.";
                    }
                    action("Payroll Journal Trasnfer")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Journal Trasnfer';
                        Image = "Order";


                        RunObject = Report "Payroll Journal Transfer";
                    }



                }

                group(PayrollReports)
                {
                    Caption = 'Payroll Reports';

                    action("Payroll Codes Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Codes Report';
                        Image = "Order";
                        Visible = false;


                        RunObject = Report "Payroll Codes Report";
                    }
                    action("P9 Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'P9 Report';
                        Image = "Order";


                        RunObject = Report "P9 Report";
                    }
                    action("Payroll Summary Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Summary Report';
                        Image = "Order";
                        Visible = true;


                        RunObject = Report "Payroll Summary Report";
                    }
                    action("Payroll Transactions Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Transactions Summary';
                        Image = "Order";
                        Visible = true;

                        RunObject = Report "Payroll Transactions Summary";
                    }
                    action("prPayrollSummary-List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'prPayrollSummary-List';
                        Image = "Order";
                        Visible = true;


                        RunObject = Report "prPayrollSummary-List";
                    }
                    action("Payroll Transaction List")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Transaction List';
                        Image = "Order";
                        Visible = true;


                        RunObject = Report "Payroll Transaction List";
                    }

                    action("Payroll Summary Report Deductions")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Summary Report - Deductions';
                        Image = "Order";
                        Visible = false;


                        RunObject = Report "Payroll Summary - Ded Report";
                    }
                    action("Payroll Variance")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Varaince ';
                        Image = "Order";

                        RunObject = Report "Payroll Variance Rpt";
                    }
                    action("Detailed Payroll Summary")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Detailed Payroll Summary Report';
                        Image = "Order";
                        Visible = false;


                        RunObject = Report "Payroll Summary Detailed";
                    }
                    action("P9 Report - Board")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'P9 Report - Board';
                        Image = "Order";


                        RunObject = Report "P9 Report - Board";
                    }
                    action("Payroll Net Pay Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Caption = 'Payroll Net Pay Report';
                        Image = "Order";


                        RunObject = Report "Payroll Net Pay Report";
                    }
                    action("NITA Report")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "NITA Report";
                    }
                    action(NSSF)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report prNSSF;
                    }
                    action(NHIF)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report prNHIF;
                    }
                    action(HELB)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "PR HELB";
                    }
                    action(KUCDAW)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "PR KUCFAW";
                    }
                    action(COTU)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "PR COTU";
                    }
                    action(PROVIDENT)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "PR Provident NSSF";
                    }
                    action("A Third Rule")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "A Third Rule";
                    }
                    action("Earnings Listing")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "Earnings Listing -List";
                    }
                    action("Deductions Listing")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "Deductions Listing-List";
                    }
                    action("Paye Schedule")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "prPaye Schedule";
                    }
                    action("Pension Contributions")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report "prStaff Pension Contrib";
                    }
                    action("Transactions Listing")
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report prAllowances_Deductions;
                    }
                    action(P10A)
                    {
                        ApplicationArea = RelationshipMgmt;
                        Image = "Order";
                        RunObject = Report P10A;
                    }

                }
            }
        }

        area(processing)
        {







        }


    }
}
