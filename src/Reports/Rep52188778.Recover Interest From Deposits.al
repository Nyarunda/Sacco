namespace CentralDB.CentralDB;

report 50460 "Recover Interest From Deposits"
{
    ApplicationArea = All;
    Caption = 'Recover Interest From Deposits';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Total Arrears" = filter('>0'), "Mobile Loan" = const(false));
            RequestFilterFields = "Disbursement Date", "Loan No.";

            trigger OnPreDataItem()
            var
                myInt: Integer;
                SaccoActivities: Codeunit "Sacco Activities";
                JTemplate: Code[20];
                JBatch: Code[20];
            begin
                SaccoActivities.GetPaymentJournalTemplate(JTemplate, JBatch);
                SaccoActivities.JournalInit(JTemplate, JBatch);
            end;

            trigger OnAfterGetRecord()
            var
                MA: Codeunit "Member Activities";
                Member: Record Members;
            begin
                Member.Reset();
                Member.SetRange("No.", Loans."Member No.");
                Member.SetFilter("Member Status", '%1|%2|%3', Member."Member Status"::Active, Member."Member Status"::New, Member."Member Status"::Dormant);
                if member.FindFirst() then
                    MA.InterestRecovery(Loans, PDate);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(PDate; PDate)
                    {
                        ApplicationArea = basic;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        PDate: Date;
}
