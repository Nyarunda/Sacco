
Page 50178 "Cheque Application"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Cheque Book Application_";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = TransType;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = accNo;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    LookupPageID = "Member Listing";
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ChequeBookType; Rec."Cheque Book Type")
                {
                    ApplicationArea = Basic;
                    Editable = chbktype;
                }
                field(BeginingChequeNo; Rec."Begining Cheque No.")
                {
                    ApplicationArea = Basic;
                    Editable = beginCh;
                }
                field(EndChequeNo; Rec."End Cheque No.")
                {
                    ApplicationArea = Basic;
                    Editable = endCh;
                }
                field(ResponsibilityCentre; Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Lastcheck; Rec."Last check")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ChequeAccountNo; Rec."Cheque Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = beginCh;
                }
                field(TranslationCode; Rec."Translation Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(ChequeRegisterGenerated; Rec."Cheque Register Generated")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ChequeBookchargesPosted; Rec."Cheque Book charges Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApplicationExported; Rec."Application Exported")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Issue/Generate Cheque Register")
            {
                ApplicationArea = Basic;
                Image = Interaction;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Rec.Status <> Rec.Status::Approved then
                        Error('The document must be fully approved');

                    //IF "Application Exported"<>TRUE THEN
                    //ERROR('You cannot generate the cheque book before the application is exported');

                    if Rec."Cheque Register Generated" then
                        Error('Cheque generation already done');

                    //TESTFIELD("Cheque Book charges Posted",TRUE);
                    Rec.TestField("Begining Cheque No.");
                    Rec.TestField("End Cheque No.");
                    IncrNo := Rec."Begining Cheque No.";

                    if Rec."End Cheque No." < Rec."Begining Cheque No." then
                        Error('Beginning number is more than ending number');


                    Leaves := 0;
                    while IncrNo <= Rec."End Cheque No." do begin
                        CheqReg.Init;
                        //CheqReg."Account No.":="Cheque Account No.";
                        CheqReg."Account No." := Rec."Account No.";
                        CheqReg."Cheque No." := IncrNo;
                        //IF STRLEN(CheqReg."Cheque No.")=6 THEN
                        //CheqReg."Cheque No.":='0000'+CheqReg."Cheque No.";
                        CheqReg."Application No." := Rec."No.";
                        CheqReg.Insert;
                        Leaves += 1;
                        IncrNo := IncStr(IncrNo);
                    end;

                    ChequeSetUp.Get(Rec."Cheque Book Type");
                    if Leaves <> ChequeSetUp."Number Of Leaf" then
                        Error('Difference in No of Leaves Created. Kindly Verify the Ending Cheque No.');


                    Rec."Cheque Register Generated" := true;
                    Rec.Modify;

                    if Vend.Get(Rec."Account No.") then begin
                        MobNo := Vend."Mobile Phone No.";
                        Vend."Cheque Account No." := Rec."Cheque Account No.";
                        Vend.Modify;
                    end;


                    //SendSMS.SendSms(SourceType::"Chq Book",MobNo,Text0001 +FORMAT(TODAY)+' '+FORMAT(TIME)
                    //+' '+COMPANYNAME,"No.",Vend."No.",TRUE,FALSE);

                    Message('Register generated successfully');
                end;
            }
            action("Cheque Register")
            {
                ApplicationArea = Basic;
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Cheque Register List";
            }
            action("Post Cheque Book Charges")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Cheque Book charges Posted", false);

                    if Confirm('Do you want post the charges', false) = true then begin


                        //IF Status=Status::"Pending Approval" THEN
                        //ERROR('The transaction must be fully approved before proceeding');

                        //SaccoT.PostBankChequeCharges(Rec);

                    end;
                end;
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
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
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
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
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
                    Visible = OpenApprovalEntriesExistForCurrUser;
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
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);

                        Rec.TestField("Cheque Book charges Posted", false);
                        Rec.TestField("Account No.");
                        Rec.TestField("Cheque Book Type");
                        //TESTFIELD("Begining Cheque No.");
                        //TESTFIELD("End Cheque No.");
                        Rec.TestField("Transaction Type");


                        VarVariant := Rec;
                        if CustomApprovals.CheckWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        if Rec.Status <> Rec.Status::"Pending Approval" then
                            Error(DocMustbePending);

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocForApproval(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin

                        approvalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        UpdateControl;
    end;

    trigger OnInit()
    begin
        UpdateControl;
    end;

    var
        CheqReg: Record "Cheques Register_";
        IncrNo: Code[10];
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        Vend: Record "Savings Accounts";
        AccountTypeS: Record "Product Setup";
        AvailableBal: Decimal;
        Charges: Record "Transaction Charges";
        GenSetup: Record "Sacco Setup";
        ChequeSetUp: Record "Cheque Set Up_";
        "TOTAL CHARGES": Decimal;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Calwide Approvals";
        DocMustbeOpen: label 'This application request must be open';
        DocMustbePending: label 'This application request must be Pending';
        chbktype: Boolean;
        beginCh: Boolean;
        endCh: Boolean;
        accNo: Boolean;
        SaccoT: Codeunit "Sacco Activities";
        TransType: Boolean;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book";
        Text0001: label 'Your cheque book is ready for collection ';
        MobNo: Code[20];
        Leaves: Integer;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;


    procedure UpdateControl()
    begin

        if Rec.Status = Rec.Status::Open then begin
            accNo := true;
            endCh := true;
            beginCh := true;
            chbktype := true;
            TransType := true;
        end;



        if Rec.Status = Rec.Status::"Pending Approval" then begin
            accNo := false;
            endCh := true;
            beginCh := true;
            chbktype := false;
            TransType := false;
        end;


        if Rec.Status = Rec.Status::Rejected then begin
            accNo := false;
            endCh := false;
            beginCh := false;
            chbktype := false;
            TransType := false;

        end;

        if Rec.Status = Rec.Status::Approved then begin
            accNo := false;
            endCh := true;
            beginCh := true;
            chbktype := false;
            TransType := false;

        end;


        if Rec."Cheque Register Generated" = true then begin
            accNo := false;
            endCh := false;
            beginCh := false;
            chbktype := false;
            TransType := false;

        end;
    end;
}

