Report 50278 "Sacco Trial Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Sacco Trial Balance.rdlc';
    Caption = 'Trial Balance';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            column(ReportForNavId_6710; 6710)
            {
            }
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(COMPANYNAME; CompanyProperty.DisplayName)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FieldCaption("No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
            {
            }
            column(G_L_Account___Net_Change__Control22Caption; G_L_Account___Net_Change__Control22CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date_Caption; G_L_Account___Balance_at_Date_CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date__Control24Caption; G_L_Account___Balance_at_Date__Control24CaptionLbl)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(TCredit; TCredit * -1)
            {
            }
            column(TDebit; TDebit)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(ReportForNavId_5444; 5444)
                {
                }
                column(OpeningBalance; OpeningBalance)
                {
                }
                column(Debits; Debits)
                {
                }
                column(Credits; Credits)
                {
                }
                column(NetChange; NetChange)
                {
                }
                column(ClosingBalance; ClosingBalance)
                {
                }
                column(TOpeningBalance; TOpeningBalance)
                {
                }
                column(TDebits; TDebits)
                {
                }
                column(TCredits; TCredits)
                {
                }
                column(TNetChange; TNetChange)
                {
                }
                column(TClosingBalance; TClosingBalance)
                {
                }
                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Net_Change_; "G/L Account"."Net Change")
                {
                }
                column(G_L_Account___Net_Change__Control22; -"G/L Account"."Net Change")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Balance_at_Date_; "G/L Account"."Balance at Date")
                {
                }
                column(G_L_Account___Balance_at_Date__Control24; -"G/L Account"."Balance at Date")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Account_Type_; Format("G/L Account"."Account Type", 0, 2))
                {
                }
                column(No__of_Blank_Lines; "G/L Account"."No. of Blank Lines")
                {
                }
                dataitem(BlankLineRepeater; "Integer")
                {
                    DataItemTableView = sorting(Number);
                    column(ReportForNavId_7; 7)
                    {
                    }
                    column(BlankLineNo; BlankLineNo)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if BlankLineNo = 0 then
                            CurrReport.Break;

                        BlankLineNo -= 1;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    BlankLineNo := "G/L Account"."No. of Blank Lines" + 1;


                    FYCloseBalance := 0;
                    if SDate = CalcDate('-CY', SDate) then begin
                        GLAccount.Reset;
                        GLAccount.SetRange("No.", AccNo);
                        GLAccount.SetFilter("Date Filter", '%1', ClosingDate(SDate - 1));
                        if GLAccount.FindFirst then begin
                            GLAccount.CalcFields("Net Change");
                            FYCloseBalance := GLAccount."Net Change";
                        end;
                    end;


                    GLAccount.Reset;
                    GLAccount.SetRange("No.", AccNo);
                    GLAccount.SetFilter("Date Filter", '..%1', SDate - 1);
                    if GLAccount.FindFirst then begin
                        GLAccount.CalcFields("Net Change");
                        OpeningBalance := GLAccount."Net Change" + FYCloseBalance;
                    end;

                    GLAccount.Reset;
                    GLAccount.SetRange("No.", AccNo);
                    GLAccount.SetFilter("Date Filter", '%1..%2', SDate, EDate);
                    if GLAccount.FindFirst then begin
                        GLAccount.CalcFields("Debit Amount", "Credit Amount", "Net Change");
                        Debits := GLAccount."Debit Amount";
                        Credits := GLAccount."Credit Amount";
                        NetChange := GLAccount."Net Change";
                    end;


                    GLAccount.Reset;
                    GLAccount.SetRange("No.", AccNo);
                    GLAccount.SetFilter("Date Filter", '..%1', EDate);
                    if GLAccount.FindFirst then begin
                        GLAccount.CalcFields("Net Change");
                        ClosingBalance := GLAccount."Net Change";
                    end;



                    if GLAccount."Account Type" = GLAccount."account type"::Posting then begin
                        TOpeningBalance += OpeningBalance;
                        TClosingBalance += ClosingBalance;
                        TDebits += Debits;
                        TCredits += Credits;
                        TNetChange += NetChange;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("Net Change", "Balance at Date");

                if ChangeGroupNo then begin
                    PageGroupNo += 1;
                    ChangeGroupNo := false;
                end;

                ChangeGroupNo := "New Page";
                AccNo := "G/L Account"."No.";

                /*
                IF "G/L Account"."Account Type"="G/L Account"."Account Type"::Posting THEN
                BEGIN
                IF "Net Change">0 THEN
                TDebit:=TDebit+ "Net Change";
                IF "Net Change"<0 THEN
                TCredit:=TCredit+ "Net Change";
                END;
                */

            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 0;
                ChangeGroupNo := false;


                DFilter := "G/L Account".GetFilter("Date Filter");
                ;

                SDate := 20010101D;
                EDate := Today;
                if DFilter <> '' then begin
                    if CopyStr(DFilter, 1, 2) = '..' then
                        EDate := "G/L Account".GetRangemax("Date Filter")
                    else begin
                        SDate := "G/L Account".GetRangeMin("Date Filter");
                        EDate := "G/L Account".GetRangemax("Date Filter");
                    end;
                end;
                if PeriodText = '' then begin
                    PeriodText := Format(SDate) + '..' + Format(EDate);
                    if SDate = 20010101D then
                        PeriodText := '..' + Format(EDate);
                end;
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
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        GLFilter := "G/L Account".GetFilters;
        PeriodText := "G/L Account".GetFilter("Date Filter");
    end;

    var
        CompanyInfo: Record "Company Information";
        Text000: label 'Period: %1';
        GLFilter: Text;
        PeriodText: Text[30];
        Trial_BalanceCaptionLbl: label 'Trial Balance';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Net_ChangeCaptionLbl: label 'Net Change';
        BalanceCaptionLbl: label 'Balance';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: label 'Name';
        G_L_Account___Net_Change_CaptionLbl: label 'Debit';
        G_L_Account___Net_Change__Control22CaptionLbl: label 'Credit';
        G_L_Account___Balance_at_Date_CaptionLbl: label 'Debit';
        G_L_Account___Balance_at_Date__Control24CaptionLbl: label 'Credit';
        PageGroupNo: Integer;
        ChangeGroupNo: Boolean;
        BlankLineNo: Integer;
        TDebit: Decimal;
        TCredit: Decimal;
        GLAccount: Record "G/L Account";
        OpeningBalance: Decimal;
        Debits: Decimal;
        Credits: Decimal;
        NetChange: Decimal;
        ClosingBalance: Decimal;
        AccNo: Code[20];
        SDate: Date;
        EDate: Date;
        DFilter: Text;
        TOpeningBalance: Decimal;
        TDebits: Decimal;
        TCredits: Decimal;
        TNetChange: Decimal;
        TClosingBalance: Decimal;
        FYCloseBalance: Decimal;
}
