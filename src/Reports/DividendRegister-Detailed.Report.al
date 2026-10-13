Report 50345 "Dividend Register - Detailed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Dividend Register - Detailed.rdlc';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", Status;
            column(ReportForNavId_11; 11)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(Shares_DividendProgression; Shares)
            {
            }
            column(QualifyingShares_DividendProgression; QualifyingShare)
            {
            }
            column(GrossDividends_DividendProgression; GrossDividend)
            {
            }
            column(WitholdingTax_DividendProgression; WTaxDiv)
            {
            }
            column(NetDividends_DividendProgression; NetDividend)
            {
            }
            column(Deposits; Deposits)
            {
            }
            column(QualifyingDeposits; QualifyingDeposits)
            {
            }
            column(GrossRebates; GrossRebates)
            {
            }
            column(WTaxReb; WTaxReb)
            {
            }
            column(NetRebates; NetRebates)
            {
            }

            column(FosaShares; FosaShares)
            {
            }
            column(QualifyingFosaShare; QualifyingFosaShare)
            {
            }
            column(GrossFosaDividend; GrossFosaDividend)
            {
            }
            column(WTaxFosaDiv; WTaxFosaDiv)
            {
            }
            column(TotalGross; TotalDivRebates)
            {
            }
            column(TotalTax; TotalTax)
            {
            }
            column(TotalNet; TotalNet)
            {
            }
            column(LoansAmt; LoansAmt)
            {
            }
            column(ShareAmt; ShareAmt)
            {
            }
            column(NetPayable; NetPayable)
            {
            }

            trigger OnAfterGetRecord()
            var
                PSetup: Record "Product Setup";
            begin

                Shares := 0;
                QualifyingShare := 0;
                GrossDividend := 0;
                WTaxDiv := 0;
                NetDividend := 0;

                FosaShares := 0;
                QualifyingFosaShare := 0;
                GrossFosaDividend := 0;
                WTaxFosaDiv := 0;
                NetFosaDividend := 0;
                NetPayable := 0;
                Deposits := 0;
                QualifyingDeposits := 0;
                GrossRebates := 0;
                WTaxReb := 0;
                NetRebates := 0;
                TotalDivRebates := 0;
                TotalNet := 0;
                TotalTax := 0;
                ShareAmt := 0;
                LoansAmt := 0;

                PSetup.Reset();
                PSetup.SetRange("Product Category", PSetup."Product Category"::"Share Capital");
                if PSetup.FindFirst() then begin
                    DividendProgression.Reset;
                    DividendProgression.SetRange("Product Type", PSetup."Product ID");
                    DividendProgression.SetRange(DividendProgression."Member No", Members."No.");
                    if DividendProgression.Find('-') then begin
                        //repeat
                        //PSetup.Get(DividendProgression."Product Type");

                        DividendProg.Reset();
                        DividendProg.SetCurrentKey("End Date");
                        DividendProg.SetRange("Member No", "No.");
                        DividendProg.SetRange("Product Type", PSetup."Product ID");
                        if DividendProg.Findfirst() then begin
                            DividendProg.CalcSums("Gross Dividends", "Witholding Tax", "Net Dividends", Shares, "Qualifying Shares");
                            Deposits := DividendProg.Shares;
                            QualifyingDeposits := DividendProg."Qualifying Shares";
                            GrossRebates := DividendProg."Gross Dividends";
                            WTaxReb := DividendProg."Witholding Tax";
                            NetRebates := DividendProg."Net Dividends";
                        end;
                    end;
                end;

                PSetup.Reset();
                PSetup.SetRange("Product Category", PSetup."Product Category"::"Deposit Contribution");
                if PSetup.FindFirst() then begin
                    DividendProgression.Reset;
                    DividendProgression.SetRange(DividendProgression."Member No", Members."No.");
                    DividendProgression.SetRange("Product Type", PSetup."Product ID");
                    if DividendProgression.Find('-') then begin
                        //PSetup.Get(DividendProgression."Product Type");

                        DividendProg.Reset();
                        DividendProg.SetCurrentKey("End Date");
                        DividendProg.SetRange("Member No", "No.");
                        DividendProg.SetRange("Product Type", PSetup."Product ID");
                        if DividendProg.Findfirst() then begin
                            DividendProg.CalcSums("Gross Dividends", "Witholding Tax", "Net Dividends", Shares, "Qualifying Shares");
                            Shares := DividendProg.Shares;
                            QualifyingShare := DividendProg."Qualifying Shares";
                            GrossDividend := DividendProg."Gross Dividends";
                            WTaxDiv := DividendProg."Witholding Tax";
                            NetDividend := DividendProg."Net Dividends";
                        end;
                    end;
                end;

                DividednPostingBuffer.Reset();
                DividednPostingBuffer.SetRange(DividednPostingBuffer."Member No.", Members."No.");
                DividednPostingBuffer.SetFilter("Credit Amount", '>0');
                if DividednPostingBuffer.FindSet() then
                    repeat
                        if DividednPostingBuffer.Transaction = DividednPostingBuffer.Transaction::Loan then
                            LoansAmt += DividednPostingBuffer."Credit Amount";

                        if (DividednPostingBuffer.Transaction = DividednPostingBuffer.Transaction::Capitalized)
                           /* and (DividednPostingBuffer."Product Type" = 'S01')*/ then
                            ShareAmt += DividednPostingBuffer."Credit Amount";

                    until DividednPostingBuffer.Next() = 0;

                TotalDivRebates := GrossDividend + GrossRebates;
                TotalNet := NetDividend + NetRebates;
                TotalTax := WTaxReb + WTaxDiv;
                NetPayable := TotalNet - (ShareAmt + LoansAmt);

                if NetPayable < 0 then NetPayable := 0;
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

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
#pragma warning disable AL0432
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432
    end;

    var
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CompanyInformation: Record "Company Information";
        DividendProg: Record "Dividends Progression";
        DividendProgression: Record "Dividends Progression";
        DividednPostingBuffer: Record "Dividend Posting";
        DividendSavings: Decimal;
        QualifyingSavings: Decimal;
        GrossDividend: Decimal;
        WTaxDiv: Decimal;
        NetDividend: Decimal;
        Shares: Decimal;
        QualifyingShare: Decimal;


        GrossRebates: Decimal;
        WTaxReb: Decimal;
        NetRebates: Decimal;
        Deposits: Decimal;
        QualifyingDeposits: Decimal;
        TotalNet: Decimal;
        TotalTax: Decimal;
        TotalDivRebates: Decimal;
        GrossFosaDividend: Decimal;
        WTaxFosaDiv: Decimal;
        NetFosaDividend: Decimal;
        FosaShares: Decimal;
        NetPayable: Decimal;
        LoansAmt: Decimal;
        ShareAmt: Decimal;
        QualifyingFosaShare: Decimal;

}

