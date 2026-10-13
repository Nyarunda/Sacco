namespace UnitedWomen.UnitedWomen;

using Microsoft.Foundation.Company;

report 50606 "Appraisal Back Page Partial"
{
    ApplicationArea = All;
    Caption = 'Appraisal Back Page Partial Current Deposits';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Appraisal Back Page Partial.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(PartialHeader; "Partial Loans Disb. Header")
        {
            CalcFields = "Amount to Disburse", "Member Name", "Loan Product Name";
            RequestFilterFields = "No.", "Loan No.", "Member No.";

            column(ReportForNavId_Header; 1)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(LoanProductName; "Loan Product Name")
            {
            }
            column(TotalLoanAmountApproved; TotalLoanAmountApproved)
            {
            }
            column(RepaymentTerm; RepaymentTerm)
            {
            }

            dataitem("Loan Guarantors and Security"; "Loan Security")
            {
                UseTemporary = true;

                column(ReportForNavId_60; 60)
                {
                }
                column(GuarantorLineNo; GuarantorLineNo)
                {
                }
                column(GuarantorType; "Guarantor Type")
                {
                }
                column(GuarantorMemberNo; "Loan Guarantors and Security"."Member No")
                {
                }
                column(GuarantorName; SecDetails)
                {
                }
                column(GuarantorDeposits; GuarantorDeposits)
                {
                }
                column(PriorGuaranteeAmount; PriorGuaranteeAmount)
                {
                }
                column(LoanGuaranteeAmount; LoanGuaranteeAmount)
                {
                }
                column(GuarantorRowKey; GuarantorRowKey)
                {
                }

                trigger OnPreDataItem()
                begin
                    GuarantorLineNo := 0;
                    LoadLoanSecurityLines(PartialHeader."Loan No.");
                end;

                trigger OnAfterGetRecord()
                var
                    SavingsAccount: Record "Savings Accounts";
                    Collateral: Record "Loan Collateral Register";
                    LoanSecurityBuffer: Record "Loan Security Buffer";
                begin
                    PriorGuaranteeAmount := 0;
                    LoanGuaranteeAmount := "Loan Guarantors and Security"."Amount Guaranteed";
                    if "Loan Guarantors and Security"."Guarantor Type" = "Loan Guarantors and Security"."Guarantor Type"::Collateral then
                        GuarantorDeposits := "Loan Guarantors and Security"."Collateral Value"
                    else
                        GuarantorDeposits := GetMemberDepositBalance("Loan Guarantors and Security"."Member No");
                    Clear(SecDetails);
                    GuarantorLineNo += 1;
                    GuarantorRowKey := CopyStr(Format("Loan Guarantors and Security".RecordId), 1, MaxStrLen(GuarantorRowKey));
                    if SavingsAccount.Get("Loan Guarantors and Security"."Account No.") then
                        SecDetails := CopyStr("Loan Guarantors and Security".Name + ' - ' + SavingsAccount."Product Name", 1, MaxStrLen(SecDetails))
                    else begin
                        if Collateral.Get("Loan Guarantors and Security"."Collateral Reg. No.") then begin
                            SecDetails := CopyStr("Loan Guarantors and Security".Name + ' - ' + Collateral."Vehicle Reg. No." + Collateral.Remarks, 1, MaxStrLen(SecDetails));
                            if "Loan Guarantors and Security"."Guarantor Type" = "Loan Guarantors and Security"."Guarantor Type"::Collateral then
                                GuarantorDeposits := Collateral."Collateral Value";
                        end else
                            SecDetails := CopyStr("Loan Guarantors and Security".Name, 1, MaxStrLen(SecDetails));
                    end;

                    PriorGuaranteeAmount := GetPriorGuarantorCommitment("Loan Guarantors and Security");

                    if LoanSecurityExists("Loan Guarantors and Security"."Loan No.", "Loan Guarantors and Security"."Member No") then begin
                        LoanSecurityBuffer.Reset();
                        LoanSecurityBuffer.SetRange("Member No", "Loan Guarantors and Security"."Member No");
                        LoanSecurityBuffer.SetRange("Loan No.", "Loan Guarantors and Security"."Loan No.");
                        if LoanSecurityBuffer.FindSet() then
                            repeat
                                LoanGuaranteeAmount += LoanSecurityBuffer."Amount Guaranteed";
                            until LoanSecurityBuffer.Next() = 0;
                    end;
                end;
            }

            dataitem(PostedPartialHeader; "Partial Loans Disb. Header")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = sorting("Loan No.", "Posting Date", "Document Date", "No.");

                column(ReportForNavId_PostedPartial; 10)
                {
                }
                column(PostedPartialLineNo; PostedPartialLineNo)
                {
                }
                column(PostedPartialDate; "Posting Date")
                {
                }
                column(PostedPartialCurrentDeposits; PostedPartialCurrentDeposits)
                {
                }
                column(PostedPartialLoanBalanceAfterPayment; PostedPartialLoanBalanceAfterPayment)
                {
                }
                column(PostedPartialAmountDisbursed; PostedPartialAmountDisbursed)
                {
                }
                column(PostedPartialNewLoanBalance; PostedPartialNewLoanBalance)
                {
                }
                column(PostedPartialRemainingTerm; PostedPartialRemainingTerm)
                {
                }

                trigger OnPreDataItem()
                begin
                    PostedPartialLineNo := 0;
                    SetFilter(Status, '%1|%2|%3', Status::Open, Status::Pending, Status::Approved);
                    SetRange(Reversed, false);
                end;

                trigger OnAfterGetRecord()
                var
                    PartialLine: Record "Partial Loans Disb. Lines";
                begin
                    CalcFields(Reversed);
                    if Reversed then
                        CurrReport.Skip();

                    PartialLine.Reset();
                    PartialLine.SetRange("Header No.", "No.");
                    PartialLine.SetRange("Loan No.", "Loan No.");
                    if not PartialLine.FindFirst() then
                        CurrReport.Skip();

                    PostedPartialLineNo += 1;
                    PostedPartialCurrentDeposits := GetMemberDepositBalance("Member No.");
                    PostedPartialLoanBalanceAfterPayment := PartialLine."Outstanding Principal";
                    PartialLine.CalcSums("Amount to Disbuse");
                    PostedPartialAmountDisbursed := PartialLine."Amount to Disbuse";
                    PostedPartialNewLoanBalance := PostedPartialLoanBalanceAfterPayment + PostedPartialAmountDisbursed;
                    PostedPartialRemainingTerm := PartialLine."Remaining Period";
                end;
            }

            dataitem(BankDisbursementDetails; "HR Employee Bank Accounts")
            {
                DataItemLink = "Loan No." = field("No.");
                DataItemTableView = sorting("Line No.", "Loan No.");

                column(ReportForNavId_BankDetails; 20)
                {
                }
                column(BankLineNo; BankLineNo)
                {
                }
                column(BankChequeNo; "Cheque No.")
                {
                }
                column(BankName; GetBankDisplayName(BankDisbursementDetails))
                {
                }
                column(BankAmount; "Amount to Transfer")
                {
                }
                column(BankDate; "Disbursement Date")
                {
                }

                trigger OnPreDataItem()
                begin
                    BankLineNo := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    BankLineNo += 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                Loan: Record Loans;
            begin
                Clear(TotalLoanAmountApproved);
                Clear(RepaymentTerm);

                if Loan.Get("Loan No.") then begin
                    TotalLoanAmountApproved := Loan."Approved Amount";
                    RepaymentTerm := Loan.Installments;
                end;
            end;
        }
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    local procedure GetMemberDepositBalance(MemberNo: Code[20]): Decimal
    var
        SavingsAccount: Record "Savings Accounts";
        DepositBalance: Decimal;
    begin
        if MemberNo = '' then
            exit(0);

        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", MemberNo);
        SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Deposit Contribution");
        SavingsAccount.SetAutoCalcFields("Balance (LCY)");
        if SavingsAccount.FindSet() then
            repeat
                DepositBalance += SavingsAccount."Balance (LCY)";
            until SavingsAccount.Next() = 0;

        exit(DepositBalance);
    end;

    local procedure GetBankDisplayName(BankAccountLine: Record "HR Employee Bank Accounts"): Text[100]
    begin
        if BankAccountLine."Disbursement Bank Name" <> '' then
            exit(BankAccountLine."Disbursement Bank Name");

        if BankAccountLine."Bank Name" <> '' then
            exit(BankAccountLine."Bank Name");

        exit(Format(BankAccountLine."Mode of Disbursement"));
    end;

    local procedure GetPriorGuarantorCommitment(CurrentLoanSecurity: Record "Loan Security"): Decimal
    var
        OtherLoanSecurity: Record "Loan Security";
        PriorCommitment: Decimal;
    begin
        PriorCommitment := 0;

        OtherLoanSecurity.Reset();
        OtherLoanSecurity.SetRange("Member No", CurrentLoanSecurity."Member No");
        OtherLoanSecurity.SetRange("Guarantor Type", CurrentLoanSecurity."Guarantor Type");
        OtherLoanSecurity.SetRange("Account No.", CurrentLoanSecurity."Account No.");
        OtherLoanSecurity.SetRange("Collateral Reg. No.", CurrentLoanSecurity."Collateral Reg. No.");
        OtherLoanSecurity.SetFilter("Loan No.", '<>%1', CurrentLoanSecurity."Loan No.");
        OtherLoanSecurity.SetFilter("Amount Guaranteed", '>%1', 0);
        OtherLoanSecurity.SetRange(Substituted, false);
        OtherLoanSecurity.SetFilter("Outstanding Principal", '>0');
        if OtherLoanSecurity.FindSet() then
            repeat
                if (OtherLoanSecurity.RecordId <> CurrentLoanSecurity.RecordId) and
                   (not IsLoanBeingToppedUp(CurrentLoanSecurity."Loan No.", OtherLoanSecurity."Loan No."))
                then
                    PriorCommitment += OtherLoanSecurity."Current Committed";
            until OtherLoanSecurity.Next() = 0;

        exit(PriorCommitment);
    end;

    local procedure IsLoanBeingToppedUp(CurrentLoanNo: Code[20]; PriorLoanNo: Code[20]): Boolean
    var
        AppraisalTopUp: Record "Appraisal Top Up";
        LoanTopUp: Record "Loan Top Up";
    begin
        AppraisalTopUp.Reset();
        AppraisalTopUp.SetRange("Loan No.", CurrentLoanNo);
        AppraisalTopUp.SetRange("Loan Top Up", PriorLoanNo);
        if AppraisalTopUp.FindFirst() then
            exit(true);

        LoanTopUp.Reset();
        LoanTopUp.SetRange("Loan No.", CurrentLoanNo);
        LoanTopUp.SetRange("Loan Top Up", PriorLoanNo);
        exit(LoanTopUp.FindFirst());
    end;

    local procedure LoadLoanSecurityLines(LoanNo: Code[20])
    var
        RealLoanSecurity: Record "Loan Security";
        LoanSecurityBuffer: Record "Loan Security Buffer";
    begin
        "Loan Guarantors and Security".Reset();
        "Loan Guarantors and Security".DeleteAll();

        RealLoanSecurity.Reset();
        RealLoanSecurity.SetRange("Loan No.", LoanNo);
        RealLoanSecurity.SetRange(Substituted, false);
        if RealLoanSecurity.FindSet() then
            repeat
                "Loan Guarantors and Security".Init();
                "Loan Guarantors and Security".TransferFields(RealLoanSecurity);
                "Loan Guarantors and Security".Insert();
            until RealLoanSecurity.Next() = 0;

        LoanSecurityBuffer.Reset();
        LoanSecurityBuffer.SetRange("Loan No.", LoanNo);
        if LoanSecurityBuffer.FindSet() then
            repeat
                if not LoanSecurityExists(LoanSecurityBuffer."Loan No.", LoanSecurityBuffer."Member No") then begin
                    InsertBufferLoanSecurityLine(LoanSecurityBuffer);
                end;
            until LoanSecurityBuffer.Next() = 0;
    end;

    local procedure InsertBufferLoanSecurityLine(BufferLoanSecurity: Record "Loan Security Buffer")
    var
        SavingsAccount: Record "Savings Accounts";
        Member: Record Members;
    begin
        "Loan Guarantors and Security".Init();
        "Loan Guarantors and Security"."Loan No." := BufferLoanSecurity."Loan No.";
        "Loan Guarantors and Security"."Member No" := BufferLoanSecurity."Member No";
        "Loan Guarantors and Security"."Amount Guaranteed" := BufferLoanSecurity."Amount Guaranteed";
        "Loan Guarantors and Security"."Current Committed" := BufferLoanSecurity."Amount Guaranteed";
        "Loan Guarantors and Security"."Guarantor Type" := "Loan Guarantors and Security"."Guarantor Type"::Guarantor;

        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", BufferLoanSecurity."Member No");
        SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Deposit Contribution");
        SavingsAccount.SetAutoCalcFields("Balance (LCY)");
        if SavingsAccount.FindFirst() then begin
            "Loan Guarantors and Security"."Account No." := SavingsAccount."No.";
            "Loan Guarantors and Security".Name := SavingsAccount.Name;
            "Loan Guarantors and Security"."Guarantor Deposits" := SavingsAccount."Balance (LCY)";
        end else
            if Member.Get(BufferLoanSecurity."Member No") then
                "Loan Guarantors and Security".Name := Member.Name;

        "Loan Guarantors and Security".Insert();
    end;

    local procedure LoanSecurityExists(LoanNo: Code[20]; MemberNo: Code[20]): Boolean
    var
        LoanSecurity: Record "Loan Security";
    begin
        LoanSecurity.Reset();
        LoanSecurity.SetRange("Loan No.", LoanNo);
        LoanSecurity.SetRange("Member No", MemberNo);
        exit(LoanSecurity.FindFirst());
    end;

    var
        CompanyInfo: Record "Company Information";
        BankLineNo: Integer;
        GuarantorLineNo: Integer;
        GuarantorRowKey: Text[250];
        PriorGuaranteeAmount: Decimal;
        PostedPartialLineNo: Integer;
        PostedPartialAmountDisbursed: Decimal;
        PostedPartialCurrentDeposits: Decimal;
        PostedPartialLoanBalanceAfterPayment: Decimal;
        PostedPartialNewLoanBalance: Decimal;
        PostedPartialRemainingTerm: Integer;
        RepaymentTerm: Integer;
        TotalLoanAmountApproved: Decimal;
        LoanGuaranteeAmount: Decimal;
        GuarantorDeposits: Decimal;
        SecDetails: Text[2048];
}
