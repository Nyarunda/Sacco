
Page 50076 "Mpesa Manual Upload"
{
    ApplicationArea = Basic;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Mpesa Manual Upload";
    SourceTableView = where(Transfered = filter(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AlreadyPosted; Rec."Already Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ReceiptNo; Rec."Receipt No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CompletionTime; Rec."Completion Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(PaidIn; Rec."Paid In")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ACNo; Rec."A/C No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NeedsChange; Rec."Needs Change")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Validated; Rec.Validated)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Details; Rec.Details)
                {
                    ApplicationArea = Basic;
                }
                field(OtherPartyInfo; Rec."Other Party Info")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(KeyWord; Rec."Key Word")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LoanNo; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LoanBalance; Rec."Loan Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Transfered; Rec.Transfered)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NewAccountNo; Rec."New Account No")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Transfered, false);
                        Rec.TestField(Validated, false);
                        Rec.TestField("Needs Change", true);
                    end;
                }
                field(DateUploaded; Rec."Date Uploaded")
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
            group(ActionGroup19)
            {
            }
            action("Import Paybill Transactions")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = XMLport "Import Paybill";
            }
            action(Clear)
            {
                ApplicationArea = Basic;
                Image = Default;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to Clear All Untransfered Entries?') then begin
                        MpesaManualUpload.Reset;
                        MpesaManualUpload.SetRange(Transfered, false);
                        if MpesaManualUpload.Find('-') then begin
                            MpesaManualUpload.DeleteAll;
                        end;
                    end;
                end;
            }
            action("Validate Entries")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    MpesaManualUpload.Reset;
                    MpesaManualUpload.SetRange(Transfered, false);
                    //MpesaManualUpload.SETRANGE("A/C No.",'ORD9609');
                    if MpesaManualUpload.Find('-') then begin
                        repeat
                            MpesaManualUpload."Already Posted" := false;
                            MpesaManualUpload.Validated := true;

                            BLedger.Reset;
                            BLedger.SetRange("Document No.", MpesaManualUpload."Receipt No.");
                            if BLedger.FindFirst then begin

                                MpesaManualUpload."Already Posted" := true;
                                MpesaManualUpload.Validated := false;
                                MpesaManualUpload.Transfered := true;
                            end;


                            SpotTrans.Reset;
                            SpotTrans.SetRange("Reference No.", MpesaManualUpload."Receipt No.");
                            if SpotTrans.Find('-') then begin
                                MpesaManualUpload.Validated := false;
                                MpesaManualUpload.Transfered := true;
                            end;

                            SkyTrans.Reset;
                            SkyTrans.SetRange("Transaction ID", MpesaManualUpload."Receipt No.");
                            if SkyTrans.Find('-') then begin
                                MpesaManualUpload.Validated := false;
                                MpesaManualUpload.Transfered := true;
                            end;

                            MpesaManualUpload.Modify;

                        until MpesaManualUpload.Next = 0;
                    end;




                    Message('Validated');

                end;
            }
            action(Transfer)
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    MpesaManualUpload: Record "Mpesa Manual Upload";
                    MBankingTransactions: Record "Sky M-Banking Transactions";
                    AccountNo: Code[20];
                    LoanNo: Code[20];
                    "Key": Text;
                    i: BigInteger;
                begin


                    if Confirm('Are you sure you want to transfer all validated Entries?') then begin
                        MBankingTransactions.Reset();
                        if MBankingTransactions.FindLast() then
                            i := MBankingTransactions."No.";

                        MpesaManualUpload.Reset;
                        MpesaManualUpload.SetRange(Validated, true);
                        MpesaManualUpload.SetRange(Transfered, false);
                        MpesaManualUpload.SetRange("Already Posted", false);
                        if MpesaManualUpload.Find('-') then begin
                            repeat

                                MBankingTransactions.Reset;
                                MBankingTransactions.SetRange(MBankingTransactions."Originator ID", MpesaManualUpload."Receipt No.");
                                if MBankingTransactions.Find('-') = false then begin

                                    i += 1;
                                    MBankingTransactions.Init;
                                    MBankingTransactions."No." := i;
                                    MBankingTransactions."Originator ID" := MpesaManualUpload."Receipt No.";
                                    MBankingTransactions."Transaction ID" := MpesaManualUpload."Receipt No.";
                                    //MBankingTransactions."Session ID":=TransactionID;
                                    MBankingTransactions."Transaction Type" := MBankingTransactions."transaction type"::"Mpesa Deposit";
                                    MBankingTransactions."Transaction Description" := CopyStr(MpesaManualUpload.Details, 1, 50);
                                    MBankingTransactions."Transaction Date" := Dt2Date(MpesaManualUpload."Initiation Time");
                                    MBankingTransactions."Transaction Time" := Dt2Time(MpesaManualUpload."Initiation Time");
                                    MBankingTransactions."Beneficiary Account" := MpesaManualUpload."A/C No.";
                                    MBankingTransactions."Savings Account" := MpesaManualUpload."A/C No.";
                                    MBankingTransactions."Transaction Amount" := MpesaManualUpload."Paid In";
                                    MBankingTransactions."Loan No." := MpesaManualUpload."Loan No";
                                    MBankingTransactions."Manually Inserted" := TRUE;
                                    MBankingTransactions.Insert;


                                    MpesaManualUpload.Transfered := true;
                                    MpesaManualUpload.Modify;

                                end;
                            until MpesaManualUpload.Next = 0;
                        end;

                        MpesaManualUpload.RESET;
                        MpesaManualUpload.SETRANGE(Validated, TRUE);
                        MpesaManualUpload.SETRANGE(Transfered, FALSE);
                        MpesaManualUpload.SETRANGE("Already Posted", FALSE);
                        MpesaManualUpload.SETFILTER(Withdrawn, '<0');
                        IF MpesaManualUpload.FIND('-') THEN BEGIN
                            REPEAT

                                MBankingTransactions.RESET;
                                MBankingTransactions.SETRANGE(MBankingTransactions."Transaction ID", MpesaManualUpload."Receipt No.");
                                IF MBankingTransactions.FIND('-') = FALSE THEN BEGIN

                                    i += 1;
                                    MBankingTransactions.INIT;
                                    MBankingTransactions."No." := i;
                                    MBankingTransactions."Originator ID" := MpesaManualUpload."Receipt No.";
                                    MBankingTransactions."Transaction Type" := MBankingTransactions."Transaction Type"::"Mpesa Withdrawal";
                                    MBankingTransactions."Transaction Description" := COPYSTR(MpesaManualUpload.Details, 1, 50);
                                    MBankingTransactions."Transaction Date" := DT2DATE(MpesaManualUpload."Initiation Time");
                                    MBankingTransactions."Transaction Time" := DT2TIME(MpesaManualUpload."Initiation Time");
                                    MBankingTransactions."Source Account" := MpesaManualUpload."A/C No.";
                                    MBankingTransactions."Savings Account" := MpesaManualUpload."A/C No.";
                                    MBankingTransactions."Transaction Amount" := MpesaManualUpload.Withdrawn;// * -1;
                                    MBankingTransactions."Loan No." := MpesaManualUpload."Loan No";
                                    //MBankingTransactions."Paybill Member ID" := MpesaManualUpload."A/C No.";
                                    //MBankingTransactions."Destination Account" := '';
                                    //MBankingTransactions."Destination Name" := '';
                                    //MBankingTransactions.Organization := '';
                                    MBankingTransactions."Manually Inserted" := TRUE;
                                    MBankingTransactions.INSERT;


                                    MpesaManualUpload.Transfered := TRUE;
                                    MpesaManualUpload.MODIFY;

                                END;
                            UNTIL MpesaManualUpload.NEXT = 0;
                        END;
                    end;
                end;
            }
        }
    }

    var
        //MobileBanking: Codeunit MobileBanking;
        MpesaManualUpload: Record "Mpesa Manual Upload";
        SpotTrans: Record "Spotcash Transactions";
        SkyTrans: Record "Sky Transactions.";
        MBankingTransactions: Record "MBanking Transactions";
        AccountNo: Text;
        LoanNo: Code[20];
        "Key": Text;
        MemberNo: Code[20];
        LBal: Decimal;
        PAct: Code[20];
        BLedger: Record "Bank Account Ledger Entry";
}

