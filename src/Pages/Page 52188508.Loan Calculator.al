
Page 50171 "Loan Calculator"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Loans;
    PromotedActionCategories = 'New,Process,Report,Approval Requests';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                    ShowMandatory = true;

                    LookupPageID = "Member Listing";

                    trigger OnValidate()
                    begin
                        /*
                        //Check share capital requirement
                        SavAcc.RESET;
                        SavAcc.SETRANGE(SavAcc."Member No.","Member No.");
                        SavAcc.SETRANGE(SavAcc."Product Category",SavAcc."Product Category"::"Share Capital");
                        IF SavAcc.FIND('-') THEN BEGIN
                          SavAcc.CALCFIELDS(SavAcc."Balance (LCY)");
                          //Check Minimum savings per product
                          IF SavAcc."Balance (LCY)"<GenSetup."Minimum Share Capital" THEN
                             ERROR(Text019,SavAcc."Balance (LCY)",GenSetup."Minimum Share Capital");
                        END ELSE
                             ERROR(Text019,SavAcc."Balance (LCY)",GenSetup."Minimum Share Capital");
                             */

                    end;
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(LoanProductType; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                    ShowMandatory = true;
                }
                field(LoanProductTypeName; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                }
                field(InterestCalculationMethod; Rec."Interest Calculation Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                }
                field(AnnualInterest; Rec."Annual Interest %")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Use Special Multiplier"; Rec."Use Special Multiplier")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Editable = ApplicationDetailsEdit;
                }
                field(AmountApplied; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = ApplicationDetailsEdit;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field(SystemRecommendedAmount; Rec."Recommended Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'System Recommended Amount';
                    Editable = false;
                }
                field(ApprovedAmount; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = ApplicationDetailsEdit;
                }
                field(Repayment; Rec.Repayment + Rec."Deposit COntribution" + Rec."Total Insurance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Repayment';
                    Editable = false;
                }
                field(LoanPrincipleRepayment; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LoanInterestRepayment; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Insurance"; Rec."Total Insurance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Insurance';
                    Editable = false;
                }
                field(RepaymentFrequency; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                }
                field(DisbursementDate; Rec."Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field(RepaymentStartDate; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field(ScheduleStartDate; Rec."Schedule Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(CompletionDate; Rec."Completion Date")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Disbursement)
            {
                field(ModeofDisbursement; Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                }
                field(DisbursementAccountNo; Rec."Disbursement Account No")
                {
                    ApplicationArea = Basic;
                }
                field(ChequeNo; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(BatchNo; Rec."Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = ApprovedEdit;
                }
            }
            part(Control46; "Loan Charges")
            {
                Editable = false;
                SubPageLink = "Loan No." = field("Loan No.");
            }
        }
        area(factboxes)
        {
            part(Control63; "Info Base")
            {
                SubPageLink = "Member No." = field("Member No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {

            action("Loan Top Up")
            {
                ApplicationArea = Basic;
                Image = SettleOpenTransactions;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Page "Loan Top Up";
                RunPageLink = "Loan No." = field("Loan No."),
                              "Member No." = field("Member No.");
            }
            action("Salary Details")
            {
                ApplicationArea = Basic;
                Image = Calculate;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Page "Salary Details";
                RunPageLink = "Loan No" = field("Loan No.");
            }
            action("Other Clearances")
            {
                ApplicationArea = Basic;
                Image = ClearFilter;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Page "Other Commitments Clearance";
                RunPageLink = "Loan Application No." = field("Loan No.");
            }

        }
        area(reporting)
        {
            action("Loan Appraisal Report")
            {
                ApplicationArea = Basic;
                Image = AnalysisView;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin

                    Commit;
                    MemberActivities.SetLoanAppraisal(Rec."Loan No.");
                    Commit;

                    Appraisal.Reset;
                    Appraisal.SetRange("Loan No.", Rec."Loan No.");
                    if Appraisal.FindFirst then
                        Report.Run(50078, true, false, Appraisal);
                end;
            }
            action("Loan Schedule Report")
            {
                ApplicationArea = Basic;
                Image = Link;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin

                    SaccoActivities.GenerateRepaymentSchedule(Rec);
                    Commit;

                    LoanRec.Reset;
                    LoanRec.SetRange("Loan No.", Rec."Loan No.");
                    if LoanRec.FindFirst then
                        Report.Run(50079, true, false, LoanRec);
                end;
            }
        }
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
                    Visible = SendBool;

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

                        CheckControls;

                        SendNotifications;

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."Loan No.", Rec."Requested Amount", Documenttype::"Loan Application", Rec."Global Dimension 1 Code", Rec."Booking Branch", Rec.Source);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = CancelBool;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Member Application","Loan Application";
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."Loan No.");
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
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application";
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocType := Doctype::"Loan Application";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."Loan No.");
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

                        if (Rec.Status <> Rec.Status::Open) and (Rec.Status <> Rec.Status::Pending) then begin

                            if not Confirm('Are you sure you want to re-open document?') then exit;
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateFields;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateFields;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Loan Calculator" := true;
        Rec."Loan No." := CopyStr(UserId, 1, 20);
    end;

    trigger OnOpenPage()
    begin
        UpdateFields;

        Rec.SetRange("Loan No.", CopyStr(UserId, 1, 20));
    end;


    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        Found: Boolean;
        SourceType: Option "New Member","New Account","Loan Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit","Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued",Bonus,Dividend,Bulk,"Standing Order","Loan Bill Due","POS Deposit","Mini Bonus","Leave Application","Loan Witness";
        TotalOffset: Decimal;
        Vend: Record "Savings Accounts";
        GLAcc: Record "G/L Account";
        CompInfo: Record "Company Information";
        EndDateSalo: Date;
        TotalLoans: Decimal;
        "******************************************************Controls": Integer;
        ApplicationDetailsEdit: Boolean;
        DisbursementEdit: Boolean;
        ApprovedEdit: Boolean;
        Temp: Record "User Setup";
        MicroDef: Text;
        initDF: DateFormula;
        AddToExisting: Boolean;
        infoVisible: Boolean;
        MemberActivities: Codeunit "Member Activities";
        LoanSecurity: Record "Loan Security";
        LoanRec: Record Loans;
        Appraisal: Record "Loan Appraisal";
        SendBool: Boolean;
        CancelBool: Boolean;
        SaccoActivities: Codeunit "Sacco Activities";
        ProductSetup: Record "Product Setup";

    local procedure UpdateFields()
    begin
        if Rec.Status = Rec.Status::Open then begin
            ApplicationDetailsEdit := true;
            SendBool := true;
            CancelBool := false;

        end
        else begin
            ApplicationDetailsEdit := true;
            SendBool := false;
            CancelBool := false;
        end;

        if Rec.Status = Rec.Status::Pending then begin
            CancelBool := true;
        end;
        if Rec.Status = Rec.Status::Approved then
            ApprovedEdit := true
        else
            ApprovedEdit := false;
    end;

    local procedure SendNotifications()
    var
        MemberActivities: Codeunit "Member Activities";
        Msg: Text;
        Member: Record Members;
        SMSSource: Enum "SMS Source Enum";
        ProductSetup: Record "Product Setup";
        SenderAddress: Text;
        SenderName: Text;
        CompanyInfo: Record "Company Information";
        SaccoSetup: Record "Sacco Setup";

    begin


        Member.Get(Rec."Member No.");
        ProductSetup.Get(Rec."Loan Product Type");
        Rec.TestField("Disbursement Account No");
        CompanyInfo.get;
        CompInfo.get;
        /*
        IF NOT "SMS Sent" THEN BEGIN
            Msg := 'Dear '+Member.Name+', We have received your '+ProductSetup.Description+' of KES '+FORMAT("Requested Amount")+'. If Approved it will be disbursed into your Account.';
            MemberActivities.SendSms(SMSSource::"Loan Application",Member."Mobile Phone No.",Msg,"Loan No.","Disbursement Account No",FALSE,FALSE);
        END;
        */

        /*
        if SMTPSetup.Get then begin
        
            CompanyInfo.Get;
            SenderName := CompanyInfo.Name;
            SenderAddress := SMTPSetup."User ID";
            if SenderName = '' then
                SenderName := COMPANYNAME;
        
            if SaccoActivities.ValidEmailAddress(SenderAddress) then begin
                SMTP.CreateMessage(SenderName,SenderAddress,Member."E-Mail",'LOAN APPLICATION: '+UpperCase(SenderName),'',true);
        
        
                //SMTP.AppendBody('<img src="data:image/png;base64,'+MemberActivities.Base64Header+'" alt="Red dot" />');
                //SMTP.AppendBody('<br><br>');
                SMTP.AppendBody('Dear '+Member.Name);
                SMTP.AppendBody('<br><br>');
                SMTP.AppendBody('We have received your '+ProductSetup.Description+' of KES '+Format("Requested Amount")+'. If Approved it will be disbursed into your Account.');
                SMTP.AppendBody('<br><br>');
                LoanSecurity.Reset;
                LoanSecurity.SetRange("Loan No.","Loan No.");
                LoanSecurity.SetRange("SMS Sent",false);
                LoanSecurity.SetFilter("Account No.",'<>%1','');
                if LoanSecurity.FindFirst then begin
                    SMTP.AppendBody('<b>LOAN SECURITY</b>');
                    SMTP.AppendBody('<table>');
                      SMTP.AppendBody('<tr>');
                        SMTP.AppendBody('<th>Security Type</th>');
                        SMTP.AppendBody('<th>Account No.</th>');
                        SMTP.AppendBody('<th>Collateral No.</th>');
                        SMTP.AppendBody('<th>Name</th>');
                        SMTP.AppendBody('<th>Amount Guaranteed</th>');
                      SMTP.AppendBody('</tr>');
        
                    repeat
        
                      SMTP.AppendBody('<tr>');
                        SMTP.AppendBody('<td>'+Format(LoanSecurity."Guarantor Type")+'</td>');
                        SMTP.AppendBody('<td>'+LoanSecurity."Account No."+'</td>');
                        SMTP.AppendBody('<td>'+LoanSecurity."Collateral Reg. No."+'</td>');
                        SMTP.AppendBody('<td>'+LoanSecurity.Name+'</td>');
                        SMTP.AppendBody('<td>'+Format(LoanSecurity."Amount Guaranteed")+'</td>');
                      SMTP.AppendBody('</tr>');
        
                    until LoanSecurity.Next = 0;
                    SMTP.AppendBody('</table>');
        
                end;
        
                SMTP.AppendBody('<br><br>');
                SMTP.AppendBody('Kind Regards,');
                SMTP.AppendBody('<br>');
                SMTP.AppendBody('<hr>');
        
        
                if SMTP.TrySend then;
        
        
            end;
        end;
        */




        SaccoSetup.get;
        LoanSecurity.Reset;
        LoanSecurity.SetRange("Loan No.", Rec."Loan No.");
        LoanSecurity.SetFilter("Account No.", '<>%1', '');
        if LoanSecurity.FindFirst then begin
            repeat
                if Member.Get(LoanSecurity."Member No") then begin

                  /*   Msg := 'Dear ' + Member.Name + ', You have guaranteed ' + Rec."Member Name" + ' ' + ProductSetup.Description + ' of KES ' + Format(Rec."Requested Amount") +
                            ' an Amount of KES ' + Format(LoanSecurity."Amount Guaranteed") + '. Call ' + SaccoSetup."Sacco Contacts" + ' if in dispute.';

                    Rec.TestField("Disbursement Account No");
                    if LoanSecurity."Member No" <> Rec."Member No." then
                        MemberActivities.SendSms(Smssource::"Loan Guarantors", Member."Mobile Phone No.", Msg, Rec."Loan No.", Rec."Disbursement Account No", true, false);
 */

                    /*
                    if SMTPSetup.Get then begin

                        CompanyInfo.Get;
                        SenderName := CompanyInfo.Name;
                        SenderAddress := SMTPSetup."User ID";
                        if SenderName = '' then
                            SenderName := COMPANYNAME;

                        if SaccoActivities.ValidEmailAddress(SenderAddress) then begin
                            SMTP.CreateMessage(SenderName, SenderAddress, Member."E-Mail", 'LOAN GUARANTORSHIP: ' + UpperCase(SenderName), '', true);

                            //SMTP.AppendBody('<img src="data:image/png;base64,'+MemberActivities.Base64Header+'" alt="Red dot" />');
                            //SMTP.AppendBody('<br><br>');
                            SMTP.AppendBody('Dear ' + Member."First Name");
                            SMTP.AppendBody('<br><br>');
                            SMTP.AppendBody('You have guaranteed ' + "Member Name" + ' ' + ProductSetup.Description + ' of KES ' + Format("Requested Amount") +
                                ' an Amount of KES ' + Format(LoanSecurity."Amount Guaranteed") + '. If in dispute kindly contact the SACCCO');
                            SMTP.AppendBody('<br><br>');

                            SMTP.AppendBody('<br><br>');
                            SMTP.AppendBody('Kind Regards,');
                            SMTP.AppendBody('<br>');
                            SMTP.AppendBody(SenderName);

                            SMTP.AppendBody('<hr>');
                            if SMTP.TrySend then;
                        end;
                    end;
                    */
                end;
            until LoanSecurity.Next = 0;
        end;

    end;

    local procedure CheckControls()
    var
        ScheduleofProperties: Record "Schedule of Properties";
    begin

        Rec.TestField("Main Sector Code");
        Rec.TestField("Sub-Sector Level 1 Code");
        Rec.TestField("Sub-Sector Level 2 Code");

        ProductSetup.Reset;
        ProductSetup.SetRange("Product ID", Rec."Loan Product Type");
        ProductSetup.SetRange("Schedule of Property Mandatory", true);
        //ProductSetup.SETRANGE("No Guarantee",FALSE);
        if ProductSetup.FindFirst then begin
            ScheduleofProperties.Reset;
            ScheduleofProperties.SetRange("Loan No.", Rec."Loan No.");
            ScheduleofProperties.SetFilter("Estimated Value", '>0');
            if not ScheduleofProperties.FindFirst then
                Error('Capture Schedule of Properties');

        end;


        Rec.CalcFields("Total Guaranteed");

        if (Rec."Loanee Guaranteed" + Rec."Total Guaranteed" < Rec."Requested Amount") and (Rec."Loan Product Type" <> '153') then
            Error('Loan Not Fully Guaranteed');

        Appraisal.Reset;
        Appraisal.SetRange("Loan No.", Rec."Loan No.");
        if not Appraisal.FindFirst then
            Error('Loan Not Appraised');
    end;
}

