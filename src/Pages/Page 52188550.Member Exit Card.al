Page 50213 "Member Exit Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Exit";
    PromotedActionCategories = 'New,Process,Report,Request Approval,Post';

    layout
    {
        area(content)
        {
            //member forfeiting exit-mwende 092926
            group(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ClosureType; Rec."Closure Type")
                {
                    ApplicationArea = Basic;
                }
                field(ClosingDate; Rec."Closing Date")
                {
                    ApplicationArea = Basic;
                }
                field(NoticeNo; Rec."Notice No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(WithdrawalType; Rec.WithdrawalType)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Credit Summary")
            {
                field(TotalPenalty; Rec."Total Penalty")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TotalAppraisal; Rec."Total Appraisal")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Insurance"; Rec."Outstanding Insurance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Insurance';
                }
                field(TotalInterest; Rec."Total Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TotalPrincipal; Rec."Total Principal")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TotalLoanOutstanding; Rec."Total Loan Outstanding")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Savings Summary")
            {
                field(ShareCapital; Rec."Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RetainedSharesDeductable; Rec."Retained Shares Deductable")
                {
                    ApplicationArea = Basic;
                }
                field(WithdrawableSavings; Rec."Withdrawable Savings")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Junior Savings"; Rec."Junior Savings")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Holiday Savings"; Rec."Holiday Savings")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fixed Deposit"; Rec."Fixed Deposit")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Ordinary Savings"; Rec."Ordinary Savings")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Dividend Account"; Rec."Dividend Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Dividends/Rebates"; Rec."Dividends/Rebates")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NonWithdrawableSavings; Rec."Non-Withdrawable Savings")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TermSavings; Rec."Term Savings")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TotalSavings; Rec."Total Savings")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Self Guaranteed Amount"; Rec."Self Guaranteed Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Guaranteed"; Rec."Total Guaranteed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Partial Withdrawal Amount"; Rec."Partial Withdrawal Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TotalRefundable; Rec."Total Refundable")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Net Refundable"; Rec."Net Refundable")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
            group("Share Capital Sale")
            {
                field(ShareCapitalSale; Rec."Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ShareCapitalSaleTo; Rec."Share Capital Sale To")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field("Share Capital Amount To Sale"; Rec."Share Capital Amount To Sale")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Share Charge"; Rec."Share Charge")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Share Charge GL"; Rec."Share Charge GL")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(Charges)
            {
                field(ExitCharge; Rec."Exit Charge")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                /*
                field(MemberExitCharge;Rec.MemberExitCharge)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                */
                field(DutyonExitCharge; Rec."Duty on Exit Charge")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TotalCharges; Rec."Total Charges")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(EnteredBy; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TransferAccount; Rec."Transfer Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TransferAccountName; Rec."Transfer Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

            }
        }

    }

    actions
    {
        area(navigation)
        {

            action("Account closure Slip")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.RUN(Report::"Resignation Slip", TRUE, FALSE, Rec);
                    Rec.Reset();
                end;
            }

            action("Resignation Slip")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                Visible = false;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    MemberEx: Record "Member Exit";
                begin

                    MemberEx.RESET;
                    MemberEx.SETRANGE(MemberEx."Member No.", Rec."Member No.");
                    IF MemberEx.FIND('-') THEN BEGIN
                        REPORT.RUN(Report::"Membership Closure Report", TRUE, FALSE, MemberEx);
                    END;


                end;
            }
            action(CreateSeperatePV)
            {
                Caption = 'Create PV';
                ApplicationArea = Basic;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                var
                    MemberAccounts: Record "Savings Accounts";
                    AvailBal: Decimal;
                    MemberActivities: Codeunit "Member Activities";
                    Ben: Record "Member Exit Beneficiary";
                    RecType: Record "Payment & Receipt Types";
                    PVLine: Record "Document Line";
                    PVHeader: Record "Payment Header";
                    PCount: Integer;
                begin
                    Rec.TestField(Posted, true);

                    if Rec."Closure Type" = Rec."Closure Type"::"Withdrawal - Death" then begin
                        // Death -> pay the beneficiaries
                        Rec.CalcFields("Beneficiary Amount");
                        Rec.TestField("Beneficiary Amount");
                        MemberAccounts.Reset();
                        MemberAccounts.SetRange("No.", Rec."Transfer Account");
                        if MemberAccounts.FindFirst() then begin
                            AvailBal := MemberActivities.GetAccountBalance(MemberAccounts."No.");
                            if AvailBal < Rec."Beneficiary Amount" then
                                Error('Insufficient Available Balance');

                            PCount := 0;
                            Ben.Reset();
                            Ben.SetRange("Exit No.", Rec."No.");
                            Ben.SetFilter(Amount, '>0');
                            if Ben.FindFirst() then begin
                                if Ben."PV No." = '' then begin
                                    if not RecType.Get('BENF') THEN begin
                                        RecType.Init();
                                        RecType.Code := 'BENF';
                                        RecType.Description := 'Member Exit Beneficiary';
                                        RecType."Account Type" := RecType."Account Type"::Savings;
                                        RecType.Type := RecType.Type::Payment;
                                        RecType.Insert();
                                    end;

                                    Ben.Reset();
                                    Ben.SetRange("Exit No.", Rec."No.");
                                    Ben.SetFilter(Amount, '>0');
                                    if Ben.FindFirst() then begin
                                        repeat
                                            PVHeader.Init();
                                            PVHeader."No." := '';
                                            PVHeader."Payment Type" := PVHeader."payment type"::Normal;
                                            PVHeader.Insert();
                                            Ben."PV No." := PVHeader."No.";
                                            Ben.Modify();

                                            PVLine.Init();
                                            PVLine."Header No." := Ben."PV No.";
                                            PVLine.Validate(Type, 'BENF');
                                            PVLine.Validate("Account No.", Rec."Transfer Account");
                                            PVLine.Validate(Amount, Ben.Amount);
                                            PVLine.Description := 'Beneficiary Payment: ' + Ben."Principal Member Name";
                                            PVLine.Insert();
                                            PCount += 1;
                                        until Ben.Next() = 0;
                                    end;
                                end;
                            end;
                            Message('%1 PVs Created', PCount);
                        end;
                    end else
                        // All other closure types -> pay the exiting member
                        CreateExitPaymentVoucher();
                end;
            }
            action(Post)
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MCAcc: Record "Savings Accounts";
                    TransAmt: Decimal;
                    DestAcc: Record "Savings Accounts";
                    TChannel: Enum "Transaction Channel";
                    DimID: Integer;
                    Notice: Record "Member Exit Notice";
                        ForfeitRequest: Record "Forfeit Exit Request";
                begin

                    if ForfeitRequest.IsForfeitApprovedForExit(Rec."No.") then
                        Error('This member exit has been forfeited and cannot be posted.');

                    Rec.Validate("Member No.");
                    if ForfeitRequest.FindPendingForMember(Rec."Member No.", ForfeitRequest."Forfeit Type"::"Member Exit") then
                        if (ForfeitRequest."Exit No." = Rec."No.") or
                           ((ForfeitRequest."Notice No." <> '') and (ForfeitRequest."Notice No." = Rec."Notice No.")) then
                            Error('A Forfeit Exit request is pending. Resolve it before posting this exit.');

                    Notice.Get(Rec."Notice No.");
                    if Notice."Maturity Date" > Today then
                        Rec.Validate("Closure Type", Rec."Closure Type"::"Withdrawal - Immediate");
                    Rec.Modify();

                    if Rec.Status <> Rec.Status::Approved then
                        Error(ErrTxt0002);


                    if Rec.Posted = true then
                        Error(ErrTxt0000);

                    if Rec."Total Refundable" < 0 then
                        Error(ErrTxt0001);

                    SaccoSetup.Get;

                    if Rec."Partial Withdrawal Amount" > 0 then begin


                        if Members.Get(Rec."Member No.") then begin
                            if Confirm('Are yous sure you want to post this partial withdrawal?') = false then
                                exit;

                            UserSetup.Get(UserId);
                            UserSetup.TestField("Payment Journal Template");
                            UserSetup.TestField("Payment Journal Batch");

                            JTemplate := UserSetup."Payment Journal Template";
                            JBatch := UserSetup."Payment Journal Batch";

                            SaccoActivities.JournalInit(JTemplate, JBatch);


                            //SaccoSetup.TestField("Member Exit Transfer Account");

                            AvailBal := 0;
                            Rec."Transfer Account" := '';
                            Rec."Transfer Account Name" := '';

                            ProductSetup.Reset();
                            ProductSetup.SetRange("Loan Processing Account", true);
                            if ProductSetup.FindFirst() then begin
                                repeat
                                    Savings.Reset;
                                    Savings.SetRange("Product Type", ProductSetup."Product ID");
                                    Savings.SetRange("Member No.", Rec."Member No.");
                                    if Savings.FindFirst then begin
                                        Rec."Transfer Account" := Savings."No.";
                                        Rec."Transfer Account Name" := Savings."Product Name";
                                        AvailBal += MemberActivities.GetAccountBalance(Savings."No.");

                                        if Savings.Blocked <> Savings.Blocked::" " then begin
                                            Savings.Blocked := Savings.Blocked::" ";
                                            Savings.Modify;
                                        end;
                                    end;
                                until ProductSetup.Next() = 0;
                            end else
                                Error('Loan Processing Account missing in product setup');

                            Savings.Reset;
                            Savings.SetRange("Member No.", Rec."Member No.");
                            Savings.SetFilter("Product Category", '<>%1&<>%2&<>%3',
                                                Savings."product category"::"Share Capital",
                                                Savings."product category"::"Benevolent Fund",
                                                Savings."product category"::"Registration Fee"
                            );
                            Savings.SetFilter("Product Type", '<>%1', SaccoSetup."Member Exit Transfer Account");
                            if Savings.FindFirst then begin
                                repeat
                                    ProductSetup.Get(Savings."Product Type");
                                    if ProductSetup."Savings Type" <> ProductSetup."savings type"::"Retained Shares" then begin

                                        if Savings.Blocked <> Savings.Blocked::" " then begin
                                            Savings.Blocked := Savings.Blocked::" ";
                                            Savings.Modify;
                                        end;

                                        SavingsAmt := MemberActivities.GetAccountBalance(Savings."No.");
                                        if Savings."Product Category" = Savings."Product Category"::"Deposit Contribution" then begin

                                            SavingsAmt -= Rec."Total Guaranteed";
                                            if SavingsAmt < 0 then
                                                Error('Member Does not have enough deposits because if the guaranteed shares committed');

                                        end;


                                        AvailBal += SavingsAmt;

                                        SaccoActivities.JournalInsert(
                                            JTemplate,
                                            JBatch,
                                            Rec."No.",
                                            Rec."Closing Date",
                                            Accttype::Savings,
                                            Savings."No.",
                                            CopyStr('Member Exit - ' + Rec."Transfer Account Name" + ' Balance Transfer', 1, 100),
                                            Balaccttype::"G/L Account",
                                            '',
                                            SavingsAmt,
                                            ExtDocNo,
                                            '',
                                            Transtype::" ",
                                            Rec."Global Dimension 1 Code",
                                            Rec."Global Dimension 2 Code",
                                            true,
                                            TChannel::"Member Exit",
                                            DimID
                                            );

                                        SaccoActivities.JournalInsert(
                                            JTemplate,
                                            JBatch,
                                            Rec."No.",
                                           Rec."Closing Date",
                                            Accttype::Savings,
                                            Rec."Transfer Account",
                                            CopyStr('Member Exit - ' + Savings."Product Name" + ' Balance Transfer', 1, 100),
                                            Balaccttype::"G/L Account",
                                            '',
                                            SavingsAmt * -1,
                                            ExtDocNo,
                                            '',
                                            Transtype::" ",
                                           Rec."Global Dimension 1 Code",
                                            Rec."Global Dimension 2 Code",
                                            true,
                                            TChannel::"Member Exit",
                                            DimID
                                            );
                                    end;

                                until Savings.Next = 0;
                            end;

                            RunBal := AvailBal;


                            if RunBal > 0 then begin
                                RecoverLoanFromTransferAccount(RunBal);
                            end;

                            Rec.Posted := true;
                            Rec.Modify;
                            SaccoActivities.JournalPost(JTemplate, JBatch);
                            Message(JTemplate + '-' + JBatch);

                        end;
                    end
                    else begin

                        Rec.CalcFields("Maturity Date");
                        if Rec."Closure Type" <> Rec."closure type"::"Withdrawal - Death" then
                            if not Rec."Early Exit" then
                                if Rec."Maturity Date" > Today then
                                    Error('Membership Closure Period is %1', SaccoSetup."Member Exit Notice Period");

                        if Rec."Total Loan Outstanding" > Rec."Total Savings" then
                            Error(Txt0002);


                        Rec.TestField("Closing Date");


                        if Members.Get(Rec."Member No.") then begin
                            if Confirm(ConfmTxt0003) = false then
                                exit;

                            UserSetup.Get(UserId);
                            UserSetup.TestField("Payment Journal Template");
                            UserSetup.TestField("Payment Journal Batch");

                            JTemplate := UserSetup."Payment Journal Template";
                            JBatch := UserSetup."Payment Journal Batch";

                            SaccoActivities.JournalInit(JTemplate, JBatch);


                            //SaccoSetup.TestField("Member Exit Transfer Account");

                            AvailBal := 0;
                            Rec."Transfer Account" := '';
                            Rec."Transfer Account Name" := '';

                            //SaccoSetup.TestField("Chamaa Consolidation Account");
                            ProductSetup.Reset();
                            ProductSetup.SetRange("Loan Processing Account", true);
                            if ProductSetup.FindFirst() then
                                repeat

                                    Savings.Reset;
                                    Savings.SetRange("Product Type", ProductSetup."Product ID");
                                    Savings.SetRange("Member No.", Rec."Member No.");
                                    if Savings.FindFirst then begin
                                        Rec."Transfer Account" := Savings."No.";
                                        Rec."Transfer Account Name" := Savings."Product Name";
                                        AvailBal += MemberActivities.GetAccountBalance(Savings."No.");

                                        if Rec."Partial Withdrawal Amount" = 0 then begin
                                            AvailBal -= SaccoSetup."Exit Min. Balance";
                                        end;

                                        if Savings.Blocked <> Savings.Blocked::" " then begin
                                            Savings.Blocked := Savings.Blocked::" ";
                                            Savings.Modify;
                                        end;
                                    end;
                                until ProductSetup.Next() = 0;


                            Savings.Reset;
                            Savings.SetRange("Member No.", Rec."Member No.");
                            Savings.SetFilter("Product Category", '<>%1&<>%2&<>%3&<>%4',
                                                Savings."product category"::"Share Capital",
                                                Savings."product category"::"Benevolent Fund",
                                                Savings."product category"::"Registration Fee",
                                                Savings."product category"::"Ordinary Savings"
                            );
                            Savings.SetFilter("Product Type", '<>%1', SaccoSetup."Member Exit Transfer Account");
                            if Savings.FindFirst then begin
                                repeat
                                    ProductSetup.Get(Savings."Product Type");
                                    if ProductSetup."Savings Type" <> ProductSetup."savings type"::"Retained Shares" then begin

                                        if Savings.Blocked <> Savings.Blocked::" " then begin
                                            Savings.Blocked := Savings.Blocked::" ";
                                            Savings.Modify;
                                        end;

                                        SavingsAmt := MemberActivities.GetAccountBalance(Savings."No.");
                                        if Savings."Product Category" = Savings."Product Category"::"Deposit Contribution" then begin

                                            SavingsAmt -= Rec."Total Guaranteed";
                                            if SavingsAmt < 0 then
                                                Error('Member Does not have enough deposits because if the guaranteed shares committed');

                                        end;


                                        AvailBal += SavingsAmt;

                                        SaccoActivities.JournalInsert(
                                            JTemplate,
                                            JBatch,
                                            Rec."No.",
                                            Rec."Closing Date",
                                            Accttype::Savings,
                                            Savings."No.",
                                            CopyStr('Member Exit - ' + Rec."Transfer Account Name" + ' Balance Transfer', 1, 100),
                                            Balaccttype::"G/L Account",
                                            '',
                                            SavingsAmt,
                                            ExtDocNo,
                                            '',
                                            Transtype::" ",
                                            Rec."Global Dimension 1 Code",
                                            Rec."Global Dimension 2 Code",
                                            true,
                                            TChannel::"Member Exit",
                                            DimID
                                            );

                                        SaccoActivities.JournalInsert(
                                            JTemplate,
                                            JBatch,
                                            Rec."No.",
                                           Rec."Closing Date",
                                            Accttype::Savings,
                                            Rec."Transfer Account",
                                            CopyStr('Member Exit - ' + Savings."Product Name" + ' Balance Transfer', 1, 100),
                                            Balaccttype::"G/L Account",
                                            '',
                                            SavingsAmt * -1,
                                            ExtDocNo,
                                            '',
                                            Transtype::" ",
                                           Rec."Global Dimension 1 Code",
                                            Rec."Global Dimension 2 Code",
                                            true,
                                            TChannel::"Member Exit",
                                            DimID
                                            );
                                    end;

                                until Savings.Next = 0;
                            end;

                            DestAcc.Get(Rec."Transfer Account");

                            ProductSetup.Reset;
                            ProductSetup.SetRange("Savings Type", ProductSetup."savings type"::"Retained Shares");
                            ProductSetup.SetFilter("Product Category", '<>%1', ProductSetup."Product Category"::"Ordinary Savings");
                            if ProductSetup.FindFirst then begin
                                repeat

                                    Savings.Reset;
                                    Savings.SetRange("Member No.", Rec."Member No.");
                                    Savings.SetRange("Product Type", ProductSetup."Product ID");
                                    if Savings.FindFirst then begin
                                        repeat
                                            Savings.CalcFields("Balance (LCY)");

                                            TransAmt := ProductSetup."Mandatory Contribution" - Savings."Balance (LCY)";

                                            if TransAmt > 0 then begin

                                                if Savings.Blocked <> Savings.Blocked::" " then begin
                                                    Savings.Blocked := Savings.Blocked::" ";
                                                    Savings.Modify;
                                                end;

                                                SavingsAmt := MemberActivities.GetAccountBalance(Rec."Transfer Account") -
                                                              SaccoActivities.GetJournalDebits(JTemplate, JBatch, Accttype::Savings, Rec."Transfer Account") +
                                                              SaccoActivities.GetJournalCredits(JTemplate, JBatch, Accttype::Savings, Rec."Transfer Account");

                                                if SavingsAmt < 0 then
                                                    SavingsAmt := 0;

                                                //MESSAGE('TransAmt %1\SavingsAmt %2',TransAmt,SavingsAmt);

                                                if TransAmt > SavingsAmt then
                                                    TransAmt := SavingsAmt;

                                                AvailBal -= TransAmt;

                                                SaccoActivities.JournalInsert(
                                                    JTemplate,
                                                    JBatch,
                                                   Rec."No.",
                                                    Rec."Closing Date",
                                                    Accttype::Savings,
                                                    Savings."No.",
                                                    CopyStr('Member Exit - ' + Rec."Transfer Account Name" + ' Balance Transfer', 1, 100),
                                                    Balaccttype::"G/L Account",
                                                    '',
                                                    -TransAmt,
                                                    ExtDocNo,
                                                    '',
                                                    Transtype::" ",
                                                    Rec."Global Dimension 1 Code",
                                                    Rec."Global Dimension 2 Code",
                                                    true,
                                                    TChannel::"Member Exit",
                                                    DimID
                                                    );

                                                SaccoActivities.JournalInsert(
                                                    JTemplate,
                                                    JBatch,
                                                   Rec."No.",
                                                    Rec."Closing Date",
                                                    Accttype::Savings,
                                                    Rec."Transfer Account",
                                                    CopyStr('Member Exit - ' + Savings."Product Name" + ' Balance Transfer', 1, 100),
                                                    Balaccttype::"G/L Account",
                                                    '',
                                                    TransAmt,
                                                    ExtDocNo,
                                                    '',
                                                    Transtype::" ",
                                                   Rec."Global Dimension 1 Code",
                                                    Rec."Global Dimension 2 Code",
                                                    true,
                                                    TChannel::"Member Exit",
                                                    DimID
                                                    );
                                            end;

                                        until Savings.Next = 0;
                                    end;

                                until ProductSetup.Next = 0;
                            end;


                            RunBal := AvailBal;

                            if RunBal > 0 then begin
                                //if "Closure Type" = "closure type"::"Withdrawal - Normal" then begin
                                RecoverWithdrawalFee(RunBal, Rec."Transfer Account");
                                //end
                            end;

                            if RunBal > 0 then begin
                                RecoverLoanFromTransferAccount(RunBal);
                            end;

                            Savings.Reset;
                            Savings.SetRange("Member No.", Rec."Member No.");
                            Savings.SetFilter("Product Category", '%1', Savings."product category"::"Benevolent Fund");
                            if Savings.Find('-') then begin
                                repeat
                                    Savings.CalcFields("Balance (LCY)");
                                    if Savings."Balance (LCY)" <> 0 then begin
                                        Savings.TestField("Customer Posting Group");
                                        //CustPostingGr.Get(Savings."Customer Posting Group");
                                        SaccoSetup.TestField("GFE Income Acc.");
                                        BalAcctNo := SaccoSetup."GFE Income Acc.";//CustPostingGr.GetPayablesAccount;

                                        SaccoActivities.JournalInsert(
                                            JTemplate,
                                            JBatch,
                                            Rec."No.",
                                            Rec."Closing Date",
                                            Accttype::Savings,
                                            Savings."No.",
                                            CopyStr('Member Exit - Zerolize Benevolent Fund', 1, 100),
                                            Balaccttype::"G/L Account",
                                            BalAcctNo,
                                            Savings."Balance (LCY)",
                                            ExtDocNo,
                                            '',
                                            Transtype::" ",
                                            Rec."Global Dimension 1 Code",
                                            Rec."Global Dimension 2 Code",
                                            true,
                                            TChannel::"Member Exit",
                                            DimID
                                            );

                                    end;

                                until Savings.Next = 0;
                            end;


                            if (Rec."Share Capital Amount To Sale" <> 0) and (Rec."Source Share Capital" <> '') and (Rec."Share Capital Sale To" <> '') then begin
                                SaccoActivities.JournalInsert(JTemplate, JBatch, Rec."No.", Rec."Closing Date", Accttype::Savings, Rec."Source Share Capital", CopyStr('Member Exit - Share Capital Transfer ' + Rec."Share Capital Sale To", 1, 100), Balaccttype::"G/L Account", '', Rec."Share Capital Amount To Sale", ExtDocNo, '', Transtype::" ", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", true, TChannel::"Member Exit", DimID);

                                SaccoActivities.JournalInsert(JTemplate, JBatch, Rec."No.", Rec."Closing Date", Accttype::Savings, Rec."Share Capital Sale To", CopyStr('Member Exit - Share Capital Transfer ' + Rec."Share Capital Sale To", 1, 100), Balaccttype::"G/L Account", '', -Rec."Share Capital Amount To Sale", ExtDocNo, '', Transtype::" ", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", true, TChannel::"Member Exit", DimID);

                            end;

                            if Rec."Partial Withdrawal Amount" <= 0 then begin
                                Savings.Reset;
                                Savings.SetRange("Member No.", Rec."Member No.");
                                // When Closure = Death we DO NOT want to change Deposit Contribution or Ordinary Savings
                                if Rec."Closure Type" = Rec."closure type"::"Withdrawal - Death" then
                                    Savings.SetFilter("Product Category", '<>%1&<>%2&<>%3&<>%4',
                                        Savings."product category"::"Share Capital",
                                        Savings."product category"::"Registration Fee",
                                        Savings."product category"::"Deposit Contribution",
                                        Savings."product category"::"Ordinary Savings"
                                    )
                                else
                                    Savings.SetFilter("Product Category", '<>%1&<>%2&<>%3',
                                        Savings."product category"::"Share Capital",
                                        Savings."product category"::"Registration Fee",
                                        Savings."product category"::"Ordinary Savings");

                                if Savings.Find('-') then begin
                                    repeat
                                        if (Rec."Closure Type" = Rec."closure type"::"Withdrawal - Normal") or (Rec."Closure Type" = Rec."closure type"::"Withdrawal - Immediate") or
                                          (Savings."Product Category" = Savings."product category"::"Junior Savings") then
                                            Savings.Status := Savings.Status::Withdrawn
                                        else
                                            if (Rec."Closure Type" = Rec."closure type"::"Withdrawal - Death") then
                                                Savings.Status := Savings.Status::Deceased;

                                        Savings.Modify;
                                    until Savings.Next = 0;
                                end;

                                if Rec."Closure Type" = Rec."closure type"::"Withdrawal - Death" then
                                    Members."Member Status" := Members."Member Status"::Deceased
                                else
                                    Members."Member Status" := Members."Member Status"::Withdrawn;

                            end;

                            Rec.Posted := true;
                            Rec.Modify;
                            SaccoActivities.JournalPost(JTemplate, JBatch);
                            Message(JTemplate + '-' + JBatch);

                            if Rec."Partial Withdrawal Amount" <= 0 then begin

                                Members.Blocked := Members.Blocked::All;
                                Members.Modify;
                            end;

                        end;


                        if Rec."Partial Withdrawal Amount" <= 0 then begin

                            Savings.Reset;
                            Savings.SetRange("Member No.", Rec."Member No.");
                            Savings.SetFilter(Status, '%1|%2', Savings.Status::Deceased, Savings.Status::Closed);
                            Savings.SetFilter("No.", '<>%1', Rec."Transfer Account");
                            Savings.SetFilter("Product Category", '<>%1&<>%2&<>%3&<>%4',
                                                Savings."product category"::"Share Capital",
                                                Savings."product category"::"Benevolent Fund",
                                                Savings."product category"::"Registration Fee",
                                                Savings."product category"::"Ordinary Savings"
                            );
                            if Savings.Find('-') then begin
                                Savings.ModifyAll(Blocked, Savings.Blocked::All);
                            end;

                            Savings.Reset;
                            Savings.SetRange("Member No.", Rec."Member No.");
                            Savings.SetFilter("No.", Rec."Transfer Account");
                            if Savings.Find('-') then begin
                                Savings.CalcFields("Balance (LCY)");

                                if Savings."Balance (LCY)" > 0 then
                                    Savings.Validate(Blocked, Savings.Blocked::" ")
                                /* else
                                    Savings.Validate(Blocked, Savings.Blocked::All) */
                            end;
                        end;

                    end;


                    Message('Closure posted successfully.');

                    CreateExitPaymentVoucher();
                end;
            }
        }
        area(processing)
        {
            group(Process)
            {
                action(RequestForfeitExit)
                {
                    ApplicationArea = Basic;
                    Caption = 'Forfeit Exit';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ForfeitRequest: Record "Forfeit Exit Request";
                        ReasonPage: Page "Forfeit Exit Reason";
                        Reason: Text[250];
                    begin
                        if ReasonPage.RunModal() <> Action::OK then
                            exit;
                        Reason := ReasonPage.GetForfeitReason();

                        ForfeitRequest.RequestForfeitExit(Rec."Member No.", Rec."No.", Rec."Notice No.", Reason);
                        Message('Forfeit Exit request sent to the configured approver.');
                        CurrPage.Update(false);
                    end;
                }
                action(ApproveForfeitExit)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve Forfeit Exit';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ForfeitRequest: Record "Forfeit Exit Request";
                    begin
                        if not ForfeitRequest.FindPendingForMember(Rec."Member No.", ForfeitRequest."Forfeit Type"::"Member Exit") then
                            Error('There is no pending Forfeit Exit request for this member.');
                        if not Confirm('Approve Forfeit Exit? Reason: %1', false, ForfeitRequest.ForfeitReason) then
                            exit;

                        ForfeitRequest.ApproveForfeitExit(Rec."Member No.");
                        Message('Forfeit Exit approved. The exit status is Forfeited and the member is Active.');
                        CurrPage.Update(false);
                    end;
                }
                action(RejectForfeitExit)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject Forfeit Exit';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ForfeitRequest: Record "Forfeit Exit Request";
                        ReasonPage: Page "Forfeit Exit Reason";
                        RejectionReason: Text[250];
                    begin
                        if not ForfeitRequest.FindPendingForMember(Rec."Member No.", ForfeitRequest."Forfeit Type"::"Member Exit") then
                            Error('There is no pending Forfeit Exit request for this member.');
                        if not Confirm('Reject Forfeit Exit? Request reason: %1', false, ForfeitRequest.ForfeitReason) then
                            exit;
                        if ReasonPage.RunModal() <> Action::OK then
                            exit;
                        RejectionReason := ReasonPage.GetForfeitReason();

                        ForfeitRequest.RejectForfeitExit(Rec."Member No.", RejectionReason);
                        Message('Forfeit Exit request rejected. The member status was not changed.');
                        CurrPage.Update(false);
                    end;
                }
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        NextofKIN: Record "Service Item";
                        ProductFactory: Record "Service Item";
                        SavingsAccountRegistration: Record "Service Item";
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin

                        CheckControls;

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Member Exit", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Member Exit";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
                        ApprovalTracker.SetRange("Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        TestForfeitExitCanContinue();

                        if Rec.Status = Rec.Status::Pending then begin
                            VarVariant := Rec;
                            CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                }

                action("Reset Closing Date")
                {
                    ApplicationArea = Basic;
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    begin

                        if not Confirm('Are you sure you want to re-set this document closing date?') then
                            exit;

                        Rec."Closing Date" := Today;
                        Rec.Modify;
                    end;
                }

            }
        }
    }

    var
        SaccoSetup: Record "Sacco Setup";
        ErrTxt0000: label 'Account already Posted';
        ErrTxt0001: label 'Account cannot be colsed, insufficient funds';
        ErrTxt0002: label 'The request must be approved';
        ConfmTxt0003: label 'Are you sure you want to recover the loans from the members shares?';
        Txt0004: label 'Account Closure ';
        Txt0005: label 'Interest Recovery from deposits';
        Txt0006: label 'Principle Recovery from deposits';
        Txt0007: label 'Member Withdrawal Account No';
        Txt0008: label 'Funeral Expenses';
        DocMustbeOpen: label 'This application request must be open';
        DocMustbePending: label 'This application request must be Pending';
        Txt0000: label 'Checkoff has been posted';
        Txt0001: label 'Excise Duty';
        Txt0002: label 'Member cannot close the account before clearing the loans';
        Txt0009: label 'Withdrawal Fee';
        Txt0010: label 'Account Closure Fee';
        Members: Record Members;
        UserSetup: Record "User Setup";
        SaccoActivities: Codeunit "Sacco Activities";
        JTemplate: Code[10];
        JBatch: Code[10];
        Savings: Record "Savings Accounts";
        AvailBal: Decimal;
        MemberActivities: Codeunit "Member Activities";
        ProductSetup: Record "Product Setup";
        SavingsAmt: Decimal;
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        BalAcctNo: Code[20];
        ExtDocNo: Code[20];
        TransType: Enum "Transaction Type Enum";
        RunBal: Decimal;
        Loans: Record Loans;
        CustPostingGr: Record "Vendor Posting Group";
        Withdrawal: Record "Member Exit";
        TChannel: Enum "Transaction Channel";

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        UpdateControl();
    end;

    local procedure UpdateControl()
    begin


        if Rec.Status = Rec.Status::Open then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false;
    end;

    local procedure CheckControls()
    begin
        TestForfeitExitCanContinue();

        Rec.TestField("Member No.");
        Rec.TestField("Closing Date");


        if Rec."Closure Type" = Rec."closure type"::" " then
            Error('Enter Closure Type');

        //IF "Closure Type" = "Closure Type"::"Withdrawal - Normal" THEN
        //  TESTFIELD("Notice No.");
    end;

    local procedure TestForfeitExitCanContinue()
    var
        ForfeitRequest: Record "Forfeit Exit Request";
    begin
        if Rec.Status = Rec.Status::Forfeited then
            Error('This Member Exit has been forfeited and cannot be changed.');
        if ForfeitRequest.IsForfeitApprovedForExit(Rec."No.") then
            Error('This Member Exit has been forfeited and cannot be changed.');
        if ForfeitRequest.FindPendingForMember(Rec."Member No.", ForfeitRequest."Forfeit Type"::"Member Exit") then
            if ForfeitRequest."Exit No." = Rec."No." then
                Error('A Forfeit Exit request is pending for this Member Exit.');
    end;

    local procedure CreateExitPaymentVoucher()
    var
        RecType: Record "Payment & Receipt Types";
        PVHeader: Record "Payment Header";
        PVLine: Record "Document Line";
        PayAmount: Decimal;
    begin
        // Refund payable to the exiting member
        PayAmount := Rec."Net Refundable";
        if PayAmount <= 0 then
            PayAmount := Rec."Total Refundable";

        if PayAmount <= 0 then
            exit;

        Rec.TestField("Member No.");
        Rec.TestField("Transfer Account");

        // Don't silently create a second PV for the same exit
        PVLine.Reset();
        PVLine.SetRange("Member Exit No.", Rec."No.");
        if not PVLine.IsEmpty() then
            if not Confirm('A PV already exists for this exit. Do you want to create another?', false) then
                exit;

        if not Confirm('Do you want to create a Payment Voucher (PV) to pay %1 to %2?', false, PayAmount, Rec."Member Name") then
            exit;

        // Line-level payment type that pays a member from a Savings account
        if not RecType.Get('MEXIT') then begin
            RecType.Init();
            RecType.Code := 'MEXIT';
            RecType.Description := 'Member Exit Refund';
            RecType."Account Type" := RecType."Account Type"::Savings;
            RecType.Type := RecType.Type::Payment;
            RecType.Insert();
        end;

        // HEADER = paying side. Created as a draft (Open) so it goes through PV approval.
        // Paying Bank Account is left for the user to pick on the PV Card.
        PVHeader.Init();
        PVHeader."No." := '';
        PVHeader."Payment Type" := PVHeader."Payment Type"::Normal;
        PVHeader.Insert(true);

        PVHeader.Validate("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        PVHeader.Validate("Shortcut Dimension 2 Code", Rec."Global Dimension 2 Code");
        PVHeader.Payee := Rec."Member No.";
        PVHeader."Payment Narration" :=
            CopyStr('Member Exit Refund - ' + Rec."No." + ' - ' + Rec."Member Name", 1, MaxStrLen(PVHeader."Payment Narration"));
        PVHeader.Modify(true);

        // LINE = what is paid: Savings payment to the member's Transfer account
        PVLine.Init();
        PVLine."Header No." := PVHeader."No.";
        PVLine."Line No." := 10000;
        PVLine.Validate(Type, 'MEXIT');
        PVLine.Validate("Account Type", PVLine."Account Type"::Savings);
        PVLine.Validate("Member No.", Rec."Member No.");
        PVLine.Validate("Account No.", Rec."Transfer Account");
        PVLine.Validate(Amount, PayAmount);
        PVLine."Member Exit No." := Rec."No.";
        PVLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        PVLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
        PVLine.Description := CopyStr('Member Exit Refund - ' + Rec."No.", 1, MaxStrLen(PVLine.Description));
        PVLine.Insert(true);

        // Open the draft PV so the user sets the Paying Bank Account and clicks Send Approval Request
        Page.Run(Page::"PV Card", PVHeader);
    end;

    procedure RecoverLoanFromTransferAccount(var AvailableBalance: Decimal)
    var
        Loans: Record Loans;
        Interest: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LRepayment: Decimal;
        ProductType: Record "Product Setup";
        j: Integer;
        SkipLoan: Boolean;
        SavAccts: Record "Savings Accounts";
        SavingsAccounts: Record "Savings Accounts";
        DedAmount: Decimal;
        ProductSetup: Record "Product Setup";
        Dim1: Code[20];
        Dim2: Code[20];
        LRec: Record Loans;
        DocNo: Code[20];
        RSchedule: Record "Loan Repayment Schedule";
        SchDate: Date;
        IncomeType: Enum "Repay Mode Enum";
        DepCont: Decimal;
        DepAccount: Code[20];
        SavingsACC: Record "Savings Accounts";
        ExpAmt: Decimal;
        AmtPaid: Decimal;
        DefAmt: Decimal;
        DaysDef: Integer;
        ArrearsDate: Date;
        RunBal: Decimal;
        LoanAmt: Decimal;
    begin

        if SavingsAccounts.Get(Rec."Transfer Account") then begin

            for j := 1 to 5 do begin

                Loans.Reset;
                Loans.SetRange("Member No.", Rec."Member No.");
                if j = 1 then
                    Loans.SetFilter("Outstanding Penalty", '>0')
                else
                    if j = 2 then
                        Loans.SetFilter("Outstanding Insurance", '>0')
                    else
                        if j = 3 then
                            Loans.SetFilter("Outstanding Appraisal", '>0')
                        else
                            if j = 4 then
                                Loans.SetFilter("Outstanding Interest", '>0')
                            else
                                if j = 5 then
                                    Loans.SetFilter("Outstanding Principal", '>0')
                                else
                                    Error('Invalid Code - Programming Error');


                if Loans.Find('-') then begin
                    repeat

                        if AvailableBalance > 0 then begin
                            Loans.CalcFields("Outstanding Penalty", "Outstanding Insurance", "Outstanding Appraisal", "Outstanding Interest", "Outstanding Principal");
                            Loans.CalcFields("Appraisal Fee Paid", "Schedule Appraisal", "Schedule Interest", "Interest Paid");

                            if Loans."Outstanding Penalty" < 0 then
                                Loans."Outstanding Penalty" := 0;
                            if Loans."Outstanding Insurance" < 0 then
                                Loans."Outstanding Insurance" := 0;
                            if Loans."Outstanding Appraisal" < 0 then
                                Loans."Outstanding Appraisal" := 0;
                            if Loans."Outstanding Interest" < 0 then
                                Loans."Outstanding Interest" := 0;
                            if Loans."Outstanding Principal" < 0 then
                                Loans."Outstanding Principal" := 0;


                            Dim1 := Rec."Global Dimension 1 Code";
                            Dim2 := Rec."Global Dimension 2 Code";

                            if j = 1 then
                                LoanAmt := Loans."Outstanding Penalty"
                            else
                                if j = 2 then begin
                                    LoanAmt := Loans."Outstanding Insurance";
                                end
                                else
                                    if j = 3 then begin
                                        LoanAmt := Loans."Outstanding Appraisal";
                                    end
                                    else
                                        if j = 4 then begin
                                            LoanAmt := Loans."Outstanding Interest";
                                        end
                                        else
                                            if j = 5 then begin
                                                LoanAmt := Loans."Outstanding Principal";
                                            end
                                            else
                                                LoanAmt := 0;


                            if LoanAmt > 0 then begin
                                if AvailableBalance < LoanAmt then
                                    LoanAmt := AvailableBalance;

                                if j = 1 then begin
                                    RecoverLoans(JTemplate, JBatch, Rec."No.", Rec."Closing Date", 'Member Exit - Penalty Recovered', LoanAmt, Loans."Loan No.", Transtype::"Penalty Paid", Loans."Loan Account", SavingsAccounts."No.", Dim1, Dim2);
                                    AvailableBalance -= LoanAmt;
                                end
                                else
                                    if j = 2 then begin
                                        RecoverLoans(JTemplate, JBatch, Rec."No.", Today, 'Member Exit - Insurance Recovered', LoanAmt, Loans."Loan No.", Transtype::"Insurance Paid", Loans."Loan Account", SavingsAccounts."No.", Dim1, Dim2);
                                        AvailableBalance -= LoanAmt;
                                    end
                                    else
                                        if j = 3 then begin
                                            RecoverLoans(JTemplate, JBatch, Rec."No.", Today, 'Member Exit - Appraisal Recovered', LoanAmt, Loans."Loan No.", Transtype::"Appraisal Paid", Loans."Loan Account", SavingsAccounts."No.", Dim1, Dim2);
                                            AvailableBalance -= LoanAmt;
                                        end
                                        else
                                            if j = 4 then begin
                                                RecoverLoans(JTemplate, JBatch, Rec."No.", Today, 'Member Exit - Interest Recovered', LoanAmt, Loans."Loan No.", Transtype::"Interest Paid", Loans."Loan Account", SavingsAccounts."No.", Dim1, Dim2);
                                                AvailableBalance -= LoanAmt;
                                            end
                                            else
                                                if j = 5 then begin
                                                RecoverLoans(JTemplate, JBatch, Rec."No.", Today, 'Member Exit - Principle Recovered', LoanAmt, Loans."Loan No.", Transtype::"Principal Repayment", Loans."Loan Account", SavingsAccounts."No.", Dim1, Dim2);
                                                AvailableBalance -= LoanAmt;
                                                end;

                            end;
                        end;
                    until Loans.Next = 0;
                end;

            end;
        end;
    end;

    local procedure RecoverLoans(Jtemplate: Code[20]; JBatch: Code[20]; DocNo: Code[20]; PDate: Date; Desc: Text[50]; Amount: Decimal; LoanNo: Code[20]; Transaction: Enum "Transaction Type Enum"; LoanAccount: Code[20];
        SavAccount: Code[20];
        Dim1: Code[20];
        Dim2: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        FosaAcc: Record "Savings Accounts";
        LoanRec: Record Loans;
        ProdFact: Record "Product Setup";
        DimID: Integer;
    begin
        UserSetup.get(UserId);
        UserSetup.TestField("Dimension Set ID");
        DimID := UserSetup."Dimension Set ID";
        TChannel := TChannel::Offset;

        if FosaAcc.Get(SavAccount) then begin

            SaccoActivities.JournalInsert(Jtemplate, JBatch, DocNo, PDate, Accttype::Credit, LoanAccount, Desc + ' - From: ' + SavAccount, Accttype::"G/L Account", '', Amount * -1, SavAccount, LoanNo, Transaction, Dim1, Dim2, true, TChannel, DimID);

            SaccoActivities.JournalInsert(Jtemplate, JBatch, DocNo, PDate, Accttype::Savings, SavAccount, Desc + ' - To: ' + LoanNo, Accttype::"G/L Account", '', Amount, LoanNo, '', Transaction::" ", Dim1, Dim2, true, TChannel, DimID);

        end;
    end;

    local procedure RecoverWithdrawalFee(var RunBal: Decimal; AcctToCharge: Code[20])
    Var
        DimID: Integer;
        ShareCharge: Decimal;
    begin
        //HERE
        if RunBal < Rec."Exit Charge" + Rec."Duty on Exit Charge" then begin
            Rec."Duty on Exit Charge" := ROUND(RunBal * SaccoSetup."Excise Duty (%)" / (100 + SaccoSetup."Excise Duty (%)"));
            Rec."Exit Charge" := RunBal - Rec."Duty on Exit Charge";
        end;

        UserSetup.get(UserId);
        UserSetup.TestField("Dimension Set ID");
        DimID := UserSetup."Dimension Set ID";
        TChannel := TChannel::"Member Exit";
        if RunBal > Rec."Exit Charge" then begin

            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                Rec."No.",
                Rec."Closing Date",
                Accttype::Savings,
                AcctToCharge,
                CopyStr('Member Exit Fee', 1, 100),
                Balaccttype::"G/L Account",
                Rec."Charge GL",
                Rec."Exit Charge",
                ExtDocNo,
                '',
                Transtype::" ",
                Rec."Global Dimension 1 Code",
                Rec."Global Dimension 2 Code",
                true,
                TChannel,
                DimID
                );
            UpdateControl();

            RunBal -= Rec."Exit Charge";
        end;

        if RunBal > Rec."Duty on Exit Charge" then begin

            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                Rec."No.",
                Rec."Closing Date",
                Accttype::Savings,
                AcctToCharge,
                CopyStr('Excise Duty on Member Exit Fee', 1, 100),
                Balaccttype::"G/L Account",
                SaccoSetup."Excise Duty GL",
                Rec."Duty on Exit Charge",
                ExtDocNo,
                '',
                Transtype::" ",
                Rec."Global Dimension 1 Code",
                Rec."Global Dimension 2 Code",
                true,
                TChannel::" ",
                DimID
                );

            RunBal -= Rec."Exit Charge";
        end;

        if Rec."Share Charge" > 0 then begin

            Rec.TestField("Share Charge GL");
            SaccoActivities.JournalInsert(
            JTemplate,
                JBatch,
                Rec."No.",
                Rec."Closing Date",
                Accttype::Savings,
                AcctToCharge,
                CopyStr('Share Capital Sale Charge Fee', 1, 100),
                Balaccttype::"G/L Account",
                Rec."Share Charge GL",
                Rec."Share Charge",
                ExtDocNo,
                '',
                Transtype::" ",
                Rec."Global Dimension 1 Code",
                Rec."Global Dimension 2 Code",
                true,
                TChannel,
                DimID
                );

            SaccoActivities.JournalInsert(
                JTemplate,
                JBatch,
                Rec."No.",
                Rec."Closing Date",
                Accttype::Savings,
                AcctToCharge,
                CopyStr('Excise Duty on Share Capital Sale Fee', 1, 100),
                Balaccttype::"G/L Account",
                SaccoSetup."Excise Duty GL",
                Rec."Share Charge" * SaccoSetup."Excise Duty (%)" * 0.01,
                ExtDocNo,
                '',
                Transtype::" ",
                Rec."Global Dimension 1 Code",
                Rec."Global Dimension 2 Code",
                true,
                TChannel,
                DimID
                );

        end;

    end;
}
