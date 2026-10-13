report 50058 "Resignation Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Resignation Slip.rdlc';

    dataset
    {
        dataitem("Member Exit"; "Member Exit")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(USERID; USERID)
            {
            }
            column(CompanyInfo__Address_2_; Company."Address 2")
            {
            }
            column(CompanyInfo_Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(No_; "No.")
            {
            }
            column(Members__No__; "member No.")
            {
            }
            column(Members_Name; "Member Exit"."Member Name")
            {
            }
            column(Members_ID; "Member Exit"."ID No.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(product; Product)
            {
            }
            column(Closure_Type; "Closure Type"
            )
            {
            }
            column(Interests; "Member Exit"."Total Interest")
            {
            }
            column(Loan; "Member Exit"."Total Loan Outstanding")
            {
            }
            column(Balance_AccountClosureLine; "Member Exit"."Total Savings")
            {
            }
            column(Reason_for_Withdrawal; "Reason for Withdrawal")
            {
            }
            column(ShareCapital; "Member Exit"."Share Capital")
            {
            }
            column(Refund; "Member Exit"."Net Refundable")
            {
            }
            column(Normal_charges; "Normal charges")
            {
            }
            column(WithdrawalFee; "Member Exit"."Total Charges")
            {
            }
            column(ChargeAmount; "Member Exit"."Exit Charge")
            {
            }
            column(ProductName; "Member Exit"."Transfer Account Name")
            {
            }
            column(MemberAccountsCaption; 'Member Accounts')
            {
            }
            column(ClosingDate; "Member Exit"."Closing Date")
            {
            }
            dataitem("Member Exit Notice"; "Member Exit Notice")
            {
                DataItemLink = "No." = FIELD("Notice No.");
                // DataItemTableView = WHERE(Close = CONST(Yes));
                column(NoticeNo; "Member Exit Notice"."No.")
                {
                }
                column(Notice_Reason_for_withdrawal; "Reason for withdrawal")
                {
                }
                column(Withdrawa_Noticel_Date; "Withdrawa Noticel Date")
                {
                }
                column(Maturity_Date; "Maturity Date")
                {
                }

                /*column(AccountNo_AccountClosureLine; "Member Exit Notice"."Account No.")
                {
                }
                column(Name_AccountClosureLine; "Member Exit Notice".Name)
                {
                }
                */
                /*column(ProductType_AccountClosureLine; "Member Exit Notice"."Product Type")
                {
                }
                column(Balance_AccountClosureLine; "Member Exit Notice".Balance)
                {
                }
                column(Close_AccountClosureLine; "Member Exit Notice".Close)
                {
                }
                */
                column(MemberNo_AccountClosureLine; "Member Exit Notice"."Member No.")
                {
                }
                column(NetRefund; NetRefund)
                {
                }

            }
            dataitem("Member Accounts"; "Savings Accounts")
            {
                DataItemLink = "Member No." = FIELD("Member No.");
                DataItemTableView = SORTING("Member No.", "No.");

                column(AccountProductName; "Product Name")
                {
                }
                column(AccountBalance; "Balance (LCY)")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CalcFields("Balance (LCY)");
                end;

                trigger OnPreDataItem()
                begin
                    SetFilter("Balance (LCY)", '<>%1', 0);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                WithdrawalFee := 0;
                NetPayable := 0;
                FWithdrawal := 0;
                UBFRefund := 0;
                Excise := 0;
                NetRefund := 0;


                /*FWithdrawal := GenSetUp."Withdrawal Fee";
                AccountClosure.RESET;
                AccountClosure.SETRANGE(AccountClosure."Member No.", "Membership closure"."Member No.");
                IF AccountClosure.FIND('-') THEN BEGIN
                    REPEAT
                        NetPayable := NetPayable + (AccountClosure.Balance * -1);
                        Product := AccountClosure."Product Type";
                        Amount := AccountClosure.Balance;
                    UNTIL AccountClosure.NEXT = 0;
                END;

                TransactionTypes.RESET;
                TransactionTypes.SETRANGE(TransactionTypes.Type, TransactionTypes.Type::"Member Closure");
                IF TransactionTypes.FIND('-') THEN BEGIN
                END;

                //Charges
                TCharges := 0;

                TransactionCharges.RESET;
                TransactionCharges.SETRANGE(TransactionCharges."Transaction Type", TransactionTypes.Code);
                IF TransactionCharges.FIND('-') THEN BEGIN
                    REPEAT

                        ChargeAmount := 0;
                        IF TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" = TRUE THEN
                            ChargeAmount := ("Member Savings" * TransactionCharges."Percentage of Amount") * 0.01
                        ELSE
                            ChargeAmount := TransactionCharges."Charge Amount";

                        IF TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered THEN BEGIN

                            TransactionCharges.TESTFIELD(TransactionCharges."Staggered Charge Code");

                            TariffDetails.RESET;
                            TariffDetails.SETRANGE(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                            IF TariffDetails.FIND('-') THEN BEGIN
                                REPEAT
                                    IF ("Member Savings" >= TariffDetails."Lower Limit") AND ("Member Savings" <= TariffDetails."Upper Limit") THEN BEGIN
                                        IF TariffDetails."Use Percentage" = TRUE THEN BEGIN
                                            ChargeAmount := "Membership closure"."Member Savings" * TariffDetails.Percentage * 0.01;
                                        END ELSE BEGIN
                                            ChargeAmount := TariffDetails."Charge Amount"
                                        END;
                                    END;
                                UNTIL TariffDetails.NEXT = 0;
                            END;
                        END;
                    UNTIL TransactionCharges.NEXT = 0;
                END;

                WithdrawalFee := ChargeAmount;
                IF WithdrawalFee < 1000 THEN
                    WithdrawalFee := 1000;

                IF WithdrawalFee > 5000 THEN
                    WithdrawalFee := 5000;

                Excise := (WithdrawalFee * GenSetUp."Excise Duty (%)") / 100;
                //MESSAGE('The charge amount is %1',WithdrawalFee);
                // END;
                Refund := "Deposit Refundable" - WithdrawalFee - ChargeAmount;
                IF Refund < 0 THEN
                    Refund := 0;

                NetRefund -= ("Membership closure"."Total Loan" + "Membership closure"."Total Interest" + WithdrawalFee + Excise);
                */
                //MESSAGE('"Membership closure"."Total Loan" %1 \"Membership closure"."Total Interest" %2 \WithdrawalFee %3\Excise %4\ChargeAmount %5',
                //"Membership closure"."Total Loan","Membership closure"."Total Interest",WithdrawalFee,Excise,chargeAmount);

            end;

            trigger OnPreDataItem()
            begin
                IF Company.GET() THEN
                    Company.CALCFIELDS(Company.Picture);

                GenSetUp.GET;
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
        WithdrawalFee: Decimal;
        NetRefund: Decimal;
        FWithdrawal: Decimal;
        NetPayable: Decimal;
        FOSAInterest: Decimal;
        FExpenses: Decimal;
        CICLoan: Decimal;
        InsFund: Decimal;
        UnpaidDividends: Decimal;
        Account: Record "Savings Accounts";
        Company: Record "Company Information";
        UBFRefund: Decimal;
        GenSetUp: Record "Sacco Setup";
        Vend: Record Vendor;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ACCOUNT_CLOSURE_SLIPCaptionLbl: Label 'ACCOUNT CLOSURE SLIP';
        Member_No_CaptionLbl: Label 'Member No.';
        Current_Oustanding_LoanCaptionLbl: Label 'Current Oustanding Loan';
        Deposit_ContributionCaptionLbl: Label 'Deposit Contribution';
        Other_DeductionsCaptionLbl: Label 'Other Deductions';
        Insurance_Fund_CaptionLbl: Label 'Insurance Fund ';
        ADD__Unpaid_DividendsCaptionLbl: Label 'ADD: Unpaid Dividends';
        LESS_CaptionLbl: Label 'LESS:';
        ADD_CaptionLbl: Label 'ADD:';
        Net_RefundCaptionLbl: Label 'Net Refund';
        Withdrawal_FeesCaptionLbl: Label 'Withdrawal Fees';
        Batch_No_CaptionLbl: Label 'Batch No.';
        Prepared_ByLbl: Label 'Prepared By: ....................................................................................................................................................................';
        Approved_ByLbl: Label 'Approved By: ....................................................................................................................................................................';
        Signature_DateLbl: Label 'Signature/Date: ....................................................................................................................................................................';
        Signature_Date000Lbl: Label 'Signature/Date: ....................................................................................................................................................................';
        Member_StatusCaptionLbl: Label 'Member Status';
        FOSA_Accrued_InterestCaptionLbl: Label 'FOSA Accrued Interest';
        FOSA_Current_Oustanding_LoanCaptionLbl: Label 'FOSA Current Oustanding Loan';
        Shares_CapitalCaptionLbl: Label 'Shares Capital';
        Funeral_ExpensesCaptionLbl: Label 'Funeral Expenses';
        Under_Excess_InsuranceCaptionLbl: Label 'Under/Excess Insurance';
        Capital_ReserveCaptionLbl: Label 'Capital Reserve';
        Insurance__CIC_CaptionLbl: Label 'Insurance (CIC)';
        TotalCaptionLbl: Label 'Total';
        TotalCaption_Control1102760055Lbl: Label 'Total';
        UBF_Refund_CaptionLbl: Label 'UBF Refund ';
        Product: Code[20];
        Amount: Decimal;
        MemberwithdrawalNotice: Record "Member Exit Notice";
        TCharges: Decimal;
        ChargeAmount: Decimal;
        Refund: Decimal;
        ProductFactory: Record "Product Setup";
        ProducName: Text;
        Excise: Decimal;
}

