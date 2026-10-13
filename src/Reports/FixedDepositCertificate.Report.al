Report 50175 "Fixed Deposit Certificate"
{
    DefaultLayout = Word;
    //RDLCLayout = './src/Layouts/Fixed Deposit Certificate.rdlc';
    WordLayout = './src/Layouts/Fixed Deposit Certificate.docx';

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
            column(RefNo; RefNo)
            {
            }
            column(WthTax; WthTax)
            {
            }
            column(MaturityD; MaturityD)
            {
            }
            column(MemberEmail; MemberEmail)
            {
            }
            column(FD_Maturity_Instructions;"FD Maturity Instructions")
            {
            }
            column(MaturityInstructionLine; MaturityInstructionLine)
            {
            }
            column(MaturityInstrPrefix; MaturityInstrPrefix)
            {
            }
            column(MaturityInstrAmount; MaturityInstrAmount)
            {
            }
            column(MaturityInstrMiddle; MaturityInstrMiddle)
            {
            }
            column(MaturityInstrAmount2; MaturityInstrAmount2)
            {
            }
            column(MaturityInstrSuffix; MaturityInstrSuffix)
            {
            }
            column(TotalAmt; "FD Amount" + "Total Interest Earned")
            { }
            column(Payee_Bank_Name; "Payee Bank Name")
            { }
            column(Payee_Bank_Account; "Payee Account No.")
            { }
            column(Payee_Branch_Name; "Payee Branch Name")
            { }
            column(Payee_Account_Name; "Payee Account Name")
            { }
            column(NetAmount; NetAmount)
            { }
            column(NetInterest; NetInterest)
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
            trigger OnAfterGetRecord()
            var
                SaccoSetup: Record "Sacco Setup";
                Member: Record Members;
            begin
                SaccoSetup.Get();

                Rate := "Savings Accounts"."Negotiated Interest %";
                if "Savings Accounts"."Negotiated Interest %" = 0 then
                    Rate := "Savings Accounts"."FD Annual Interest %";

                Bal := "Savings Accounts"."FD Amount";
                FdType := "Savings Accounts"."FD Type";
                InterestExpected := "Savings Accounts"."Total Expected Interest";
                WthTax := InterestExpected * SaccoSetup.WthTax * 0.01;
                NetInterest := InterestExpected - WthTax;
                NetAmount := Bal + NetInterest;
                MaturityInstructionLine := GetMaturityInstructionLine();
                SetMaturityInstructionParts();


                DuratinFD := "Savings Accounts"."FD Type";
                MaturityD := "Savings Accounts"."FD Maturity Date";

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
            area(content)
            {
                field(RefNo; RefNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reference No.';
                }
            }
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
        NetInterest: Decimal;
        NetAmount: Decimal;
        MemberEmail: Text[100];
        Rate: Decimal;
        CheckReport: Report Check;
        NumberText: array[2] of Text[120];
        Bal: Decimal;
        RefNo: Code[30];
        InterestExpected: Decimal;
        WthTax: Decimal;
        TotalAmt: Decimal;
        FdType: Code[20];
        DuratinFD: Code[20];
        MaturityD: Date;
        CompInfo: Record "Company Information";
        MaturityInstructionLine: Text[250];
        MaturityInstrAmount: Text[30];
        MaturityInstrAmount2: Text[30];
        MaturityInstrMiddle: Text[250];
        MaturityInstrPrefix: Text[250];
        MaturityInstrSuffix: Text[250];

    local procedure GetMaturityInstructionLine(): Text[250]
    begin
        case "Savings Accounts"."FD Maturity Instructions" of
            "Savings Accounts"."FD Maturity Instructions"::"Renew Both Principal & Interest":
                exit(StrSubstNo(
                    'Upon maturity, the principal together with accrued interest amounting to KES %1 will be renewed into a new fixed deposit account.',
                    FormatCertificateAmount(NetAmount)));

            "Savings Accounts"."FD Maturity Instructions"::"Transfer Interest & Renew Principal":
                exit(StrSubstNo(
                    'Upon maturity, only the principal amount of KES %1 will be renewed into a new fixed deposit account. The accrued interest of KES %2 will be paid out to your bank account.',
                    FormatCertificateAmount(Bal),
                    FormatCertificateAmount(NetInterest)));

            "Savings Accounts"."FD Maturity Instructions"::"Transfer all to Savings":
                exit(StrSubstNo(
                    'Upon maturity, the total amount of KES %1 will be transferred to your bank account.',
                    FormatCertificateAmount(NetAmount)));

            "Savings Accounts"."FD Maturity Instructions"::"Transfer all to Bank":
                exit(StrSubstNo(
                    'Upon maturity, the total amount of KES %1 will be transferred to the bank account details provided below.',
                    FormatCertificateAmount(NetAmount)));
        end;

        exit('');
    end;

    local procedure SetMaturityInstructionParts()
    begin
        Clear(MaturityInstrPrefix);
        Clear(MaturityInstrAmount);
        Clear(MaturityInstrMiddle);
        Clear(MaturityInstrAmount2);
        Clear(MaturityInstrSuffix);

        case "Savings Accounts"."FD Maturity Instructions" of
            "Savings Accounts"."FD Maturity Instructions"::"Renew Both Principal & Interest":
                begin
                    MaturityInstrPrefix := 'Upon maturity, the principal together with accrued interest amounting to KES ';
                    MaturityInstrAmount := FormatCertificateAmount(NetAmount);
                    MaturityInstrSuffix := ' will be renewed into a new fixed deposit account.';
                end;

            "Savings Accounts"."FD Maturity Instructions"::"Transfer Interest & Renew Principal":
                begin
                    MaturityInstrPrefix := 'Upon maturity, only the principal amount of KES ';
                    MaturityInstrAmount := FormatCertificateAmount(Bal);
                    MaturityInstrMiddle := ' will be renewed into a new fixed deposit account. The accrued interest of KES ';
                    MaturityInstrAmount2 := FormatCertificateAmount(NetInterest);
                    MaturityInstrSuffix := ' will be paid out to your bank account.';
                end;

            "Savings Accounts"."FD Maturity Instructions"::"Transfer all to Savings":
                begin
                    MaturityInstrPrefix := 'Upon maturity, the total amount of KES ';
                    MaturityInstrAmount := FormatCertificateAmount(NetAmount);
                    MaturityInstrSuffix := ' will be transferred to your bank account.';
                end;

            "Savings Accounts"."FD Maturity Instructions"::"Transfer all to Bank":
                begin
                    MaturityInstrPrefix := 'Upon maturity, the total amount of KES ';
                    MaturityInstrAmount := FormatCertificateAmount(NetAmount);
                    MaturityInstrSuffix := ' will be transferred to the bank account details provided below.';
                end;
        end;
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
