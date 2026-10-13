
Page 50220 "Member Account Card"
{
    ApplicationArea = All;
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Savings Accounts";
    PromotedActionCategories = 'New,Process,Report,FD Accounts,Nominee';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(ProductCategory; Rec."Product Category")
                {
                    ApplicationArea = Basic;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(ProductName; Rec."Product Name")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;
                }
                field("Signing Instructions Narration"; Rec."Signing Instructions Narration")
                {
                    ApplicationArea = Basic;
                }
                field("ATM No"; ATMNo)
                {

                }
                field("Virtual Account No."; Rec."Virtual Account No.")
                {

                }
                field("Virtual Balance (LCY)"; Rec."Virtual Balance (LCY)")
                {

                }

                field("ATM Delinked By"; Rec."ATM Delinked By")
                {

                }
                field("Date Delinked"; Rec."Date Delinked")
                {

                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field(MonthlyContribution; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic;
                }
                field(BalanceLCY; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(MobilePhoneNo; Rec."Mobile Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(PayrollStaffNo; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                group("Junior Account")
                {
                    Visible = JuniorBool;
                    field(ChildName; Rec."Child Name")
                    {
                        ApplicationArea = Basic;
                    }
                    field(ChildDateOfBirth; Rec."Child Date Of Birth")
                    {
                        ApplicationArea = Basic;
                    }
                    field(ChildBirthCetNo; Rec."Child Birth Cet. No.")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field(ChildAge; Rec."Child Age")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Child Age (Years)';
                    }
                    field("Piggy Bank Issued"; Rec."Piggy Bank Issued")
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
            group("Other Information")
            {
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1; "Mobile Loan Limit")
            {
                Visible = Rec."Product Category" = Rec."Product Category"::"Ordinary Savings";
                SubPageLink = "Account No." = field("No.");
            }
        }
        area(factboxes)
        {


            part(Control26; "Savings Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
            part(Control3; "Picture & Signature")
            {
                SubPageLink = "Member No." = field("Member No.");
                ApplicationArea = All;
                Visible = not JuniorBool;
            }
            Part(control4; "Junior Pic & Sign")
            {
                SubPageLink = "Junior Account No." = field("No.");
                Visible = JuniorBool;
                ApplicationArea = Basic, Suite;

            }
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Member Accounts Application"),
                              "No." = field("Document Ref. No."),
                              "Document Type" = field("Document Type");
            }
        }

    }

    actions
    {
        area(processing)
        {
            action("FD Accounts")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Fixed Deposit Accounts";
                RunPageLink = "Fixed Account No." = field("No.");
                Visible = FDBool;
            }
            action("Loan Limit")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                visible = false;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    myInt: Integer;
                    Sky: Codeunit "Sky MBanking";
                    QualAmt: Decimal;
                    Remark: Text;
                    RespCode: Text;
                begin
                    Remark := '';
                    QualAmt := 0;
                    Sky.GetLoanQualifiedAmount(Rec."No.", 'L05', QualAmt, Remark, RespCode);
                    Message(Remark + ': Limit - ' + Format(QualAmt));
                end;
            }
            action("Set Loan Limit")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                Visible = Rec."Product Category" = Rec."Product Category"::"Ordinary Savings";
                PromotedCategory = Process;
                RunObject = Page "Mobile Loan Limit";
                RunPageLink = "Account No." = field("No.");
            }
            action("Dividend Limit")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    myInt: Integer;
                    Sky: Codeunit "Sky MBanking";
                    QualAmt: Decimal;
                    Remark: Text;
                begin
                    Remark := '';
                    QualAmt := 0;
                    Sky.GetDividendLoanQualifiedAmount(Rec."No.", 'L16', QualAmt, Remark);
                    Message(Remark + ': Limit - ' + Format(QualAmt));
                end;
            }
            action("Loan Balance Request")
            {
                ApplicationArea = Basic;
                Image = FinChargeMemo;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    Loans: Record Loans;
                begin
                    Loans.Reset();
                    Loans.SetRange("Member No.", Rec."Member No.");
                    if Loans.FindFirst() then
                        Report.Run(Report::"Loan Balances Request", true, false, Loans);
                end;
            }
            action("Charge Statement")
            {
                ApplicationArea = Basic;
                Image = FinChargeMemo;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    Acc: Record "Savings Accounts";
                begin
                    Acc.Reset();
                    Acc.SetRange("No.", Rec."No.");
                    if Acc.FindFirst() then
                        Report.Run(Report::"Charge Statement", true, false, Acc);
                end;
            }
            action("Issue Piggy Bank")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                Visible = JuniorBool;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    if Confirm('Are you sure you want to Update Piggy Bank Issued Status') then begin
                        Rec.TestField("Product Category", Rec."Product Category"::"Junior Savings");
                        if Rec."Piggy Bank Issued" then begin
                            Rec."Piggy Bank Issued" := false;
                            Rec.Modify();
                            Message('Updated');

                        end
                        else begin

                            Rec."Piggy Bank Issued" := true;
                            Rec.Modify();
                            Message('Updated');

                        end;
                    end;
                end;
            }
            action("De-Link ATM")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    myInt: Integer;
                    SaccoPermissions: Record "User Setup";
                begin

                    SaccoPermissions.Reset;
                    SaccoPermissions.SetRange("User ID", UserId);
                    SaccoPermissions.SetRange("De-Link ATM", true);
                    if not SaccoPermissions.FindFirst then
                        Error('You do not have the following permission: "De-Link ATM"');

                    if Confirm('Are you sure you want to DeLink ATM') then begin
                        Rec.TestField("ATM No.");
                        Rec."ATM No." := '';
                        Rec."ATM Delinked By" := UserId;
                        Rec."Date Delinked" := Today;
                        Rec.Modify();
                        Message('Updated');

                    end;
                end;
            }
        }
        area(reporting)
        {
            action("Charge Ledger Fee")
            {
                ApplicationArea = Basic;
                Image = StyleSheet;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    ProductSetup: Record "Product Setup";
                begin

                    MemberAccounts.Reset;
                    MemberAccounts.SetRange("No.", Rec."No.");
                    if MemberAccounts.FindFirst then
                        Report.Run(Report::"Charge Ledger Fee", true, false, MemberAccounts);
                end;
            }
            action("Old Member Statement")
            {
                ApplicationArea = Basic;
                Image = StyleSheet;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    ProductSetup: Record "Product Setup";
                begin
                    if Rec."Customer Posting Group" = '' then begin
                        ProductSetup.Get(Rec."Product Type");
                        Rec."Customer Posting Group" := ProductSetup."Product Posting Group";
                        Rec.Modify();
                        Commit();
                    end;
                    MemberAccounts.Reset;
                    MemberAccounts.SetRange("No.", Rec."No.");
                    if MemberAccounts.FindFirst then
                        Report.Run(Report::"Old Savings Statement", true, false, MemberAccounts);
                end;
            }
            action("Account Statement")
            {
                ApplicationArea = Basic;
                Image = StyleSheet;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ProductSetup: Record "Product Setup";
                begin
                    
                    if Rec."Customer Posting Group" = '' then begin
                        ProductSetup.Get(Rec."Product Type");
                        Rec."Customer Posting Group" := ProductSetup."Product Posting Group";
                        Rec.Modify();
                        Commit();
                    end;

                    MemberAccounts.Reset;
                    MemberAccounts.SetRange("No.", Rec."No.");
                    if MemberAccounts.FindFirst then
                        Report.Run(Report::"Savings Statement", true, false, MemberAccounts);
                end;
            }
            action("Junior Acceptance Letter")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = JuniorBool;

                trigger OnAction()
                begin
                    Rec.TestField("Product Category", Rec."Product Category"::"Junior Savings");
                    Rec.TestField("Member No.");

                    MemberAccounts.Reset();
                    MemberAccounts.SetRange("No.", Rec."No.");
                    if MemberAccounts.FindFirst() then
                        Report.Run(Report::JuniorAcceptanceLetter, true, false, MemberAccounts);
                end;
            }
            action("PIN RESET")
            {
                ApplicationArea = Basic;
                RunObject = Page "Update PIN Change";
                RunPageLink = "Mobile No." = field("Transactional Mobile No");
            }
            action("Nominee")
            {
                ApplicationArea = Basic;
                Image = NewLotProperties;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                RunObject = Page Nominee;
                RunPageLink = "No." = field("No.");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls;
        if not UserSetup.Get(UserId) then
            Error('You Are Not SetUp As a User under User Setup');
        Rec.CalcFields("Member Category");

        if (Rec."Member Category" in [Rec."Member Category"::"Staff Members", Rec."Member Category"::"Board Members"]) then begin

            if Rec."Payroll/Staff No." = UserSetup."Staff No" then
                exit;

            if not UserSetup."View Staff Accounts" then
                Error('You Are Not SetUp to View Other Staff''s Accounts');
        end;

        if Rec."Member Category" = Rec."Member Category"::"Board Members" then begin
            if not UserSetup."View Board Accounts" then
                Error('You are not authorized to view board member accounts');
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;


    var
        JuniorBool: Boolean;
        FDBool: Boolean;
        MemberAccounts: Record "Savings Accounts";
        MemberActivities: Codeunit "Member Activities";
        UserSetup: Record "User Setup";
        Main: Record Members;
        ATMNo: Code[20];
        SAactivities: Codeunit "Sacco Activities";

    local procedure UpdateControls()
    begin

        ATMNo := '';
        if StrLen(Rec."ATM No.") = 16 then begin
            ATMNo := '**** **** **** ' + CopyStr(Rec."ATM No.", 13, 4)
        end;

        JuniorBool := false;
        FDBool := false;

        if Rec."Product Category" = Rec."product category"::"Junior Savings" then
            JuniorBool := true;

        if Rec."Product Category" = Rec."product category"::"Fixed Deposit" then
            FDBool := true;
    end;
}

