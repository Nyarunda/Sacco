namespace UnitedWomen.UnitedWomen;

page 50958 "Staff Application card"
{
    Caption = 'Staff Application Card';
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
                    Lookup = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        MemberFilterRec: Record Members;
                        SelectedMember: Record Members;
                        MemberRec: Record Members;
                        MemberListPage: Page "Member Listing";
                        SelectedMemberNo: Code[20];
                    begin
                        MemberFilterRec.Reset();
                        MemberFilterRec.SetRange("Member Category", MemberFilterRec."Member Category"::"Staff Members");

                        Clear(MemberListPage);
                        MemberListPage.LookupMode(true);
                        MemberListPage.SetTableView(MemberFilterRec);

                        if MemberListPage.RunModal() = Action::LookupOK then begin
                            Clear(SelectedMember);
                            MemberListPage.SetSelectionFilter(SelectedMember);

                            SelectedMemberNo := SelectedMember.GetFilter("No.");

                            if SelectedMemberNo = '' then
                                Error('No staff member was selected.');

                            if StrPos(SelectedMemberNo, '|') > 0 then
                                Error('Please select one staff member only.');

                            if not MemberRec.Get(SelectedMemberNo) then
                                Error('Selected member %1 was not found.', SelectedMemberNo);

                            if MemberRec."Member Category" <> MemberRec."Member Category"::"Staff Members" then
                                Error(
                                    'Only staff members are allowed on this staff appraisal card. Member %1 - %2 is %3.',
                                    MemberRec."No.",
                                    MemberRec.Name,
                                    Format(MemberRec."Member Category"));

                            // Very important:
                            // This prevents BC from revalidating the old value after lookup closes.
                            Text := MemberRec."No.";

                            Rec.Validate("Member No.", MemberRec."No.");

                            if MemberRec."Date of Birth" <> 0D then
                                MemberAge := Date2DMY(Today, 3) - Date2DMY(MemberRec."Date of Birth", 3)
                            else
                                MemberAge := 0;

                            CurrPage.Update(false);

                            exit(true);
                        end;

                        exit(false);
                    end;

                    trigger OnValidate()
                    var
                        MemberRec: Record Members;
                    begin
                        if Rec."Member No." = '' then begin
                            MemberAge := 0;
                            exit;
                        end;

                        if not MemberRec.Get(Rec."Member No.") then
                            Error('Member %1 does not exist.', Rec."Member No.");

                        if MemberRec."Member Category" <> MemberRec."Member Category"::"Staff Members" then
                            Error(
                                'Only staff members are allowed on this staff appraisal card. Member %1 - %2 is %3.',
                                MemberRec."No.",
                                MemberRec.Name,
                                Format(MemberRec."Member Category"));

                        if MemberRec."Date of Birth" <> 0D then
                            MemberAge := Date2DMY(Today, 3) - Date2DMY(MemberRec."Date of Birth", 3)
                        else
                            MemberAge := 0;
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
                field("Appraiser Comments"; Rec."Appraiser Comments")
                {
                    ApplicationArea = All;
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
                    Lookup = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ProductFilterRec: Record "Product Setup";
                        SelectedProduct: Record "Product Setup";
                        ProductRec: Record "Product Setup";
                        ProductSetupListPage: Page "Product Setup List";
                        SelectedProductId: Code[20];
                    begin
                        ProductFilterRec.Reset();
                        ProductFilterRec.SetRange("Product Class", ProductFilterRec."Product Class"::Credit);
                        ProductFilterRec.SetRange(Status, ProductFilterRec.Status::Active);
                        ProductFilterRec.SetRange("Loan Clients", ProductFilterRec."Loan Clients"::"Staff Members");

                        Clear(ProductSetupListPage);
                        ProductSetupListPage.LookupMode(true);
                        ProductSetupListPage.SetTableView(ProductFilterRec);

                        if ProductSetupListPage.RunModal() = Action::LookupOK then begin
                            Clear(SelectedProduct);
                            ProductSetupListPage.SetSelectionFilter(SelectedProduct);

                            // Same approach as Member lookup:
                            // the selected value may come back as a filter, not as record fields.
                            SelectedProductId := SelectedProduct.GetFilter("Product ID");

                            if not ProductRec.Get(SelectedProductId) then
                                Error('Selected loan product %1 was not found.', SelectedProductId);

                            //ValidateStaffLoanProduct(ProductRec);
                            Text := ProductRec."Product ID";

                            Rec.Validate("Loan Product Type", ProductRec."Product ID");

                            SubTypeVisible := Rec.HasSubType();

                            currPage.Update(false);

                            exit(true);
                        end;

                        exit(false);
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
                    enabled = Rec."Appraisal Type" <> Rec."Appraisal Type"::Staff;
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
                    Visible = VisibleApprovalAmount;
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

            group(SalaryDetails)
            {
                Caption = 'PART D - Salary Details';
                Visible = SalaryDetails;

                field("Basic Salary"; Rec."Basic Pay")
                {
                    ApplicationArea = All;
                    editable = false;
                    ToolTip = 'Specifies the value of the Basic Salary field.';
                }
                field("1/3 of Gross Pay"; Rec."1/3 of Gross Pay")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the 1/3 of Gross Pay field.';
                }
                field(NSSF; Rec.NSSF)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the NSSF field.';
                }
                field(NHIF; Rec.NHIF)
                {
                    caption = 'SHA Contributions';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the NHIF field.';
                }
                field("Housing Levy"; Rec."Housing Levy")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Housing Levy field.';
                }
                field(Pension; Rec.Pension)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Pension field.';
                }
                field(Tax; Rec.Tax)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Tax field.';
                }
                field("To Deduct"; Rec."To Deduct")
                {
                    caption = 'Total Deductions';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the To Deduct field.';
                }
                field("Net Salary"; Rec."Net Salary")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Net Salary field.';
                }
                field("BOSA Loans"; Rec."BOSA Loans")
                {
                    caption = 'Total BOSA Loans repayments';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the BOSA Loans field.';
                }
                field("BOSA Loan To Run At"; Rec."BOSA Loan To Run At")
                {
                    caption = 'BOSA Loan Eligibility';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the BOSA Loan To Run At field.';
                }
                field("Net Salary Multiplier %"; Rec."Net Salary Multiplier %")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Net Salary Multiplier field.';
                }
                field("Net Salary After Fosa Ded"; Rec."Net Salary After Fosa Ded")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Net Salary After Fosa Ded field.';
                }
                field("Qualification as Per Income"; Rec."Qualification as Per Income")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Qualification as Per Income field.';
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
            /* part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Member Salary Appraisal"),"No." = field("Appraisal No.");

            } */
        }
    }

    actions
    {
        area(navigation)
        {

            action("Send To Loan Registration")
            {
                ApplicationArea = Basic;
                Image = SendTo;
                Promoted = true;
                visible = true;
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
            action("Send Loan For Disbursement")
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
    trigger OnOpenPage()
    var
        myInt: Integer;
        ProductSetup: Record "Product Setup";
    begin

        if Rec."Appraisal Type" = Rec."Appraisal Type"::Business then begin
            BusinessAppraisal := true;
            SalaryDetails := false;
        end
        else begin
            BusinessAppraisal := false;
            if ProductSetup.Get(Rec."Loan Product Type") then
                if ProductSetup."Loan Clients" = ProductSetup."Loan Clients"::"Staff Members" then
                    SalaryDetails := true;
        end;

        //Rec.ApplyStaffLoanProductFilter();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // This does not insert anything by itself because the page is Editable = false.
        // It protects the page if you later allow insert/create from this list.
        Rec."Appraisal Type" := Rec."Appraisal Type"::Staff;
        Rec.ApplyStaffLoanProductFilter();
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
        ProductSetup: Record "Product Setup";
    begin

        if Rec."Appraisal Type" = Rec."Appraisal Type"::Business then begin
            BusinessAppraisal := true;
            SalaryDetails := false;
        end
        else begin
            BusinessAppraisal := false;
            if ProductSetup.Get(Rec."Loan Product Type") then
                if ProductSetup."Loan Clients" = ProductSetup."Loan Clients"::"Staff Members" then
                    SalaryDetails := true;
        end;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Rec.SetFilter("Appraisal Type", '%1', Rec."Appraisal Type"::Staff);
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

        VisibleApprovalAmount := false;
        if Rec."Loan Stage" in [Rec."Loan Stage"::"Loan Appraisal", Rec."Loan Stage"::"Loan Approval"] then
            VisibleApprovalAmount := true
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
        VisibleStaffApprisalFields: Boolean;
        VisibleApprovalAmount: Boolean;


}
