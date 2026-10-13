Page 50614 "BBF Entitlement Headers"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    Caption = 'BBF Claim Header';
    SourceTable = "BBF Entitlement Header";
    PromotedActionCategories = 'Post,Navigate,Report,Request Approval,Functions';
    layout
    {
        area(content)
        {
            group(General)
            {
                field(RecID; Format(Rec.RecordId))
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Editable = EditFields;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Editable = EditFields;
                }
                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = EditFields;
                    ;
                    Enabled = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()


                    begin
                        //RunPeriodicTrans.POPostSinkClaim(REC);
                    end;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                /*field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }*/
                /*field("Claim Type"; "Claim Type")
                {
                    Caption = 'BBF Claim Type';

                    trigger OnValidate()
                    begin
                        if "Claim Type" = "Claim Type"::Death then
                            DemiseDet := true
                        else
                            DemiseDet := false;
                    end;
                }*/
                field("Date of Demise"; Rec."Date of Demise")
                {
                    ApplicationArea = Basic;
                    Editable = EditFields;
                    //Deceased Acc. With Balances Enabled = DemiseDet;
                }

                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = EditFields;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = EditFields;
                }
                field(ResponsibilyCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = EditFields;
                }
                field(PaymentReleaseDate; Rec."Payment Release Date")
                {
                    ApplicationArea = Basic;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = All;
                    ValuesAllowed = FOSA;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        //PayingBank := " ";
                    end;
                }
                field("Paying Bank"; Rec."Paying Bank")
                {
                    Editable = PayingBank;
                    ApplicationArea = All;
                }

                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = All;
                    Editable = EditFields;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Beneficiary Details")
            {
                Editable = EditFields;
                field("Collector Name"; Rec."Collector Name")
                {
                    ApplicationArea = All;
                }
                field("Collector ID"; Rec."Collector ID")
                {
                    ApplicationArea = All;
                }
                field("Collector Mobile No."; Rec."Collector Mobile No.")
                {
                    ApplicationArea = All;
                }
                field("Collector Relationship"; Rec."Collector Relationship")
                {
                    ApplicationArea = All;
                }

            }
            part(Control11; "BBF Entitlement Lines")
            {
                Editable = EditFields;
                SubPageLink = "Header No" = field("No.");

            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = '&Functions';
                action(Post)
                {
                    ApplicationArea = Basic;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        MActivities: Codeunit "Member Activities";
                    begin
                        Rec.TestField("Payment Release Date");
                        if Rec."Payment Release Date" <> Today then
                            Error('Payment release date must be today');

                        MActivities.PostSinkClaims(Rec);

                        CurrPage.Close();
                    end;
                }
                action("Mandatory Requirements")
                {
                    // ApplicationArea = Basic;
                    // Image = RegisteredDocs;
                    // Promoted = true;
                    // PromotedCategory = "Report";
                    // PromotedIsBig = true;
                    // RunObject = Page "Required Documents";
                    // RunPageLink = "Loan No." = field("No.");
                }

                action(Print)
                {
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        BBF: Record "BBF Entitlement Header";
                    begin
                        BBF.Reset;
                        BBF.SetRange("No.", Rec."No.");
                        if BBF.FindFirst then
                            REPORT.Run(Report::"BBF Report", true, false, BBF);
                    end;
                }
                action(PrintBBF)
                {
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;

                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        BBF: Record "BBF Entitlement Header";
                    begin
                        BBF.Reset;
                        BBF.SetRange("No.", Rec."No.");
                        if BBF.FindFirst then
                            REPORT.Run(Report::"BBF Claim Report", true, false, BBF);
                    end;
                }


                action(ReOpenDocument)
                {
                    ApplicationArea = Basic;
                    Caption = 'ReOpen Document';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        MsgOnDoc: label 'Document has been Opened. Please send approval request before you can continue.';
                    begin

                        if Rec.Posted = false then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                            Message(MsgOnDoc);
                        end;
                    end;
                }
                action(CancelDocument)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: label 'Are you sure you want to cancel this Document?';
                        Text001: label 'You have selected not to Cancel the Document';
                    begin
                    end;
                }


            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        DocumentType: Enum "Custom Document Type";
                    begin


                        Rec.TestField(Amount);

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, DocumentType::"BBF Claims", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
                    end;
                }
            }
            group(Navigate)
            {
                Caption = 'Navigate';
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
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;


                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    RunPageLink = "Table ID" = const(39005498),
                                  "Document No." = field("No. Series");
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            action("Get Beneficiary")
            {
                ApplicationArea = Basic;
                Caption = 'Get Beneficiary';
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    ClaimLines: Record "BBF Entitlement Lines";
                    Kin: Record "Next of Kin.";
                    i: Integer;
                begin
                    ClaimLines.Reset();
                    ClaimLines.SetRange("Header No", Rec."No.");
                    if ClaimLines.Find('-') then ClaimLines.DeleteAll();

                    Kin.Reset();
                    Kin.SetRange("No.", Rec."Member No");
                    if Kin.FindFirst then begin


                        ClaimLines.Reset();
                        if ClaimLines.FindLast() then
                            i := ClaimLines."Entry No.";
                        repeat
                            i += 1;
                            ClaimLines.Init();
                            ClaimLines."Header No" := Rec."No.";
                            ClaimLines."Entry No." := i;
                            ClaimLines.Name := Kin.Name;
                            ClaimLines."Relationship Type" := ClaimLines."Relationship Type"::Beneficiary;
                            ClaimLines.Relationship := Kin.Relationship;
                            ClaimLines."Member No" := Rec."Member No";
                            ClaimLines."ID No." := Kin."ID No.";
                            ClaimLines."Date of Birth" := Kin."Date of Birth";
                            ClaimLines.Insert();
                        until Kin.next() = 0;
                    end;
                end;
            }

        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;

        if Rec.Status = Rec.Status::Approved then
            PayingBank := false
        else
            PayingBank := true;

        /*if "Claim Type" = "Claim Type"::Death then
            DemiseDet := true
        else
            DemiseDet := false; */

    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
        /* if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Pending) then
             CurrPage.Editable := false;*/
        EditFields := true;
        if Rec.Status = Rec.Status::Approved then begin
            PayingBank := false;
            EditFields := false;
        end
        else
            PayingBank := true;

        /*if "Claim Type" = "Claim Type"::Death then
            DemiseDet := true
        else
            DemiseDet := false; */
    end;

    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
        CustomApprovals: Codeunit "Calwide Approvals";
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        PayingBank: Boolean;
        ErrMssg001: label 'Please provide mandatory documet %1';
        DemiseDet: Boolean;
        EditFields: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}
