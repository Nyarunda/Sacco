page 50900 "Staff Loan Application Card"
{
    Caption = 'Staff Loan Application Card';
    PageType = Card;
    SourceTable = Loans;
    DeleteAllowed = false;
    PromotedActionCategories = 'New,Process,Report,Loan Security,Loan Charges,Clearances,Approval Request,Bank Details,Post Loan,Member Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    LookupPageID = "Member Listing";
                }

                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Member Category"; Rec."Member Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff No.';
                    Editable = false;
                }

                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }

            group("Loan Information")
            {
                Caption = 'Loan Information';

                field(LoanProductType; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ProductSetup: Record "Product Setup";
                    begin
                        ProductSetup.Reset();
                        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Credit);
                        ProductSetup.SetRange(Status, ProductSetup.Status::Active);
                        ProductSetup.SetRange("Loan Clients", ProductSetup."Loan Clients"::"Staff Members");

                        if Page.RunModal(Page::"Product Setup List", ProductSetup) = Action::LookupOK then begin
                            Rec.Validate("Loan Product Type", ProductSetup."Product ID");
                            exit(true);
                        end;

                        exit(false);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateStaffLoanProduct();
                    end;
                }

                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Product Sub Type"; Rec."Product Sub Type")
                {
                    ApplicationArea = Basic;
                }

                field("Salary Appraisal No."; Rec."Salary Appraisal No.")
                {
                    ApplicationArea = Basic;
                }

                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Annual Interest %"; Rec."Annual Interest %")
                {
                    ApplicationArea = Basic;
                }

                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                }

                field("Repay Mode"; Rec."Repay Mode")
                {
                    ApplicationArea = Basic;
                }

                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                }

                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
            }

            group("Amount Details")
            {
                Caption = 'Amount Details';

                field(RequestedAmount; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }

                field(RecommendedAmount; Rec."Recommended Amount")
                {
                    ApplicationArea = Basic;
                }

                field(ApprovedAmount; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }

                field(AmountToDisburse; Rec."Amount To Disburse")
                {
                    ApplicationArea = Basic;
                }

                field("Net To Be Disbursed"; Rec."Net To Be Disbursed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Top Up Amount"; Rec."Top Up Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Loan Charges"; Rec."Loan Charges")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("External Clearance"; Rec."External Clearance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Registration Fee"; Rec."Registration Fee")
                {
                    ApplicationArea = Basic;
                }

                field("Appraisal Fee"; Rec."Appraisal Fee")
                {
                    ApplicationArea = Basic;
                }

                field("Deposit Boosting"; Rec."Deposit Boosting")
                {
                    ApplicationArea = Basic;
                }

                field("Deposit Boosted"; Rec."Deposit Boosted")
                {
                    ApplicationArea = Basic;
                }

                field("Share Capital Boosting"; Rec."Share Capital Boosting")
                {
                    ApplicationArea = Basic;
                }

                field("Deposit Boosting Commission"; Rec."Deposit Boosting Commission")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }

            group("Repayment Details")
            {
                Caption = 'Repayment Details';

                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                }

                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                }

                field("Principal Repayment"; Rec."Principal Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                }

                field("Adjusted Repayment"; Rec."Adjusted Repayment")
                {
                    ApplicationArea = Basic;
                }

                field("Total Insurance"; Rec."Total Insurance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Deposit COntribution"; Rec."Deposit COntribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposit Contribution';
                }

                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }

                field("Schedule Start"; Rec."Schedule Start")
                {
                    ApplicationArea = Basic;
                }

                field("Schedule Start Date"; Rec."Schedule Start Date")
                {
                    ApplicationArea = Basic;
                }
            }

            group("Disbursement Details")
            {
                Caption = 'Disbursement Details';

                field("Type of Disbursement"; Rec."Type of Disbursement")
                {
                    ApplicationArea = Basic;
                }

                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                }

                field("Disbursement Date"; Rec."Disbursement Date")
                {
                    ApplicationArea = Basic;
                }

                field("Disbursement Stage"; Rec."Disbursement Stage")
                {
                    ApplicationArea = Basic;
                }

                field("Disbursement Account No"; Rec."Disbursement Account No")
                {
                    ApplicationArea = Basic;
                }

                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }

                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Bank Branch"; Rec."Bank Branch")
                {
                    ApplicationArea = Basic;
                }

                field("Bank Account No"; Rec."Bank Account No")
                {
                    ApplicationArea = Basic;
                }

                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
            }

            group("Appraisal And Officers")
            {
                Caption = 'Appraisal And Officers';

                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Appraised By"; Rec."Appraised By")
                {
                    ApplicationArea = Basic;
                }

                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                }

                field("Loan Officer"; Rec."Loan Officer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Manager';
                }

                field("Relationship Officer"; Rec."Relationship Officer")
                {
                    ApplicationArea = Basic;
                }

                field("Recommended by Type"; Rec."Recommended by Type")
                {
                    ApplicationArea = Basic;
                }

                field("Recommended By"; Rec."Recommended By")
                {
                    ApplicationArea = Basic;
                }

                field("Recommended By Name"; Rec."Recommended By Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }

            group("Loan Conditions")
            {
                Caption = 'Loan Conditions';

                field("Self Guarantee"; Rec."Self Guarantee")
                {
                    ApplicationArea = Basic;
                }

                field("Self Guaranteed"; Rec."Self Guaranteed")
                {
                    ApplicationArea = Basic;
                }

                field("Consolidated Loan"; Rec."Consolidated Loan")
                {
                    ApplicationArea = Basic;
                }

                field("Rescheduled Loan"; Rec."Rescheduled Loan")
                {
                    ApplicationArea = Basic;
                }

                field("Fee Waiver Applied"; Rec."Fee Waiver Applied")
                {
                    ApplicationArea = Basic;
                }

                field("Recovered from Savings"; Rec."Recovered from Savings")
                {
                    ApplicationArea = Basic;
                }

                field("Recovered from Guarantors"; Rec."Recovered from Guarantors")
                {
                    ApplicationArea = Basic;
                }

                field("Exempt Recovery"; Rec."Exempt Recovery")
                {
                    ApplicationArea = Basic;
                }

                field("Stop Interest Due"; Rec."Stop Interest Due")
                {
                    ApplicationArea = Basic;
                }

                field("Stop Penalty"; Rec."Stop Penalty")
                {
                    ApplicationArea = Basic;
                }

                field("Stop Insurance"; Rec."Stop Insurance")
                {
                    ApplicationArea = Basic;
                }
            }

            group("Sectorial Details")
            {
                Caption = 'Sectorial Details';

                field("Main Sector Code"; Rec."Main Sector Code")
                {
                    ApplicationArea = Basic;
                }

                field("Main Sector Description"; Rec."Main Sector Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Sub-Sector Level 1 Code"; Rec."Sub-Sector Level 1 Code")
                {
                    ApplicationArea = Basic;
                }

                field("Sub-Sector Level 1 Description"; Rec."Sub-Sector Level 1 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Sub-Sector Level 2 Code"; Rec."Sub-Sector Level 2 Code")
                {
                    ApplicationArea = Basic;
                }

                field("Sub-Sector Level 2 Description"; Rec."Sub-Sector Level 2 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }

            group("Comments")
            {
                Caption = 'Comments';

                field(AppraiserComments; AppraiserComments)
                {
                    ApplicationArea = Basic;
                    Caption = 'Appraiser Comments';
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Rec.SetAppraiserComment(AppraiserComments);
                    end;
                }

                field(CreditCommitteeComments; CreditCommitteeComments)
                {
                    ApplicationArea = Basic;
                    Caption = 'Credit Committee Comments';
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Rec.SetCreditCommitteeComment(CreditCommitteeComments);
                    end;
                }

                field(CEOComments; CEOComments)
                {
                    ApplicationArea = Basic;
                    Caption = 'CEO Comments';
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Rec.SetCEOComment(CEOComments);
                    end;
                }

                field(BoardComments; BoardComments)
                {
                    ApplicationArea = Basic;
                    Caption = 'Board Comments';
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Rec.SetBoardComment(BoardComments);
                    end;
                }
            }

            group("Balances")
            {
                Caption = 'Balances';
                Editable = false;

                field("Outstanding Principal"; Rec."Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }

                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }

                field("Outstanding Insurance"; Rec."Outstanding Insurance")
                {
                    ApplicationArea = Basic;
                }

                field("Outstanding Penalty"; Rec."Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }

                field("Total Outstanding Balance"; Rec."Total Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }

                field("Principal Paid"; Rec."Principal Paid")
                {
                    ApplicationArea = Basic;
                }

                field("Interest Paid"; Rec."Interest Paid")
                {
                    ApplicationArea = Basic;
                }

                field("Insurance Paid"; Rec."Insurance Paid")
                {
                    ApplicationArea = Basic;
                }

                field("Total Guaranteed"; Rec."Total Guaranteed")
                {
                    ApplicationArea = Basic;
                }

                field("Total Arrears"; Rec."Total Arrears")
                {
                    ApplicationArea = Basic;
                }

                field("Principal Arrears"; Rec."Principal Arrears")
                {
                    ApplicationArea = Basic;
                }

                field("Interest Arrears"; Rec."Interest Arrears")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Member Card")
            {
                ApplicationArea = Basic;
                Caption = 'Member Card';
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category10;
                RunObject = Page "Member Card";
                RunPageLink = "No." = field("Member No.");
            }

            action("Salary Details")
            {
                ApplicationArea = Basic;
                Caption = 'Salary Details';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Salary Details";
                RunPageLink = "Loan No" = field("Loan No.");
            }

            action("Bank Account List")
            {
                ApplicationArea = Basic;
                Caption = 'Bank Account List';
                Image = BankAccount;
                Promoted = true;
                PromotedCategory = Category8;
                RunObject = Page "HR Bank Accounts List";
                RunPageLink = "Loan No." = field("Loan No.");
            }

            action("Loan Security")
            {
                ApplicationArea = Basic;
                Caption = 'Loan Security';
                Image = SelectChart;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Loan Security";
                RunPageLink = "Loan No." = field("Loan No.");
            }

            action("Loan Charges_")
            {
                ApplicationArea = Basic;
                Caption = 'Loan Charges';
                Image = Costs;
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = Page "Loan Charges";
                RunPageLink = "Loan No." = field("Loan No."),
                              "Loan Product Type" = field("Loan Product Type");
            }

            action("Loan Top Up")
            {
                ApplicationArea = Basic;
                Caption = 'Loan Top Up';
                Image = SettleOpenTransactions;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "Loan Top Up";
                RunPageLink = "Loan No." = field("Loan No."),
                              "Member No." = field("Member No.");
            }

            action("Other Clearances")
            {
                ApplicationArea = Basic;
                Caption = 'Other Clearances';
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "Other Commitments Clearance";
                RunPageLink = "Loan Application No." = field("Loan No.");
            }

            action("Arrears Recovery")
            {
                ApplicationArea = Basic;
                Caption = 'Arrears Recovery';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "Arrears Recovery";
                RunPageLink = "Application No." = field("Loan No."),
                              "Member No." = field("Member No.");
            }

            action("Partial Disbursement Dates")
            {
                ApplicationArea = Basic;
                Caption = 'Partial Disbursement Dates';
                Image = PriceAdjustment;
                Promoted = true;
                PromotedCategory = Category8;
                RunObject = Page "Partial Disbursement Dates";
                RunPageLink = "Loan No." = field("Loan No.");
            }
        }

        area(reporting)
        {
            action("Loan Appraisal Report")
            {
                ApplicationArea = Basic;
                Caption = 'Loan Appraisal Report';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    LoanRec: Record Loans;
                begin
                    LoanRec.Reset();
                    LoanRec.SetRange("Loan No.", Rec."Loan No.");
                    //Report.RunModal(Report::"Loan Appraisal Report", true, false, LoanRec);
                end;
            }

            action("Loan Schedule Report")
            {
                ApplicationArea = Basic;
                Caption = 'Loan Schedule Report';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    LoanRec: Record Loans;
                begin
                    LoanRec.Reset();
                    LoanRec.SetRange("Loan No.", Rec."Loan No.");
                    //Report.RunModal(Report::"Loan Schedule Report", true, false, LoanRec);
                end;
            }

            action("Member Statement")
            {
                ApplicationArea = Basic;
                Caption = 'Member Statement';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    MemberRec: Record Members;
                begin
                    MemberRec.Reset();
                    MemberRec.SetRange("No.", Rec."Member No.");
                    //Report.RunModal(Report::"Member Statement", true, false, MemberRec);
                end;
            }
        }

        area(processing)
        {
            action("Post Loan")
            {
                ApplicationArea = Basic;
                Caption = 'Post Loan';
                Image = PostApplication;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                Visible = Rec.Status = Rec.Status::Approved;

                trigger OnAction()
                var
                    NetAmt: Decimal;
                    UserSetup: Record "User Setup";
                    SaccoActivities: Codeunit "Sacco Activities";
                begin
                    ValidateStaffLoanProduct();

                    UserSetup.Get(UserId);
                    if not UserSetup."Post Loan" then
                        Error('You have not been setup to disburse loans. [Post Loan]');

                    Rec.TestField(Posted, false);
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField("Disbursement Date");

                    if Confirm('Are you sure you want to post this staff loan?', false) then begin
                        SaccoActivities.PostLoan(Rec."Loan No.", Rec."Loan No.", false, NetAmt, Rec."Disbursement Date");
                        CurrPage.Close();
                    end;
                end;
            }

            action("Reopen Staff Loan")
            {
                ApplicationArea = Basic;
                Caption = 'Reopen Staff Loan';
                Image = ReOpen;
                Promoted = true;
                //PromotedCategory = Category2;

                trigger OnAction()
                begin
                    ValidateStaffLoanProduct();

                    if not Confirm('Do you want to reopen this staff loan?', false) then
                        exit;

                    Rec.Status := Rec.Status::Open;
                    Rec.Modify(true);
                end;
            }

            action("Validate Staff Loan Product")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Staff Loan Product';
                Image = Check;
                Promoted = true;
                //PromotedCategory = Category2;

                trigger OnAction()
                begin
                    ValidateStaffLoanProduct();
                    Message('Loan product %1 is valid for Staff Members.', Rec."Loan Product Type");
                end;
            }



            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category7;
                    Visible = SendBool;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        DocumentType: Enum "Custom Document Type";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        TopUp: Record "Loan Top Up";
                        Lns: Record Loans;
                    begin

                        //CheckControls;

                        //SendNotifications;


                        //UpdateSmsCharge;
                        Rec.CalcFields("Top Up Amount", "External Clearance", "Loan Charges", "TopUp Commission");

                        //check if topup amount and the outstanding Balance are similar
                        TopUp.Reset;
                        TopUp.SetRange("Loan No.", Rec."Loan No.");
                        TopUp.SetRange("Member No.", Rec."Member No.");
                        if TopUp.FindFirst then begin
                            if Lns.Get(TopUp."Loan Top Up") then begin
                                Lns.CalcFields("Total Outstanding Balance");
                                if Lns."Outstanding Principal" + TopUp."Interest Top Up" > TopUp."Total Top Up" then
                                    error('Top Up amount is less than the Loan outstanding Balance, please update before proceeding');
                            end;
                        end;


                        //Rec."Net To Be Disbursed" := Rec."Amount To Disburse" - Rec."Top Up Amount" - Rec."Loan Charges" - Rec."External Clearance" - Rec."Deposit Boosting Commission" - Rec."Share Capital Boosting";
                        //Rec.Modify();
                        Commit();

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."Loan No.", Rec."Requested Amount", Documenttype::"Loan Application", Rec."Global Dimension 1 Code", Rec."Booking Branch", Rec.Source);
                        CurrPage.Close();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category7;
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
                        CurrPage.Close();
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."Loan No.");
                        ApprovalTracker.SetRange("Custom Document Type", DocumentType::"Loan Application");
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(RecRef.RecordId);
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    Visible = Rec.Status = Rec.Status::Pending;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        Rec.TestField(status, Rec.Status::Pending);
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                        CurrPage.Close();
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;
                    Visible = Rec.Status = Rec.Status::Approved;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        if (Rec.Status <> Rec.Status::Open) and (Rec.Status <> Rec.Status::Pending) then begin

                            if not Confirm('Are you sure you want to re-open document?') then exit;

                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;

                            CurrPage.Close();

                        end;
                    end;
                }
                action("Finance Approval")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category7;
                    Visible = Rec.Status = Rec.Status::Approved;

                    trigger OnAction()
                    var
                        UserSetup: record "User Setup";
                    begin

                        UserSetup.Get(UserId);
                        if not UserSetup."Finance Approval" then
                            Error('You have not been setup to approve finance disbursement loans.[Finance Approval]');

                        Rec.TestField(Status, Rec.Status::Approved);

                        if not Confirm('Are you sure you want to send this loan to HOD finance?') then exit;

                        Rec."Disbursement Stage" := Rec."Disbursement Stage"::Finance;
                        Rec.Modify;

                        Message('Loan successfully sent');
                        Sleep(2000);
                        CurrPage.Close();

                    end;
                }
                action("Disbursement Approval")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category7;
                    Visible = Rec."Disbursement Stage" = Rec."Disbursement Stage"::Finance;

                    trigger OnAction()
                    var
                        UserSetup: Record "User Setup";
                    begin
                        UserSetup.Get(UserId);
                        if not UserSetup."Disbursement Approval" then
                            Error('You have not been setup to [Disbursement Approval] or send disbursement');

                        Rec.TestField(Status, Rec.Status::Approved);
                        Rec.TestField(Posted, false);
                        Rec.TestField("Disbursement Stage", Rec."Disbursement Stage"::Finance);

                        // Prevent duplicate send if already sent to Disbursement
                        if Rec."Disbursement Stage" = Rec."Disbursement Stage"::Disbursement then
                            Error('Loan is already sent for disbursement.');

                        if not Confirm('Are you sure you want to send this loan for disbursement?') then
                            exit;

                        Rec."Disbursement Stage" := Rec."Disbursement Stage"::Disbursement;
                        // optional: record requester/date if fields exist
                        // Rec.Validate("Disbursement Requested By", UserId);
                        // Rec.Validate("Disbursement Requested Date", Today);
                        Rec.Modify();

                        Sleep(2000);
                        Message('Loan successfully sent');
                        CurrPage.Close();
                    end;
                }

            }

        }
    }

    trigger OnOpenPage()
    begin
        ApplyStaffLoanProductFilter();
        UpdateFields()
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateFields();
        GetComments();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        ValidateStaffLoanProduct();
        UpdateFields();
        exit(true);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        ValidateStaffLoanProduct();
        UpdateFields();
        exit(true);
    end;

    var
        AppraiserComments: Text;
        CreditCommitteeComments: Text;
        CEOComments: Text;
        BoardComments: Text;
        SendBool: Boolean;
        CancelBool: Boolean;
        BoardCommentsEditable: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ApplicationDetailsEdit: Boolean;
        VarVariant: Variant;
        ApprovedEdit: Boolean;

    local procedure ApplyStaffLoanProductFilter()
    var
        StaffLoanProductFilter: Text;
    begin
        StaffLoanProductFilter := GetStaffLoanProductFilter();

        if StaffLoanProductFilter = '' then
            Error('No active credit loan product is marked as Staff Members in Product Setup.');

        Rec.SetFilter("Loan Product Type", StaffLoanProductFilter);
    end;

    local procedure GetStaffLoanProductFilter(): Text
    var
        ProductSetup: Record "Product Setup";
        ProductFilter: Text;
    begin
        ProductSetup.Reset();
        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Credit);
        ProductSetup.SetRange(Status, ProductSetup.Status::Active);
        ProductSetup.SetRange("Loan Clients", ProductSetup."Loan Clients"::"Staff Members");

        if ProductSetup.FindSet() then
            repeat
                if ProductFilter = '' then
                    ProductFilter := ProductSetup."Product ID"
                else
                    ProductFilter += '|' + ProductSetup."Product ID";
            until ProductSetup.Next() = 0;

        exit(ProductFilter);
    end;

    local procedure ValidateStaffLoanProduct()
    var
        ProductSetup: Record "Product Setup";
    begin
        if Rec."Loan Product Type" = '' then
            exit;

        ProductSetup.Get(Rec."Loan Product Type");

        if ProductSetup."Product Class" <> ProductSetup."Product Class"::Credit then
            Error('Product %1 is not a credit product.', ProductSetup."Product ID");

        if ProductSetup.Status <> ProductSetup.Status::Active then
            Error('Product %1 is not active.', ProductSetup."Product ID");

        if ProductSetup."Loan Clients" <> ProductSetup."Loan Clients"::"Staff Members" then
            Error(
                'Loan product %1 - %2 is not a staff loan product. Select a product where Loan Clients is Staff Members.',
                ProductSetup."Product ID",
                ProductSetup.Description);
    end;

    local procedure UpdateFields()
    var
        SaccoSetup: Record "Sacco Setup";
        BoardCommentAmountThreshold: Decimal;
        LoanAmountForBoardComment: Decimal;
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
        if (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Rejected) or (Rec.Status = Rec.Status::"Pending Committee") then
            CurrPage.Editable := false
        else
            ApprovedEdit := false;

        SaccoSetup.Get;
        BoardCommentAmountThreshold := SaccoSetup."Minimum Board Loan Comment Amt";
        if BoardCommentAmountThreshold > 0 then begin
            LoanAmountForBoardComment := Rec."Approved Amount";
            if LoanAmountForBoardComment = 0 then
                LoanAmountForBoardComment := Rec."Requested Amount";

            BoardCommentsEditable := LoanAmountForBoardComment > BoardCommentAmountThreshold;
        end;

        CEOComments := Rec.GetCEOComment();
        AppraiserComments := Rec.GetAppraiserComment();
        CreditCommitteeComments := Rec.GetCreditCommitteeComment();
        BoardComments := Rec.GetBoardComment();

        Rec.HasSubType();

        SetPageEditability();
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
        // Rec.TestField("Disbursement Account No");
        CompanyInfo.get;

        /*IF NOT Rec."SMS Sent" THEN BEGIN
            Msg := 'Dear ' + Member.Name + ', We have received your ' + ProductSetup.Description + ' of KES ' + FORMAT(Rec."Requested Amount") + '. If Approved it will be disbursed into your Account. Incase of inquiries call ' + CompanyInfo."Phone No.";
            MemberActivities.SendSms(SMSSource::"Loan Application", Member."Mobile Phone No.", Msg, Rec."Loan No.", Rec."Disbursement Account No", true, FALSE);

            Rec.Validate("SMS Sent", true);
        END;*/
    end;

    local procedure CheckControls()
    var
        ScheduleofProperties: Record "Schedule of Properties";
        TopUp: Record "Loan Top Up";
        Loans: Record Loans;
        Legacy: Codeunit Legacy;
        Witness: Record "Loan Witness";
        SDetails: Record "Appraisal Salary Details";
        LoanGuarantors: Record "Loan Security";
        Member: Record Members;
        UserSetup: Record "User Setup";
        Appraisal: Record "Member Salary Appraisal";
        ProductSetup: Record "Product Setup";
    begin

        Member.Get(Rec."Member No.");
        Rec.TestField("Main Sector Code");
        Rec.TestField("Sub-Sector Level 1 Code");
        Rec.TestField("Sub-Sector Level 2 Code");
        // Rec.TestField("Mode of Disbursement");

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

        UserSetup.Get(UserId);
        if not UserSetup."Post Loan" then
            Error('You have not been setup to disbursement loans.[Post Loan]');

        //if Rec."Amount To Disburse" > Rec."Recommended Amount" then
        //    Error(StrSubstNo('You cannot disburse more than system recommended amount %1', Rec."Recommended Amount"));

        // Appraisal.Reset;
        // Appraisal.SetRange("Appraisal No.", Rec."Salary Appraisal No.");
        // Appraisal.SetFilter("Appraisal Type", '<>%1', Appraisal."Appraisal Type"::Business);
        // if Appraisal.FindFirst then begin
        //     SDetails.Reset();
        //     SDetails.SetRange("Loan No", Rec."Loan No.");
        //     if SDetails.IsEmpty() then
        //         if Rec.Source <> Rec.Source::MICRO then
        //             Error('Capture Loan Salary Details for this loan');
        // end;



        Rec.CalcFields("Total Guaranteed");

        ProductSetup.Get(Rec."Loan Product Type");
        Rec."Require Committee Approval" := false;

        if ProductSetup."Committee Approval Limit" > 0 then
            if Rec."Approved Amount" >= ProductSetup."Committee Approval Limit" then begin
                Rec."Require Committee Approval" := true;
            end;

        //if Member."Member Category" = Member."Member Category"::"Staff Members" then
        //    "Require Committee Approval" := true;

        Rec.Modify();
        commit;
        if ProductSetup."Appraise Security" then
            if (Rec."Total Guaranteed" < Rec."Amount To Disburse") and (Rec."Type of Disbursement" = Rec."Type of Disbursement"::"Full Disbursement") then
                Error('Loan Not Fully Guaranteed');


        TopUp.Reset();
        TopUp.SetRange("Loan No.", Rec."Loan No.");
        TopUp.Setfilter("Principle Top Up", '>0');
        if TopUp.FindFirst() then begin
            repeat
                Loans.get(TopUp."Loan Top Up");
                Loans.CalcFields("Total Outstanding Balance");
                if (TopUp."Interest Top Up" + TopUp."Appraisal Top Up" + TopUp."Penalty Top Up" + TopUp."Principle Top Up") > Loans."Total Outstanding Balance" then
                    Error('Top Up Amounts needs to be re-calculated. Current Balance has changed');
            until TopUp.next = 0;
        end;

        //if "Salary Appraisal No." = '' then
        //  Error('Loan Not Appraised');
    end;

    local procedure UpdateSmsCharge()
    var
        LoanChrgs: Record "Loan Charges";
        LoanGuarantors: Record "Loan Security";
        GuarantorsCount: Integer;
    begin
        LoanChrgs.Reset();
        LoanChrgs.SetRange("Loan No.", Rec."Loan No.");
        LoanChrgs.SetRange("Loan Product Type", Rec."Loan Product Type");
        LoanChrgs.SetRange("Is Sms Charge", true);
        if LoanChrgs.FindFirst() then begin

            LoanGuarantors.Reset();
            LoanGuarantors.SetRange("Self Guarantee", false);
            LoanGuarantors.SetRange("Loan No.", Rec."Loan No.");
            if LoanGuarantors.FindFirst() then
                GuarantorsCount := LoanGuarantors.Count();

            LoanChrgs.Amount += (GuarantorsCount + 2) * LoanChrgs.Amount;
            LoanChrgs."Excise Duty" += (GuarantorsCount + 2) * LoanChrgs.Amount;
            LoanChrgs.Modify();

        end;
    end;

    local procedure SetPageEditability()
    var
        LoanAppraisal: Record "Member Salary Appraisal";
        AppraisalNo: Code[20];
        Loan: Record Loans;
    begin
        AppraisalNo := Rec."Loan No.";
        if AppraisalNo = '' then
            AppraisalNo := Rec."Loan No.";

        if (AppraisalNo <> '') and LoanAppraisal.Get(AppraisalNo) then
            CurrPage.Editable := LoanAppraisal.Status <> LoanAppraisal.Status::Approved
        else
            CurrPage.Editable := true;

        if Loan.Get(Rec."Loan No.") and (Rec."Loan No." <> '') then begin
            if (Loan.Posted) or (Loan.Status = Loan.Status::Approved) then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;
        end;
    end;

    local procedure GetComments()
    begin
        AppraiserComments := Rec.GetAppraiserComment();
        CreditCommitteeComments := Rec.GetCreditCommitteeComment();
        CEOComments := Rec.GetCEOComment();
        BoardComments := Rec.GetBoardComment();
    end;
}