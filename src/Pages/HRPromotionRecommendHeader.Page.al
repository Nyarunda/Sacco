Page 51011 "HR Promotion Recommend Header"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Promotion';
    SourceTable = "HR Promo. Recommend Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(JobTitle; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SalaryGrade; Rec."Salary Grade")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SalaryNotch; Rec."Salary Notch")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Region; Rec."Shortcut Dimension code1")
                {
                    ApplicationArea = Basic;
                    Caption = 'Region';
                    Editable = false;
                }
                field(Department; Rec."Shortcut Dimension code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Department';
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Competencies; Rec.Competencies)
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(DevelopmentAreas; Rec."Development Areas")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(NewJobID; Rec."New Job ID")
                {
                    ApplicationArea = Basic;
                }
                field(NewJobTitle; Rec."New Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(NewSalaryGrade; Rec."New Salary Grade")
                {
                    ApplicationArea = Basic;
                }
                field(NewSalaryNotch; Rec."New Salary Notch")
                {
                    ApplicationArea = Basic;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = Basic;
                }
            }
            /*
            part(Control16;Rec."HR Employee Qualification Line")
            {
                Caption = 'Employee Qualifications';
                SubPageLink = "Employee No." = field("Employee No.");
            }
            */
        }
    }

    actions
    {
        area(processing)
        {
            action(Promote)
            {
                ApplicationArea = Basic;
                Image = Position;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin

                    if Confirm(Txt001, false) = true then begin

                        Employees.Reset;
                        Employees.SetRange(Employees."No.", Rec."Employee No.");
                        if Employees.Find('-') then begin
                            //Employees.Position := "New Job ID";
                            Employees."Job Title" := Rec."New Job Title";
                            //Employees."Salary Grade" := "New Salary Grade";
                            //Employees."Salary Notch/Step" := "New Salary Notch";

                            Employees.Modify;
                        end;

                        Rec.Promoted := true;
                        Rec.Modify;

                        Message(Txt002, Rec."Employee No.");

                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*
        PromoLinesrec.Reset;
        PromoLinesrec.SetRange(PromoLinesrec."Document No", No);
        if PromoLinesrec.Find('-') then
            PromoLinesrec."Document No" := No;
            */
    end;

    var
        HREmp: Record Employee;
        EmpJobDesc: Text[50];
        HRJobs: Record "HR Jobs";
        SupervisorName: Text[60];
        //SMTP: Codeunit UnknownCodeunit400;
        URL: Text[500];
        HRSetup: Record "HR Setup.";
        EmpDept: Text[30];
        ApprovalEntries: Page "Approval request Entries";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries.";
        EmpName: Text[70];
        ApprovalComments: Page "Approval Comments";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        varDaysApplied: Integer;
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        "LineNo.": Integer;
        sDate: Record Date;
        Customized: Record "HR Leave Calendar.";
        //HREmailParameters: Record UnknownRecord39003942;
        HRJournalBatch: Record "HR Leave Journal Batch.";
        //PromoLinesrec: Record UnknownRecord39003986;
        Txt001: label 'Do you want to promote this employee?';
        Txt002: label 'Employee No. %1 has been successfully promoted';
        Employees: Record Employee;
}

