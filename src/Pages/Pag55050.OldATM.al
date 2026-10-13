page 55050 "Old ATM"
{
    Caption = 'Old ATM';
    PageType = List;
    SourceTable = "ATM Transactions";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Trace ID"; Rec."Trace ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Trace ID field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Posting S"; Rec."Posting S")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting S field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Unit ID"; Rec."Unit ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit ID field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Trans Time"; Rec."Trans Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Trans Time field.';
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Time field.';
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Date field.';
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source field.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
                field("Reversed Posted"; Rec."Reversed Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reversed Posted field.';
                }
                field("Reversal Trace ID"; Rec."Reversal Trace ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reversal Trace ID field.';
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Description field.';
                }
                field("Withdrawal Location"; Rec."Withdrawal Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Withdrawal Location field.';
                }
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No field.';
                }
                field("Transaction Type Charges"; Rec."Transaction Type Charges")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Type Charges field.';
                }
                field("Card Acceptor Terminal ID"; Rec."Card Acceptor Terminal ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Card Acceptor Terminal ID field.';
                }
                field("ATM Card No"; Rec."ATM Card No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ATM Card No field.';
                }
                field("Customer Names"; Rec."Customer Names")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Names field.';
                }
                field("Process Code"; Rec."Process Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Process Code field.';
                }
                field("Is Coop Bank"; Rec."Is Coop Bank")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Is Coop Bank field.';
                }
                field("POS Vendor"; Rec."POS Vendor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the POS Vendor field.';
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reference No field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PostATM)
            {
                ApplicationArea = Basic;
                Image = Default;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()

                var
                    ExciseDutyGL: Code[20];
                    ExciseDutyRate: Decimal;
                    ExciseDuty: Decimal;
                    CoopSetup: Record "Coop ATM  Setup";
                    ChargeAmount: Decimal;
                    TransAmount: Decimal;
                    JTemplate: Code[30];
                    JBatch: Code[30];
                    GenLedgerSetup: Record "General Ledger Setup";
                    GenSetup: Record "Sacco Setup";
                    BUser: Record "User Setup";
                    SaccoTrans: Codeunit "Sacco Activities";
                    DocNo: Code[20];
                    PDate: Date;
                    AcctType: Enum "Gen. Journal Account Type";
                    BalAccType: Enum "Gen. Journal Account Type";
                    TransType: Enum "Transaction Type Enum";
                    AccNo: Code[20];
                    BalAccNo: Code[20];
                    SourceType: Enum "SMS Source Enum";
                    ExtDoc: Code[20];
                    LoanNo: Code[20];
                    Dim1: Code[30];
                    Dim2: Code[30];
                    SystCreated: Boolean;
                    SLedger: Record "G/L Entry";
                    Sep: label '\::/';
                    Null: label 'NULL';
                    Success: label '200';
                    Account_Does_Not_Exist: label '300';
                    Parameters_Not_Valid_Or_Missing: label '400';
                    Caller_Not_Authorized_For_This_Request: label '401';
                    Insufficient_Funds: label '402';
                    Daily_Amount_Limit_Reached: label '403';
                    Operation_Does_Not_Exist: label '404';
                    Daily_Frequency_Limit_Reached: label '405';
                    Severe_problem_Has_Occured: label '500';
                    CoopCode: Record "Coop Transaction Codes";
                    Continue: Boolean;
                    LedgerCount: Integer;
                    CurrRecord: Integer;
                    EndRec: label '\::::/';
                    SavAcc: Record "Savings Accounts";
                    GenJournalBatch: Record "Gen. Journal Batch";
                    ConnectionMode: Text;

                    StringWriter: Text;
                    ATM_No: Text;
                    BankCharge: Decimal;
                    SaccoFee: Decimal;
                    TerminalCode: Code[20];
                    CRate: Decimal;
                    MobileBanking: Codeunit "Sky Mbanking";
                    MActivities: Codeunit "Member Activities";
                    ChannelCode: Text;
                    Desc: Text;
                    AcctNo: Code[20];
                    BankAccount: Code[20];
                    Vendor: Record "Savings Accounts";
                    TTYpe: Code[20];
                    Channel: Code[20];
                    Terminal: Code[20];
                    TotalCharge: Decimal;
                    TChannel: Enum "Transaction Channel";
                    DimID: Integer;


                begin
                    if Confirm('Are you sure you want to Post Entries?') then begin

                        DocNo := Rec."Reference No";
                        PDate := DMY2Date(30, 11, 2022);
                        PDate := today;
                        AcctNo := Rec."Account No";
                        ExtDoc := '';
                        LoanNo := '';
                        DimID := SavAcc."Dimension Set ID";
                        TransType := Transtype::" ";
                        Dim1 := SavAcc."Global Dimension 1 Code";
                        Dim2 := SavAcc."Global Dimension 2 Code";
                        SystCreated := true;
                        Continue := true;
                        if Vendor.Get(AcctNo) then
                            if Vendor.Blocked <> Vendor.Blocked::" " then
                                Continue := false;

                        TChannel := TChannel::ATM;

                        BankAccount := '';
                        if Continue then begin

                            if Continue then begin
                                SaccoTrans.JournalInit(JTemplate, JBatch);
                                TTYpe := '';
                                Terminal := '';
                                Channel := '';
                                if Rec.Description = 'Cash W/d - Coop Bank' then begin
                                    TTYpe := '0011';
                                    Terminal := 'ATM';
                                    Channel := '';
                                end;



                                if Rec.Description = 'Cash W/d - Visa Atm' then begin
                                    TTYpe := '0011';
                                    Terminal := '';
                                    Channel := '';
                                end;

                                if Rec.Description = 'Pos Normal Purchase' then begin
                                    TTYpe := '0027';
                                    Terminal := '';
                                    Channel := '';
                                end;
                                if Rec.Description = 'Pos-balance Enquiry' then begin
                                    TTYpe := '0016';
                                    Terminal := 'POS';
                                    Channel := 'AG';
                                end;
                                if Rec.Description = 'Pos Normal Purchase' then begin
                                    TTYpe := '0027';
                                    Terminal := '';
                                    Channel := '';
                                end;
                                if Rec.Description = 'Pos-cash Withdrawal' then begin
                                    TTYpe := '0011';
                                    Terminal := 'POS';
                                    Channel := 'AG';
                                end;


                                BankAccount := GetCoopBankAccount(TTYpe, Terminal, Channel);


                                // Get Excise duty G/L
                                ExciseDutyGL := GetExciseDutyGL();
                                ExciseDutyRate := GetExciseRate();
                                ExciseDuty := 0;

                                BankCharge := 0;
                                SaccoFee := 0;
                                GetATMcharges(TTYpe, Terminal, Channel, Rec.Amount, BankCharge, SaccoFee);
                                TotalCharge := BankCharge + SaccoFee;
                                ExciseDuty := ROUND(SaccoFee * ExciseDutyRate / 100);


                                if Confirm('TotalCharge: ' + Format(TotalCharge) + '\ExciseDuty: ' + Format(ExciseDuty) + '\ Proceed?') then begin

                                    SaccoTrans.GetGeneralJournalTemplate(JTemplate, JBatch);
                                    SaccoTrans.JournalInit(JTemplate, JBatch);
                                    Desc := Rec.Description;

                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AcctNo, CopyStr(Desc, 1, 50), Balacctype::"Bank Account",
                                                  BankAccount, Rec.Amount, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AcctNo, CopyStr('Fee on ' + Desc, 1, 50), Balacctype::"G/L Account",
                                                  '', TotalCharge + ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty - ' + Desc, 1, 50), Balacctype::"G/L Account",
                                                  '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);


                                    AcctNo := BankAccount;
                                    ExtDoc := Rec."Account No";
                                    LoanNo := '';
                                    TransType := Transtype::" ";
                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", BankAccount, CopyStr(Desc + ': ' + Rec."Account No", 1, 50), Balacctype::"G/L Account",
                                                  '', -BankCharge, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                                    CoopSetup.Get();
                                    AcctNo := CoopSetup."Coop Fee Account";
                                    ExtDoc := Rec."Account No";
                                    LoanNo := '';
                                    TransType := Transtype::" ";

                                    SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", AcctNo, CopyStr(Desc + ': ' + Rec."Account No", 1, 50), Balacctype::"G/L Account",
                                                  '', -SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated, TChannel, DimID);

                                    Rec.Posted := true;
                                    Rec.Modify;


                                    SaccoTrans.JournalPost(JTemplate, JBatch);

                                end;

                            end;
                        end;
                    end;
                End;
            }
            action(ReversATM)
            {
                ApplicationArea = Basic;
                Image = Default;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Reverse this Entry?') then begin




                        Rec.Posted := true;
                        Rec.Reversed := true;


                        Rec.Modify;

                        Message('Reversed');
                    end;
                End;
            }
        }
    }



    procedure GetCoopBankAccount(TransCode: Code[10]; Terminal: Code[10]; Channel: Code[10]) BankAccount: Code[20]
    var
        Charge: Record "Coop Transaction Codes";
        Counter: Integer;
        CoopSetup: Record "Coop ATM  Setup";
    begin

        BankAccount := '';

        Charge.Reset;
        Charge.SetRange(Charge.Code, TransCode);
        Charge.SetRange(Charge.Terminal, Terminal);
        Charge.SetRange(Charge.Channel, Channel);

        if Charge.FindFirst then begin
            BankAccount := Charge."Coop Bank Account";
        end;

        if BankAccount = '' then begin
            CoopSetup.Get();
            BankAccount := CoopSetup."Coop Bank Account";
        end;
    end;


    procedure GetATMcharges(TransCode: Code[10]; Terminal: Code[10]; Channel: Code[10]; Amount: Decimal; var BankCharge: Decimal; var SaccoFee: Decimal)
    var
        Charge: Record "Coop ATM Charges";
        Counter: Integer;
    begin

        BankCharge := 0;
        SaccoFee := 0;
        Charge.Reset;
        Charge.SetRange(Charge.Code, TransCode);
        //if (TransCode <> '0016') and (TransCode <> '0014') then begin
        Charge.SetRange(Charge.Terminal, Terminal);
        Charge.SetRange(Charge.Channel, Channel);
        //end;
        Charge.SetFilter(Charge.Minimum, '<=%1', Amount);
        Charge.SetFilter(Charge.Maximum, '>=%1', Amount);
        if Charge.FindFirst then begin
            BankCharge := Charge."Bank Commission";
            SaccoFee := Charge."Sacco Commission";

            if Charge."Sacco Per Every" > 0 then begin
                Counter := ROUND(Amount / Charge."Sacco Per Every", 1, '>');
                SaccoFee := SaccoFee * Counter;
            end;

        end;
    end;


    procedure GetExciseRate() rate: Integer
    begin


        GenSetup.Get;
        GenSetup.TestField(GenSetup."Excise Duty (%)");
        rate := GenSetup."Excise Duty (%)";

    end;


    procedure GetExciseDutyGL() account: Text[20]
    begin

        GenSetup.Reset;
        GenSetup.Get;
        GenSetup.TestField(GenSetup."Excise Duty GL");
        account := GenSetup."Excise Duty GL";

    end;

    var
        GenSetup: Record "Sacco Setup";
}

