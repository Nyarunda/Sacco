namespace CentralDB.CentralDB;

using Microsoft.HumanResources.Employee;

report 50438 "Employee Appraisal  Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Employee Appraisal Report.rdlc';
    Caption = 'Employee Appraisal  Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Employee; Employee)
        {
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(JobDescription; "Job Description")
            {
            }
            column(JobTitle; "Job Title")
            {
            }
            column(EmploymentDate; "Employment Date")
            {
            }
            column(SelfRating; SelfRating)
            {
            }
            column(AgreedRating; AgreedRating)
            {
            }
            column(Sn; Sn)
            {
            }
            column(Remarks; Remarks)
            {
            }
            trigger OnAfterGetRecord()
            var
                AppHeader: Record "HR Appraisal Header";
                HrAppraisalPeriod: Record "HR Lookup Values";
                AppLines: record "HR Appraisal Lines";
            begin
                SelfRating := 0;
                AgreedRating := 0;
                Remarks := '';

                HrAppraisalPeriod.Reset();
                HrAppraisalPeriod.SetRange("Current Appraisal Period", true);
                if HrAppraisalPeriod.FindFirst() then begin

                    AppHeader.Reset();
                    AppHeader.SetRange("Employee No", Employee."No.");
                    AppHeader.SetRange("Appraisal Period", HrAppraisalPeriod.Code);
                    if AppHeader.FindFirst() then begin
                        Name := AppHeader."Employee Name";
                        Remarks := AppHeader."Team Leaders Comments";
                        AppHeader.CalcFields("Job Specific Agreed Score");
                        SelfRating := AppHeader."Job Specific Agreed Score";

                        AppLines.Reset();
                        AppLines.SetRange("Appraisal No", AppHeader."Appraisal No");
                        AppLines.SetRange("Employee No", Employee."No.");
                        if AppLines.FindFirst() then begin
                            AppLines.CalcSums("Agreed Rating");
                            AgreedRating := AppLines."Agreed Rating";
                        end;
                    end;
                    Sn += 1;
                end;

            end;
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
    var
        SelfRating: Decimal;
        AgreedRating: Decimal;
        Remarks: Text[100];
        Name: Text[100];
        Sn: Integer;
}
