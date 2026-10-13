
Report 50147 "Paybill Account Trail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Paybill Account Trail.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = where("G/L Account No." = filter('20311'));
            RequestFilterFields = "Posting Date";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(CreditAmount_GLEntry; "G/L Entry"."Credit Amount")
            {
            }
            column(DebitAmount_GLEntry; "G/L Entry"."Debit Amount")
            {
            }
            column(Description_GLEntry; "G/L Entry".Description)
            {
            }
            column(PostingDate_GLEntry; "G/L Entry"."Posting Date")
            {
            }
            column(GLAccountName_GLEntry; "G/L Entry"."G/L Account Name")
            {
            }
            column(GLAccountNo_GLEntry; "G/L Entry"."G/L Account No.")
            {
            }
            column(SourceType_GLEntry; "G/L Entry"."Source Type")
            {
            }
            column(UserID_GLEntry; "G/L Entry"."User ID")
            {
            }
            column(SourceCode_GLEntry; "G/L Entry"."Source Code")
            {
            }
            column(SourceNo_GLEntry; "G/L Entry"."Source No.")
            {
            }
            column(CreatedTime; CreatedTime)
            {
            }
            column(ExternalDocumentNo_GLEntry; "G/L Entry"."External Document No.")
            {
            }
            column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
            {
            }
            column(TimePosted_GLEntry; LMTime)
            {
            }
            dataitem("G/L Account"; "G/L Account")
            {
                CalcFields = "Net Change";
                DataItemLink = "No." = field("G/L Account No.");
                column(ReportForNavId_1; 1)
                {
                }
                column(NetChange_GLAccount; "G/L Account"."Net Change")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                ObjGlregister.Reset;
                ObjGlregister.SetRange(ObjGlregister."No.", "G/L Entry"."Entry No.");
                if ObjGlregister.Find('-') then begin
                    CreatedTime := ObjGlregister."Creation Time";
                end;

                LMTime := Dt2Time("G/L Entry"."Last Modified DateTime");

                if (LMTime < STime) then
                    CurrReport.Skip;
                if (LMTime > ETime) then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                if ETime = 0T then
                    ETime := Time;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Time"; STime)
                {
                    ApplicationArea = Basic;
                }
                field("End Time"; ETime)
                {
                    ApplicationArea = Basic;
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        ObjGlregister: Record "G/L Register";
        CreatedTime: Time;
        LMTime: Time;
        STime: Time;
        ETime: Time;
}

