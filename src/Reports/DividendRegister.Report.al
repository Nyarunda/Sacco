Report 50341 "Dividend Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Dividend Register.rdlc';

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
            column(WitholdingTax_DividendProgression; WTax)
            {
            }
            column(NetDividends_DividendProgression; NetDividend)
            {
            }

            trigger OnAfterGetRecord()
            begin
                GrossDividend := 0;
                WTax := 0;
                NetDividend := 0;
                Shares := 0;
                QualifyingShare := 0;

                DividendProgression.Reset;
                DividendProgression.SetRange(DividendProgression."Member No", Members."No.");
                if DividendProgression.Find('-') then begin
                    DividendProgression.CalcSums(DividendProgression.Shares, DividendProgression."Qualifying Shares", DividendProgression."Gross Dividends",
                                                 DividendProgression."Witholding Tax", DividendProgression."Net Dividends");

                    GrossDividend := DividendProgression."Gross Dividends";
                    WTax := DividendProgression."Witholding Tax";
                    NetDividend := DividendProgression."Net Dividends";

                    DividendProgression.Reset;
                    DividendProgression.SetCurrentKey("End Date");
                    DividendProgression.SetRange(DividendProgression."Member No", Members."No.");
                    if DividendProgression.FindLast() then begin
                        Shares := DividendProgression.Shares;
                        QualifyingShare := DividendProgression."Qualifying Shares";
                    end;

                end else
                    CurrReport.Skip;
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
        DividendProgression: Record "Dividends Progression";
        DividendSavings: Decimal;
        QualifyingSavings: Decimal;
        GrossDividend: Decimal;
        WTax: Decimal;
        NetDividend: Decimal;
        Shares: Decimal;
        QualifyingShare: Decimal;


}

