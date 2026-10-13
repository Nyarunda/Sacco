page 50434 "Salary Appraisal Card"
{
    Caption = 'Loan Application Card';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Salary Appraisal";
    PromotedActionCategories = 'New,Process,Report,Send to Loan Appraisal,Reopen Document,Loan Top Up,Other Clearances,Loan Security,Loan Charges,Member Card';

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
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
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
                    Visible = false;
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
                    ApplicationArea = all;
                    Caption = 'Appraiser ID';
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
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the product description field';
                }

                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = All;
                }
                field("Annual Interest %"; Rec."Annual Interest %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Annual Interest % field.';
                }
                field("Repay Mode"; Rec."Repay Mode")
                {
                    ApplicationArea = all;
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
                field("Loan Restructured"; Rec."Loan Restructured")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Self Guarantee"; Rec."Self Guarantee")
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
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Qualification as Per Guarantor"; Rec."Qualification as Per Guarantor")
                {
                    ApplicationArea = Basic;
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
                    ToolTip = 'Specifies the value of the Recommended field.';
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                    Visible = false;

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
                field("BOSA Savings"; Rec."BOSA Savings")
                {
                    ApplicationArea = All;

                    Caption = 'Monthly Deposit Contributions';
                    ToolTip = 'Specifies the value of the BOSA Savings field.';
                }

                field("Total Charges"; Rec."Total Charges")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Charges field.';
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
            action("Get CRB Report")
            {
                ApplicationArea = Basic;
                Image = SettleOpenTransactions;
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                var
                    myInt: Integer;
                    Cust: record Members;
                    PSetup: Record "Product setup";
                    Employer: Record Customer;
                    CheckCRB: Boolean;
                    CRBReq: Record "MCRB API Request";
                    MCRBIntegration: Codeunit "MCRB API Integration";
                    MCRBLog: Record "MCRB Integration Log";
                    NewReport: Boolean;
                    FileMan: Codeunit "File Management";
                    pdfInStream: InStream;
                begin
                    Rec.TestField("Loan Product Type");
                    Rec.TestField("Member No.");
                    NewReport := false;
                    Rec."CRB Mandatory" := false;
                    if Cust.get(Rec."Member No.") then begin
                        CheckCRB := true;
                        if Employer.get(Cust."Employer Code") then begin
                            if Employer."Skip Check CRB" then
                                CheckCRB := false;
                        end;
                        if CheckCRB then begin

                            PSetup.get(Rec."Loan Product Type");
                            if not PSetup."Allow CRB Check" then
                                Error('CRB Check disabled for this product');

                            if Rec."Requested Amount" < PSetup."CRB Minimum Loan Amount" then
                                Error('CRB Check disabled for this loan amount');



                            Rec."CRB Mandatory" := true;
                            Rec.Modify();
                            MCRBLog.Reset();
                            MCRBLog.SetAscending(EntryID, true);
                            MCRBLog.SetRange(LoanNo, Rec."Appraisal No.");
                            MCRBLog.SetRange(MemberNo, Rec."Member No.");
                            if MCRBLog.FindLast() then begin
                                MCRBLog.CalcFields(JsonPDFReport);
                                if MCRBLog.JsonPDFReport.HasValue then begin
                                    if Rec."CRB Status Date" < Today then begin
                                        if Confirm('Report Already Generated. Do you want to Request a new one?') then
                                            NewReport := true
                                        else begin

                                            MCRBLog.JsonPDFReport.CreateInStream(pdfInStream);
                                            if not FileMan.DownloadFromStreamHandler(pdfInStream,
                                                                            'Open PDF Report',
                                                                            '',                    // Folder: leave blank to use default
                                                                            'PDF Files|*.pdf',     // Filter string: adjust as needed
                                                                            'Report.pdf') then      // The file name for the PDF
                                                Error('Failed to open PDF report.');

                                        end;
                                    end;
                                end
                                else
                                    NewReport := true;
                            end
                            else
                                NewReport := true;

                            if NewReport then begin

                                CRBReq.Init();
                                CRBReq.ReportType := CRBReq.ReportType::"JSON Report";
                                if Cust."Account Category" = Cust."Account Category"::Business then begin

                                    if Cust."Business Reg. No." <> '' then begin
                                        CRBReq.IdentityNumber := Cust."Business Reg. No.";
                                        CRBReq.IdentityType := '005';

                                    end
                                    else
                                        Error('Customer Identity is missing');


                                end
                                else begin

                                    if Cust."ID No." <> '' then begin
                                        CRBReq.IdentityNumber := Cust."ID No.";
                                        CRBReq.IdentityType := '001';
                                    end
                                    else if Cust.Passport <> '' then begin
                                        CRBReq.IdentityNumber := Cust.Passport;
                                        CRBReq.IdentityType := '002';
                                    end
                                    else
                                        Error('Customer Identity is missing');


                                end;
                                CRBReq.LoanAmount := Rec."Requested Amount";
                                CRBReq.ReportReason := 1;
                                CRBReq.LoanNo := Rec."Appraisal No.";
                                CRBReq.MemberNo := Rec."Member No.";
                                CRBReq.Insert();


                                // Call ProcessReport using the values from the current record.
                                MCRBIntegration.ProcessReport(
                                    Rec."Appraisal No.",
                                    Rec."Member No.",
                                    CRBReq.RequestID,
                                    CRBReq."ReportType",
                                    CRBReq."IdentityNumber",
                                    CRBReq."IdentityType",
                                    CRBReq."LoanAmount",
                                    CRBReq."ReportReason",
                                    CRBReq.MobileScore
                                );
                            end;

                            MCRBLog.Reset();
                            MCRBLog.SetAscending(EntryID, true);
                            MCRBLog.SetRange(LoanNo, Rec."Appraisal No.");
                            MCRBLog.SetRange(MemberNo, Rec."Member No.");
                            if MCRBLog.FindLast() then begin
                                MCRBLog.CalcFields(JsonPDFReport);
                                if MCRBLog.JsonPDFReport.HasValue then begin
                                    Rec."CRB Checked" := true;
                                    Rec."CRB Status Date" := Today;
                                    Rec."CRB Status Code" := MCRBLog."CRB Status Code";
                                    Rec."CRB Status Description" := MCRBLog."CRB Status Description";
                                end;
                            end;

                        end
                        else begin

                            Error('CRB Check disabled for this employer: %1', Employer.Name);
                        end;

                    end;
                end;
            }

            action("Arrears Recovery")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = category7;
                PromotedIsBig = true;
                RunObject = Page "Arrears Recovery";
                RunPageLink = "Application No." = field("Appraisal No."), "Member No." = field("Member No.");
            }

            action("Send To Loan Registration")
            {
                ApplicationArea = Basic;
                Image = SendTo;
                Promoted = true;
                Caption = 'Send To Loan Appraisal';
                PromotedCategory = category4;


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
                    LoanType.Get(Rec."Loan Product Type");
                    Rec.CheckRequestAmountAgainstDepositMuitplier();
                    Rec.CheckMultipleRunningLoanAllowed(LoanType);
                    if Rec."Loan Stage" = Rec."Loan Stage"::"Loan Application" then begin
                        if not Confirm('Are you sure you want to send this application to Loan Appraisal?', false) then
                            exit;

                        Rec."Loan Stage" := Rec."Loan Stage"::"Loan Appraisal";
                    end;
                    Rec.Modify();
                    CurrPage.Close();
                    // SendToLoanAppraisal();
                end;

            }
            action("Re-Open")
            {
                ApplicationArea = Basic;
                Image = SendTo;
                Promoted = true;
                PromotedCategory = category5;


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
                        Rec.testfield("Appraisal Completed", true);
                        Rec."Appraisal Completed" := false;
                        Rec.Modify();
                        Message('Re-Opened');

                        CurrPage.close();
                    end;
                end;

            }
            action("Loan Top Up")
            {
                ApplicationArea = Basic;
                Image = SettleOpenTransactions;
                Promoted = true;
                PromotedCategory = category6;
                RunObject = Page "Appraisal Loan Top Up";
                RunPageLink = "Loan No." = field("Appraisal No."), "Member No." = field("Member No.");
            }

            action("Other Clearances")
            {
                ApplicationArea = Basic;
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = category7;
                RunObject = Page "Other Commitments Clearance";
                RunPageLink = "Loan Application No." = field("Appraisal No.");
            }
            action("Loan Security")
            {
                ApplicationArea = Basic;
                Image = SettleOpenTransactions;
                Promoted = true;
                PromotedCategory = Category8;
                RunObject = Page "Loan Security";
                RunPageLink = "Loan No." = field("Appraisal No.");
            }

            action("Bank Account List")
            {
                ApplicationArea = Basic;
                Image = SetPriorities;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                RunObject = Page "HR Bank Accounts List";
                RunPageLink = "Loan No." = field("Appraisal No.");

            }
            action("Loan Witness")
            {
                ApplicationArea = Basic;
                Image = SetPriorities;
                Promoted = true;
                Visible = false;
                PromotedCategory = Category8;
                RunObject = Page "Loan Witness";
                RunPageLink = "Loan No." = field("Appraisal No.");
            }

            action("Loan Charges")
            {
                ApplicationArea = Basic;
                Image = Costs;
                Promoted = true;
                PromotedCategory = category9;
                RunObject = Page "Loan Charges";
                RunPageLink = "Loan No." = field("Appraisal No."),
                              "Loan Product Type" = field("Loan Product Type");
            }
            action("Member Card")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = true;
                RunObject = Page "Member Card";
                RunPageLink = "No." = field("Member No.");
            }

        }
        area(reporting)
        {


            action("Loan Schedule Report")
            {
                ApplicationArea = Basic;
                Image = Link;
                Visible = false;

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

    local procedure CheckStaffAccountPermission()
    var
        UserSetup: Record "User Setup";
    begin

        if not UserSetup.Get(UserId) then
            Error('You Are Not SetUp to View Other Staff''s Accounts');

        if not UserSetup."View Staff Accounts" then
            Error('You Are Not SetUp to View Other Staff''s Accounts');
    end;

    trigger OnOpenPage()
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

    trigger OnAfterGetCurrRecord()
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
        TotalGuaranteed: Decimal;
        LoanApp: Record Loans;
        Loan: Record Loans;
    begin

        Member.Get(Rec."Member No.");

        ProductSetup.Get(Rec."Loan Product Type");


        //if Member."Member Category" = Member."Member Category"::"Staff Members" then
        //    "Require Committee Approval" := true;

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

        Rec.HasSubType();
    end;

    local procedure SendToLoanAppraisal()
    var
        Loan: Record Loans;
        NewLoan: Record Loans;
    begin
        if not Confirm('Ready to send the application to Loan Appraisal?', false) then
            exit;

        // Validate application before proceeding
        CheckControls();
        Rec.GetValues();
        Commit();

        // Check if loan already exists for this appraisal
        if FindExistingLoan(Loan) then
            UpdateExistingLoan(Loan)
        else
            CreateNewLoan();

        // Mark appraisal as completed
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

        // Update loan details from appraisal
        Loan.Validate("Member No.", Rec."Member No.");
        Loan.Validate("Salary Appraisal No.", Rec."Appraisal No.");

        if Loan.Installments <> Rec.Period then
            Loan.Validate(Installments, Rec.Period);

        Loan."Repay Mode" := Rec."Repay Mode";
        Loan."Loan Officer" := Rec."Loan Officer";
        Loan.Modify();

        // Ask to open the loan
        if Confirm('Loan %1 has been updated. Do you want to open it?', true, LoanNo) then
            Page.Run(Page::"Loan Application Card", Loan);
    end;

    local procedure CreateNewLoan()
    var
        Loan: Record Loans;
    begin
        Loan.Init();

        if not Loan.Insert(true) then
            Error('Failed to create new loan application.');

        // Populate loan details from appraisal
        PopulateLoanFromAppraisal(Loan);

        // Ask to open the loan
        if Confirm('A new loan Appraisal %1 has been registered. Do you want to open it?', true, Loan."Loan No.") then
            Page.Run(Page::"Loan Application Card", Loan);
    end;

    local procedure PopulateLoanFromAppraisal(var Loan: Record Loans)
    begin
        Loan.Validate("Member No.", Rec."Member No.");
        Loan.Validate("Salary Appraisal No.", Rec."Appraisal No.");

        if Loan.Installments <> Rec.Period then
            Loan.Validate(Installments, Rec.Period);

        Loan."Repay Mode" := Rec."Repay Mode";
        Loan."Loan Officer" := Rec."Loan Officer";
        Loan."Email Address" := Rec."Email Address";
        Loan."ID No." := Rec."ID Number";
        Loan."KRA PIN" := Rec."KRA PIN";
        Loan.Modify();
    end;

    var
        BusinessAppraisal: Boolean;
        SalaryDetails: Boolean;
        memberAge: Integer;
        SubTypeVisible: Boolean;



}
