
Page 50085 "Mpesa Manual Upload- Moved"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Mpesa Manual Upload";
    SourceTableView = where(Transfered = filter(true));
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
                //RunObject = XMLport "Import Paybill";
            }
            action(Clear)
            {
                ApplicationArea = Basic;
                Image = Default;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to CLear All Untransfered Entries?') then begin
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
                    MpesaManualUpload.SetRange(Validated, false);
                    MpesaManualUpload.SetRange(Transfered, false);
                    //MpesaManualUpload.SETRANGE("A/C No.",'117281');
                    if MpesaManualUpload.Find('-') then begin
                        repeat
                            MpesaManualUpload."Already Posted" := false;

                            BLedger.Reset;
                            BLedger.SetRange("Document No.", MpesaManualUpload."Receipt No.");
                            if BLedger.FindFirst then begin

                                MpesaManualUpload."Already Posted" := true;
                                MpesaManualUpload.Validated := false;
                            end
                            else begin
                                MemberNo := '';
                                Key := '';
                                AccountNo := '';
                                LoanNo := '';
                                LBal := 0;
                                PAct := MpesaManualUpload."A/C No.";
                                if (MpesaManualUpload."Needs Change") and (MpesaManualUpload."New Account No" <> '') then
                                    PAct := MpesaManualUpload."New Account No";

                                MpesaManualUpload."Needs Change" := true;


                                //MobileBanking.GetPayBillAccount(PAct, MemberNo, AccountNo, LoanNo, Key, LBal);

                                if MemberNo <> '' then
                                    if AccountNo <> '' then begin
                                        MpesaManualUpload."Loan No" := LoanNo;
                                        MpesaManualUpload."Account No" := AccountNo;
                                        MpesaManualUpload."Key Word" := Key;
                                        MpesaManualUpload.Validated := true;
                                        MpesaManualUpload."Loan Balance" := LBal;
                                        MpesaManualUpload."Needs Change" := false;
                                    end;

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
                    MBankingTransactions: Record "MBanking Upload Transactions";
                    AccountNo: Code[20];
                    LoanNo: Code[20];
                    "Key": Text;
                begin


                    if Confirm('Are you sure you want to transfer all validated Entries?') then begin
                        MpesaManualUpload.Reset;
                        MpesaManualUpload.SetRange(Validated, true);
                        MpesaManualUpload.SetRange(Transfered, false);
                        MpesaManualUpload.SetRange("Already Posted", false);
                        if MpesaManualUpload.Find('-') then begin
                            repeat

                                MBankingTransactions.Reset;
                                MBankingTransactions.SetRange(MBankingTransactions."Transaction ID", MpesaManualUpload."Receipt No.");
                                if MBankingTransactions.Find('-') = false then begin

                                    MBankingTransactions.Init;
                                    MBankingTransactions."Entry No." := CreateGuid;
                                    MBankingTransactions."Transaction ID" := MpesaManualUpload."Receipt No.";
                                    ;
                                    //MBankingTransactions."Session ID":=TransactionID;
                                    MBankingTransactions."Transaction Type" := MBankingTransactions."transaction type"::Paybill;
                                    MBankingTransactions."Transaction Name" := 'Paybill';
                                    MBankingTransactions.Description := CopyStr('Paybill Deposit', 1, 50);
                                    ;
                                    MBankingTransactions."Transaction Date" := Dt2Date(MpesaManualUpload."Initiation Time");
                                    MBankingTransactions."Transaction Time" := Dt2Time(MpesaManualUpload."Initiation Time");
                                    MBankingTransactions."Member Account" := MpesaManualUpload."Account No";
                                    MBankingTransactions.Amount := MpesaManualUpload."Paid In";
                                    MBankingTransactions."Loan No." := MpesaManualUpload."Loan No";
                                    MBankingTransactions."Mobile No." := '';
                                    MBankingTransactions."Vendor Commission" := 0;
                                    MBankingTransactions."Sacco Fee" := 0;
                                    MBankingTransactions."Paybill Member ID" := MpesaManualUpload."A/C No.";
                                    MBankingTransactions.Keyword := MpesaManualUpload."Key Word";
                                    MBankingTransactions.Insert;

                                    MpesaManualUpload.Transfered := true;
                                    MpesaManualUpload.Modify;

                                end;
                            until MpesaManualUpload.Next = 0;
                        end;
                    end;
                end;
            }
        }
    }

    var
        //MobileBanking: Codeunit MobileBanking;
        MpesaManualUpload: Record "Mpesa Manual Upload";
        MBankingTransactions: Record "MBanking Transactions";
        AccountNo: Text;
        LoanNo: Code[20];
        "Key": Text;
        MemberNo: Code[20];
        LBal: Decimal;
        PAct: Code[20];
        BLedger: Record "Bank Account Ledger Entry";
}

