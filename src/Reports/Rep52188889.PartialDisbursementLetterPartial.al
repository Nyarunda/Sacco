namespace UnitedWomen.UnitedWomen;

using Microsoft.HumanResources.Employee;
using System.Security.User;
using Microsoft.Foundation.Company;

report 50591 "Partial Disbursement-Partial"
{
    ApplicationArea = All;
    Caption = 'Partial Disbursement Letter-partial';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './src/Layouts/PartialDisbursment-partial-updated-fixed.docx';

    dataset
    {
        dataitem(Loans; Loans)
        {
            column(LoanNo; "Loan No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(NetToBeDisbursed; "Net To Be Disbursed")
            {
            }
            column(DisbursementDate; PostingDate)
            {
            }
            column(DisbursementDate_; "Disbursement Date")
            {
            }
            column(Repayment_Start_Date; "Repayment Start Date")
            {
            }
            column(Loan_Product_Type_Name; ProductDescription)
            {
            }
            column(Sub_Sector_Level_2_Description; "Sub-Sector Level 2 Description")
            {
            }
            column(TopupInt; TopupInt)
            {
            }
            column(PrincipalTopUp; PrincipalTopUp)
            {
            }
            column(CreditOfficerName; CreditOfficerName)
            {
            }
            column(CreditOfficerPost; CreditOfficerPost)
            {
            }
            column(Amount_To_Disburse; GetFirstPartialDisbursedAmount(Loans."Loan No."))
            {
            }
            column(CurrentPartialDisbursementAmount; GetCurrentPartialDisbursementAmount())
            {
            }
            column(Approved_Amount; "Approved Amount")
            {
            }
            column(Installments; Loans.Installments)
            {
            }
            column(MemberEmail; MemberEmail)
            {
            }
            column(Repayment; Repayment)
            {
            }
            column(FirstName; FirstName)
            {
            }
            column(Loan_Interest_Repayment; "Loan Interest Repayment")
            {
            }
            column(Total_Monthly_Repayment; "Total Monthly Repayment")
            {
            }
            column(GetLastDay; UpperCase(Format(GetLastDay, 0, '<Month Text> <Year4>')))
            {
            }
            column(LetterDate; Today)
            {
            }
            column(RepaymentNotice; RepaymentNotice)
            {
            }
            column(RepaymentNoticeAmount; RepaymentNoticeAmount)
            {
            }
            column(RepaymentNoticeMonth; RepaymentNoticeMonth)
            {
            }
            column(RepaymentNoticeInstallmentDueDate; RepaymentNoticeInstallmentDueDate)
            {
            }
            column(RepaymentNoticeClause; RepaymentNoticeClause)
            {
            }
            column(CEOSignature; CompanyInformation."CEO Signature")
            {
            }

            dataitem("Partial Loans Disb. Header"; "Partial Loans Disb. Header")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = where(Status = filter(<> Rejected));
                column(LineNo; PartialLineNo)
                {
                }
                column(PartialLoanNo; "Loan No.")
                {
                }
                column(PartialDisbursementAccNo; "Disbursement Account No")
                {
                }
                column(PartialDisbursementDate; "Posting Date")
                {
                }
                column(PartialDisbursementAmount; PartialDisbursementAmount)
                {
                }
                column(TotalDisbursed2Date; CumulativeDisbursedAmount)
                {
                }
                column(PartialRemarks; PartialText)
                {
                }
                column(RepayAmount; RepayAmount)
                {
                }
                trigger OnPreDataItem()
                begin
                    //SetRange(Status, Status::Approved);
                    //SetRange(Posted, true);

                    PartialLineNo := 1;
                    CumulativeDisbursedAmount := GetFirstPartialDisbursedAmount(Loans."Loan No.");


                    SetFilter(Reversed, '%1', false);
                    SetFilter(Status, '%1|%2|%3', Status::Open, Status::Pending, Status::Approved);
                end;

                trigger OnAfterGetRecord()
                begin

                    if not PartialDisbursementHeaderStatusCanPrint("Partial Loans Disb. Header".Status) then
                        CurrReport.Skip();

                    PartialLineNo += 1;
                    PartialDisbursementAmount := GetPartialDisbursementAmount("No.");

                    //if PartialLineNo = 2 then
                    CumulativeDisbursedAmount += PartialDisbursementAmount;

                    RepayAmount := 0;
                    PartialLoansDisbLine.Reset();
                    PartialLoansDisbLine.SetRange("Header No.", "Partial Loans Disb. Header"."No.");
                    if PartialLoansDisbLine.FindLast() then
                        RepayAmount := PartialLoansDisbLine."New Repyament Amount";


                    PartialText := '';
                    HRBanks.Reset();
                    HRBanks.SetRange("Loan No.", "Partial Loans Disb. Header"."No.");
                    if HRBanks.FindFirst() then
                        PartialText := HRBanks.Remarks;

                end;
            }

            dataitem("HR Employee Bank Accounts"; "HR Employee Bank Accounts")
            {
                DataItemTableView = sorting("Line No.", "Loan No.");

                column(BankLineNo; BankLineNo)
                {
                }
                column(BankDisbursementDate; BankDisbursementDate)
                {
                }
                column(BankModeOfDisbursement; "Mode of Disbursement")
                {
                }
                column(BankDisbursementAccountNo; "Disbursement Account No.")
                {
                }
                column(BankChequeNo; "Cheque No.")
                {
                }
                column(BankCode; "Bank Code")
                {
                }
                column(BankName; "Bank Name")
                {
                }
                column(BankBranchCode; "Branch Code")
                {
                }
                column(BankBranchName; "Branch Name")
                {
                }
                column(BankAccountNo; "A/C Number")
                {
                }
                column(BankAmountToTransfer; "Amount to Transfer")
                {
                }
                column(BankCumulativeAmount; BankCumulativeAmount)
                {
                }
                column(BankRemarks; Remarks)
                {
                }

                // Compatibility names for the copied Word table row.
                column(LineNo_Bank; BankLineNo)
                {
                }
                column(PartialDisbursementDate_Bank; BankDisbursementDate)
                {
                }
                column(PartialDisbursementAmount_Bank; "Amount to Transfer")
                {
                }
                column(TotalDisbursed2Date_Bank; BankCumulativeAmount)
                {
                }
                column(PartialRemarks_Bank; Remarks)
                {
                }

                trigger OnPreDataItem()
                var
                    HeaderNoFilter: Text;
                begin
                    HeaderNoFilter := GetCurrentPartialHeaderNoFilter(Loans."Loan No.");
                    if HeaderNoFilter = '' then begin
                        CurrReport.Break();
                        exit;
                    end;

                    SetFilter("Loan No.", HeaderNoFilter);
                    BankLineNo := 0;
                    BankCumulativeAmount := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    if not PartialDisbursementHeaderCanPrint("HR Employee Bank Accounts"."Loan No.") then
                        CurrReport.Skip();

                    BankLineNo += 1;
                    BankDisbursementDate := GetPartialHeaderPostingDate("Loan No.");
                    BankCumulativeAmount += "Amount to Transfer";
                end;
            }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if CompanyInformation.Get() then
                    CompanyInformation.CalcFields("CEO Signature");
            end;

            trigger OnAfterGetRecord()
            var
                LoanTopUp: Record "Loan Top Up";
                MemberRec: Record Members;
                MemberAct: Codeunit "Member Activities";
                Partialheader: Record "Partial Loans Disb. Header";
                PartialLines: Record "Partial Loans Disb. Lines";
            begin
                Clear(PrincipalTopUp);
                Clear(TopupInt);
                Clear(MemberEmail);
                Clear(FirstName);
                Clear(CreditOfficerName);
                Clear(CreditOfficerPost);
                Clear(RepaymentNotice);
                Clear(RepaymentNoticeAmount);
                Clear(RepaymentNoticeMonth);
                Clear(RepaymentNoticeInstallmentDueDate);
                Clear(RepaymentNoticeClause);

                LoanTopUp.Reset();
                LoanTopUp.SetRange("Loan No.", Loans."Loan No.");
                if LoanTopUp.FindFirst() then begin
                    PrincipalTopUp := LoanTopUp."Principle Top Up";
                    TopupInt := LoanTopUp."Total Top Up" - LoanTopUp."Principle Top Up";
                end;

                GetLastDay := CalcDate('CM', Loans."Repayment Start Date");

                usersetup.Reset();
                usersetup.SetRange("Is CEO", true);
                if usersetup.FindFirst() then
                    if Employee.Get(usersetup."Staff No") then begin
                        CreditOfficerName := Employee.FullName();
                        CreditOfficerPost := Employee."Job Title";
                    end;

                if MemberRec.Get("Member No.") then begin
                    MemberEmail := MemberRec."E-Mail";
                    FirstName := MemberAct.GetMemberFirstName(MemberRec.Name);
                end;


                Partialheader.Reset();
                if CurrentPartialHeaderNo <> '' then
                    Partialheader.SetRange("No.", CurrentPartialHeaderNo)
                else
                    Partialheader.SetRange("Loan No.", Loans."Loan No.");
                Partialheader.SetFilter(Status, '%1|%2|%3', Partialheader.Status::Open, Partialheader.Status::Pending, Partialheader.Status::Approved);
                if Partialheader.FindLast() then begin

                    PostingDate := Partialheader."Posting Date";

                    BankAccounts.Reset();
                    BankAccounts.SetRange("Loan No.", Partialheader."No.");
                    BankAccounts.SetFilter(Remarks, '<>%1', '');
                    if BankAccounts.FindLast() then
                        PartialText := BankAccounts.Remarks;

                    PartialLines.Reset();
                    PartialLines.SetRange("Header No.", Partialheader."No.");
                    if PartialLines.FindLast() then begin

                        if PartialLines."Remaining Period" > 0 then
                            Installments := Loans.Installments;

                        if PartialLines."New Repyament Amount" > 0 then begin
                            RepaymentNotice := Format(Today);
                            RepaymentNoticeAmount := PartialLines."New Repyament Amount";
                            RepaymentNoticeMonth := Format(Today, 0, '<Month Text,3> <Year4>');
                            RepaymentNoticeInstallmentDueDate := Format(CalcDate('CM', Today));
                            RepaymentNoticeClause := StrSubstNo(
                                'Kindly note that you will be required to pay Kshs. %1 on or before %2 being the %3 installment.',
                                RepaymentNoticeAmount,
                                RepaymentNoticeInstallmentDueDate,
                                RepaymentNoticeMonth);
                        end;

                    end;
                end;

                ProductDescription := UpperCase(Loans."Loan Product Type Name");

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    var
        BankAccounts: Record "HR Employee Bank Accounts";
        PartialLoansDisbLine: Record "Partial Loans Disb. Lines";
        HRBanks: Record "HR Employee Bank Accounts";
        ProductDescription: Text[100];
        RepayAmount: Decimal;
        PrincipalTopUp: Decimal;
        TopupInt: Decimal;
        CreditOfficerPost: Text;
        CreditOfficerName: Text;
        Employee: Record Employee;
        usersetup: Record "User Setup";
        MemberEmail: Text;
        FirstName: Text;
        GetLastDay: Date;
        PartialLineNo: Integer;
        PostingDate: Date;
        PartialDisbursementAmount: Decimal;
        CumulativeDisbursedAmount: Decimal;
        BankLineNo: Integer;
        BankDisbursementDate: Date;
        BankCumulativeAmount: Decimal;
        PartialText: Text[100];
        RepaymentNotice: Text;
        RepaymentNoticeAmount: Decimal;
        RepaymentNoticeMonth: Text;
        RepaymentNoticeInstallmentDueDate: Text;
        RepaymentNoticeClause: Text;
        PartialLoansDisbHeader: Record "Partial Loans Disb. Header";
        CompanyInformation: Record "Company Information";
        CurrentPartialHeaderNo: Code[20];

    procedure SetPartialHeaderNo(PartialHeaderNo: Code[20])
    begin
        CurrentPartialHeaderNo := PartialHeaderNo;
    end;

    local procedure GetPartialDisbursementAmount(HeaderNo: Code[20]): Decimal
    var
        HeaderAmount: Decimal;
    begin
        PartialLoansDisbLine.Reset();
        PartialLoansDisbLine.SetRange("Header No.", HeaderNo);
        if PartialLoansDisbLine.FindSet() then
            repeat
                PartialLoansDisbHeader.Reset();
                PartialLoansDisbHeader.SetRange("No.", PartialLoansDisbLine."Header No.");
                PartialLoansDisbHeader.SetFilter(Status, '%1|%2|%3', PartialLoansDisbHeader.Status::Open, PartialLoansDisbHeader.Status::Pending, PartialLoansDisbHeader.Status::Approved);
                if PartialLoansDisbHeader.FindSet() then begin
                    PartialLoansDisbHeader.CalcFields(Reversed);
                    if PartialLoansDisbHeader.Reversed = false then
                        HeaderAmount += PartialLoansDisbLine."Amount to Disbuse";
                end;
            until PartialLoansDisbLine.Next() = 0;

        exit(HeaderAmount);
    end;

    local procedure GetCurrentPartialDisbursementAmount(): Decimal
    var
        LatestPartialHeader: Record "Partial Loans Disb. Header";
    begin
        if CurrentPartialHeaderNo <> '' then
            exit(GetPartialDisbursementAmount(CurrentPartialHeaderNo));

        // Backward-compatible fallback for direct report runs that do not pass a header.
        // The partial-disbursement card always passes the current header.
        LatestPartialHeader.SetRange("Loan No.", Loans."Loan No.");
        LatestPartialHeader.SetFilter(Status, '<>%1', LatestPartialHeader.Status::Rejected);
        if LatestPartialHeader.FindLast() then
            if PartialDisbursementHeaderCanPrint(LatestPartialHeader) then
                exit(GetPartialDisbursementAmount(LatestPartialHeader."No."));

        exit(0);
    end;

    local procedure GetFirstPartialDisbursedAmount(LoanNo: Code[20]): Decimal
    var
        FirstPartialHeader: Record "Partial Loans Disb. Header";
        FirstPartialLine: Record "Partial Loans Disb. Lines";
    begin
        FirstPartialHeader.Reset();
        FirstPartialHeader.SetCurrentKey("Loan No.", "Posting Date", "Document Date", "No.");
        FirstPartialHeader.SetRange("Loan No.", LoanNo);
        FirstPartialHeader.SetFilter(Status, '%1|%2|%3', FirstPartialHeader.Status::Open, FirstPartialHeader.Status::Pending, FirstPartialHeader.Status::Approved);
        FirstPartialHeader.SetFilter(Reversed, '%1', false);
        if FirstPartialHeader.FindSet() then
            repeat
                FirstPartialLine.Reset();
                FirstPartialLine.SetRange("Header No.", FirstPartialHeader."No.");
                FirstPartialLine.SetRange("Loan No.", LoanNo);
                if FirstPartialLine.FindFirst() then
                    exit(FirstPartialLine."Disbused Amount");
            until FirstPartialHeader.Next() = 0;

        exit(Loans."Amount To Disburse");
    end;

    local procedure GetPartialHeaderNoFilter(LoanNo: Code[20]): Text
    var
        HeaderNoFilter: Text;
    begin
        PartialLoansDisbHeader.Reset();
        PartialLoansDisbHeader.SetRange("Loan No.", LoanNo);
        PartialLoansDisbHeader.SetFilter(Status, '%1|%2|%3', PartialLoansDisbHeader.Status::Open, PartialLoansDisbHeader.Status::Pending, PartialLoansDisbHeader.Status::Approved);
        if PartialLoansDisbHeader.FindSet() then
            repeat
                PartialLoansDisbHeader.CalcFields(Reversed);
                if PartialLoansDisbHeader.Reversed = false then begin
                    if HeaderNoFilter <> '' then
                        HeaderNoFilter += '|';
                    HeaderNoFilter += PartialLoansDisbHeader."No.";
                end;
            until PartialLoansDisbHeader.Next() = 0;

        exit(HeaderNoFilter);
    end;

    local procedure GetAllPartialHeaderNoFilter(LoanNo: Code[20]): Text
    var
        HeaderNoFilter: Text;
    begin
        PartialLoansDisbHeader.Reset();
        PartialLoansDisbHeader.SetRange("Loan No.", LoanNo);
        PartialLoansDisbHeader.SetFilter(Status, '<>%1', PartialLoansDisbHeader.Status::Rejected);
        if PartialLoansDisbHeader.FindSet() then
            repeat
                PartialLoansDisbHeader.CalcFields(Reversed);
                if not PartialLoansDisbHeader.Reversed then begin
                    if HeaderNoFilter <> '' then
                        HeaderNoFilter += '|';
                    HeaderNoFilter += PartialLoansDisbHeader."No.";
                end;
            until PartialLoansDisbHeader.Next() = 0;

        exit(HeaderNoFilter);
    end;

    local procedure GetCurrentPartialHeaderNoFilter(LoanNo: Code[20]): Text
    var
        PartialLoansDisbHeader2: Record "Partial Loans Disb. Header";
    begin
        if CurrentPartialHeaderNo <> '' then begin
            if PartialDisbursementHeaderCanPrint(CurrentPartialHeaderNo) then
                exit(CurrentPartialHeaderNo);
            exit('');
        end;

        PartialLoansDisbHeader2.Reset();
        PartialLoansDisbHeader2.SetRange("Loan No.", LoanNo);
        PartialLoansDisbHeader2.SetFilter(Status, '<>%1', PartialLoansDisbHeader2.Status::Rejected);
        if PartialLoansDisbHeader2.FindLast() then
            repeat
                if PartialDisbursementHeaderCanPrint(PartialLoansDisbHeader2) then
                    exit(PartialLoansDisbHeader2."No.");
            until PartialLoansDisbHeader2.Next(-1) = 0;

        exit('');
    end;

    local procedure GetPartialHeaderPostingDate(HeaderNo: Code[20]): Date
    var
        PartialLoansDisbHeader: Record "Partial Loans Disb. Header";
    begin
        if PartialLoansDisbHeader.Get(HeaderNo) then
            if PartialLoansDisbHeader.Status <> PartialLoansDisbHeader.Status::Rejected then
                if PartialDisbursementHeaderCanPrint(PartialLoansDisbHeader) then
                    exit(PartialLoansDisbHeader."Posting Date");

        exit(0D);
    end;

    local procedure PartialDisbursementHeaderCanPrint(HeaderNo: Code[20]): Boolean
    var
        PartialLoansDisbHeader: Record "Partial Loans Disb. Header";
    begin
        if not PartialLoansDisbHeader.Get(HeaderNo) then
            exit(false);

        exit(PartialDisbursementHeaderCanPrint(PartialLoansDisbHeader));
    end;

    local procedure PartialDisbursementHeaderCanPrint(var PartialLoansDisbHeader: Record "Partial Loans Disb. Header"): Boolean
    begin
        PartialLoansDisbHeader.CalcFields(Reversed);
        exit((not PartialLoansDisbHeader.Reversed) and PartialDisbursementHeaderStatusCanPrint(PartialLoansDisbHeader.Status));
    end;

    local procedure PartialDisbursementHeaderStatusCanPrint(HeaderStatus: Option Open,Pending,Approved,Rejected): Boolean
    begin
        exit(HeaderStatus in [HeaderStatus::Open, HeaderStatus::Pending, HeaderStatus::Approved]);
    end;


}
