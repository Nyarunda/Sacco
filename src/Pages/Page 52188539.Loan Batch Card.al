
Page 50202 "Posted Loan Disb. Header"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Loan Disbursement Header";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                Editable = ApprovedEdit;
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(SubsequentDisbursements; Rec."Subsequent Disbursements")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if Rec."Subsequent Disbursements" = Rec."subsequent disbursements"::Yes then
                            SubseqDisb := true
                        else
                            SubseqDisb := false;
                    end;
                }
                field(DisbursementDestination; Rec."Disbursement Destination")
                {
                    ApplicationArea = Basic;
                }
                field(DisburseAccounts; Rec."Disburse Accounts")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(ChequeNo; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field(TimePosted; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field(TotalAmount; Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                group("Partial Disbursements")
                {
                    Visible = SubseqDisb;
                    field(LoanProductType; Rec."Loan Product Type")
                    {
                        ApplicationArea = Basic;
                        Editable = SubseqDisb;
                        Visible = SubseqDisb;
                    }
                    field(IssuedDateFrom; Rec."Issued Date From")
                    {
                        ApplicationArea = Basic;
                    }
                    field(IssuedDateTo; Rec."Issued Date To")
                    {
                        ApplicationArea = Basic;
                        Editable = SubseqDisb;
                        Visible = SubseqDisb;
                    }
                }
            }
            part(PVLines; "Loan Disbursement Lines")
            {
                SubPageLink = No = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Loan Disbursement Schedule")
            {
                ApplicationArea = Basic;
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Batches.Reset;
                    Batches.SetRange(Batches."No.", Rec."No.");
                    if Batches.Find('-') then begin
                        Report.Run(50174, true, false, Batches);
                    end;
                end;
            }
            action(REOPEN)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        StatusControl;
    end;

    trigger OnOpenPage()
    begin
        if Rec."Subsequent Disbursements" = Rec."subsequent disbursements"::Yes then
            SubseqDisb := true
        else
            SubseqDisb := false;
        StatusControl;
    end;

    var
        Text001: label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        Text000: label 'Do you want to Void Check No %1';
        Text002: label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';
        Posting: Codeunit "Sacco Activities";
        Batches: Record "Loan Disbursement Header";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        "LoanDateErr:": label 'Dates are inconsistent';
        EntryNo: Integer;
        Loans: Record Loans;
        DisbLines: Record "Loan Disbursement Lines";
        "MissingLoans:": label 'There are missing loans within the filter';
        PartDisb: Record "Partial Disbursement Schedule";
        Text003: label 'This option is meant for subsequent disbursements - Partial';
        Text004: label 'This option is first time disbursements';
        Text005: label 'Dates cannot be blank';
        LoanApp: Record Loans;
        LoanNotApproved: label 'Loan No. %1 in the current batch is not approved. Remove from batch or approve first';
        SubseqDisb: Boolean;
        ApprovedEdit: Boolean;

    local procedure GetIfNothingSelected()
    begin
    end;


    procedure StatusControl()
    begin
        ApprovedEdit := true;
        case Rec.Status of
            Rec.Status::Pending, Rec.Status::Approved, Rec.Status::Rejected:
                begin
                    ApprovedEdit := false;
                end;
            Rec.Status::Open:
                begin
                    ApprovedEdit := true;
                end;
        end;
    end;
}

