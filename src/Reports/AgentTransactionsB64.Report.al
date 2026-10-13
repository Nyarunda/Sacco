Report 50313 "Agent Transactions B64"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Agent Transactions B64.rdlc';

    dataset
    {
        dataitem("Sky Agents Transactions"; "Sky Agents Transactions")
        {
            DataItemTableView = sorting("Transaction Date", "Time Posted") where(Posted = const(true));
            RequestFilterFields = "Date Posted", "Agent Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(TransactionID_SkyAgentsTransactions; "Sky Agents Transactions"."Transaction ID")
            {
            }
            column(TransactionDate_SkyAgentsTransactions; "Sky Agents Transactions"."Transaction Date")
            {
            }
            column(AgentCode_SkyAgentsTransactions; "Sky Agents Transactions"."Agent Code")
            {
            }
            column(MemberAccount_SkyAgentsTransactions; "Sky Agents Transactions"."Member Account")
            {
            }
            column(MemberNo_SkyAgentsTransactions; "Sky Agents Transactions"."Member No")
            {
            }
            column(VendorCommission_SkyAgentsTransactions; "Sky Agents Transactions"."Vendor Commission")
            {
            }
            column(SaccoFee_SkyAgentsTransactions; "Sky Agents Transactions"."Sacco Fee")
            {
            }
            column(Description_SkyAgentsTransactions; "Sky Agents Transactions".Description)
            {
            }
            column(Amount_SkyAgentsTransactions; "Sky Agents Transactions".Amount)
            {
            }
            column(DatePosted_SkyAgentsTransactions; "Sky Agents Transactions"."Date Posted")
            {
            }
            column(TransactionType_SkyAgentsTransactions; "Sky Agents Transactions"."Transaction Type")
            {
            }
            column(TransactionName_SkyAgentsTransactions; "Sky Agents Transactions"."Transaction Name")
            {
            }
            column(LoanNo_SkyAgentsTransactions; "Sky Agents Transactions"."Loan No.")
            {
            }
            column(MobileNo_SkyAgentsTransactions; "Sky Agents Transactions"."Mobile No.")
            {
            }
            column(ClientName_SkyAgentsTransactions; "Sky Agents Transactions"."Client Name")
            {
            }
            column(AgentComm; AgentComm)
            {
            }
            column(PrintedAt; PrintedAt)
            {
            }
            column(PrintedBy; PrintedBy)
            {
            }
            column(TransactionTime_SkyAgentsTransactions; "Sky Agents Transactions"."Transaction Time")
            {
            }
            column(AgentCode; AgentCode)
            {
            }
            column(AgentName; AgentName)
            {
            }
            column(MemberName; MemberName)
            {
            }
            column(DateAndTime; DateAndTime)
            {
            }
            column(MobileNumberName; MobileNumberName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                VendorLedgerEntry.Reset;
                VendorLedgerEntry.SetRange("Account No.", "Sky Agents Transactions"."Agent Commision Account");
                VendorLedgerEntry.SetRange("Document No.", "Sky Agents Transactions"."Transaction ID");
                if VendorLedgerEntry.FindFirst then begin
                    VendorLedgerEntry.CalcFields(Amount);
                    AgentComm := VendorLedgerEntry.Amount;
                    AgentComm := Abs(AgentComm);
                end;
                DateAndTime := Format("Sky Agents Transactions"."Date Posted", 0, '<Day,2>/<Month,2>/<Year4>') + Format("Sky Agents Transactions"."Time Posted");
                if "Sky Agents Transactions"."Member No" <> '' then begin
                    MemberName := SkyAgencyBanking.FormatName("Sky Agents Transactions"."Member No");
                end;
                MobileNumberName := "Sky Agents Transactions"."Mobile No." + '(' + MemberName + ')';
            end;

            trigger OnPreDataItem()
            begin
                AgentCode := "Sky Agents Transactions".GetFilter("Sky Agents Transactions"."Agent Code");
                if AgentApplications.Get(AgentCode) then
                    AgentName := AgentApplications."Name of the Proposed Agent";
                if AgentCode = '' then begin
                    AgentCode := '0';
                    AgentName := 'All Agents';
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
        PrintedBy := UserId;
        Pos := StrPos(PrintedBy, '\');
        PrintedBy := CopyStr(PrintedBy, Pos + 1, 50);
        PrintedAt := CurrentDatetime;
        //if CurrReport.PageNo <> 1 then CurrReport.SHOWOUTPUT(false);
    end;

    var
        AgentComm: Decimal;
        VendorLedgerEntry: Record "Savings Ledger Entry";
        PrintedBy: Code[50];
        PrintedAt: DateTime;
        Pos: Integer;
        AgentCode: Code[40];
        AgentName: Text;
        AgentApplications: Record "Agent Applications";
        DateAndTime: Text;
        MemberNo: Code[30];
        MemberName: Text;
        SkyAgencyBanking: Codeunit "Sky Agency Banking";
        Members: Record Members;
        MobileNumberName: Text;
}

