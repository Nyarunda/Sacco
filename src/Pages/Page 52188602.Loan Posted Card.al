
Page 50265 "Loan Posted Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Loans;
    PromotedActionCategories = 'New,Process,Report,Member Card,Defaulter Notices,Client Interactions,Loan Security,Salary Details';

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
                field(FormSerialNo; Rec."Form Serial No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Group  Code"; Rec."Group Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(StaffNo; Rec."Staff No")
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
                field(MinuteNos; Rec."Minute Nos.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if Rec."Global Dimension 1 Code" = 'MICRO' then infoVisible := true else infoVisible := false;
                    end;
                }
                field(BookingBranch; Rec."Booking Branch")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field(LoanProductType; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                    ShowMandatory = true;
                }
                field(TopUpType; Rec."Top Up Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if Rec."Top Up Type" = Rec."top up type"::"Add to Existing Loan" then
                            AddToExisting := true
                        else
                            AddToExisting := false;
                    end;
                }
                field(TopUpLoanNo; Rec."Top Up Loan No.")
                {
                    ApplicationArea = Basic;
                    Editable = AddToExisting;
                    Visible = false;
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
                field("Old Installments"; Rec."Old Installments")
                {
                    ApplicationArea = Basic;
                }
                field(AnnualInterest; Rec."Annual Interest %")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field(AmountToDisburse; Rec."Amount To Disburse")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                }
                field("Consolidated Loan"; Rec."Consolidated Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Rescheduled Loan"; Rec."Rescheduled Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(PurposeofLoan; Rec."Purpose of Loan")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDetailsEdit;
                }
                field("Exempt Recovery"; Rec."Exempt Recovery")
                {
                    ApplicationArea = Basic;
                }
                field(RecoveryMode; Rec."Repay Mode")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPrincipal; Rec."Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInsurance; Rec."Outstanding Insurance")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPenalty; Rec."Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field(DepositBoostingOption; Rec."Deposit Boosting Option")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Deposit Boosting"; Rec."Deposit Boosting")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposit Boosting';
                    Editable = false;
                    Visible = false;
                }
                field(ShareFinancing; Rec."Share Capital Boosting")
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Financing';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if xRec."Share Capital Boosting" <> 0 then
                            if Rec."Share Capital Boosting" <= 0 then
                                Error('Share Financing Cannot be equal to Zero');
                    end;
                }
                field("Adjusted Repayment"; Rec."Adjusted Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Repayment; Rec.Repayment + Rec."Deposit COntribution" + Rec."Total Insurance")
                {
                    ApplicationArea = Basic;
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
                field("Schedule Insurance"; Rec."Schedule Insurance")
                {
                    ApplicationArea = Basic;
                    Caption = ' Total Insurance';
                    Editable = false;
                }
                field("Schedule Balance"; Rec."Schedule Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                Field("Deposit Contribution"; Rec."Deposit Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(AppraisalFee; Rec."Appraisal Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(DiscountedAmount; Rec."Discounted Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(TypeofDisbursement; Rec."Type of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Manager"; Rec."Loan Officer")
                {
                    ApplicationArea = Basic;
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
                field("Stop Penalty"; Rec."Stop Penalty")
                {
                    Enabled = false;
                    ApplicationArea = Basic;
                }
                field(RepaymentStartDate; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Interest Run Date"; Rec."Interest Run Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }

                field("Loan Moratorium Start Date"; Rec."Loan Moratorium Start Date")
                {
                    ApplicationArea = Basic;

                }
                field("Loan Moratorium End Date"; Rec."Loan Moratorium End Date")
                {
                    ApplicationArea = Basic;
                }
                field(ScheduleStartDate; Rec."Schedule Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(CompletionDate; Rec."Completion Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LoanRejectionReason; Rec."Loan Rejection Reason")
                {
                    ApplicationArea = Basic;
                    Editable = DisbursementEdit;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field(RecommendedbyType; Rec."Recommended by Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(RecommendedBy; Rec."Recommended By")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(RecommendedByName; Rec."Recommended By Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Rescheduled date"; LoanApp."Date Rescheduled")
                {
                    ApplicationArea = Basic;
                    Caption = 'Rescheduled date';
                }
                field(TotalGuaranteed; Rec."Total Guaranteed")
                {
                    ApplicationArea = Basic;
                }

                field("Loan Suspended"; Rec."Loan Suspended")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Suspension Start Date"; Rec."Loan Suspension Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Suspension End Date"; Rec."Loan Suspension End Date")
                {
                    ApplicationArea = Basic;
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    Editable = false;
                }
                field("Top Up Amount"; Rec."Top Up Amount")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    //Editable = false;
                }
                group("Comments")
                {
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
                        MultiLine = true;


                        trigger OnValidate()
                        begin
                            Rec.SetBoardComment(BoardComments);
                        end;
                    }
                }


            }
            group(Disbursement)
            {
                part(Accounts; "HR Bank Accounts List")
                {
                    Caption = 'Disbursement Details';
                    ApplicationArea = Basic;
                    SubPageLink = "Loan No." = field("Loan No.");
                    UpdatePropagation = Both;
                }
            }
        }
        area(factboxes)
        {
            part(Control8; "Loans Statistics FactBox")
            {
                SubPageLink = "Loan No." = field("Loan No.");
            }
            part(Control63; "Info Base")
            {
                Editable = true;
                Caption = 'Loan Client Interaction';
                SubPageLink = "Member No." = field("Member No."), "Account No." = field("Loan No.");
            }

        }
    }

    actions
    {
        area(navigation)
        {
            action("Attachment")
            {
                ApplicationArea = Basic;
                Image = Link;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    DMSint: Record "DMS Endpoints";
                begin

                    DMSint.RESET;
                    DMSint.SETRANGE(DMSint."Link Type", DMSint."Link Type"::Loans);
                    IF DMSint.FIND('-') THEN BEGIN
                        HYPERLINK(DMSint."Path" + Rec."Loan No.");
                    END;
                end;
            }
            action("Mark UnPosted")
            {
                ApplicationArea = Basic;
                Visible = false;
                trigger OnAction()
                var
                    myInt: Integer;
                    Det: REcord "Credit Ledger Entry";
                begin
                    Det.reset;
                    Det.SetRange("Loan No.", Rec."Loan No.");
                    if det.FindFirst() then
                        Error('Ledger Entry Exists');

                    If Confirm('Are you sure you want to Mark this Loan As Unposted?') then begin

                        Rec.Posted := false;
                        Rec.Modify;
                        Message('Updated');
                    end;
                end;
            }

            action("Loan Security")
            {
                ApplicationArea = Basic;
                RunObject = Page "Loan Security";
                RunPageLink = "Loan No." = field("Loan No.");
            }


            action("Member Card")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Member Card";
                RunPageLink = "No." = field("Member No.");
            }
            action("Loan Statement")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    Loans: Record Loans;
                begin
                    Loans.SetRange("Loan No.", Rec."Loan No.");
                    if Loans.FindFirst then begin
                        Report.Run(Report::"Loan Statement", true, false, Loans);
                    end;
                end;
            }


            action("Loan Charges")
            {
                ApplicationArea = Basic;
                Image = Costs;
                Promoted = true;
                RunObject = Page "Loan Charges";
                RunPageLink = "Loan No." = field("Loan No."),
                              "Loan Product Type" = field("Loan Product Type");
            }
            action("Client Interactions")
            {
                ApplicationArea = Basic;
                Image = Interaction;
                Promoted = true;
                PromotedCategory = category6;

                RunObject = Page "Info Base";
                RunPageLink = "Member No." = field("Member No."), "Account No." = field("Loan No.");

            }
            action("Loan Top Up")
            {
                ApplicationArea = Basic;
                Image = SettleOpenTransactions;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "Loan Top Up";
                RunPageLink = "Loan No." = field("Loan No."),
                              "Member No." = field("Member No.");
            }

        }
        area(reporting)
        {
            action("Loan Appraisal Report")
            {
                ApplicationArea = Basic;
                Image = AnalysisView;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    AppraisalNew: Record "Member Salary Appraisal";
                begin

                    Commit;
                    //MemberActivities.SetLoanAppraisal(Rec."Loan No.");
                    //CurrPage.Update();
                    //SLEEP(1000);
                    Commit;

                    SLEEP(3000);
                    // Delay in milliseconds (1 second)

                    AppraisalNew.Reset;
                    AppraisalNew.SetRange("Appraisal No.", Rec."Salary Appraisal No.");
                    if AppraisalNew.FindFirst then
                        Report.Run(Report::"Loan Salary Appraisal", true, false, AppraisalNew);

                end;
            }
            action(AppraisalBack)
            {
                ApplicationArea = All;
                Image = Report;
                Caption = 'Appraisal Back Report';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    MemberLoanAppraisal: Record "Member Salary Appraisal";
                begin

                    MemberLoanAppraisal.Reset();
                    MemberLoanAppraisal.SetRange("Appraisal No.", Rec."Salary Appraisal No.");
                    if MemberLoanAppraisal.FindFirst() then
                        Report.Run(Report::"Appraisal Back Form", true, false, MemberLoanAppraisal);
                end;
            }

            action(appraisalReport)
            {
                ApplicationArea = All;
                Image = Report;
                Caption = 'Appraisal Report';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MemberLoanAppraisal: Record "Member Salary Appraisal";
                    ReportId: Integer;
                begin

                    if Rec."Approved Amount" > 20000000 then
                        ReportId := Report::"Appraisal Report - Board"
                    else
                        ReportId := Report::"Appraisal Report";

                    MemberLoanAppraisal.Reset();
                    MemberLoanAppraisal.SetRange("Appraisal No.", Rec."Salary Appraisal No.");
                    if MemberLoanAppraisal.FindFirst() then
                        Report.Run(ReportId, true, false, MemberLoanAppraisal);
                end;
            }

            action("Loan Schedule Report")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    LoanRec.Reset;
                    LoanRec.SetRange("Loan No.", Rec."Loan No.");
                    if LoanRec.FindFirst then
                        Report.Run(Report::"Loan Repayment Schedule", true, false, LoanRec);
                end;
            }
            action("Loan Schedule Full Date Report")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    LoanRec.Reset;
                    LoanRec.SetRange("Loan No.", Rec."Loan No.");
                    if LoanRec.FindFirst then
                        Report.Run(Report::"Loan Repay Schedule Full Date", true, false, LoanRec);
                end;
            }
            action("Disbursement Letter")
            {
                ApplicationArea = Basic;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LoanTopUp: Record "Loan Top Up";
                    PostedLoan: Record Loans;
                begin
                    PostedLoan.Reset();
                    PostedLoan.SetRange("Loan No.", Rec."Loan No.");
                    if not PostedLoan.FindFirst() then
                        exit;

                    LoanTopUp.Reset();
                    LoanTopUp.SetRange("Loan No.", PostedLoan."Loan No.");
                    // Old check only tested if a top-up line existed:
                    // if LoanTopUp.FindFirst() then
                    LoanTopUp.SetFilter("Total Top Up", '>0');

                    if LoanTopUp.FindFirst() then
                        // Old call passed the page Rec directly:
                        // Report.Run(Report::"Top Up Disbursement Letter", true, false, Rec)
                        Report.Run(Report::"Top Up Disbursement Letter", true, false, PostedLoan)
                    else
                        if PostedLoan."Type of Disbursement" = PostedLoan."Type of Disbursement"::"Partial Disbursement" then
                            // Old call passed the page Rec directly:
                            // Report.Run(Report::"Partial Disbursement Letter", true, false, Rec)
                            Report.Run(Report::"Partial Disbursement Letter", true, false, PostedLoan)
                        else
                            // Old call passed the page Rec directly:
                            // Report.Run(Report::"Loan Disbursement letter", true, false, Rec)
                            Report.Run(Report::"Loan Disbursement letter", true, false, PostedLoan);
                end;
            }

            action("Repayment Schedule")
            {
                ApplicationArea = Basic;
                Visible = false;
                trigger OnAction()
                begin

                    LoanRec.Reset;
                    LoanRec.SetRange("Loan No.", Rec."Loan No.");
                    if LoanRec.FindFirst then
                        Report.Run(Report::"Static Loan Repayment Schedule", true, false, LoanRec);
                end;

            }
            group("Defaulter Notices")
            {
                Image = ResourcePlanning;
            }
            action("Defaulter Notice-1")
            {
                ApplicationArea = Basic;
                Caption = 'Defaulter Notice-1';
                Image = DefaultFault;
                Promoted = true;
                PromotedCategory = category5;

                trigger OnAction()
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then begin
                        Report.Run(Report::"Defaulter Notice-1", true, false, LoanApp)
                    end;
                end;
            }
            action("Defaulter Notice-2")
            {
                ApplicationArea = Basic;
                Caption = 'Defaulter Notice-2';
                Image = FaultDefault;
                Promoted = true;
                PromotedCategory = category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    HasGuarantors: Boolean;
                    HasCollateral: Boolean;
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then begin
                        HasGuarantors := HasSecurityType(LoanApp."Loan No.", true);
                        HasCollateral := HasSecurityType(LoanApp."Loan No.", false);

                        if HasGuarantors then
                            Report.Run(Report::"Second DemandLetter-Guarantors", true, false, LoanApp);

                        if HasCollateral then
                            Report.Run(Report::"Second Demand Letter -Security", true, false, LoanApp);

                        if (not HasGuarantors) and (not HasCollateral) then
                            Report.Run(Report::"Defaulter Notice-2", true, false, LoanApp)
                    end;
                end;
            }

            action("Second Demand Letter - Guarantors")
            {
                ApplicationArea = Basic;
                Caption = 'Second Demand Letter - Guarantors';
                Image = Print;
                Promoted = true;
                PromotedCategory = category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then
                        Report.Run(Report::"Second DemandLetter-Guarantors", true, false, LoanApp);
                end;
            }

            action("Second Demand Letter - Security")
            {
                ApplicationArea = Basic;
                Caption = 'Second Demand Letter - Security';
                Image = Print;
                Promoted = true;
                PromotedCategory = category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then
                        Report.Run(Report::"Second Demand Letter -Security", true, false, LoanApp);
                end;
            }

            action("Defaulter Final Notice-3")
            {
                ApplicationArea = Basic;
                Caption = 'Defaulter Final-3';
                Image = LimitedCredit;
                Promoted = true;
                PromotedCategory = category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    //LoanApp.SETRANGE(LoanApp."Member No", Rec."Member No");
                    if LoanApp.Find('-') then begin
                        Report.Run(Report::"Defaulter Notice-3", true, false, LoanApp)
                    end;
                    //"Loan Group":=TODAY;
                    //MODIFY;
                end;
            }

            action("First Demand Letter Savings-4")
            {
                ApplicationArea = Basic;
                Caption = 'First Demand Letter-Loan Within Savings';
                Image = Print;
                Promoted = true;
                PromotedCategory = category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then
                        Report.Run(Report::"First Demand Letter Savings", true, false, LoanApp);
                end;
            }
            action("First Demand Letter Security-6")
            {
                ApplicationArea = Basic;
                Caption = 'First Demand Letter - With Security';
                Image = Print;
                Promoted = true;
                PromotedCategory = category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then
                        Report.Run(Report::"First Demand Letter Security", true, false, LoanApp);
                end;
            }
            action("First Demand Letter Security-7")
            {
                ApplicationArea = Basic;
                Caption = 'First Demand Letter - With Guarantors';
                Image = Print;
                Promoted = true;
                PromotedCategory = category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then
                        Report.Run(Report::"First Demand Letter Guarantors", true, false, LoanApp);
                end;
            }
            action("Statutory Notice-Security-8")
            {
                ApplicationArea = Basic;
                Caption = 'Statutory Notice-1';
                Image = Print;
                Promoted = true;
                PromotedCategory = category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SelectedSecurity: Record "Loan Security";
                begin
                    LSecurity.Reset();
                    LSecurity.SetRange("Loan No.", Rec."Loan No.");
                    LSecurity.SetRange("Guarantor Type", LSecurity."Guarantor Type"::Collateral);
                    LSecurity.SetRange(Substituted, false);
                    if LSecurity.FindSet() then
                        repeat
                            SelectedSecurity := LSecurity;
                            SelectedSecurity.SetRecFilter();
                            Report.Run(Report::"Statutory Notice-1", true, false, SelectedSecurity);
                        until LSecurity.Next() = 0;
                end;
            }

            action("Statutory Notice-Security-9")
            {
                ApplicationArea = Basic;
                Caption = 'Statutory Notice-2';
                Image = Print;
                Promoted = true;
                PromotedCategory = category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SelectedSecurity: Record "Loan Security";
                begin
                    LSecurity.Reset();
                    LSecurity.SetRange("Loan No.", Rec."Loan No.");
                    LSecurity.SetRange("Guarantor Type", LSecurity."Guarantor Type"::Collateral);
                    LSecurity.SetRange(Substituted, false);
                    if LSecurity.FindSet() then
                        repeat
                            SelectedSecurity := LSecurity;
                            SelectedSecurity.SetRecFilter();
                            Report.Run(Report::"Statutory Notice-2", true, false, SelectedSecurity);
                        until LSecurity.Next() = 0;
                end;
            }

        }
    }
    trigger OnAfterGetRecord()
    begin
        UpdateFields;
    end;

    trigger OnAfterGetCurrRecord()
    begin

        CurrPage.Update;
        UpdateFields();
    end;

    trigger OnOpenPage()
    begin

        IntToDate := SaccoActivities.GetInterestDue(Rec, Today);

        UpdateFields();
    end;

    local procedure UpdateFields()
    begin
        CEOComments := Rec.GetCEOComment();
        AppraiserComments := Rec.GetAppraiserComment();
        CreditCommitteeComments := Rec.GetCreditCommitteeComment();
        BoardComments := Rec.GetBoardComment();
    end;

    local procedure HasSecurityType(LoanNo: Code[20]; IsGuarantor: Boolean): Boolean
    var
        LoanSecurityRec: Record "Loan Security";
    begin
        if LoanNo = '' then
            exit(false);

        LoanSecurityRec.Reset();
        LoanSecurityRec.SetRange("Loan No.", LoanNo);
        LoanSecurityRec.SetRange(Substituted, false);
        if IsGuarantor then
            LoanSecurityRec.SetRange("Guarantor Type", LoanSecurityRec."Guarantor Type"::Guarantor)
        else
            LoanSecurityRec.SetRange("Guarantor Type", LoanSecurityRec."Guarantor Type"::Collateral);

        exit(LoanSecurityRec.FindFirst());
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        StyleTxt: Text;
        CreditCommitteeComments: Text;
        AppraiserComments: Text;
        BoardComments: Text;
        CEOComments: Text;
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
        LoanSecurity: Record "Shipment Method";
        LoanRec: Record Loans;
        LSecurity: Record "Loan Security";
        Appraisal: Record "Loan Appraisal";
        SendBool: Boolean;
        CancelBool: Boolean;
        SaccoActivities: Codeunit "Sacco Activities";
        IntToDate: Decimal;
        LoanApp: Record Loans;
}



