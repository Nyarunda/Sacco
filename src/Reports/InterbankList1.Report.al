Report 50311 "Interbank List Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Interbank List1.rdlc';

    dataset
    {
        dataitem("IBT Header"; "IBT Header")
        {
            RequestFilterFields = "No.", Date;
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(No_IBTHeader; "IBT Header"."No.")
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(Date_IBTHeader; "IBT Header".Date)
            {
            }
            column(PayMode_IBTHeader; "IBT Header"."Pay Mode")
            {
            }
            column(PayingAccount_IBTHeader; "IBT Header"."Paying Account")
            {
            }
            column(PayingAccountName_IBTHeader; "IBT Header"."Paying Account Name")
            {
            }
            column(PayingAccountCurrencyCode_IBTHeader; "IBT Header"."Paying Account Currency Code")
            {
            }
            column(PayingAccountBalance_IBTHeader; "IBT Header"."Paying Account Balance")
            {
            }
            column(PayingAccountBalanceLCY_IBTHeader; "IBT Header"."Paying Account Balance (LCY)")
            {
            }
            column(PayingAccountBankNo_IBTHeader; "IBT Header"."Paying Account Bank No.")
            {
            }
            column(Status_IBTHeader; "IBT Header".Status)
            {
            }
            column(LastModifiedBy_IBTHeader; "IBT Header"."Last Modified By")
            {
            }
            column(LastModifiedDateTime_IBTHeader; "IBT Header"."Last Modified Date/Time")
            {
            }
            column(AmounttoTransfer_IBTHeader; "IBT Header"."Amount to Transfer")
            {
            }
            column(AmounttoTransferLCY_IBTHeader; "IBT Header"."Amount to Transfer (LCY)")
            {
            }
            column(NoSeries_IBTHeader; "IBT Header"."No. Series")
            {
            }
            column(ExchangeRate_IBTHeader; "IBT Header"."Exchange Rate")
            {
            }
            column(ChequeDocNo_IBTHeader; "IBT Header"."Cheque / Doc. No")
            {
            }
            column(TransferReleaseDate_IBTHeader; "IBT Header"."Transfer Release Date")
            {
            }
            column(TotalLinesAmountLCY_IBTHeader; "IBT Header"."Total Lines Amount (LCY)")
            {
            }
            column(Remarks_IBTHeader; "IBT Header".Remarks)
            {
            }
            column(Posted_IBTHeader; "IBT Header".Posted)
            {
            }
            column(DatePosted_IBTHeader; "IBT Header"."Date Posted")
            {
            }
            column(TimePosted_IBTHeader; "IBT Header"."Time Posted")
            {
            }
            column(PostedBy_IBTHeader; "IBT Header"."Posted By")
            {
            }
            column(PostedOnComputerName_IBTHeader; "IBT Header"."Posted On Computer Name")
            {
            }
            column(CreatedBy_IBTHeader; "IBT Header"."Created By")
            {
            }
            column(CancelledBy_IBTHeader; "IBT Header"."Cancelled By")
            {
            }
            column(PayingAccountMaxCredit_IBTHeader; "IBT Header"."Paying Account Max. Credit")
            {
            }
            column(CurrencyCodeDestination_IBTHeader; "IBT Header"."Currency Code Destination")
            {
            }
            column(CurrencyCodeSource_IBTHeader; "IBT Header"."Currency Code Source")
            {
            }
            column(ResponsibilityCenter_IBTHeader; "IBT Header"."Responsibility Center")
            {
            }
            dataitem("IBT Lines"; "IBT Lines")
            {
                DataItemLink = "No." = field("No.");
                column(ReportForNavId_32; 32)
                {
                }
                column(No_IBTLines; "IBT Lines"."No.")
                {
                }
                column(Date_IBTLines; "IBT Lines".Date)
                {
                }
                column(PayMode_IBTLines; "IBT Lines"."Pay Mode")
                {
                }
                column(RecievingAccount_IBTLines; "IBT Lines"."Recieving Account")
                {
                }
                column(RecievingAccountName_IBTLines; "IBT Lines"."Recieving Account Name")
                {
                }
                column(RecievinAccountCurrencyCode_IBTLines; "IBT Lines"."Recievin Account Currency Code")
                {
                }
                column(RecievingAccountBalance_IBTLines; "IBT Lines"."Recieving Account Balance")
                {
                }
                column(ReceivinAccountBalanceLCY_IBTLines; "IBT Lines"."Receivin Account Balance (LCY)")
                {
                }
                column(RecievingAccountBankNo_IBTLines; "IBT Lines"."Recieving Account Bank No.")
                {
                }
                column(LineNo_IBTLines; "IBT Lines"."Line No.")
                {
                }
                column(AmounttoReceive_IBTLines; "IBT Lines"."Amount to Receive")
                {
                }
                column(AmounttoReceiveLCY_IBTLines; "IBT Lines"."Amount to Receive (LCY)")
                {
                }
                column(ExchangeRate_IBTLines; "IBT Lines"."Exchange Rate")
                {
                }
                column(ExternalDocNo_IBTLines; "IBT Lines"."External Doc No.")
                {
                }
            }
            dataitem("Company Information"; "Company Information")
            {
                column(ReportForNavId_1000000002; 1000000002)
                {
                }
                column(Picture_CompanyInformation; "Company Information".Picture)
                {
                }
#pragma warning disable AL0432
                column(HomePage_CompanyInformation; "Company Information"."Home Page")
#pragma warning restore AL0432
                {
                }
                column(EMail_CompanyInformation; "Company Information"."E-Mail")
                {
                }
                column(Address_CompanyInformation; "Company Information".Address)
                {
                }
                column(Name_CompanyInformation; "Company Information".Name)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("IBT Header"."Total Lines Amount (LCY)");
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, ("IBT Header"."Total Lines Amount (LCY)"), '');
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.Get();
                CompInfo.CalcFields(CompInfo.Picture);
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
        PreparedBy = 'Prepared by :.......................................................... Date :..................... Signature :.........................................';
        ApprovedBy = 'Approved by :.......................................................... Date :..................... Signature :.........................................';
    }

    var
        CheckReport: Report Check;
        NumberText: array[2] of Text[250];
        Users: Record User;
        ProcessedBy: Text[50];
        ApprovalEntry: Record "Approval Entry";
        ApprovedBy: Text[50];
        CompInfo: Record "Company Information";
}

