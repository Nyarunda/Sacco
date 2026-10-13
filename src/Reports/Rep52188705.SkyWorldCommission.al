report 50368 "Sky World Commission"
{
    Caption = 'Sky World Commission';

    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Sky World Commission.rdl';
    dataset
    {
        dataitem(SkyMobileSetup; "Sky Mobile Setup.")
        {
            RequestFilterFields = "Transaction Type";
            column(No; No)
            {
            }
            column(TransactionType; "Transaction Type")
            {
            }
            column(Commission; Commission)
            {
            }
            column(SDate; SDate)
            {
            }
            column(EDate; EDate)
            {
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                VLedger: Record "Savings Ledger Entry";
                MTrans: Record "Sky Transactions.";
                SActivities: Codeunit "Sacco Activities";

                dWindow: Dialog;
                CurrentRecordNo: Integer;
                NoOfRecords: Integer;
                Loans: Record Loans;
            begin

                Commission := 0;

                if SkyMobileSetup."Transaction Type" = SkyMobileSetup."Transaction Type"::"Loan Disbursement" then begin


                    VLedger.Reset();
                    VLedger.LoadFields(Amount);
                    VLedger.SetRange("Account No.", SkyMobileSetup."Vendor Commission Account");
                    VLedger.SetRange("Posting Date", SDate, EDate);
                    VLedger.SetRange(Reversed, false);
                    //VLedger.SetRange("Sky Trans Type", VLedger."Sky Trans Type"::" ");
                    if VLedger.FindSet(false) then begin
                        NoOfRecords := VLedger.Count;
                        CurrentRecordNo := 0;
                        SActivities.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);
                        repeat
                            CurrentRecordNo += 1;
                            SActivities.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, Format(SkyMobileSetup."Transaction Type"));
                            if Loans.Get(VLedger."Document No.") then
                                Commission += VLedger.Amount * -1;
                        until VLedger.Next() = 0;
                        SActivities.ProgressClose(dWindow);
                    end;
                end
                else begin

                    VLedger.Reset();
                    VLedger.LoadFields(Amount);
                    VLedger.SetRange("Account No.", SkyMobileSetup."Vendor Commission Account");
                    VLedger.SetRange("Posting Date", SDate, EDate);
                    VLedger.SetRange(Reversed, false);
                    //VLedger.SetRange("Sky Trans Type", SkyMobileSetup."Transaction Type");
                    if VLedger.FindSet(false) then begin
                        NoOfRecords := VLedger.Count;
                        CurrentRecordNo := 0;
                        SActivities.ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);
                        repeat
                            CurrentRecordNo += 1;
                            SActivities.ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, Format(SkyMobileSetup."Transaction Type"));

                            Commission += VLedger.Amount * -1;
                        until VLedger.Next() = 0;
                        SActivities.ProgressClose(dWindow);
                    end;
                end;

                if Commission <= 0 then
                    CurrReport.Skip();
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(DateFilter)
                {
                    field("Start Date"; SDate)
                    {
                        ApplicationArea = Basic;
                    }
                    field("End Date"; EDate)
                    {
                        ApplicationArea = Basic;
                    }
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
        EDate: Date;
        SDate: Date;
        Commission: Decimal;
}
