page 50453 "HR Tranport Application Card"
{
    Caption = 'HR Tranport Application Card';
    PageType = Card;
    SourceTable = "HR Transport Application";
    PromotedActionCategories = 'Request Approval';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Estimated Start Time"; Rec."Estimated Start Time")
                {
                    ApplicationArea = all;
                }
                field("Estimated End Time"; Rec."Estimated End Time")
                {
                    ApplicationArea = all;
                }
                field("Purpose "; Rec."Purpose")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purpose  field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
                field(Vehicle; Rec.Vehicle)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle field.';
                }
                field("Vehicle Desc."; Rec."Vehicle Desc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle Desc. field.';
                }
                field(Driver; Rec.Driver)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver field.';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver field.';
                }
                field("Mileage Start"; Rec."Mileage Start")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver field.';
                }
                field("Mileage Stop"; Rec."Mileage Stop")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        NextofKIN: Record "Service Item";
                        ProductFactory: Record "Service Item";
                        SavingsAccountRegistration: Record "Service Item";
                        DocumentType: Enum "Custom Document Type";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin
                        //TESTFIELD(e)
                        //TESTFIELD("Cell Phone Number");
                        //TESTFIELD(Address);
                        Rec.TestField("Start Date");
                        Rec.TestField("End Date");
                        Rec.TestField(Purpose);
                        Rec.TestField(Vehicle);
                        Rec.TestField("Mileage Start");
                        //TESTFIELD("Interest Due Date");}

                        //CheckControls;

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec.Code, 0, Documenttype::"HR Transport Requisition", '', '', 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        DocumentType: Enum "Custom Document Type";
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec.Code);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page System.Automation."Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocType: Enum "Custom Document Type";
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocType := Doctype::Leave;


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec.Code);
                        ApprovalTracker.SetRange("Document Type", DocType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        if (Rec.Status <> Rec.Status::New) and (Rec.Status <> Rec.Status::"Pending Approval") then begin

                            if not Confirm('Are you sure you want to re-open document?') then exit;
                            Rec.Status := Rec.Status::New;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }


    var
        VarVariant: Variant;
        HREmp: Record Employee;
        EmpJobDesc: Text[50];
        SupervisorName: Text[60];
        ////SMTP: Codeunit UnknownCodeunit400;
        URL: Text[500];
        dAlloc: Decimal;
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Decimal;
        HRSetup: Record "HR Setup.";
        EmpDimension_1: Text[60];
        EmpDimension_2: Text[60];
        HRLeaveApp: Record "HR Leave Application.";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries.";
        EmpName: Text[70];
        ApprovalComments: Page "Approval Comments";
        UserSetup: Record "User Setup";
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types.";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        LeaveGjline: Record "HR Leave Journal Line.";
        "LineNo.": Integer;
        sDate: Record Date;
        Customized: Record "HR Leave Calendar Lines.";
        HRJournalBatch: Record "HR Leave Journal Batch.";
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
}