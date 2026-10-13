
/// <summary>
/// Page Loan Application Card (ID 50192).
/// </summary>
Page 50192 "Loan Application Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Caption = 'Loan Disbursement Card';

    PageType = Card;
    SourceTable = Loans;
    PromotedActionCategories = 'New,Process,Report,Loan Security,Loan Charges,LoanTopUp & Clearances,Approval Request,Bank Details,Post Loan,Upload File,View File,Member Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = true;


                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field("Group  Code"; Rec."Group Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    Editable = false;
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
                    Editable = false;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SubTypeVisible := Rec.HasSubType;
                    end;
                }

                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                group("Product Sub Type")
                {
                    Editable = false;
                    Visible = SubTypeVisible;
                    field(ProductSubType; Rec."Product Sub Type")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Salary Appraisal No."; Rec."Salary Appraisal No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Loan Application No.';
                    ShowMandatory = true;
                }
                field("Relationship Officer"; Rec."Relationship Officer")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }

                field(TopUpType; Rec."Top Up Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    Editable = false;
                    Visible = false;
                }
                field(LoanProductTypeName; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(InterestCalculationMethod; Rec."Interest Calculation Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AnnualInterest; Rec."Annual Interest %")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RegistrationFee; Rec."Registration Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Use Special Multiplier"; Rec."Use Special Multiplier")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(AmountApplied; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = false;

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
                    Editable = false;
                }
                field(AmountToDisburse; Rec."Amount To Disburse")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Business Income Amount"; Rec."Business Income Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'The average income earned by a member with a business in the last six months';
                }
                field("Main Sector Code"; Rec."Main Sector Code")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Main Sector Description"; Rec."Main Sector Description")
                {
                    ApplicationArea = Basic;

                    Editable = false;
                }
                field("Sub-Sector Level 1 Code"; Rec."Sub-Sector Level 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub-Sector Level 1 Description"; Rec."Sub-Sector Level 1 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Sub-Sector Level 2 Code"; Rec."Sub-Sector Level 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub-Sector Level 2 Description"; Rec."Sub-Sector Level 2 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RecoveryMode; Rec."Repay Mode")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DepositBoostingOption; Rec."Deposit Boosting Option")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Deposit Boosting"; Rec."Deposit Boosting")
                {
                    Caption = 'Deposit Boosted';
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field(ShareFinancing; Rec."Share Capital Boosting")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        if Rec."Share Capital Boosting" < 0 then
                            Error('Share Financing Cannot be equal to Zero');
                    end;
                }
                field("Deposit Boosting Commission"; Rec."Deposit Boosting Commission")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Adjusted Repayment"; Rec."Adjusted Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
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
                field("Deposit Contribution"; Rec."Deposit COntribution")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Repayment; Rec.Repayment + Rec."Deposit COntribution" + Rec."Total Insurance")
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
                    Editable = false;
                    Visible = false;
                }
                field("Self Guarantee"; Rec."Self Guarantee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
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
                field("Fee Waiver Applied"; Rec."Fee Waiver Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    Caption = 'Account Manager';
                }
                field(RepaymentFrequency; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(DisbursementDate; Rec."Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(RepaymentStartDate; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("Schedule Start"; Rec."Schedule Start")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Loan Moratorium Start Date"; Rec."Loan Moratorium Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                }
                field("Loan Moratorium End Date"; Rec."Loan Moratorium End Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(ScheduleStartDate; Rec."Schedule Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                }
                field(CompletionDate; Rec."Completion Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }


                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Upfront Days"; Rec."Upfront Days")
                {
                    applicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Visible = false;

                }
                field("Upfront Interest Charge"; Rec."Upfront Interest Charge")
                {
                    applicationArea = Basic;
                    Editable = false;
                    enabled = false;
                    Visible = false;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Appraised By"; Rec."Appraised By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RecommendedbyType; Rec."Recommended by Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(RecommendedBy; Rec."Recommended By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(RecommendedByName; Rec."Recommended By Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(TotalGuaranteed; Rec."Total Guaranteed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Top Up Amount"; Rec."Top Up Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Charges."; Rec."Loan Charges")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("External Clearance"; Rec."External Clearance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Net To Be Disbursed"; Rec."Net To Be Disbursed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                group("Comments")
                {
                    Editable = false;
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
                        Editable = BoardCommentsEditable;
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
                    Editable = true;
                    SubPageLink = "Loan No." = field("Loan No.");
                    UpdatePropagation = Both;
                }
            }
            group(BankDetails)
            {
                Editable = false;

                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }

                field("Bank Branch"; Rec."Bank Branch")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }

            }

            part(LoanSecurity; "Loan Security Part")
            {
                Caption = 'LoanSecurity';
                Editable = Rec.Status <> Rec.Status::Approved;
                SubPageLink = "Loan No." = field("Loan No.");
            }
            part(LoanTop; "Loan TopUp Part")
            {
                Caption = 'Loan TopUp';
                Editable = Rec.Status <> Rec.Status::Approved;
                SubPageLink = "Loan No." = field("Loan No."), "Member No." = field("Member No.");
            }

            part(Control46; "Loan Charges")
            {
                Editable = false;
                SubPageLink = "Loan No." = field("Loan No.");
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
                              "No." = field("Document Ref. No.");

            }
            part(Control3; "Picture & Signature")
            {
                SubPageLink = "Member No." = field("Member No.");
            }
            part(Control63; "Info Base")
            {
                Caption = 'Loan Client Interaction';
                SubPageLink = "Member No." = field("Member No."), "Account No." = field("Loan No.");
            }
            part(Control64; "Board Approval Entries")
            {
                Caption = 'Loan Client Interaction';
                SubPageLink = "Document No." = field("Loan No.");
            }
            part(Control1900919607; "Dimension Set Entries FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Dimension Set ID" = field("Dimension Set ID");
                Visible = true;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group(Reports)
            {
                Caption = 'Reports';

                action("Loan Payment Voucher")
                {
                    ApplicationArea = Basic;
                    Image = AnalysisView;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Report;

                    trigger OnAction()
                    begin

                        Commit;
                        MemberActivities.SetLoanAppraisal(Rec."Loan No.");
                        Commit;

                        Appraisal.Reset;
                        Appraisal.SetRange("Loan No.", Rec."Loan No.");
                        if Appraisal.FindFirst then
                            Report.Run(Report::"Loan PV", true, false, Appraisal);
                    end;
                }
                action("Loan Appraisal Report New")
                {
                    ApplicationArea = Basic;
                    Image = AnalysisView;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Report;

                    trigger OnAction()
                    var
                        AppraisalNew: Record "Member Salary Appraisal";
                    begin

                        AppraisalNew.Reset;
                        AppraisalNew.SetRange("Appraisal No.", Rec."Salary Appraisal No.");
                        if AppraisalNew.FindFirst then
                            Report.Run(Report::"Loan Salary Appraisal", true, false, AppraisalNew);
                    end;
                }
                action(AppraisalBack)
                {
                    ApplicationArea = Basic;
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
                action("Loan Schedule Report")
                {
                    ApplicationArea = Basic;
                    Image = Link;
                    Promoted = true;
                    PromotedCategory = Report;

                    trigger OnAction()
                    begin

                        SaccoActivities.GenerateRepaymentSchedule(Rec);
                        Commit;

                        LoanRec.Reset;
                        LoanRec.SetRange("Loan No.", Rec."Loan No.");
                        if LoanRec.FindFirst then
                            Report.Run(Report::"Loan Repay Schedule Full Date", true, false, LoanRec);
                    end;
                }
                action("Revised Member Statement")
                {
                    ApplicationArea = Basic;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    Visible = False;

                    trigger OnAction()
                    var
                        Members: Record Members;
                    begin
                        Members.Reset;
                        Members.SetRange("No.", Rec."Member No.");
                        if Members.FindFirst then
                            Report.Run(50276, true, false, Members);
                    end;
                }
                action("Member Statement")
                {
                    ApplicationArea = Basic;
                    Image = StyleSheet;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Members: Record Members;
                    begin
                        Members.Reset;
                        Members.SetRange("No.", Rec."Member No.");
                        if Members.FindFirst then
                            Report.Run(Report::"Detailed Member Statement", true, false, Members);
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
                action("Loan Appraisal Report")
                {
                    ApplicationArea = Basic;
                    Image = AnalysisView;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    var
                        AppraisalNew: Record "Member Salary Appraisal";
                    begin

                        Commit;
                        MemberActivities.SetLoanAppraisal(Rec."Loan No.");
                        Commit;

                        AppraisalNew.Reset;
                        AppraisalNew.SetRange("Appraisal No.", Rec."Salary Appraisal No.");
                        if AppraisalNew.FindFirst then
                            Report.Run(Report::"Loan Salary Appraisal", true, false, AppraisalNew);

                    end;
                }
                action("Term Loan Offer Letter")
                {
                    ApplicationArea = Basic;
                    Image = StyleSheet;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                    //Members: Record Members;
                    begin
                        LoanRec.Reset;
                        LoanRec.SetRange("Loan No.", Rec."Loan No.");
                        if LoanRec.FindFirst then
                            Report.Run(Report::"Term Loan-Offer Letter", true, false, LoanRec);
                    end;
                }

                action("Disbursement Letter")
                {
                    ApplicationArea = Basic;
                    Image = Link;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        LoanTopUp: Record "Loan Top Up";
                        LoanCharge: Record "Loan Charges";
                    begin
                        LoanRec.Reset;
                        LoanRec.SetRange("Loan No.", Rec."Loan No.");
                        if LoanRec.FindFirst then begin

                            LoanTopUp.Reset();
                            LoanTopUp.SetRange("Loan No.", LoanRec."Loan No.");
                            LoanTopUp.SetFilter("Total Top Up", '>0');

                            // Old selection only checked full vs partial disbursement:
                            // case LoanRec."Type of Disbursement" of
                            //     LoanRec."Type of Disbursement"::"Full Disbursement":
                            //         Report.Run(Report::"Loan Disbursement Letter", true, false, LoanRec);
                            //     LoanRec."Type of Disbursement"::"Partial Disbursement":
                            //         Report.Run(Report::"Partial Disbursement Letter", true, false, LoanRec);
                            //     else
                            //         Message('No disbursement letter available for this type of disbursement');
                            // end;

                            if LoanTopUp.FindFirst() then begin

                                LoanCharge.Reset();
                                LoanCharge.SetRange("Loan No.", Rec."Loan No.");
                                LoanCharge.SetRange("Charge Code", 'PFEE');
                                if LoanCharge.FindFirst() then;

                                if (LoanTopUp.Commision = 0) and (LoanCharge.Amount = 0) then
                                    Report.Run(Report::"Top Up Disbursement No Charge", true, false, LoanRec)
                                else
                                    Report.Run(Report::"Top Up Disbursement Letter", true, false, LoanRec)

                            end else
                                if LoanRec."Type of Disbursement" = LoanRec."Type of Disbursement"::"Partial Disbursement" then
                                    Report.Run(Report::"Partial Disbursement Letter", true, false, LoanRec)
                                else begin
                                    LoanCharge.Reset();
                                    LoanCharge.SetRange("Loan No.", LoanRec."Loan No.");
                                    LoanCharge.SetRange("Charge Code", 'PFEE');
                                    if not LoanCharge.FindFirst() then begin
                                        Report.Run(Report::"Loan Disbur. Without Charges", true, false, LoanRec);
                                    end else
                                        Report.Run(Report::"Loan Disbursement letter", true, false, LoanRec);
                                end;

                        end;
                    end;
                }

            }
        }


        area(navigation)
        {
            action(Dimensions)
            {
                AccessByPermission = TableData Dimension = R;
                ApplicationArea = Dimensions;
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Alt+D';
                Promoted = true;
                PromotedCategory = New;
                Visible = false;
                PromotedIsBig = true;
                ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                trigger OnAction()
                begin
                    Rec.ShowDimensions();
                    CurrPage.SaveRecord();
                end;
            }
            action("Loan Witness")
            {
                ApplicationArea = Basic;
                Image = SetPriorities;
                Promoted = true;
                Visible = false;
                PromotedCategory = New;
                RunObject = Page "Loan Witness";
                RunPageLink = "Loan No." = field("Loan No.");
            }
            action("Salary Details")
            {
                ApplicationArea = Basic;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = New;
                Visible = false;
                RunObject = Page "Salary Details";
                RunPageLink = "Loan No" = field("Loan No.");
            }

            action("Bank Account List")
            {
                ApplicationArea = All;
                Image = SetPriorities;
                Promoted = true;
                Visible = false;
                PromotedCategory = Category8;
                RunObject = Page "HR Bank Accounts List";
                RunPageLink = "Loan No." = field("Loan No.");

            }
            action("Partial Disbusement Dates")
            {
                ApplicationArea = Basic;
                Image = PriceAdjustment;
                Visible = false;
                Promoted = true;
                PromotedCategory = new;
                RunObject = Page "Partial Disbursement Dates";
                RunPageLink = "Loan No." = field("Loan No.");
            }
            action("Arrears Recovery")
            {
                ApplicationArea = Basic;
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "Arrears Recovery";
                RunPageLink = "Application No." = field("Loan No."), "Member No." = field("member no.");
            }
            action("Loan Security")
            {
                ApplicationArea = Basic;
                Image = SelectChart;
                Promoted = true;
                PromotedCategory = category4;
                RunObject = Page "Loan Security";
                RunPageLink = "Loan No." = field("Loan No.");
            }
            action("Loan Charges")
            {
                ApplicationArea = Basic;
                Image = Costs;
                Promoted = true;
                PromotedCategory = category5;
                RunObject = Page "Loan Charges";
                RunPageLink = "Loan No." = field("Loan No."),
                              "Loan Product Type" = field("Loan Product Type");
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
            action("Other Clearances")
            {
                ApplicationArea = Basic;
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "Other Commitments Clearance";
                RunPageLink = "Loan Application No." = field("Loan No.");
            }
            action("Post Loan")
            {
                ApplicationArea = Basic;
                Image = PostApplication;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                //VALARIE: CLIENT DOES NOT WANT TO SEND FOR APPROVAL, THEY WANT TO POST DIRECTLY. CODE COMMENTED OUT BELOW
                //SEARCH: POST DIRECTLY
                //Visible = Rec.Status = Rec.Status::Approved;
                Visible = SendBool;

                trigger OnAction()
                var
                    NetAmt: Decimal;
                    UserSetup: Record "User Setup";
                    //VALARIE: CLIENT DOES NOT WANT TO SEND FOR APPROVAL, THEY WANT TO POST DIRECTLY. VARS ADDED BELOW
                    //SEARCH: POST DIRECTLY
                    TopUp: Record "Loan Top Up";
                    Lns: Record Loans;
                begin

                    UserSetup.Get(UserId);
                    if not UserSetup."Post Loan" then
                        Error('You have not been setup to disbursement loans.[Post Loan]');

                    //VALARIE: MOVED FROM SEND FOR APPROVAL INCASE OF CHECKS; ALSO ADDED FOR THE LOAN STATUS TO CHANGE TO APPROVED
                    //SEARCH: POST DIRECTLY
                    //STARTT
                    CheckControls;

                    SendNotifications;


                    UpdateSmsCharge;
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

                    //START
                    //STOP


                    Rec.TestField(Posted, false);
                    //VALARIE: CODE BELOW COMMENTED FOR CLIENT TO POST DIRECTLY
                    //SEARCH: POST DIRECTLY
                    //Rec.TestField(Status, Rec.Status::Approved);

                    Rec.Validate("Disbursement Date");
                    // if "Mode of Disbursement" = "Mode of Disbursement"::"Transfer to Fosa" then
                    //  TestField("Disbursement Account No");

                    if Confirm('Are you sure you want to post this loan?') then begin
                        Rec.Status := Rec.Status::Approved;
                        SaccoActivities.PostLoan(Rec."Loan No.", Rec."Loan No.", false, NetAmt, Rec."Disbursement Date");
                    end;

                    CurrPage.Close();
                end;
            }
            action("Get Adjusted Approved Amount")
            {
                ApplicationArea = Basic;
                Image = ValidateEmailLoggingSetup;
                Promoted = false;
                Visible = false;
                //PromotedCategory = Category9;
                //PromotedIsBig = false;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.TestField(Posted, false);
                    Rec.TestField(Status, Rec.Status::Open);

                    if Confirm('Are you sure you want to Get Adjusted Approved Amount for this loan?') then begin
                        Rec.GetAdjustedApprovedAmount();
                    end;
                end;
            }
            action("Upload File to Azure")
            {
                ApplicationArea = All;
                Caption = 'Upload File';
                Image = Import;
                Enabled = true;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category10;

                trigger OnAction()
                var
                    InStr: InStream;
                    OutStr: OutStream;
                    FileName: Text;
                    SaccoSetup: Record "Sacco Setup";
                    Document: Record "Cloud Document Attachment";
                    DMS_: Codeunit EDMS;
                    Directory: Text;
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Get(UserId);

                    if not UserSetup."Upload File" then
                        Error('Permission Denied. User does not have permission to upload files![Upload Files]');


                    //Check if Already Uploaded
                    if Rec."Azure Path" <> '' then begin

                        if not UserSetup."Overwrite Upload File" then
                            Error('Permission Denied. User does not have permission to overwite uploaded files![Overwrite Upload Files]');

                        if not Confirm('Document Already Upload. DO you want to upload again?') then
                            Error('Aborted');
                    end;

                    //Add Permission to ennsure only the user who initially uploaded the document is the one uploading again. 

                    //Set File Name
                    Rec."Document File Name" := Rec."Loan No." + '-' + Rec."Member No." + '.pdf';

                    //Set Directory
                    Directory := 'SaccoFIles/Loans/' + Rec."Loan No." + '/';

                    //Set Full FIle Path
                    Rec."Document Path" := Directory + Rec."Document File Name";
                    Rec.Modify;

                    //Upload to Blob Field
                    Rec.Blob.CREATEINSTREAM(InStr, TextEncoding::WINDOWS);

                    UploadBlobToRecord;
                    //(We dont need this unless we want to save the file in the database as well)

                    DMS_.NewUploadFileToBlob(Rec."Document Path", InStr, Rec."Azure Path");
                    //DMS_.NewUploadFileToBlob(SaccoSetup."Azure Path", InStr, SaccoSetup."Azure Storage Path");

                end;
            }

            action("Upload Loan Documents")
            {
                ApplicationArea = All;
                Image = Import;
                Enabled = true;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category10;
                Visible = false;

                RunObject = Page "CBS Uploads";
                RunPageLink = "Loan Application No." = field("Loan No."),
                              "Member No." = field("Member No.");

                trigger OnAction()
                var
                    InStr: InStream;
                    OutStr: OutStream;
                    FileName: Text;
                    SaccoSetup: Record "Sacco Setup";
                    Document: Record "Cloud Document Attachment";
                    DMS_: Codeunit EDMS;
                    Directory: Text;
                    UserSetup: Record "User Setup";
                begin




                end;
            }
            action("View File")
            {
                ApplicationArea = All;
                Caption = 'View File';
                Image = View;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    Document: Record "Cloud Document Attachment";
                    DMS_: Codeunit EDMS;
                begin

                    // Ensure the required fields are populated
                    Rec.TESTFIELD("Document Path");

                    // Example SAS token (typically securely stored)
                    // Download and show the document
                    DMS_.NewDownloadFileFromBlob(Rec."Document Path");
                end;
            }
            action("Member Card")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Category11;
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
                    PromotedCategory = Category7;
                    //VALARIE: CLIENT DOES NOT WANT TO SEND FOR APPROVAL, THEY WANT TO POST DIRECTLY CODE COMMENTED BELOW
                    //SEARCH: POST DIRECTLY
                    //Visible = SendBool;
                    visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        DocumentType: Enum "Custom Document Type";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        TopUp: Record "Loan Top Up";
                        Lns: Record Loans;
                    begin

                        CheckControls;

                        SendNotifications;


                        UpdateSmsCharge;
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

    trigger OnAfterGetCurrRecord()
    begin
        UpdateFields;

    end;

    trigger OnAfterGetRecord()
    begin
        UpdateFields;
    end;

    trigger OnOpenPage()
    begin
        UpdateFields;
    end;

    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin
        if Rec.Posted then
            Error('You cannot modify posted record!!');
    end;


    procedure UploadBlobToRecord()
    var
        InStr: InStream;
        OutStr: OutStream;
        FileName: Text;
    begin
        if UploadIntoStream('', '', '', FileName, InStr) then begin
            Rec.Blob.CreateOutStream(OutStr);
            CopyStream(OutStr, InStr);
            Rec.Modify();
        end;


    end;

    var
        CreditCommitteeComments: Text;
        AppraiserComments: Text;
        BoardComments: Text;
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
        SubTypeVisible: Boolean;
        CEOComments: Text;
        BoardCommentsEditable: Boolean;

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


        /*

                if SMTPSetup.Get then begin

                    CompanyInfo.Get;
                    SenderName := CompanyInfo.Name;
                    SenderAddress := SMTPSetup."User ID";
                    if SenderName = '' then
                        SenderName := COMPANYNAME;

                            if SaccoActivities.ValidEmailAddress(SenderAddress) then begin
                                 SMTP.CreateMessage(SenderName, SenderAddress, Member."E-Mail", 'LOAN APPLICATION: ' + UpperCase(SenderName), '', true);


                                 //SMTP.AppendBody('<img src="data:image/png;base64,'+MemberActivities.Base64Header+'" alt="Red dot" />');
                                 //SMTP.AppendBody('<br><br>');
                                 SMTP.AppendBody('Dear ' + Member.Name);
                                 SMTP.AppendBody('<br><br>');
                                 SMTP.AppendBody('We have received your ' + ProductSetup.Description + ' of KES ' + Format("Requested Amount") + '. If Approved it will be disbursed into your Account.');
                                 SMTP.AppendBody('<br><br>');
                                 LoanSecurity.Reset;
                                 LoanSecurity.SetRange("Loan No.", "Loan No.");
                                 LoanSecurity.SetRange("SMS Sent", false);
                                 LoanSecurity.SetFilter("Account No.", '<>%1', '');
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
                                         SMTP.AppendBody('<td>' + Format(LoanSecurity."Guarantor Type") + '</td>');
                                         SMTP.AppendBody('<td>' + LoanSecurity."Account No." + '</td>');
                                         SMTP.AppendBody('<td>' + LoanSecurity."Collateral Reg. No." + '</td>');
                                         SMTP.AppendBody('<td>' + LoanSecurity.Name + '</td>');
                                         SMTP.AppendBody('<td>' + Format(LoanSecurity."Amount Guaranteed") + '</td>');
                                         SMTP.AppendBody('</tr>');

                                     until LoanSecurity.Next = 0;
                                     SMTP.AppendBody('</table>');

                                 end;

                                 SMTP.AppendBody('<br><br>');
                                 SMTP.AppendBody('Kind Regards,');
                                 SMTP.AppendBody('<br>');
                                 SMTP.AppendBody('<hr>');


                                 if SMTP.TrySend then;Rec.


                             end;
                end;*/



        /*SaccoSetup.get;
        LoanSecurity.Reset;
        LoanSecurity.SetRange("Loan No.", "Loan No.");
        LoanSecurity.SetFilter("Account No.", '<>%1', '');
        if LoanSecurity.FindFirst then begin
            repeat
                if Member.Get(LoanSecurity."Member No") then begin

                    Msg := 'Dear ' + Member.Name + ', You have guaranteed ' + "Member Name" + ' ' + ProductSetup.Description + ' of KES ' + Format("Requested Amount") +
                            ' an Amount of KES ' + Format(LoanSecurity."Amount Guaranteed") + '. Call ' + SaccoSetup."Sacco Contacts" + ' if in dispute.';

                    //TestField("Disbursement Account No");
                    if LoanSecurity."Member No" <> "Member No." then
                        MemberActivities.SendSms(Smssource::"Loan Guarantors", Member."Mobile Phone No.", Msg, "Loan No.", "Disbursement Account No", true, false);

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
                                        end;Rec.*/

        /*end;
                until LoanSecurity.Next = 0;
            end;*/

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

        if Rec."Loan Product Type" <> 'L07' then begin
            Rec.calcFields("Total Guaranteed");
            if Rec."Amount To Disburse" > Rec."Total Guaranteed" then
                Error(
                    'Amount to disburse %1 cannot be greater than total amount guaranteed %2.',
                    Rec."Amount To Disburse",
                    Rec."Total Guaranteed"
                );
        end;

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
        Rec.CheckMultipleRunningLoanAllowed();
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
                if (TopUp."Interest Top Up" + TopUp."Appraisal Top Up" + TopUp."Principle Top Up") > Loans."Total Outstanding Balance" then
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

}

