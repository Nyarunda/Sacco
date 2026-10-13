page 50784 "CRB Submission Card"
{
    ApplicationArea = All;
    Caption = 'CRB Submission Card';
    PageType = Card;
    SourceTable = "CRB Submission Header";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Captured By field.', Comment = '%';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("Is Final Submission"; Rec."Is Final Submission")
                {
                    ApplicationArea = All;
                }
                field("Completion Start Date"; Rec."Completion Start Date")
                {
                    ApplicationArea = All;

                }
                field("Completion End Date"; Rec."Completion End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Success; Rec.Success)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Success field.', Comment = '%';
                }
                field("Has Error"; Rec."Has Error")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Has Error field.', Comment = '%';
                }
                field("Api Code"; Rec."Api Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Api Code field.', Comment = '%';
                }
                field("Api Code Description"; Rec."Api Code Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Api Code Description field.', Comment = '%';
                }
                field("Transaction ID"; Rec."Transaction ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction ID field.', Comment = '%';
                }
            }
            group(Filters)
            {
                Visible = false;

                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = All;
                }
                field("Repayment End Date"; Rec."Repayment End Date")
                {
                    ApplicationArea = All;
                }
                field("Loan No. Filter"; Rec."Loan No. Filter")
                {

                }

                field("Member No. Filter"; Rec."Member No. Filter")
                {


                }

                field("Loan Product Filter"; Rec."Loan Product Filter")
                {

                }
            }

            part(Control1102755015; "Individual Consumer - CE")
            {
                Editable = true;
                ApplicationArea = Basic, Suite;
                SubPageLink = HeaderNo = FIELD("Entry No.");

            }

        }
    }



    actions
    {
        area(processing)
        {
            action(SendToMetropol)
            {
                ApplicationArea = All;
                Caption = 'Send To Metropol';
                Image = Import;
                trigger OnAction()
                var

                    CRBActivities: Codeunit CRB;
                begin

                    //TestField(Success, false);

                    IF CONFIRM('Are you sure you want to Send this Data to Metropol') THEN BEGIN

                        if rec.Category = rec.Category::Individual then
                            CRBActivities.IndividualConsumerEmployerAccountSubmission(rec."Entry No.")
                        else if rec.Category = rec.Category::Business then
                            CRBActivities.NonIndividualConsumerEmployerAccountSubmission(rec."Entry No.")
                        else
                            CRBActivities.IndividualConsumerEmployerAccountSubmission(rec."Entry No.");

                        Message('Successfully Run');
                        Commit();
                    END;

                end;
            }
            action(Validate)
            {
                ApplicationArea = All;
                Caption = 'Validate Submission';
                Image = Import;
                trigger OnAction()
                var

                    CRBActivities: Codeunit CRB;
                begin

                    //TestField(Success, false);

                    IF CONFIRM('Are you sure you want to validate submission?') THEN BEGIN
                        Commit();
                        CRBActivities.ValidateCRBStatus(rec."Entry No.");
                        Message('Successfully Run');
                    END;

                end;
            }
            action(GetLogs)
            {
                ApplicationArea = All;
                Caption = 'Get Error Logs';
                Image = Import;
                trigger OnAction()
                var

                    CRBActivities: Codeunit CRB;
                begin

                    //TestField(Success, false);

                    IF CONFIRM('Are you sure you want to generate error logs?') THEN BEGIN

                        CRBActivities.generateCRBErrorLog(rec."Entry No.");
                        Message('Successfully Run');
                    END;

                end;
            }
            action(GenerateEntries)
            {
                ApplicationArea = All;
                Caption = 'Generate Entries';
                Image = Import;
                trigger OnAction()
                var
                    MonthlyCE: Report "Generate CRB Submission";
                    Header: Record "CRB Submission Header";

                begin

                    rec.TestField(rec.Success, false);

                    IF confirm('Are you sure you want to Generate CRB Data') THEN BEGIN


                        Header.Reset();
                        Header.SetRange("Entry No.", rec."Entry No.");
                        if Header.FindFirst() then
                            report.RunModal(report::"Generate CRB Submission", true, false, header);


                    END;

                end;
            }




            action(Logs)
            {

                ApplicationArea = Basic;
                Image = SelectChart;
                Promoted = true;
                PromotedCategory = category8;
                RunObject = Page "CRB Submission Logs";
                RunPageLink = "Header No." = field("Entry No.");
            }



        }
    }


    var

        "ID No.": Code[20];
        Name: Text;
        "Serial No.": Text;
        FirstName: Text;
        Surname: Text;
        OtherNames: Text;
        LineNo: Integer;

        citizenship: Text;
        date_of_birth: Date;
        gender: Text;
        place_of_birth: Text;
        date_of_issue: Text;
        id_number: Text;
        date_of_expiry: Text;
        IDType: Option "","National ID",Passport;


}
