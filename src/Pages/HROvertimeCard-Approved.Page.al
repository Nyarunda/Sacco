Page 51093 "HR Overtime Card - Approved"
{
    ApplicationArea = All;
    Editable = false;
    PageType = Card;
    SourceTable = "HR Overtime Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(ApplicationCode; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(StaffNo; Rec."Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field(StaffName; Rec."Staff Name")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(WeekendHours; Rec."WeekDay Hours")
                {
                    ApplicationArea = Basic;
                }
                field(HolidayHours; Rec."Sunday/Holiday Hours")
                {
                    ApplicationArea = Basic;
                }
                field(ExtraHours; Rec."Extra Hours")
                {
                    ApplicationArea = Basic;
                }
                field(TotalOvertimeHours; Rec."Total Overtime Hours")
                {
                    ApplicationArea = Basic;
                }
                field(ConvertTo; Rec."Convert To?")
                {
                    ApplicationArea = Basic;
                }
                field(Converted; Rec.Converted)
                {
                    ApplicationArea = Basic;
                }
                field(PostedtoPayroll; Rec."Posted to Payroll")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("OverTime Amount"; Rec."OverTime Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(OvertimeDetails)
            {
                Caption = 'Overtime Details';
                part(Control1000000004; "HR Overtime Lines")
                {
                    SubPageLink = "Application Code" = field("Application Code");
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approval)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    //ApprovalEntries: Page "Approval Entries";
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Jobs,"Employee Req",Employees,Promotion,Confirmation,"Employee Transfer","Asset Transfer","Transport Req",Overtime,"Training App","Leave App";
                begin
                    DocumentType := Documenttype::Overtime;
                    //ApprovalEntries.Setfilters(Database::"HR Overtime Header", DocumentType, "Application Code");
                    //ApprovalEntries.Run;
                end;
            }


            action(CalculateOverTime)
            {
                ApplicationArea = Basic;
                Caption = 'Calculate Overtime';
                Image = Overdue;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()

                begin
                    if Confirm('Calculate the overtime ? ', false) then begin
                        Rec.HasValidLines();
                        Rec."OverTime Amount" := Rec.CalculateOverTime();
                        Rec.Modify();
                        Commit();
                        Message('Overtime Amount has been updated!');
                    end;
                end;
            }


        }

    }
    trigger OnAfterGetCurrRecord()
    begin
        Approvals.Reset();
        Approvals.SetRange("Document No.", Rec."Application Code");
        if Approvals.Findlast() then Rec."Approver ID" := Approvals."Approver ID";
        Rec.Modify();
    end;

    trigger OnOpenPage()
    begin
        Approvals.Reset();
        Approvals.SetRange("Document No.", Rec."Application Code");
        if Approvals.FindFirst() then Rec."Approver ID" := Approvals."Approver ID";
        Rec.Modify();
    end;

    var
        Approvals: Record "Approval Entry";
        HRSetup: Record "HR Setup.";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp;
}

