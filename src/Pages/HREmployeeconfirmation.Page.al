Page 51014 "HR Employee confirmation"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Employee Confirmation";

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
                field(EmployeeNumber; Rec."Employee Number")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
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
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RequestDate; Rec."Request Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ProbationStartDate; Rec."Probation Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ProbationEndDate; Rec."Probation End Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ConfirmationDate; Rec."Confirmation Date")
                {
                    ApplicationArea = Basic;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {
                Caption = 'F&unctions';
                action("Confirmation Report")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    /*trigger OnAction()
                    begin
                        EmployeeConfirmation.Reset;
                        EmployeeConfirmation.SetRange(EmployeeConfirmation.No, No);
                        if EmployeeConfirmation.Find('-') then
                            Report.Run(Report::"Employee Confirmation Report", true, true, EmployeeConfirmation);
                    end;Rec.*/
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Request Date" := Today;
    end;

    var
        HREmp: Record Employee;
        EmpJobDesc: Text[50];
        HRJobs: Record "HR Jobs";
        SupervisorName: Text[60];
        ////SMTP: Codeunit UnknownCodeunit400;
        URL: Text[500];
        HRSetup: Record "HR Setup.";
        EmpDept: Text[30];
        //ApprovalEntries: Page "Approval Entries";
        //HRLeaveLedgerEntries: Record UnknownRecord39003930;
        EmpName: Text[70];
        ApprovalComments: Page "Approval Comments";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        varDaysApplied: Integer;
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        "LineNo.": Integer;
        sDate: Record Date;
        //Customized: Record "HR Leave Calendar.";
        //HREmailParameters: Record UnknownRecord39003942;
        HRJournalBatch: Record "HR Leave Journal Batch.";
    //EmployeeConfirmation: Record UnknownRecord39003984;
}

