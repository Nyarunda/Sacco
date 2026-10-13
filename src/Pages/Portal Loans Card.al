page 50794 "Portal Loans Card"
{
    PageType = Card;
    SourceTable = "Portal Loans";
    ApplicationArea = All;
    Caption = 'Portal Loan Application';
    UsageCategory = Documents;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Information';
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the application number.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the member number.';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the account name.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the application date.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                    ToolTip = 'Specifies the current status of the application.';
                }
                field("Step Completed"; Rec."Step Completed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current step in the application process.';
                }

                field("Employer"; Rec."Employer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employer code.';
                }
                field("Terms of Employment"; Rec."Terms Of Appointment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the terms of employment.';
                }
                field("Basic Salary"; Rec."Basic Salary")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the basic salary.';
                }
                field(Allowances; Rec.Allowances)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the allowances.';
                }
                field(Deductions; Rec.Deductions)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the deductions.';
                }
                field(PAYE; Rec.PAYE)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the PAYE amount.';
                }
                field("Net Salary"; Rec."Net Salary")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the calculated net salary.';
                }


                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the loan product type.';
                }
                field("Loan Name"; Rec."Loan Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the loan product name.';
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the requested loan amount.';
                    StyleExpr = 'Strong';
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approved loan amount.';
                }
                field("Loan Period"; Rec."Loan Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the loan period in months.';
                }
                field("Loan Purpose"; Rec."Loan Purpose")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the purpose of the loan.';
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the disbursement account number.';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the loan number after approval.';
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the application has been posted.';
                }
                field("Total Guaranteed Amount"; TotalGuaranteedAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Total Guaranteed Amount';
                    Editable = false;
                    ToolTip = 'Shows the total amount guaranteed for this loan.';
                }
                field("Guarantee Coverage %"; GuaranteeCoveragePercent)
                {
                    ApplicationArea = All;
                    Caption = 'Guarantee Coverage %';
                    Editable = false;
                    ToolTip = 'Shows the percentage of guarantee coverage.';
                    StyleExpr = GuaranteeStyle;
                }
                field("Documents Uploaded"; DocumentsCount)
                {
                    ApplicationArea = All;
                    Caption = 'Documents Uploaded';
                    Editable = false;
                    ToolTip = 'Shows the number of documents uploaded.';
                }
                field("Use My Deposits"; Rec."Use My Deposits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates whether the applicant has chosen to use their deposits as security for the loan.';
                }
                field("Guaranteed By Other Members"; Rec."Guaranteed By Other Members")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates whether the applicant has other members guaranteeing the loan.';
                }
                field("Use Holiday Savings"; Rec."Use Holiday Savings")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates whether the applicant has chosen to use their holiday savings as security for the loan.';
                }
            }

            part(Guarantors; "Portal Guarantors Subpage")
            {
                ApplicationArea = All;
                Caption = 'Guarantors';
                SubPageLink = "Loan No." = field("Application No.");
                UpdatePropagation = Both;
            }

            part(Witnesses; "Portal Witnesses Subpage")
            {
                ApplicationArea = All;
                Caption = 'Witnesses';
                SubPageLink = "Loan Application No." = field("Application No.");
                UpdatePropagation = Both;
            }

            part(Documents; "Portal Documents Subpage")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                SubPageLink = "Loan Application No." = field("Application No.");
                UpdatePropagation = Both;
            }

            part(TopUpLoans; "Portal TopUp Subpage")
            {
                ApplicationArea = All;
                Caption = 'Top-Up Loans';
                SubPageLink = "Loan No." = field("Application No.");
                UpdatePropagation = Both;
            }

            part(BankAccountsList; "HR Bank Accounts List")
            {
                ApplicationArea = All;
                Caption = 'Bank Accounts';
                SubPageLink = "Loan No." = field("Application No.");
                UpdatePropagation = Both;
            }


        }


    }

    actions
    {
        area(processing)
        {
            group(ProcessingActions)
            {
                Caption = 'Processing';
                action(Approve)
                {
                    Caption = 'Approve Application';
                    ApplicationArea = All;
                    Image = Approve;
                    ToolTip = 'Approve this loan application.';
                    Enabled = Rec.Status <> Rec.Status::Approved;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to approve this loan application?') then begin
                            Rec.Status := Rec.Status::Approved;
                            // Rec."Last Modified Date" := CurrentDateTime;
                            Rec.Modify(true);
                            CurrPage.Update();
                            Message('Loan application has been approved.');
                        end;
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject Application';
                    ApplicationArea = All;
                    Image = Reject;
                    ToolTip = 'Reject this loan application.';
                    Enabled = Rec.Status <> Rec.Status::Failed;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to reject this loan application?') then begin
                            Rec.Status := Rec.Status::Failed;
                            //Rec."Last Modified Date" := CurrentDateTime;
                            Rec.Modify(true);
                            CurrPage.Update();
                            Message('Loan application has been rejected.');
                        end;
                    end;
                }
                action(SendBack)
                {
                    Caption = 'Send Back for Review';
                    ApplicationArea = All;
                    Image = Return;
                    ToolTip = 'Send the application back for additional information.';

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to send this application back for review?') then begin
                            Rec.Status := Rec.Status::Pending;
                            //Rec."Last Modified Date" := CurrentDateTime;
                            Rec.Modify(true);
                            CurrPage.Update();
                            Message('Application has been sent back for review.');
                        end;
                    end;
                }
            }

            group(NavigationActions)
            {
                Caption = 'Navigation';
                action(ViewMember)
                {
                    Caption = 'View Member Card';
                    ApplicationArea = All;
                    Image = Customer;
                    ToolTip = 'Open the member card for this applicant.';
                    RunObject = page "Member Card";
                    RunPageLink = "No." = field("Member No.");
                }
                action(ViewLoanProduct)
                {
                    Caption = 'View Loan Product';
                    ApplicationArea = All;
                    //Image = Product;
                    ToolTip = 'View the loan product details.';
                    RunObject = page "Product Setup Card";
                    RunPageLink = "Product ID" = field("Loan Product Type");
                }
            }

            group(Reports)
            {
                Caption = 'Reports';
                action(PrintApplication)
                {
                    Caption = 'Print Application';
                    ApplicationArea = All;
                    Image = Print;
                    ToolTip = 'Print the loan application form.';

                    trigger OnAction()
                    var
                        PortalLoan: Record "Portal Loans";
                        LoanForm: Report "Online loan Application";
                    begin
                        PortalLoan := Rec;
                        PortalLoan.SetRecFilter();
                        Report.RunModal(Report::"Online loan Application", true, true, PortalLoan);
                    end;
                }
                action(LoanCalculation)
                {
                    Caption = 'Loan Calculation';
                    ApplicationArea = All;
                    Image = Calculate;
                    ToolTip = 'View loan calculation and repayment schedule.';

                    trigger OnAction()
                    begin
                        Message('Loan calculation: Amount=%1, Period=%2 months', Rec."Requested Amount", Rec."Loan Period");
                    end;
                }
            }
        }

        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Portal Uploads")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PortalDocs: Record "Portal Uploads";
                    begin
                        PortalDocs.Reset();
                        PortalDocs.SetRange("Loan Application No.", Rec."Application No.");
                        if PortalDocs.FindFirst() then begin
                            Page.Run(Page::"Portal Uploads", PortalDocs);
                        end;

                    end;
                }
                action("Loan Security")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PortalDocs: Record "Mobile Loan Guarantors";
                    begin
                        /*   PortalDocs.Reset();
                          PortalDocs.SetRange("Loan No.", Rec."Application No.");
                          if PortalDocs.FindFirst() then begin
                              Page.Run(Page::"Portal Guarantors Subpage", PortalDocs);
                          end; */

                    end;
                }
                action("Send To Loan Application")
                {
                    ApplicationArea = Basic;
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        //Loans: Record Loans;
                        LoanProduct: Record "Product Setup";
                        PortalGuarantors: Record "Mobile Loan Guarantors";
                        PortalTopup: Record "Portal Top Up";
                        PortalWitness: Record "Portal Loan Witness";
                        LoanSecurity: Record "Loan Security";
                        Legacy: COdeunit Legacy;
                        Members: Record Members;
                        Witness: Record "Loan Witness";

                        AppraisalTopup: Record "Appraisal Top Up";
                        Appraisal: Record "Member Salary Appraisal";

                        Loans: Record Loans;
                        ExistingAppraisal: Boolean;

                        PCharges: Record "Charges.";
                        LoanCharges: Record "Loan Charges";
                        PChAmt: Decimal;
                        GL: Code[20];
                        EDuty: Decimal;
                        Continue: Boolean;
                        GenSetup: Record "Sacco Setup";
                        MemberActivities: Codeunit "Member Activities";
                    begin
                        //Rec.TestField(Status, Rec.Status::Pending);

                        Appraisal.Reset();
                        Appraisal.SetRange("Portal Loan Code", Rec."Application No.");
                        ExistingAppraisal := Appraisal.FindFirst();

                        if Rec."Requested Amount" > TotalGuaranteedAmount then
                            Message('Loan not fully guaranteed');

                        if ExistingAppraisal then begin
                            if not Confirm('Already transferred to Loan Appraisal: %1. Do you want to update the existing appraisal with current details?', false, Appraisal."Appraisal No.") then
                                exit;
                        end else
                            if not Confirm('Are you sure you want to send this loan to Appraisal?') then
                                exit;

                        begin

                            LoanProduct.Get(Rec."Loan Product Type");

                            if not ExistingAppraisal then begin
                                Appraisal.Init;
                                Appraisal."Appraisal No." := '';
                                Appraisal."Portal Loan Code" := Rec."Application No.";
                                Appraisal.Date := Today;
                                Appraisal.Validate("Member No.", Rec."Member No.");
                                Appraisal.Validate("Loan Product Type", LoanProduct."Product ID");
                                Appraisal.Validate("Requested Amount", Rec."Requested Amount");
                                //Appraisal.validate(Installments, LoanProduct."Default Installments");
                                Appraisal.Insert(true);
                            end else begin
                                Appraisal.Validate("Member No.", Rec."Member No.");
                                Appraisal.Validate("Loan Product Type", LoanProduct."Product ID");
                                Appraisal.Validate("Requested Amount", Rec."Requested Amount");
                                Appraisal.Date := Today;
                                Appraisal."Portal Loan Code" := Rec."Application No.";
                                Appraisal.Modify(true);
                            end;


                            Rec."Loan No." := Appraisal."Appraisal No.";

                            Rec.Status := Rec.Status::"Pending Appraisal";
                            Rec.Modify();

                            PortalGuarantors.Reset();
                            PortalGuarantors.SetRange("Loan No.", Rec."Application No.");
                            PortalGuarantors.SetRange("Guarantor Accepted", PortalGuarantors."Guarantor Accepted"::Yes);
                            if PortalGuarantors.FindFirst() then begin

                                LoanSecurity.Reset();
                                LoanSecurity.SetRange("Loan No.", Appraisal."Appraisal No.");
                                if LoanSecurity.FindSet() then
                                    LoanSecurity.DeleteAll();

                                repeat
                                    if members.Get(PortalGuarantors."Guarantor Member No.") then begin

                                        LoanSecurity.Init();
                                        LoanSecurity."Loan No." := Appraisal."Appraisal No.";
                                        LoanSecurity."Guarantor Type" := LoanSecurity."Guarantor Type"::Guarantor;
                                        LoanSecurity."Member No" := members."No.";
                                        LoanSecurity.Validate("Account No.", Legacy.GetDepositAccounts(PortalGuarantors."Guarantor Member No."));
                                        LoanSecurity.Validate("Amount Guaranteed", PortalGuarantors."Amount Guaranteed");
                                        LoanSecurity.Insert();

                                    end;
                                until PortalGuarantors.Next() = 0;
                            end;


                            PortalTopup.Reset();
                            PortalTopup.SetRange("Loan No.", Rec."Application No.");
                            if PortalTopup.FindSet() then begin

                                AppraisalTopup.Reset();
                                AppraisalTopup.SetRange("Loan No.", Appraisal."Appraisal No.");
                                if AppraisalTopup.FindFirst() then
                                    AppraisalTopup.DeleteAll();

                                repeat
                                    Loans.Get(PortalTopup."Loan Top Up");
                                    Loans.CalcFields("Total Outstanding Balance");
                                    if Loans."Total Outstanding Balance" > 0 then begin

                                        AppraisalTopup.Init();
                                        AppraisalTopup."Loan No." := Appraisal."Appraisal No.";
                                        AppraisalTopup."Member No." := Loans."Member No.";
                                        AppraisalTopup.validate("Loan Top Up", PortalTopup."Loan Top Up");
                                        AppraisalTopup.Insert(true);

                                    end;
                                until PortalTopup.Next() = 0;
                            end;


                            PortalWitness.Reset();
                            PortalWitness.SetRange("Loan Application No.", Rec."Application No.");
                            PortalWitness.SetFilter("Witness No.", '<>%1', '');
                            PortalWitness.SetRange("Witness Approved", PortalWitness."Witness Approved"::Yes);
                            if PortalWitness.FindSet() then begin

                                Witness.Reset();
                                Witness.SetRange("Loan No.", Appraisal."Appraisal No.");
                                if Witness.FindFirst() then
                                    Witness.DeleteAll();

                                //repeat
                                Witness.Init();
                                Witness."Loan No." := Appraisal."Appraisal No.";
                                Witness.Category := Witness.Category::Witness;
                                Witness."Member No." := Appraisal."Member No.";
                                Witness.Name := PortalWitness."Witness Name";
                                Witness."Mobile Phone No" := PortalWitness."Witness Phone";
                                Witness.Insert();
                                //until PortalWitness.Next() = 0;
                            end;

                            Rec.Status := Rec.Status::"Pending Appraisal";
                            Rec.Modify();

                            /* PCharges.Reset;
                            PCharges.SetFilter(PCharges."Charge Code", 'SKY');
                            if PCharges.Find('-') then begin
                                repeat
                                    PChAmt := 0;
                                    GL := '';
                                    EDuty := 0;
                                    if PCharges."Charge Amount" > 0 then
                                        PChAmt := PCharges."Charge Amount"
                                    else
                                        MemberActivities.GetLoanChargeAmount(Rec."Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", Rec."Approved Amount", PChAmt, EDuty, GL);

                                    LoanCharges.Init;
                                    LoanCharges."Loan No." := Rec."Loan No.";
                                    LoanCharges."Loan Product Type" := Rec."Loan Product Type";
                                    LoanCharges."Charge Code" := PCharges."Charge Code";
                                    LoanCharges."Charge %" := PCharges.Percentage;
                                    LoanCharges.Amount := PChAmt;
                                    LoanCharges."Excise Duty" := EDuty;
                                    LoanCharges."Total Charge" := PChAmt + EDuty;
                                    LoanCharges."Account Type" := PCharges."Charge Account Type";
                                    LoanCharges."Account No." := PCharges."Charges G_L Account";
                                    LoanCharges."Posting Type" := PCharges."Posting Type";
                                    //LoanCharges."Is Sms Charge" := PCharges."Is Sms Alert";
                                    LoanCharges."Charge Type" := PCharges."Charge Type";

                                    LoanCharges.Description := PCharges.Description;

                                    if EDuty > 0 then begin
                                        GenSetup.TestField("Excise Duty GL");
                                        LoanCharges."Duty GL" := GenSetup."Excise Duty GL";
                                    end;
                                    LoanCharges.Insert;

                                until PCharges.Next = 0;
                            end; */

                            if ExistingAppraisal then
                                Message('Loan Appraisal has been Updated: Appraisal No. %1', Rec."Loan No.")
                            else
                                Message('Loan Appraisal has been Created: Appraisal No. %1', Rec."Loan No.");
                        end;
                    end;

                }
                action("Reject Loan Application")
                {
                    ApplicationArea = Basic;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Loans: Record Loans;
                        PortalLoans: Record "Portal Loans";
                        LoanProduct: Record "Product Setup";
                        RejectPortalLoan: Page "Reject Portal Loan Application";

                    begin

                        if Confirm('Are you sure you want to Reject this Applications?') then begin

                            PortalLoans.Reset();
                            PortalLoans.SetRange("Application No.", Rec."Application No.");
                            if PortalLoans.FindFirst() then begin
                                Page.Run(50364, PortalLoans);
                            end;
                        end;
                    end;
                }

                action("Test Reject All")
                {
                    ApplicationArea = Basic;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Loans: Record Loans;
                        PortalLoans: Record "Portal Loans";
                        LoanProduct: Record "Product Setup";
                        RejectPortalLoan: Page "Reject Portal Loan Application";

                    begin

                        if Confirm('Are you sure you want to Reject this Applications?') then begin

                            PortalLoans.Reset();
                            PortalLoans.SetRange("Member No.", rec."Member No.");
                            PortalLoans.SetFilter(Status, '<>%1', PortalLoans.Status::Failed);
                            if PortalLoans.FindFirst() then begin
                                PortalLoans.Modifyall(PortalLoans.Status, PortalLoans.Status::Failed)
                            end;
                        end;
                    end;
                }
            }
        }

        area(reporting)
        {
            action(ApplicationForm)
            {
                Caption = 'Application Form';
                ApplicationArea = All;
                Image = "Report";
                ToolTip = 'Generate the loan application form.';

                trigger OnAction()
                var
                    PortalLoan: Record "Portal Loans";
                begin
                    PortalLoan := Rec;
                    PortalLoan.SetRecFilter();
                    // Report.RunModal(Report::"Online loan Application", true, true, PortalLoan);
                    Message('Application form report to be implemented.');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalculateGuaranteeInfo();
        CalculateDocumentsCount();
        SetStatusStyles();
    end;

    local procedure CalculateGuaranteeInfo()
    var
        PortalGuarantors: Record "Mobile Loan Guarantors";
    begin
        TotalGuaranteedAmount := 0;
        GuaranteeCoveragePercent := 0;

        PortalGuarantors.Reset();
        PortalGuarantors.SetRange("Loan No.", Rec."Application No.");
        if PortalGuarantors.FindSet() then begin
            repeat
                TotalGuaranteedAmount += PortalGuarantors."Amount Guaranteed";
            until PortalGuarantors.Next() = 0;
        end;

        if Rec."Requested Amount" > 0 then
            GuaranteeCoveragePercent := Round((TotalGuaranteedAmount / Rec."Requested Amount") * 100, 0.01);

        /* if Rec."Requested Amount" >= TotalGuaranteedAmount then begin
            if Rec.Status = Rec.Status::"Pending Guarantor Action" then begin
                Rec.Status := Rec.Status::Approved;
                Rec.Modify();
            end;
        end; */
    end;

    local procedure CalculateDocumentsCount()
    var
        PortalDocs: Record "Portal Uploads";
    begin
        DocumentsCount := 0;
        PortalDocs.Reset();
        PortalDocs.SetRange("Loan Application No.", Rec."Application No.");
        DocumentsCount := PortalDocs.Count();
    end;

    local procedure SetStatusStyles()
    begin
        case Rec.Status of
            Rec.Status::Pending:
                StatusStyle := 'StandardAccent';
            Rec.Status::Approved:
                StatusStyle := 'Favorable';
            Rec.Status::Failed:
                StatusStyle := 'Unfavorable';
            Rec.Status::Appraisal:
                StatusStyle := 'Attention';
            else
                StatusStyle := 'Standard';
        end;

        if GuaranteeCoveragePercent >= 100 then
            GuaranteeStyle := 'Favorable'
        else if GuaranteeCoveragePercent >= 75 then
            GuaranteeStyle := 'StandardAccent'
        else
            GuaranteeStyle := 'Unfavorable';
    end;

    var
        TotalGuaranteedAmount: Decimal;
        GuaranteeCoveragePercent: Decimal;
        DocumentsCount: Integer;
        StatusStyle: Text;
        GuaranteeStyle: Text;
}