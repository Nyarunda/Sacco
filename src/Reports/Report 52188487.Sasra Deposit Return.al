
Report 50150 "Sasra Deposit Return"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Sasra Deposit Return.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("Deposit Return Buffer"; "Deposit Return Buffer")
        {
            DataItemTableView = sorting("No.") where("No. of Accounts" = filter(> 0));
            column(ReportForNavId_1; 1)
            {
            }
            column(No_DepositReturnBuffer; ENo)
            {
            }
            column(Range_DepositReturnBuffer; SRange)
            {
            }
            column(TypeofDeposit_DepositReturnBuffer; "Deposit Return Buffer"."Type of Deposit")
            {
            }
            column(NoofAccounts_DepositReturnBuffer; "Deposit Return Buffer"."No. of Accounts")
            {
            }
            column(AmountinKES_DepositReturnBuffer; "Deposit Return Buffer"."Amount in KES")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(saccoNo; CompanyInfo."Sacco Society No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                ENo := Format("Deposit Return Buffer"."No.");
                SRange := '';

                if ENo = PENo then
                    ENo := '';

                if ENo <> '' then begin
                    case "Deposit Return Buffer".Range of
                        "Deposit Return Buffer".Range::"Less 50000":
                            SRange := 'Less than 50,000';
                        "Deposit Return Buffer".Range::"50001_100000":
                            SRange := '50,001 to 100,000';
                        "Deposit Return Buffer".Range::"100001_300000":
                            SRange := '100,001 to 300,000';
                        "Deposit Return Buffer".Range::"300001_1000000":
                            SRange := '300,001 to 1,000,000';
                        "Deposit Return Buffer".Range::"Over 1000000":
                            SRange := 'Over 1,000,000';
                    end;
                end;

                PENo := Format("Deposit Return Buffer"."No.");
            end;

            trigger OnPreDataItem()
            begin

                /*
                IF CONFIRM('Do you want to update the buffer?') THEN BEGIN
                    Sav.RESET;
                    Sav.SETFILTER("Date Filter",'..%1',AsAt);
                    IF Sav.FINDFIRST THEN
                        REPORT.RUN(39004384,FALSE,FALSE,Sav);
                END;
                */

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        ENo: Code[10];
        SRange: Code[20];
        PENo: Code[10];
        AsAt: Date;
        DepositReturnBuffer: Record "Deposit Return Buffer";
        Sav: Record "Savings Accounts";
}

