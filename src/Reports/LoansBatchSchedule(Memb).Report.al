Report 50174 "Loans Batch Schedule(Memb)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans Batch Schedule(Memb).rdlc';

    dataset
    {
        dataitem("Loan Disburesment-Batching"; "Loan Disbursement Header")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1157; 1157)
            {
            }
            column(UserId; UserId)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(BatchNo_LoanDisburesmentBatching; "Loan Disburesment-Batching"."No.")
            {
            }
            column(DescriptionRemarks_LoanDisburesmentBatching; "Loan Disburesment-Batching"."Description/Remarks")
            {
            }
            column(Posted_LoanDisburesmentBatching; "Loan Disburesment-Batching".Posted)
            {
            }
            column(Status_LoanDisburesmentBatching; "Loan Disburesment-Batching".Status)
            {
            }
            column(DateCreated_LoanDisburesmentBatching; "Loan Disburesment-Batching"."Date Created")
            {
            }
            column(PostingDate_LoanDisburesmentBatching; "Loan Disburesment-Batching"."Posting Date")
            {
            }
            column(PostedBy_LoanDisburesmentBatching; "Loan Disburesment-Batching"."Posted By")
            {
            }
            column(PreparedBy_LoanDisburesmentBatching; "Loan Disburesment-Batching"."Prepared By")
            {
            }
            column(Date_LoanDisburesmentBatching; "Loan Disburesment-Batching".Date)
            {
            }
            column(ModeOfDisbursement_LoanDisburesmentBatching; "Loan Disburesment-Batching"."Disbursement Destination")
            {
            }
            column(DocumentNo_LoanDisburesmentBatching; "Loan Disburesment-Batching"."No.")
            {
            }
            column(BOSABankAccount_LoanDisburesmentBatching; "Loan Disburesment-Batching"."Disburse Accounts" + ' ' + "Loan Disburesment-Batching".Name)
            {
            }
            column(NoSeries_LoanDisburesmentBatching; "Loan Disburesment-Batching"."No. Series")
            {
            }
            column(ApprovalsRemarks_LoanDisburesmentBatching; "Loan Disburesment-Batching"."Posting Remarks")
            {
            }
            column(TotalLoanAmount_LoanDisburesmentBatching; "Loan Disburesment-Batching"."Total Amount")
            {
            }
            column(ChequeNo_LoanDisburesmentBatching; "Loan Disburesment-Batching"."Cheque No.")
            {
            }
            column(BatchType_LoanDisburesmentBatching; "Loan Disburesment-Batching"."Payment Type")
            {
            }
            column(SpecialAdvancePosted_LoanDisburesmentBatching; '')
            {
            }
            column(FOSABankAccount_LoanDisburesmentBatching; '')
            {
            }
            column(NoofLoans_LoanDisburesmentBatching; "Loan Disburesment-Batching"."No of Loans")
            {
            }
            column(PosttoLoanControl_LoanDisburesmentBatching; '')
            {
            }
            column(TotalAppealAmount_LoanDisburesmentBatching; '')
            {
            }
            dataitem("Loans Register"; Loans)
            {
                DataItemLink = "Batch No." = field("No.");
                CalcFields = "Top Up Amount";

                column(ReportForNavId_4645; 4645)
                {
                }
                column(TotalCharges; TotalCharges)
                {
                }
                column(LoanNo_LoansRegister; "Loans Register"."Loan No.")
                {
                }
                column(ClientCode_LoansRegister; "Loans Register"."Member No.")
                {
                }
                column(ClientName_LoansRegister; "Loans Register"."Member Name")
                {
                }
                column(ApplicationDate_LoansRegister; "Loans Register"."Application Date")
                {
                }
                column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
                {
                }
                column(GroupCode_LoansRegister; "Loans Register"."Group Code")
                {
                }
                column(Savings_LoansRegister; 0)
                {
                }
                column(ExistingLoan_LoansRegister; '')
                {
                }
                column(RequestedAmount_LoansRegister; "Loans Register"."Requested Amount")
                {
                }
                column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
                {
                }
                column(TopUpAmount_LoansRegister; "Loans Register"."Top Up Amount")
                {
                }
                column(TotalDeductions_LoansRegister; "Loans Register"."Total Deductions")
                {
                }
                column(TopupCommission_LoansRegister; "Loans Register"."Top Up Amount")
                {
                }
                column(RefinanceProfit_LoansRegister; 0)
                {
                }
                column(LoanProductTypeName_LoansRegister; "Loans Register"."Loan Product Type Name")
                {
                }
                column(Insurance_LoansRegister; "Loans Register"."Total Insurance")
                {
                }
                column(NetToBeDisbursed_LoansRegister; "Loans Register"."Net To Be Disbursed")
                {
                }
                column(LoanInsurance_LoansRegister; 0)
                {
                }
                column(Bankcode_LoansRegister; "Loans Register"."Bank code")
                {
                }
                column(BankNo_LoansRegister; "Loans Register"."Bank Account No")
                {
                }
                column(BankName_LoansRegister; "Loans Register"."Bank Name")
                {
                }
                column(BankBranch_LoansRegister; "Loans Register"."Bank Branch")
                {
                }

                trigger OnAfterGetRecord()
                var
                    Appraisal: Record "Loan Appraisal";
                begin
                    TotalCharges := 0;
                    Appraisal.Get("Loans Register"."Loan No.");
                    TotalCharges := Appraisal."Total Charges";
                end;
            }

            trigger OnPreDataItem()
            begin

                CI.Get;
                CI.CalcFields(CI.Picture);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        TRequestedAmount: Decimal;
        TApprovedAmount: Decimal;
        LoanApp: Record Loans;
        Cust: Record Members;
        //Stations: Record UnknownRecord50400;
        StationDesc: Text[150];
        //Employer: Record Customer;
        EmployerDesc: Text[200];
        Loans_ScheduleCaptionLbl: label 'Loans Schedule';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Batch_TypeCaptionLbl: label 'Batch Type';
        APPROVED_BY________________________________________________________________________________________________CaptionLbl: label 'APPROVED BY:...............................................................................................';
        Grand_TotalsCaptionLbl: label 'Grand Totals';
        CHECKED_BY________________________________________________________________________________________________CaptionLbl: label 'CHECKED BY:...............................................................................................';
        AUTHORISED_BY________________________________________________________________________________________________CaptionLbl: label 'AUTHORISED BY:...............................................................................................';
        V1st__SignatoryCaptionLbl: label '1st  Signatory';
        V2nd_SignatoryCaptionLbl: label '2nd Signatory';
        V3rd_SignatoryCaptionLbl: label '3rd Signatory';
        Loan_TypeCaptionLbl: label 'Loan Type';
        PeriodCaptionLbl: label 'Period';
        Member_No_CaptionLbl: label 'Member No.';
        NameCaptionLbl: label 'Name';
        Staff_No_CaptionLbl: label 'Staff No.';
        Approved_AmountCaptionLbl: label 'Approved Amount';
        Bridged_Commitements_CaptionLbl: label 'Bridged Commitements ';
        Requested_AmountCaptionLbl: label 'Requested Amount';
        AcknowledgementCaptionLbl: label 'Acknowledgement';
        Commision: Decimal;
        LoanTopup: Record "Loan Top Up";
        TotalRefinance: Decimal;
        TotalDeductions: Decimal;
        NetAmount: Decimal;
        InterestTopUp: Decimal;
        TotalDed: Decimal;
        TotalNetAmount: Decimal;
        TotalDedAmount: Decimal;
        TotalIntAmount: Decimal;
        TotalRefAmount: Decimal;
        "Total 6%": Decimal;
        "Total 2.5%": Decimal;
        TotalReq: Decimal;
        CompInfo: Record "Company Information";
        PCharges: Record "Loan Product Charges.";
        Upcomm: Decimal;
        EarlyRelease: Decimal;
        InsuranceCom: Decimal;
        TotalCharges: Decimal;
        LCharges: Decimal;
        TopUpCom: Decimal;
        PrincipleTopUp: Decimal;
        LFees: Decimal;
        GenSetUp: Record "Sacco Setup";
        SchCharge: Decimal;
        ShareCharge: Decimal;
        NetLoan: Decimal;
        DepositDeduct: Decimal;
        TotalTopUp: Decimal;
        MemDeposit: Decimal;
        LoanType: Record "Product Setup";
        GenSetUpS: Record "Product Setup";
        Upfronts: Decimal;
        JazaLevy: Decimal;
        Reistement: Decimal;
        BRIGEDAMOUNT: Decimal;
        Netdisbursed: Decimal;
        BridgeLevy: Decimal;
        LoanProdType: Record "Product Setup";
        TotalUpfronts: Decimal;
        TotalNetPay: Decimal;
        TBridgeLevy: Decimal;
        InstInterest: Decimal;
        Charges: Record "Charges.";
        CI: Record "Company Information";
        bankDet: Text;
}

