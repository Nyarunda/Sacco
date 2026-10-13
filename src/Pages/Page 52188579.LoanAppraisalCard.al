page 50242 "Loan Appraisal Card"
{
    Caption = 'Loan Appraisal Card';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Salary Appraisal";
    PromotedActionCategories = 'New,Process,Report,Send Loan For Loan Disbursement,Send For Approval,Loan Top Up,Other Clearances,Loan Security,Loan Charges,Member Card';
    ApplicationArea = All, Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Information';
                field("Appraisal No."; Rec."Appraisal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appraisal No. field.';
                }
                field("Portal Loan Code"; Rec."Portal Loan Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appraisal No. field.';
                }

                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the loan application date.';
                }
                field("Loan Appraisal Date"; Rec."Loan Appraisal Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the loan was appraised. This date appears on the appraisal back page and appraiser signature.';
                }
            }
            group("Member Information")
            {
                Caption = 'PART A - Member Information';

                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                    LookupPageId = "Member Listing";

                    trigger OnValidate()
                    var
                        Members: Record Members;
                    begin
                        if Members.get(Rec."Member No.") then
                            if Members."Date of Birth" <> 0D then
                                MemberAge := Date2DMY(Today, 3) - Date2DMY(Members."Date of Birth", 3);
                    end;
                }
                field("Member Name"; Rec.Name)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Age; Rec.GetMemberAge())
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Member Type"; Rec."Member Type")
                {
                    ApplicationArea = All;
                    visible = false;
                }

                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("P.O. Box"; Rec."P.O. Box")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Editable = false;
                }
                field("Alternate Mobile No."; Rec."Alternate Mobile No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Place of Work"; Rec."Place of Work")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Business Description"; Rec."Business Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Caption = 'Occupation/Business Description';
                }
                field("Net Income Per Month"; Rec."Net Income Per Month")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Monthly Expenditure"; Rec."Monthly Expenditure")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Captured By field.';

                }
                field("Account Manager"; Rec."Loan Officer")
                {
                    ApplicationArea = All;
                    Caption = 'Account Manager';
                }
                field("Appraiser ID"; Rec."Appraiser ID")
                {
                    ApplicationArea = All;
                    Editable = (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Pending);
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }

            group("Loan Information")
            {
                Caption = 'PART B - Loan Details';


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
                field("Self Guarantee"; Rec."Self Guarantee")
                {
                    ApplicationArea = Basic;
                }
                field("Total Arrears"; Rec."Total Arrears")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the ttoal arrears field.';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Staff No. field.';
                }

                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Product Type field.';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SubTypeVisible := Rec.HasSubType;
                    end;
                }
                group("Product Sub Type")
                {
                    Visible = SubTypeVisible;
                    field(ProductSubType; Rec."Product Sub Type")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = All;
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the product description field';
                }
                field("Repay Mode"; Rec."Repay Mode")
                {
                    ApplicationArea = all;
                }

                field("Annual Interest %"; Rec."Annual Interest %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Annual Interest % field.';
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested Amount field.';
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period field.';
                }

                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin

                        if Rec."Appraisal Type" = Rec."Appraisal Type"::Business then begin
                            BusinessAppraisal := true;
                            SalaryDetails := false;
                        end
                        else begin
                            BusinessAppraisal := false;
                            SalaryDetails := true;
                        end;

                    end;
                }
                field("Loan Purpose"; Rec."Loan Purpose")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Purpose field.';
                }
                field("Loan Moratorium Start Date"; Rec."Loan Moratorium Start Date")
                {
                    ApplicationArea = All;
                }
                field("Loan Moratorium End Date"; Rec."Loan Moratorium End Date")
                {
                    ApplicationArea = All;
                }
                field(RepaymentStartDate; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(ScheduleStartDate; Rec."Schedule Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                }

                field("Appraisal Completed"; Rec."Appraisal Completed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appraisal Completed field.';
                }


            }
            group(Qualifications)
            {
                Caption = 'PART C - Loan Qualification Details';
                field(Qualification; Rec.Qualification)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qualification as Per Income"; Rec."Qualification as Per Income")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Qualification field.';
                }

                field("Share Deposits"; Rec."Share Deposits")
                {
                    ApplicationArea = All;
                }
                field(Multiplier; Rec.Multiplier)
                {
                    ApplicationArea = All;
                }
                field("Deposit Multiplier"; Rec."Deposit Multiplier")
                {
                    ApplicationArea = All;
                }
                field("Qualification As Per Deposits"; Rec."Qualification As Per Deposits")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Qualification as Per Guarantor"; Rec."Qualification as Per Guarantor")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("BOSA Loan balance"; Rec."BOSA Loan balance")
                {
                    ApplicationArea = All;
                }

                field("Maximum Credit"; Rec."Maximum Credit")
                {
                    ApplicationArea = All;
                }

                field("Recommended Amount"; Rec."Recommended Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Recommended Amount field.';
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        UpdateFields();
                    end;
                }


                field("External Clearance"; Rec."External Clearance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Clearance field.';
                }

                field("Deposit Boosted"; Rec."Deposit Boosted")
                {
                    ApplicationArea = All;
                    //Editable = false;
                    ToolTip = 'Specifies the value of the External Clearance field.';
                }
                field("Deposit Boosting"; Rec."Deposit Boosting")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the External Clearance field.';
                }
                field("Share Capital Boosting"; Rec."Share Capital Boosting")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Clearance field.';
                }
                field("Required Share Capital"; Rec."Required Share Capital")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Current Share Capital"; Rec."Current Share Capital")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("External Clearance Charges"; Rec."External Clearance Charges")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Clearance Charges field.';
                }
                field("Top Up Loan"; Rec."Top Up Loan")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Top Up Loan field.';
                }
                field("Top Up Commission"; Rec."Top Up Commission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Top Up Commission field.';
                }
                field("Commission Excise"; Rec."Commission Excise")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Top Up Commission field.';
                }
                field("Upfront Interest"; Rec."Upfront Interest")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Upfront Interest field.';
                }
                field(Insurance; Rec.Insurance)
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insurance field.';
                }
                field("Total Charges"; Rec."Total Charges")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Charges field.';
                }
                field("BOSA Savings"; Rec."BOSA Savings")
                {
                    ApplicationArea = All;

                    Caption = 'Monthly Deposit Contributions';
                    ToolTip = 'Specifies the value of the BOSA Savings field.';
                }
                field("Monthly Repayment"; Rec."Monthly Repayment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Monthly Repayment field.';
                }
                field("Principal Repayment"; Rec."Principal Repayment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Principal Repayment field.';
                }
                field("Interest Repayment"; Rec."Interest Repayment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Repayment field.';
                }
                field("Max. Monthly Deduction"; Rec."Max. Monthly Deduction")
                {
                    ApplicationArea = All;
                    Caption = 'Total Monthly Repayment';
                    ToolTip = 'Specifies the value of the Max. Monthly Deduction field.';
                }
                field("Total Loan to Pay"; Rec."Total Loan to Pay")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Loan to be paid.';
                }
                field("Net Loan Take Home"; Rec."Net Loan Take Home")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }

            group("Appraisal Details")
            {
                Caption = 'PART D - Appraisal Details';

                field("Appraiser Comments"; AppraiserComments)
                {
                    ApplicationArea = Basic, Suite, All;
                    MultiLine = true;


                    trigger OnValidate()
                    begin
                        Rec.SetAppraiserComment(AppraiserComments);
                    end;
                }
                field("Credit Committee Comments"; CreditCommitteeComments)
                {
                    Caption = 'Credit Manager Comments';
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;


                    trigger OnValidate()
                    begin
                        Rec.SetCreditCommitteeComment(CreditCommitteeComments);
                    end;
                }

                field("CEO Comments"; CEOComments)
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;


                    trigger OnValidate()
                    begin
                        Rec.SetCEOComment(CEOComments);
                    end;
                }
                field("Board Comments"; BoardComments)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = BoardCommentsEditable;
                    MultiLine = true;


                    trigger OnValidate()
                    begin
                        Rec.SetBoardComment(BoardComments);
                    end;
                }
                field("Loan Rejection Reason"; Rec."Loan Rejection Reason")
                {
                    MultiLine = true;
                    ApplicationArea = Basic, Suite;
                    Editable = Rec.Status = Rec.Status::Rejected;
                }
            }
            group(Sectorial)
            {
                Caption = 'PART E - Loan Sectors';


                field("Main Sector Code"; Rec."Main Sector Code")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Main Sector Description"; Rec."Main Sector Description")
                {

                    ApplicationArea = All;
                }
                field("Sub-Sector Level 1 Code"; Rec."Sub-Sector Level 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Sub-Sector Level 1 Description"; Rec."Sub-Sector Level 1 Description")
                {
                    ApplicationArea = All;

                }

                field("Sub-Sector Level 2 Code"; Rec."Sub-Sector Level 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Sub-Sector Level 2 Description"; Rec."Sub-Sector Level 2 Description")
                {
                    ApplicationArea = All;
                }

            }

            group("Disbursement Details")
            {
                Caption = 'PART F - Loan Disbursement Details';
                field(AmountToDisburse; Rec."Amount To Disburse")
                {
                    ApplicationArea = Basic;

                }
                field("Type of Disbursement"; Rec."Type of Disbursement")
                {
                    ApplicationArea = Basic;
                }


            }
            group(Disbursement)
            {
                part(Accounts; "HR Bank Accounts List")
                {
                    Caption = 'Disbursement Details';
                    ApplicationArea = Basic;
                    SubPageLink = "Loan No." = field("Appraisal No.");
                    UpdatePropagation = Both;
                }
            }
            group(Declarations)
            {
                Caption = 'Applicant Declarations';

                field("Declaration 1"; Rec."Declaration 1")
                {
                    ApplicationArea = All;
                    Caption = '1. Statements are correct and true';
                    ShowMandatory = true;
                }
                field("Declaration 2"; Rec."Declaration 2")
                {
                    ApplicationArea = All;
                    Caption = '2. Understand offence of false information';
                    ShowMandatory = true;
                }
                field("Declaration 3"; Rec."Declaration 3")
                {
                    ApplicationArea = All;
                    Caption = '3. Authorize deduction in case of default';
                    ShowMandatory = true;
                }
                field("Declaration 4"; Rec."Declaration 4")
                {
                    ApplicationArea = All;
                    Caption = '4. Agree to abide by Sacco bylaws';
                    ShowMandatory = true;
                }
                field("Declaration 5"; Rec."Declaration 5")
                {
                    ApplicationArea = All;
                    Caption = '5. Authorize credit checks';
                    ShowMandatory = true;
                }
                field("Declaration 6"; Rec."Declaration 6")
                {
                    ApplicationArea = All;
                    Caption = '6. Pledge to notify address changes';
                    ShowMandatory = true;
                }
                field("Indemnity Accepted"; Rec."Indemnity Accepted")
                {
                    ApplicationArea = All;
                    Caption = 'Indemnity Clause Accepted';
                    ShowMandatory = true;
                }
                field("Applicant Signature Date"; Rec."Applicant Signature Date")
                {
                    ApplicationArea = All;
                }
            }

        }
        area(factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Member Salary Appraisal"),
                              "No." = field("Appraisal No.");

            }

        }

    }

    actions
    {
        area(navigation)
        {
            action("Arrears Recovery")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = category7;
                PromotedIsBig = true;
                RunObject = Page "Arrears Recovery";
                RunPageLink = "Application No." = field("Appraisal No."), "Member No." = field("Member No.");
            }
            action("Send To Loan Registration")
            {
                ApplicationArea = All;
                Image = SendTo;
                Promoted = true;
                Caption = 'Send Loan For Disbursement';
                PromotedCategory = category4;
                Visible = Rec.Status = Rec.Status::Approved;

                trigger OnAction()
                var
                    Appraisal: Record "Member Salary Appraisal";
                    NewTopUp: Record "Loan Top Up";
                    NewClearance: Record "Other Committments Clearance";
                    TopUp: Record "Appraisal Top Up";
                    Clearance: Record "Other Committments Clearance";
                    Loan: Record Loans;
                    NewLoan: Record Loans;
                    LoanType: Record "Product Setup";
                begin
                    SendToLoanAppraisal();
                end;

            }
            action("Re-Open")
            {
                ApplicationArea = All;
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category5;


                trigger OnAction()
                var
                    Appraisal: Record "Member Salary Appraisal";
                    NewTopUp: Record "Loan Top Up";
                    NewClearance: Record "Other Committments Clearance";
                    TopUp: Record "Appraisal Top Up";
                    Clearance: Record "Other Committments Clearance";
                    Loan: Record Loans;
                    NewLoan: Record Loans;
                begin

                    Loan.Reset();
                    Loan.SetRange("Salary Appraisal No.", Rec."Appraisal No.");
                    if Loan.FindFirst() then begin
                        if loan.Status <> loan.Status::Open then
                            Error('The appraisal number already exists under loan %1, kindly Reopen the loan before proceeding.', Loan."Loan No.");
                    end;


                    if Confirm('Are you sure you want to reopen this appraisal??', false) then begin
                        Rec."Appraisal Completed" := false;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                        Message('Re-Opened');

                        CurrPage.close();
                    end;
                end;

            }
            action("Loan Top Up")
            {

                ApplicationArea = All;
                Image = SettleOpenTransactions;
                Promoted = true;
                PromotedCategory = category6;
                RunObject = Page "Appraisal Loan Top Up";
                RunPageLink = "Loan No." = field("Appraisal No."), "Member No." = field("Member No.");
            }

            action("Other Clearances")
            {
                ApplicationArea = All;
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = category7;
                RunObject = Page "Other Commitments Clearance";
                RunPageLink = "Loan Application No." = field("Appraisal No.");
            }
            action("Loan Security")
            {

                ApplicationArea = All;
                Image = SettleOpenTransactions;
                Promoted = true;
                PromotedCategory = Category8;
                RunObject = Page "Loan Security";
                RunPageLink = "Loan No." = field("Appraisal No.");
            }
            action("Bank Account List")
            {

                ApplicationArea = All;
                Image = SetPriorities;
                Promoted = true;
                PromotedCategory = Category8;
                RunObject = Page "HR Bank Accounts List";
                RunPageLink = "Loan No." = field("Appraisal No.");

            }
            action("Loan Witness")
            {
                ApplicationArea = All;
                Image = SetPriorities;
                Promoted = true;
                Visible = false;
                PromotedCategory = Category8;
                RunObject = Page "Loan Witness";
                RunPageLink = "Loan No." = field("Appraisal No.");
            }

            action("Loan Charges")
            {

                ApplicationArea = All;
                Image = Costs;
                Promoted = true;
                PromotedCategory = category9;
                RunObject = Page "Loan Charges";
                RunPageLink = "Loan No." = field("Appraisal No."),
                              "Loan Product Type" = field("Loan Product Type");
            }
            action("Member Card")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = true;
                RunObject = Page "Member Card";
                RunPageLink = "No." = field("Member No.");
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
                    PromotedCategory = Category5;
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
                        TopUp: Record "Loan Top Up";
                        Lns: Record Loans;
                        VarVariant: Variant;
                    begin

                        CheckControls;

                        //check if topup amount and the outstanding Balance are similar
                        TopUp.Reset;
                        TopUp.SetRange("Loan No.", Rec."Appraisal No.");
                        TopUp.SetRange("Member No.", Rec."Member No.");
                        if TopUp.FindFirst then begin
                            if Lns.Get(TopUp."Loan Top Up") then begin
                                Lns.CalcFields("Total Outstanding Balance");
                                if Lns."Outstanding Principal" + TopUp."Interest Top Up" > TopUp."Total Top Up" then
                                    error('Top Up amount is less than the Loan outstanding Balance, please update before proceeding');
                            end;
                        end;

                        Commit();

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."Appraisal No.", Rec."Requested Amount", Documenttype::"Loan Appraisal", Rec."Global Dimension 1 Code", Rec."Booking Branch", Rec.Source);
                        CurrPage.Close();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = CancelBool;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."Appraisal No.");
                        CurrPage.Close();
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;

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
                        ApprovalTracker.SetRange("Document No.", Rec."Appraisal No.");
                        ApprovalTracker.SetRange("Custom Document Type", DocumentType::"Loan Appraisal");
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(RecRef.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = DelegateVisible;

                    trigger OnAction()
                    var
                        UserSetup: Record "User Setup";
                        SelectedUserID: Code[50];
                        CurrentAppraiserID: Code[50];
                    begin
                        if Rec."Appraiser ID" = '' then
                            Error('No appraiser is currently assigned to this appraisal.');

                        CurrentAppraiserID := Rec."Appraiser ID";

                        if not Confirm(StrSubstNo('Current appraiser is %1. Do you want to delegate to another user?', CurrentAppraiserID)) then
                            exit;

                        UserSetup.Get(CurrentAppraiserID);
                        if Page.RunModal(Page::"User Setup", UserSetup) = Action::LookupOK then begin
                            SelectedUserID := UserSetup."User ID";
                            if SelectedUserID = CurrentAppraiserID then begin
                                Message('Selected user is already the current appraiser.');
                                exit;
                            end;

                            Rec.Validate("Appraiser ID", SelectedUserID);
                            Rec.Modify(true);
                            Message('Appraisal delegated from %1 to %2.', CurrentAppraiserID, SelectedUserID);
                        end;
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category5;
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
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        if (Rec.Status <> Rec.Status::Open) and (Rec.Status <> Rec.Status::Rejected) then begin

                            if not Confirm('Are you sure you want to re-open document?') then exit;

                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;

                            CurrPage.Close();

                        end;
                    end;
                }
            }

        }
        area(reporting)
        {

            action(appraisalReport)
            {
                ApplicationArea = All;
                Image = Report;
                Caption = 'Appraisal Report';

                trigger OnAction()
                var
                    MemberLoanAppraisal: Record "Member Salary Appraisal";
                    ReportId: Integer;
                begin
                    Rec.GetValues();
                    Commit();

                    if Rec."Approved Amount" > 20000000 then
                        ReportId := Report::"Appraisal Report - Board"
                    else
                        ReportId := Report::"Appraisal Report";

                    MemberLoanAppraisal.Reset();
                    MemberLoanAppraisal.SetRange("Appraisal No.", Rec."Appraisal No.");
                    if MemberLoanAppraisal.FindFirst() then
                        Report.Run(ReportId, true, false, MemberLoanAppraisal);
                end;
            }
            action(AppraisalBack)
            {
                ApplicationArea = All;
                Image = Report;
                Caption = 'Appraisal Back Report';
                trigger OnAction()
                var
                    MemberLoanAppraisal: Record "Member Salary Appraisal";
                begin
                    Rec.GetValues();
                    Commit();

                    MemberLoanAppraisal.Reset();
                    MemberLoanAppraisal.SetRange("Appraisal No.", Rec."Appraisal No.");
                    if MemberLoanAppraisal.FindFirst() then
                        Report.Run(Report::"Appraisal Back Form", true, false, MemberLoanAppraisal);
                end;
            }
            action("Loan Appraisal Report")
            {
                ApplicationArea = All;
                Image = AnalysisView;
                trigger OnAction()
                var
                    MemberLoanAppraisal: Record "Member Salary Appraisal";
                    Topup: Record "Appraisal Top Up";
                    LoanCharges: Record "Loan Charges";
                    SelectedCharge: integer;
                begin

                    Rec.GetValues();
                    Commit();
                    MemberLoanAppraisal.Reset;
                    MemberLoanAppraisal.SetRange("Appraisal No.", Rec."Appraisal No.");
                    if MemberLoanAppraisal.FindFirst then
                        Report.Run(Report::"Loan Salary Appraisal", true, false, MemberLoanAppraisal);
                end;
            }
            action("Loan Schedule Report")
            {
                ApplicationArea = All;
                Image = Link;

                trigger OnAction()
                var
                    SaccoActivities: Codeunit "Sacco Activities";
                    Appraisal: Record "Member Salary Appraisal";
                begin

                    SaccoActivities.GenerateAppraisalRepaymentSchedule(Rec);
                    Commit;

                    Appraisal.Reset;
                    Appraisal.SetRange("Appraisal No.", Rec."Appraisal No.");
                    if Appraisal.FindFirst then
                        Report.Run(Report::"Appraisal Repayment Schedule", true, false, Appraisal);
                end;
            }

        }

    }
    trigger OnAfterGetRecord()
    begin
        UpdateFields;
        CEOComments := Rec.GetCEOComment();
        AppraiserComments := Rec.GetAppraiserComment();
        CreditCommitteeComments := Rec.GetCreditCommitteeComment();
        BoardComments := Rec.GetBoardComment();
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        UpdateFields;
        if Rec."Appraisal Type" = Rec."Appraisal Type"::Business then begin
            BusinessAppraisal := true;
            SalaryDetails := false;
        end
        else begin
            BusinessAppraisal := false;
            SalaryDetails := true;
        end;

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        UpdateFields;
        if Rec."Appraisal Type" = Rec."Appraisal Type"::Business then begin
            BusinessAppraisal := true;
            SalaryDetails := false;
        end
        else begin
            BusinessAppraisal := false;
            SalaryDetails := true;
        end;


    end;

    local procedure CheckControls()
    var
        ScheduleofProperties: Record "Schedule of Properties";
        TopUp: Record "Appraisal Top Up";
        Loans: Record Loans;
        Legacy: Codeunit Legacy;
        Witness: Record "Loan Witness";
        SDetails: Record "Appraisal Salary Details";
        LoanGuarantors: Record "Loan Security";
        Member: Record Members;
        Appraisal: Record "Member Salary Appraisal";
        ProductSetup: Record "Product Setup";
        TotalGuaranteedErr: Label 'You cannot send this loan for approval because the amount to disburse (%1) must be equal to the total amount guaranteed (%2).';
        TotalGuaranteed: Decimal;
        LoanApp: Record Loans;
        Loan: Record Loans;
    begin

        Member.Get(Rec."Member No.");
        Rec.TestField("Main Sector Code");
        Rec.TestField("Sub-Sector Level 1 Code");
        Rec.TestField("Sub-Sector Level 2 Code");
        Rec.TestField("Amount To Disburse");
        Rec.CalcFields("Total Guaranteed");

        ProductSetup.Get(Rec."Loan Product Type");
        Rec.checkRequestAmountAgainstDepositMuitplier();


        //if Member."Member Category" = Member."Member Category"::"Staff Members" then
        //    "Require Committee Approval" := true;
        if ProductSetup."Appraise Deposits" then
            if Rec."Amount To Disburse" > Rec."Total Guaranteed" then
                Error(
                    'Amount to disburse %1 cannot be greater than total amount guaranteed %2.',
                    Rec."Amount To Disburse",
                    Rec."Total Guaranteed"
                );

        if Rec."Loan Product Type" <> 'L07' then
            if Rec."Amount To Disburse" <> Rec."Total Guaranteed" then
                Error(
                    TotalGuaranteedErr,
                    Rec."Amount To Disburse",
                    Rec."Total Guaranteed"
                );

        Loan.Reset();
        Loan.SetRange("Salary Appraisal No.", Rec."Appraisal No.");
        if Loan.FindFirst() then begin
            if loan.Status <> loan.Status::Open then
                Error('The appraisal number already exists under loan %1, kindly check it before proceeding.', Loan."Loan No.");
        end;

        // //confirm if loan exist of same type
        LoanApp.Reset;
        LoanApp.SetRange("Member No.", Rec."Member No.");
        LoanApp.SetRange(Posted, true);
        LoanApp.SetRange("Loan Product Type", Rec."Loan Product Type");
        LoanApp.SetFilter("Outstanding Principal", '>0');
        if LoanApp.Find('-') then begin
            repeat
                if ProductSetup."Allow Multiple Running Loans" = false then begin
                    //check if loan has been topped up
                    TopUp.Reset();
                    TopUp.SetRange("Loan Top Up", LoanApp."Loan No.");
                    TopUp.SetFilter("Total Top Up", '>0');
                    if not TopUp.FindFirst() then
                        Error('Member already has an existing Loan %1 of same product which needs bridging', LoanApp."Loan No.");
                end;

            until LoanApp.Next = 0;
        end;

        Rec.TestField("Appraisal Completed", false);
        Rec.TestField("Recommended Amount");
        Rec.TestField(Period);

        if ProductSetup."Appraise Security" then begin

            LoanGuarantors.Reset;
            LoanGuarantors.SetRange("Loan No.", Rec."Appraisal No.");
            if LoanGuarantors.Find('-') then begin
                repeat
                    TotalGuaranteed += LoanGuarantors."Amount Guaranteed";
                until LoanGuarantors.Next = 0;
            end;

        end;

        // if ProductSetup."Appraise Security" then
        //     if TotalGuaranteed < Rec."Recommended Amount" then
        //         Error('Loan Not Fully Guaranteed');


        TopUp.Reset();
        TopUp.SetRange("Loan No.", Rec."Appraisal No.");
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

    procedure SendToLoanAppraisal()
    var
        Loan: Record Loans;
        NewLoan: Record Loans;
    begin
        if not Confirm('Are you Ready to send the Loan for Disbursement?', false) then
            exit;

        CheckControls();
        //Rec.GetValues();
        //Commit();

        if FindExistingLoan(Loan) then
            UpdateExistingLoan(Loan)
        else
            CreateNewLoan();

        Rec."Appraisal Completed" := true;
        Rec.Modify();
        CurrPage.Close();
    end;

    local procedure FindExistingLoan(var Loan: Record Loans): Boolean
    begin
        Loan.Reset();
        Loan.SetRange("Salary Appraisal No.", Rec."Appraisal No.");
        exit(Loan.FindFirst());
    end;

    local procedure UpdateExistingLoan(var Loan: Record Loans)
    var
        LoanNo: Code[20];
    begin
        LoanNo := Loan."Loan No.";

        if not Loan.Get(LoanNo) then
            Error('Loan %1 not found.', LoanNo);

        Rec.CalcFields("CEO Comments", "Appraiser Comments", "Board Comments", "Credit Committee Comments");

        // Update loan details from appraisal
        Loan."Application Date" := Rec."Date";
        Loan.Validate("Member No.", Rec."Member No.");
        Loan.Validate("Salary Appraisal No.", Rec."Appraisal No.");

        if Loan.Installments <> Rec.Period then
            Loan.Validate(Installments, Rec.Period);
        Loan."Document Ref. No." := Rec."Appraisal No.";
        Loan."Repay Mode" := Rec."Repay Mode";
        Loan."Loan Officer" := Rec."Loan Officer";
        Loan."Main Sector Code" := Rec."Main Sector Code";
        Loan."Main Sector Description" := Rec."Main Sector Description";
        Loan."Sub-Sector Level 1 Code" := Rec."Sub-Sector Level 1 Code";
        Loan."Sub-Sector Level 1 Description" := Rec."Sub-Sector Level 1 Description";
        Loan."Sub-Sector Level 2 Code" := Rec."Sub-Sector Level 2 Code";
        Loan."Sub-Sector Level 2 Description" := Rec."Sub-Sector Level 2 Description";
        Loan."Loan Moratorium Start Date" := Rec."Loan Moratorium Start Date";
        Loan."Loan Moratorium End Date" := Rec."Loan Moratorium End Date";
        Loan."Total Insurance" := Rec.Insurance;
        Loan."Approved By" := Rec."Approved By";
        Loan."Approved On" := Rec."Approved On";
        Loan."Approved Amount" := Rec."Approved Amount";
        Loan."Net Income Per Month" := Rec."Net Income Per Month";
        Loan."Monthly Expenditure" := Rec."Monthly Expenditure";
        Loan."Document Ref. No." := Rec."Appraisal No.";
        Loan."Amount To Disburse" := Rec."Amount To Disburse";
        Loan."Loan Principle Repayment" := Rec."Principal Repayment";
        Loan."Loan Interest Repayment" := Rec."Interest Repayment";
        Loan."Type of Disbursement" := Rec."Type of Disbursement";
        Loan."Self Guarantee" := rec."Self Guarantee";
        Loan."Appraised By" := Rec."Appraiser ID";
        Loan."Total Monthly Repayment" := Rec."Max. Monthly Deduction";
        Loan."Repay Mode" := Rec."Repay Mode";
        Loan."Amount To Disburse" := Rec."Amount To Disburse";
        Loan."Consolidated Loan" := Rec."Consolidated Loan";
        Loan."Rescheduled Loan" := Rec."Rescheduled Loan";
        Loan."Schedule Start Date" := Rec."Schedule Start Date";
        Loan."Interest Calculation Method" := Rec."Interest Calculation Method";
        Loan."Deposit COntribution" := Rec."BOSA Savings";
        Loan."Application Date" := Rec."Date";

        //Loan.Validate("Amount To Disburse", Rec."Recommended Amount");
        Loan.SetCEOComment(Rec.GetCEOComment());
        Loan.SetAppraiserComment(Rec.GetAppraiserComment());
        Loan.SetCreditCommitteeComment(Rec.GetCreditCommitteeComment());
        Loan.SetBoardComment(Rec.GetBoardComment());
        Loan.Modify();


    end;

    local procedure CreateNewLoan()
    var
        Loan: Record Loans;
    begin
        Loan.Init();

        Loan.Insert(true);

        // Populate loan details from appraisal
        PopulateLoanFromAppraisal(Loan);
        Message('Loan %1 has been successfully registered and is ready for disbursement.', Loan."Loan No.");
    end;

    local procedure PopulateLoanFromAppraisal(var Loan: Record Loans)
    begin
        Loan."Application Date" := Rec.Date;
        Loan.Validate("Member No.", Rec."Member No.");
        Loan.Validate("Salary Appraisal No.", Rec."Appraisal No.");
        Rec.CalcFields("CEO Comments", "Appraiser Comments", "Board Comments", "Credit Committee Comments");

        if Loan.Installments <> Rec.Period then
            Loan.Validate(Installments, Rec.Period);

        Loan."Type of Disbursement" := Rec."Type of Disbursement";
        Loan."Repay Mode" := Rec."Repay Mode";
        Loan."Loan Officer" := Rec."Loan Officer";
        Loan."Email Address" := Rec."Email Address";
        Loan."ID No." := Rec."ID Number";
        Loan."KRA PIN" := Rec."KRA PIN";
        Loan."Main Sector Code" := Rec."Main Sector Code";
        Loan."Main Sector Description" := Rec."Main Sector Description";
        Loan."Sub-Sector Level 1 Code" := Rec."Sub-Sector Level 1 Code";
        Loan."Sub-Sector Level 1 Description" := Rec."Sub-Sector Level 1 Description";
        Loan."Sub-Sector Level 2 Code" := Rec."Sub-Sector Level 2 Code";
        Loan."Sub-Sector Level 2 Description" := Rec."Sub-Sector Level 2 Description";
        Loan."Loan Moratorium Start Date" := Rec."Loan Moratorium Start Date";
        Loan."Loan Moratorium End Date" := Rec."Loan Moratorium End Date";
        Loan."Total Insurance" := Rec.Insurance;
        Loan."Purpose of Loan" := Rec."Loan Purpose";
        Loan."Deposit COntribution" := Rec."BOSA Savings";
        Loan."Approved By" := Rec."Approved By";
        Loan."Approved On" := Rec."Approved On";
        Loan."Net Income Per Month" := Rec."Net Income Per Month";
        Loan."Monthly Expenditure" := Rec."Monthly Expenditure";
        Loan."Total Monthly Repayment" := Rec."Max. Monthly Deduction";
        Loan."Document Ref. No." := Rec."Appraisal No.";
        Loan."Self Guarantee" := Rec."Self Guarantee";
        Loan."Appraised By" := Rec."Appraiser ID";
        Loan."Approved Amount" := rec."Approved Amount";
        Loan."Loan Principle Repayment" := Rec."Principal Repayment";
        Loan."Loan Interest Repayment" := Rec."Interest Repayment";
        Loan."Amount To Disburse" := Rec."Amount To Disburse";
        loan."Consolidated Loan" := Rec."Consolidated Loan";
        Loan."Rescheduled Loan" := Rec."Rescheduled Loan";
        Loan."Repay Mode" := Rec."Repay Mode";
        Loan."Schedule Start Date" := Rec."Schedule Start Date";
        Loan."Interest Calculation Method" := Rec."Interest Calculation Method";
        Loan."Application Date" := Rec.Date;
        //Loan.Validate("Amount To Disburse", Rec."Recommended Amount");

        Loan.SetCEOComment(Rec.GetCEOComment());
        Loan.SetAppraiserComment(Rec.GetAppraiserComment());
        Loan.SetCreditCommitteeComment(Rec.GetCreditCommitteeComment());
        Loan.SetBoardComment(Rec.GetBoardComment());
        Loan.Modify();
    end;

    local procedure UpdateFields()
    var
        SaccoSetup: Record "Sacco Setup";
        BoardCommentAmountThreshold: Decimal;
        LoanAmountForBoardComment: Decimal;
    begin
        //Rec.validate("Member No.");
        if Rec.Status = Rec.Status::Open then begin
            SendBool := true;
            CancelBool := false;

        end
        else begin

            SendBool := false;
            CancelBool := true;
        end;

        if Rec.Status = Rec.Status::Pending then begin
            CancelBool := true;
        end;

        DelegateVisible :=
            (Rec."Appraiser ID" <> '') and
            (Rec."Appraiser ID" = UserId()) and
            (Rec.Status <> Rec.Status::Approved) and
            (Rec.Status <> Rec.Status::Rejected);

        if SaccoSetup.Get() then
            BoardCommentAmountThreshold := SaccoSetup."Minimum Board Loan Comment Amt";

        if BoardCommentAmountThreshold > 0 then begin
            LoanAmountForBoardComment := Rec."Approved Amount";
            if LoanAmountForBoardComment = 0 then
                LoanAmountForBoardComment := Rec."Requested Amount";

            BoardCommentsEditable := LoanAmountForBoardComment > BoardCommentAmountThreshold;
        end;
        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Rejected) then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;

    var
        BusinessAppraisal: Boolean;
        SalaryDetails: Boolean;
        memberAge: Integer;
        CancelBool: Boolean;
        ApprovedEdit: Boolean;
        SendBool: Boolean;
        CEOComments: Text;
        CreditCommitteeComments: Text;
        AppraiserComments: Text;
        BoardComments: Text;
        BoardCommentsEditable: Boolean;
        SubTypeVisible: Boolean;
        DelegateVisible: Boolean;

}


