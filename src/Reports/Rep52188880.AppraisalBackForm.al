namespace UnitedWomen.UnitedWomen;
using Microsoft.Foundation.Company;

report 50582 "Appraisal Back Form"
{
    ApplicationArea = All;
    Caption = 'Appraisal Back Form';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Appraisal Back Form.rdlc';
    //RDLCLayout = './src/Layouts/Back Form.rdl';

    dataset
    {
        dataitem(MemberSalaryAppraisal; "Member Salary Appraisal")
        {
            CalcFields = "Total Charges", "CEO Comments", "Credit Committee Comments", "Appraiser Comments", "Board Comments";
            RequestFilterFields = "Appraisal No.";

            column(Picture; CI.Picture)
            {
            }
            column(C_Name; CI.Name)
            {
            }
            column(AppraisalNo; "Appraisal No.")
            {
            }
            column(OfficialUseDate; OfficialUseDate)
            {
            }
            column(MemberName; Name)
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(ShareDeposits; "Share Deposits")
            {
            }
            column(DepositMultiplier; "Deposit Multiplier")
            {
            }
            column(MaximumCredit; "Maximum Credit")
            {
            }
            column(MaxLoanAllowed; maxLoanAllowed)
            {
            }
            column(BOSALoanBalance; "BOSA Loan balance")
            {
            }
            column(QualificationAsPerDeposits; "Qualification As Per Deposits")
            {
            }
            column(ApprovedAmount; DisplayApprovedAmount)
            {
            }
            column(PrincipleTopup; PrincipleTopup)
            {
            }
            column(InterestTopup; InterestTopup)
            {
            }
            column(InsuranceTopup; InsuranceTopup)
            {
            }
            column(NetLoanTakeHome; "Net Loan Take Home")
            {
            }
            column(RepaymentTerm; Period)
            {
            }
            column(LoanOfficer; "Appraiser ID")
            {
            }
            column(ProcessingNotes; ProcessingNotesTxt)
            {
            }
            column(TypeOfDisbursement; Format("Type of Disbursement"))
            {
            }
            column(TotalCharges; "Total Charges" + RefinanceFees + "Commission Excise")
            {
            }
            column(RefinanceFees; RefinanceFees)
            {
            }
            column(LoanProcessingFees; LoanProcessingFees)
            {
            }
            column(ValuationFees; ValuationFees)
            {
            }
            column(LegalFees; LegalFees)
            {
            }
            column(ExciseDuty; ExciseDuty + "Commission Excise")
            {

            }
            column(ApplicantSignatureDate; "Applicant Signature Date")
            {
            }
            column(CEOComments; MemberSalaryAppraisal.GetCEOComment())
            {
            }
            column(CreditCommitteeComments; MemberSalaryAppraisal.GetCreditCommitteeComment())
            {
            }
            column(AppraiserComments; MemberSalaryAppraisal.GetAppraiserComment())
            {
            }
            column(BoardComments; MemberSalaryAppraisal.GetBoardComment())
            {
            }

            dataitem("Loan Guarantors and Security"; "Loan Security")
            {
                //DataItemTableView = where("Guarantor Type" = filter(Guarantor));

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
                column(GuarantorDeposits; "Loan Guarantors and Security"."Guarantor Deposits")
                {
                }
                column(PriorGuaranteeAmount; PriorGuaranteeAmount)
                {
                }
                column(LoanGuaranteeAmount; "Loan Guarantors and Security"."Amount Guaranteed")
                {
                }
                column(GuarantorRowKey; GuarantorRowKey)
                {
                }

                trigger OnPreDataItem()
                var
                    PostedLoan: Record Loans;
                    LoanNoFilter: Text[2048];
                begin
                    GuarantorLineNo := 0;
                    LoanNoFilter := MemberSalaryAppraisal."Appraisal No.";

                    /*   PostedLoan.Reset();
                      PostedLoan.SetRange("Salary Appraisal No.", MemberSalaryAppraisal."Appraisal No.");
                      if PostedLoan.FindSet() then
                          repeat
                              if StrPos('|' + LoanNoFilter + '|', '|' + PostedLoan."Loan No." + '|') = 0 then
                                  LoanNoFilter += '|' + PostedLoan."Loan No.";
                          until PostedLoan.Next() = 0; */

                    SetFilter("Loan No.", LoanNoFilter);
                end;

                trigger OnAfterGetRecord()
                var
                    SavingsAccount: Record "Savings Accounts";
                    Collateral: Record "Loan Collateral Register";
                begin
                    PriorGuaranteeAmount := 0;
                    Clear(SecDetails);
                    GuarantorLineNo += 1;
                    GuarantorRowKey := CopyStr(Format("Loan Guarantors and Security".RecordId), 1, MaxStrLen(GuarantorRowKey));
                    if SavingsAccount.Get("Loan Guarantors and Security"."Account No.") then
                        SecDetails := CopyStr("Loan Guarantors and Security".Name + ' - ' + SavingsAccount."Product Name", 1, MaxStrLen(SecDetails))
                    else begin
                        if Collateral.Get("Loan Guarantors and Security"."Collateral Reg. No.") then
                            SecDetails := CopyStr("Loan Guarantors and Security".Name + ' - ' + Collateral."Vehicle Reg. No." + Collateral.Remarks, 1, MaxStrLen(SecDetails))
                        else
                            SecDetails := CopyStr("Loan Guarantors and Security".Name, 1, maxStrLen(SecDetails));
                    end;

                    PriorGuaranteeAmount := GetPriorGuarantorCommitment("Loan Guarantors and Security");

                end;
            }

            dataitem("Current Loan Charges"; "Loan Charges")
            {
                DataItemLink = "Loan No." = field("Appraisal No.");

                column(ReportForNavId_66; 66)
                {
                }
                column(ChargeDescription; Description)
                {
                }
                column(ChargeAmount; Amount)
                {
                }
                column(ChargeExciseDuty; "Excise Duty")
                {
                }
                column(ChargeTotal; "Total Charge")
                {
                }
            }

            dataitem(EmployeeBankAccounts; "HR Employee Bank Accounts")
            {
                //DataItemLink = "Loan No." = field("Appraisal No.");

                column(ReportForNavId_51129; 51129)
                {
                }
                column(BankLineNo; "Line No.")
                {
                }
                column(BankDisbursementMode; Format("Mode of Disbursement"))
                {
                }
                column(BankChequeNo; "Cheque No.")
                {
                }
                column(BankDisbursementBankName; "Disbursement Bank Name")
                {
                }
                column(BankAmountToTransfer; "Amount to Transfer")
                {
                }
                column(Disbursement_Date; "Disbursement Date")
                {
                }
                trigger OnPreDataItem()
                var
                    LoanNoFilter: Code[20];
                    PostedLoan: Record Loans;
                begin
                    LoanNoFilter := MemberSalaryAppraisal."Appraisal No.";

                    PostedLoan.Reset();
                    PostedLoan.SetRange("Salary Appraisal No.", MemberSalaryAppraisal."Appraisal No.");
                    if PostedLoan.FindSet() then begin
                        LoanNoFilter := '';
                        repeat
                            LoanNoFilter += PostedLoan."Loan No.";
                        until PostedLoan.Next() = 0;
                    end;
                    SetFilter("Loan No.", LoanNoFilter);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                OfficialUseDate := "Loan Appraisal Date";
                if OfficialUseDate = 0D then
                    OfficialUseDate := "Date";
                if OfficialUseDate = 0D then
                    OfficialUseDate := Today;

                DisplayApprovedAmount := "Approved Amount";
                if DisplayApprovedAmount = 0 then
                    DisplayApprovedAmount := "Requested Amount";

                LoanType.Get("Loan Product Type");
                if LoanType."Appraise Security" then
                    maxLoanAllowed := "Maximum Credit"
                else
                    maxLoanAllowed := "Deposit Multiplier";

                if "Loan Product Type" = 'L07' then begin
                    maxLoanAllowed := LoanType."maximum Loan Amount";
                    "Qualification As Per Deposits" := maxLoanAllowed;
                end;

                if "Loan Product Type" = 'L01' then
                    "Qualification As Per Deposits" := maxLoanAllowed - "BOSA Loan balance";

                /*  MaxLoanAllowed := "Deposit Multiplier" - "BOSA Loan balance";
                 if MaxLoanAllowed < 0 then
                     MaxLoanAllowed := 0; */

                ClearChargeBuckets();
                SummarizeCharges();
                CalculateTopUpSummary();
                BuildProcessingNotes();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        CI.Get();
        CI.CalcFields(Picture);
    end;

    local procedure BuildProcessingNotes()
    begin
        Clear(ProcessingNotesTxt);
        AppendProcessingNote(MemberSalaryAppraisal.GetAppraiserComment());
        AppendProcessingNote(MemberSalaryAppraisal.GetCreditCommitteeComment());
        AppendProcessingNote(MemberSalaryAppraisal.GetCEOComment());
    end;

    local procedure AppendProcessingNote(NoteText: Text)
    begin
        if NoteText = '' then
            exit;

        if ProcessingNotesTxt <> '' then
            ProcessingNotesTxt += ' | ';

        ProcessingNotesTxt += NoteText;
    end;

    local procedure ClearChargeBuckets()
    begin
        RefinanceFees := 0;
        LoanProcessingFees := 0;
        ValuationFees := 0;
        LegalFees := 0;
    end;

    local procedure CalculateTopUpSummary()
    var
        AppTopup: Record "Appraisal Top Up";
    begin
        PrincipleTopup := 0;
        InterestTopup := 0;
        InsuranceTopup := 0;

        if MemberSalaryAppraisal."Appraisal Type" <> MemberSalaryAppraisal."Appraisal Type"::Business then
            exit;

        AppTopup.Reset();
        AppTopup.SetRange("Loan No.", MemberSalaryAppraisal."Appraisal No.");
        if AppTopup.FindSet() then
            repeat
                PrincipleTopup += AppTopup."Principle Top Up";
                InterestTopup += AppTopup."Interest Top Up" + AppTopup."Uncharged Interest";
                InsuranceTopup += AppTopup."Appraisal Top Up" + AppTopup."Uncharged Insurance";
            until AppTopup.Next() = 0;
    end;

    local procedure SummarizeCharges()
    var
        LoanCharge: Record "Loan Charges";
        ChargeDescriptionTxt: Text;
    begin
        LoanCharge.SetRange("Loan No.", MemberSalaryAppraisal."Appraisal No.");
        if LoanCharge.FindSet() then
            repeat
                ChargeDescriptionTxt := LowerCase(LoanCharge.Description);

                if StrPos(ChargeDescriptionTxt, 'refin') > 0 then
                    RefinanceFees += LoanCharge.Amount
                else
                    if (StrPos(ChargeDescriptionTxt, 'process') > 0) or
                       (LoanCharge."Charge Type" = LoanCharge."Charge Type"::"Loan Processing Fee")
                    then begin
                        LoanProcessingFees += LoanCharge.Amount;
                        if LoanCharge."Excise Duty" <> 0 then
                            ExciseDuty += LoanCharge."Excise Duty";
                    end else
                        if StrPos(ChargeDescriptionTxt, 'valuat') > 0 then
                            ValuationFees += LoanCharge."Total Charge"
                        else
                            if StrPos(ChargeDescriptionTxt, 'legal') > 0 then
                                LegalFees += LoanCharge."Total Charge"
                            else
                                if LoanCharge."Excise Duty" <> 0 then
                                    ExciseDuty += LoanCharge."Excise Duty";

            until LoanCharge.Next() = 0;

        if RefinanceFees = 0 then
            RefinanceFees := MemberSalaryAppraisal."Top Up Commission";
    end;

    /* local procedure GetPriorGuarantorCommitment(CurrentLoanSecurity: Record "Loan Security"): Decimal
     var
         OtherLoanSecurity: Record "Loan Security";
         PriorCommitment: Decimal;
     begin
         PriorCommitment := 0;

         OtherLoanSecurity.Reset();
         OtherLoanSecurity.SetRange("Member No", CurrentLoanSecurity."Member No");
         OtherLoanSecurity.SetRange("Guarantor Type", OtherLoanSecurity."Guarantor Type"::Guarantor);
         OtherLoanSecurity.SetFilter("Loan No.", '<>%1', CurrentLoanSecurity."Loan No.");
         OtherLoanSecurity.SetFilter("Amount Guaranteed", '>%1', 0);
         OtherLoanSecurity.SetRange(Substituted, false);
         OtherLoanSecurity.SetFilter("Outstanding Principal", '>0');
         if OtherLoanSecurity.FindSet() then
             repeat
                 PriorCommitment += OtherLoanSecurity."Amount Guaranteed";
             until OtherLoanSecurity.Next() = 0;

         exit(PriorCommitment);
     end; */
    /*mwende*/

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

    var
        CI: Record "Company Information";
        LoanType: Record "Product Setup";
        DisplayApprovedAmount: Decimal;
        maxLoanAllowed: Decimal;
        LegalFees: Decimal;
        LoanProcessingFees: Decimal;
        OfficialUseDate: Date;
        PriorGuaranteeAmount: Decimal;
        ProcessingNotesTxt: Text[2048];
        RefinanceFees: Decimal;
        SecDetails: Text[2048];
        ValuationFees: Decimal;
        ExciseDuty: Decimal;
        GuarantorRowKey: Text[250];
        GuarantorLineNo: Integer;
        PrincipleTopup: Decimal;
        InterestTopup: Decimal;
        InsuranceTopup: Decimal;
}



