Page 50953 "HR Staff Transport Requisition"
{
    PageType = Card;
    PromotedActionCategories = 'Manage,Process,Report';
    SourceTable = "HR Transport Requisition Head";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(TransportRequestNo; Rec."Transport Request No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RaisedBy; Rec."Raised By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(EmployeeNo; Rec."Employee No")
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
                field(DepartureDate; Rec."Departure Date")
                {
                    ApplicationArea = Basic;
                }
                field(ReturnDate; Rec."Return Date")
                {
                    ApplicationArea = Basic;
                }
                field(DaysApplied; Rec."Days Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TimeofTrip; Rec."Time of Trip")
                {
                    ApplicationArea = Basic;
                }
                field(PickupPoint; Rec."Pickup Point")
                {
                    ApplicationArea = Basic;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = Basic;
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = Basic;
                }
                field(PurposeofTrip; Rec."Purpose of Trip")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        // if ApprovalsMgmt.CheckHrtransportApprovalsWorkflowEnabled(Rec) then
                        //   ApprovalsMgmt.OnSendHrtransportForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    //Image = cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.OnCancelHrtransportApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    var
        HREmp: Record Employee;
        EmpJobDesc: Text[30];
        HRJobs: Record "HR Jobs";
        SupervisorName: Text[30];
        //SMTP: Codeunit UnknownCodeunit400;
        URL: Text[500];
        dAlloc: Decimal;
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Decimal;
        HRSetup: Record "HR Setup.";
        EmpDept: Text[30];
        HRLeaveApp: Record "HR Leave Application.";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries.";
        D: Date;
        EmpName: Text[70];
        DoclLink: Record "HR Company Attachments";
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";


    procedure TESTFIELDS()
    begin
        Rec.TestField("Days Applied");
        Rec.TestField("Departure Date");
    end;
}

