
Report 50128 "Fixed Deposit Report 1"
{
    caption = 'Fixed Deposit Slip';
    DefaultLayout = Word;
    WordLayout = './src/Layouts/Fixed Deposit Report.docx';

    dataset
    {
        dataitem("Savings Accounts"; "Fixed Deposit Accounts")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(DayT; Today)
            {
            }
            column(No; "Savings Accounts"."No.")
            {
            }
            column(Amount; Bal)
            {
            }
            column(FD_Start_Date; "FD Start Date")
            {
            }
            column(Member_No_; "Member No.")
            { }
            column(Name; "Savings Accounts".Name)
            {
            }
            column(FixedDuration; DuratinFD)
            {
            }
            column(Rate; Rate)
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(InterestExpected; InterestExpected)
            {
            }
            column(FD_Amount; "FD Amount" + "Total Interest Earned")
            { }
            column(RefNo; RefNo)
            {
            }
            column(WthTax; WthTax)
            {
            }
            column(MaturityD; MaturityD)
            {
            }
            column(FDInstructions; "FD Maturity Instructions")
            {
            }
            column(MemberEmail; MemberEmail)
            {

            }
            column(Payee_Bank_Name; "Payee Bank Name")
            { }
            column(Payee_Bank_Account; "Payee Account No.")
            { }
            column(Payee_Branch_Name; "Payee Branch Name")
            { }
            column(Payee_Account_Name; "Payee Account Name")
            { }
            column(compName; COMPANYNAME)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(MaturityMessage; MaturityMessage) { }
            column(MaturityAmountText; MaturityAmountText) { }
            column(PaymentInstructionLine; PaymentInstructionLine) { }
            trigger OnAfterGetRecord()
            var
                SaccoSetup: Record "Sacco Setup";
                Member: Record Members;
            begin

                Rate := "Savings Accounts"."Negotiated Interest %";
                if "Savings Accounts"."Negotiated Interest %" = 0 then
                    Rate := "Savings Accounts"."FD Annual Interest %";

                SaccoSetup.Get();

                Bal := "Savings Accounts"."FD Amount";
                FdType := "Savings Accounts"."FD Type";
                InterestExpected := "Savings Accounts"."Total Expected Interest";
                WthTax := InterestExpected * SaccoSetup.WthTax * 0.01;
                DuratinFD := format("Savings Accounts"."FD Duration");
                MaturityD := "Savings Accounts"."FD Maturity Date";
                NetInterest := InterestExpected - WthTax;
                NetAmount := Bal + NetInterest;

                case "Savings Accounts"."FD Maturity Instructions" of

                    "Savings Accounts"."FD Maturity Instructions"::"Renew Both Principal & Interest":
                        begin
                            NetAmount := Bal + NetInterest;
                            RenewedAmount := NetAmount;
                            MaturityMessage := 'Your Fixed Deposit has been renewed.';
                            MaturityAmountText := StrSubstNo('Renewed Amount: %1', Format(RenewedAmount, 0, '<Precision,2:2><Standard Format,0>'));
                        end;

                    "Savings Accounts"."FD Maturity Instructions"::"Transfer all to Savings":
                        begin
                            NetAmount := Bal + NetInterest;
                            TransferredAmount := NetAmount;
                            MaturityMessage := 'Your Fixed Deposit has been transferred to your Savings Account.';
                            MaturityAmountText := StrSubstNo('Transferred Amount: %1', Format(TransferredAmount, 0, '<Precision,2:2><Standard Format,0>'));
                        end;

                    "Savings Accounts"."FD Maturity Instructions"::"Transfer all to Bank":
                        begin
                            NetAmount := Bal + NetInterest;
                            TransferredAmount := NetAmount;
                            MaturityMessage := 'Your Fixed Deposit has been transferred to the bank account details provided below.';
                            MaturityAmountText := StrSubstNo('Transferred Amount: %1', Format(TransferredAmount, 0, '<Precision,2:2><Standard Format,0>'));
                        end;

                    "Savings Accounts"."FD Maturity Instructions"::"Transfer Interest & Renew Principal":
                        begin
                            NetAmount := NetInterest;
                            InterestTransferred := NetInterest;
                            PrincipalRenewed := Bal;
                            MaturityMessage := 'Your Fixed Deposit interest has been transferred and your principal has been renewed.';
                            MaturityAmountText := StrSubstNo('Interest Transferred: %1 | Principal Renewed: %2',
                                Format(InterestTransferred, 0, '<Precision,2:2><Standard Format,0>'),
                                Format(PrincipalRenewed, 0, '<Precision,2:2><Standard Format,0>'));
                    end;

                end;

                PaymentInstructionLine := GetPaymentInstructionLine();

                if Member.get("Savings Accounts"."Member No.") then begin
                    MemberEmail := Member."E-Mail";

                end;

                if RefNo <> '' then
                    RefNo := "Savings Accounts"."No.";

                //Amount into words
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NumberText, Bal, '')

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
    trigger OnInitReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var

        Rate: Decimal;
        CheckReport: Report Check;
        NumberText: array[2] of Text[120];
        Bal: Decimal;
        RefNo: Code[30];
        InterestExpected: Decimal;
        WthTax: Decimal;
        FdType: Code[20];
        DuratinFD: Code[20];
        MaturityD: Date;
        CompInfo: Record "Company Information";
        MemberEmail: Text[250];
        NetInterest: Decimal;
        NetAmount: Decimal;
        MaturityMessage: Text[500];
        MaturityAmountText: Text[100];
        RenewedAmount: Decimal;
        TransferredAmount: Decimal;
        InterestTransferred: Decimal;
        PrincipalRenewed: Decimal;
        PaymentInstructionLine: Text[500];

    local procedure GetPaymentInstructionLine(): Text[500]
    begin
        case "Savings Accounts"."FD Maturity Instructions" of
            "Savings Accounts"."FD Maturity Instructions"::"Renew Both Principal & Interest":
                exit(StrSubstNo(
                    'We wish to confirm that the fixed deposit you placed with us on %1 has matured and the total amount of Kshs. %2 has been renewed into a new fixed deposit account.',
                    FormatCertificateDate("Savings Accounts"."FD Start Date"),
                    FormatCertificateAmount(NetAmount)));

            "Savings Accounts"."FD Maturity Instructions"::"Transfer Interest & Renew Principal":
                exit(StrSubstNo(
                    'We wish to confirm that the fixed deposit you placed with us on %1 has matured. The principal amount of Kshs. %2 has been renewed into a new fixed deposit account and the accrued interest of Kshs. %3 has been paid out to the bank account details below:',
                    FormatCertificateDate("Savings Accounts"."FD Start Date"),
                    FormatCertificateAmount(Bal),
                    FormatCertificateAmount(NetInterest)));

            "Savings Accounts"."FD Maturity Instructions"::"Transfer all to Savings":
                exit(StrSubstNo(
                    'We wish to confirm that the fixed deposit you placed with us on %1 has matured and we have transferred Kshs. %2 to the bank account details below:',
                    FormatCertificateDate("Savings Accounts"."FD Start Date"),
                    FormatCertificateAmount(NetAmount)));

            "Savings Accounts"."FD Maturity Instructions"::"Transfer all to Bank":
                exit(StrSubstNo(
                    'We wish to confirm that the fixed deposit you placed with us on %1 has matured and we have transferred Kshs. %2 to the bank account details below:',
                    FormatCertificateDate("Savings Accounts"."FD Start Date"),
                    FormatCertificateAmount(NetAmount)));
        end;

        exit(StrSubstNo(
            'We wish to confirm that the fixed deposit you placed with us on %1 has matured.',
            FormatCertificateDate("Savings Accounts"."FD Start Date")));
    end;

    local procedure FormatCertificateDate(DateValue: Date): Text[30]
    begin
        exit(Format(DateValue, 0, '<Month Text> <Day,2>, <Year4>'));
    end;

    local procedure FormatCertificateAmount(Amount: Decimal): Text[30]
    var
        AmountText: Text[30];
    begin
        AmountText := Format(Amount, 0, '<Precision,2:2><Standard Format,0>');
        if (StrLen(AmountText) >= 3) and (CopyStr(AmountText, StrLen(AmountText) - 2, 3) = '.00') then
            AmountText := CopyStr(AmountText, 1, StrLen(AmountText) - 3);

        exit(AmountText);
    end;
}
