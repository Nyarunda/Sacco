report 50363 "Loan Reminder SMSS"
{
    ApplicationArea = All;
    Caption = 'Loan Reminder SMS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true), "Mobile Loan" = const(true));
            trigger OnPreDataItem()
            begin
                SSetup.get;
            end;

            trigger OnAfterGetRecord()
            var
                CustNot: Codeunit "Send Custom Notifications";
            begin
                if SSetup."Reminder SMs Date" = today then begin
                    CustNot.CreditPaymentDue(Loans."Loan No.");
                    CustNot.CreditDefaulterSMS(Loans."Loan No.");
                end;
            end;

            trigger OnPostDataItem()
            begin
                SSetup."Reminder SMs Date" := CalcDate('CM', Today);
                SSetup.Modify();
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        SSetup: Record "Sacco Setup";
}
