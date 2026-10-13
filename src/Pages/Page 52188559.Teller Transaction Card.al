
Page 50222 "Teller Transaction Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Teller Transaction";
    PromotedActionCategories = ' New,Process,Report,Approval Requests,Post';

    layout
    {
        area(content)
        {
            group(Transactions)
            {
                Caption = 'Transactions';
                field(TransactionNo; Rec."Transaction No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if Rec."Account Type" = Rec."account type"::Account then
                            AccNo := true
                        else
                            if (Rec."Account Type" = Rec."account type"::"G/L Account") or (Rec."Account Type" = Rec."account type"::Customer) then
                                AccNo := true
                            else
                                AccNo := false;
                    end;
                }
                field("Employer Type"; Rec."Employer Type")
                {
                    ApplicationArea = Basic;
                    Editable = Rec."Account Type" = Rec."Account Type"::Customer;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = AccNo;
                    //LookupPageId = "Member Accounts  List";

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Members: Record Members;
                        Accounts: Record "Savings Accounts";
                        Customer: Record Customer;
                        Vendor: Record "Savings Accounts";
                        GLAcc: Record "G/L Account";
                        Bank: Record "Bank Account";
                    begin
                        if Rec."Account Type" = Rec."Account Type"::"G/L Account" then begin
                            Rec."Account No." := '';
                            GLAcc.Reset();
                            GLAcc.SetRange("Cashier G/L", true);
                            if Page.RunModal(Page::"Chart of Accounts", GLAcc) = Action::LookupOK then
                                Rec."Account No." := GLAcc."No.";
                        end
                        else
                            if Rec."Account Type" = Rec."Account Type"::"Non-Member" then begin
                                Rec."Account No." := '';
                                Bank.Reset();
                                if Page.RunModal(Page::"Bank Account List", Bank) = Action::LookupOK then
                                    Rec."Account No." := GLAcc."No.";
                            end
                            else
                                if Rec."Account Type" = Rec."Account Type"::Account then begin

                                    Rec."Account No." := '';
                                    Accounts.Reset();
                                    if Page.RunModal(Page::"Member Accounts List", Accounts) = Action::LookupOK then
                                        Rec."Account No." := Accounts."No.";
                                end else
                                    if Rec."Account Type" = Rec."Account Type"::Customer then begin

                                        Rec."Account No." := '';
                                        if Rec."Employer Type" = Rec."Employer Type"::Checkoff then begin
                                            Customer.Reset();
                                            Customer.SetRange("Account Type", Customer."Account Type"::Employer);
                                            if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then begin
                                                Rec."Account No." := Customer."No.";
                                            end

                                        end;

                                        if Rec."Employer Type" = Rec."Employer Type"::Imprest then begin
                                            Customer.Reset();
                                            Customer.SetRange("Account Type", Customer."Account Type"::Imprest);
                                            if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then begin
                                                Rec."Account No." := Customer."No.";
                                            end;
                                        end;

                                        if Rec."Employer Type" = Rec."Employer Type"::Tenant then begin
                                            Customer.Reset();
                                            Customer.SetRange("Account Type", Customer."Account Type"::Tenant);
                                            if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then begin
                                                Rec."Account No." := Customer."No.";
                                            end;
                                        end;

                                    end;

                        Rec.Validate("Account No.");
                    end;

                    trigger OnValidate()
                    begin

                        UpdateControl;
                    end;
                }
                field(mNO; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                    Editable = false;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GroupAccount; Rec."Group Account")
                {
                    ApplicationArea = Basic;
                }
                field(LoanDefaulted; Rec."Loan Defaulted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TransactionMode; Rec."Transaction Mode")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = TransType;

                    trigger OnValidate()
                    begin
                        FChequeVisible := false;
                        BChequeVisible := false;
                        BReceiptVisible := false;
                        BOSAReceiptChequeVisible := false;
                        AllAmount := false;
                        DiscCH := false;
                        FLien := false;
                        ChqTrans := false;

                        if (Rec.Type = Rec.Type::"Cheque Deposit") or (Rec.Type = Rec.Type::"Cheque Withdrawal") then begin
                            FChequeVisible := true;
                            DiscCH := true;
                        end;


                        if (Rec.Type = Rec.Type::"Inhouse Cheque Transfer") then begin
                            FChequeVisible := true;
                            DiscCH := true;
                            ChqTrans := true;
                        end;


                        if Rec."Account Type" = Rec."account type"::"G/L Account" then
                            AllAmount := true;


                        if Rec.Type = Rec.Type::"Bankers Cheque" then
                            BChequeVisible := true;

                        if Rec.Type = Rec.Type::"Bankers Cheque GL" then
                            BChequeVisible := true;

                        if Rec.Type = Rec.Type::"Credit Receipt" then begin
                            BReceiptVisible := true;

                            BOSAReceiptChequeVisible := true;
                            AllAmount := true;
                        end;

                        if Rec.Type = Rec.Type::"Credit Cheque" then begin
                            FChequeVisible := true;
                            BOSAReceiptChequeVisible := true;
                            AllAmount := true;
                        end;

                        if Rec.Type = Rec.Type::Lien then begin
                            FLien := true;
                        end;

                        //MESSAGE('%1',Type);
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = Amont;
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = Currr;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AccountStatus; Rec."Account Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MobilePhoneNo; Rec."Mobile Phone No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    Caption = 'Remarks/Deposited By';
                    ApplicationArea = Basic;
                    Editable = Remarrrks;
                }
                field("Close Account"; Rec."Close Account")
                {
                    ApplicationArea = Basic;
                }
                field(AllocatedAmount; Rec."Allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field(BookBalance; Rec."Book Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Send SMS"; Rec."Send SMS")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(AvailableBalance; Rec."Available Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Available Balance';
                    Editable = false;
                }
                field("Total Charge Amount"; Rec."Total Charge Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Other Charges"; Rec."Other Charges")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NewAccountBalance; Rec."New Account Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(IDNo; Rec."ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }
                field(TillName; Rec."Till Name")
                {
                    ApplicationArea = Basic;
                }
                field(TIllBalance; Rec."TIll Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(TransactionTime; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    //Editable = true;
                }
                field(SigningInstructions; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Signing Instruction Narration"; Rec."Signing Instruction Narration")
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
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(AttemptedSelfTransaction; Rec."Attempted Self Transaction")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    LookupPageID = "Member Listing";
                }

            }
            group(BCheque)
            {
                Caption = '.';
                Visible = BChequeVisible;
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                }
                field(BankersChequeType; Rec."Bankers Cheque Type")
                {
                    ApplicationArea = Basic;
                }
                field(BankersChequeNo; Rec."Bankers Cheque No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bankers Cheque No';
                }
            }
            group(BReceipt)
            {
                Caption = '.';
                Visible = BReceiptVisible;
                field("Member No"; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Lien Transaction")
            {
                Caption = '.';
                Visible = FLien;
                field("Expiry Date"; Rec."Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
            group(FCheque)
            {
                Caption = '.';
                Visible = FChequeVisible;
                field(ChequeType; Rec."Cheque Type")
                {
                    ApplicationArea = Basic;
                }
                field(BchequeNo; Rec."Cheque No")
                {
                    ApplicationArea = Basic;
                    Caption = ' Cheque No';
                }
                field(Bank; Rec."Bank Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank';
                    Editable = false;
                    Visible = false;
                }
                field(IssueingBankAccount; Rec."Issueing Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field(ChequeIssueingBank; Rec."Cheque Issueing Bank")
                {
                    ApplicationArea = Basic;
                }
                field(DrawerName; Rec."Drawer Name")
                {
                    ApplicationArea = Basic;
                }
                field(ChequeDate; Rec."Cheque Date")
                {
                    ApplicationArea = Basic;
                }
                field(ChequeStatus; Rec."Cheque Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ExpectedMaturityDate; Rec."Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control20; "Teller Lines")
            {
                SubPageLink = "Transaction No." = field("Transaction No."), "Member No." = field("Member No.");
                Visible = BOSAReceiptChequeVisible;
            }
        }
        area(factboxes)
        {
            part(Control66; "Info Base")
            {
                SubPageLink = "Member No." = field("Member No.");
            }
            part(Control3; "Picture & Signature")
            {
                SubPageLink = "Member No." = field("Member No.");
            }
            part(Control57; "Member Loan Statictics")
            {
                SubPageLink = "Member No." = field("Member No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Transaction)
            {
                Caption = 'Transaction';
                action(Statement)
                {
                    ApplicationArea = Basic;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Account.Reset;
                        Account.SetRange(Account."No.", Rec."Account No.");
                        if Account.Find('-') then
                            Report.Run(Report::"Savings Statement", true, false, Account)
                    end;
                }
                action("Account Page")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Page';
                    Image = Vendor;
                    Promoted = true;
                    RunObject = Page "Member Account Card";
                    RunPageLink = "No." = field("Account No.");
                }

                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Image = NewSparkle;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Account Signatories";
                    RunPageLink = Code = field("Member No.");
                }
                action("Picture & Signature")
                {
                    ApplicationArea = Basic;
                    Image = Picture;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        ImageData.Reset;
                        ImageData.SetRange(ImageData."Member No.", Rec."Member No.");
                        if ImageData.Find('-') then begin
                            Page.Run(50068, ImageData);
                        end;
                    end;
                }
                separator(Action80)
                {
                }
                action(StopCheque)
                {
                    ApplicationArea = Basic;
                    Caption = 'Stop Cheque';
                    Image = Stop;
                    Promoted = true;
                    PromotedCategory = Process;
                }
            }
        }
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                begin


                    Rec.TestField(Amount);
                    Rec.TestField("Attempted Self Transaction", false);
                    if Rec.Status = Rec.Status::"Pending Approval" then
                        Error('The transaction must be fully approved before proceeding');

                    if Confirm('Are you sure you want to post this ' + Format(Rec.Type)) then begin

                        BankingActivities.InitPost(Rec);

                        CurrPage.close();
                    end;
                end;
            }
            action("Post & Print")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Rec.Status = Rec.Status::"Pending Approval" then
                        Error('The transaction must be fully approved before proceeding');

                    if Confirm('Are you sure you want to post this ' + Format(Rec.Type)) then begin

                        BankingActivities.InitPost(Rec);

                        Commit;

                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Use POS Printer" then begin
                                Trans.Reset;
                                Trans.SetRange("Transaction No.", Rec."Transaction No.");
                                if Trans.Find('-') then begin
                                    if Rec.Type = Rec.Type::"Cash Withdrawal" then begin
                                        if Rec."Group Account" then
                                            Report.Run(Report::"POS Dep_With Slip", false, true, Trans)
                                        else
                                            Report.Run(Report::"POS Dep_With Slip", false, true, Trans)
                                    end
                                    else
                                        if Rec.Type = Rec.Type::"Cash Deposit" then
                                            Report.Run(Report::"POS Dep_With Slip", false, true, Trans)
                                        else
                                            if Rec.Type = Rec.Type::"Credit Receipt" then
                                                Report.Run(Report::"POS Credit Receipt Slip", false, true, Trans)
                                            else
                                                if Rec.Type = Rec.Type::"Income Transactions" then
                                                    Report.Run(Report::"POS Dep_With Slip", false, true, Trans)
                                                else
                                                    if Rec.Type = Rec.Type::"Cheque Deposit" then
                                                        Report.Run(Report::"POS Cheque Slip", false, true, Trans)
                                                    else
                                                        if Rec.Type = Rec.Type::"Cheque Withdrawal" then
                                                            Report.Run(Report::"POS Cheque Slip", false, true, Trans)
                                                        else
                                                            if Rec.Type = Rec.Type::"Credit Cheque" then
                                                                Report.Run(Report::"POS Credit Receipt Slip", false, true, Trans)
                                                            else
                                                                if Rec.Type = Rec.Type::"Bankers Cheque" then
                                                                    Report.Run(Report::"POS Credit Receipt Slip", false, true, Trans)
                                    //REPORT.RUN(50199,TRUE,TRUE,Trans)
                                end;
                            end
                            else begin


                                Trans.Reset;
                                Trans.SetRange("Transaction No.", Rec."Transaction No.");
                                if Trans.Find('-') then begin
                                    if Rec.Type = Rec.Type::"Cash Withdrawal" then begin
                                        if Rec."Group Account" then
                                            Report.Run(Report::"Group Withdrawal Slip", false, true, Trans)
                                        else
                                            Report.Run(Report::"Withdrawal Slip", true, false, Trans)
                                    end
                                    else
                                        if Rec.Type = Rec.Type::"Cash Deposit" then
                                            Report.Run(Report::"Deposit Slip", false, true, Trans)
                                        else
                                            if Rec.Type = Rec.Type::"Credit Receipt" then
                                                Report.Run(Report::"Credit Cheque Deposit Slip", false, true, Trans)
                                            else
                                                if Rec.Type = Rec.Type::"Income Transactions" then
                                                    Report.Run(Report::"Credit Cheque Deposit Slip", false, true, Trans)
                                                else
                                                    if Rec.Type = Rec.Type::"Cheque Deposit" then
                                                        Report.Run(Report::"Cheque Deposit Slip", false, true, Trans)
                                                    else
                                                        if Rec.Type = Rec.Type::"Cheque Withdrawal" then
                                                            Report.Run(Report::"Withdrawal Slip", false, true, Trans)
                                                        else
                                                            if Rec.Type = Rec.Type::"Credit Cheque" then
                                                                Report.Run(Report::"Credit Cheque Deposit Slip", false, true, Trans)
                                                            else
                                                                if Rec.Type = Rec.Type::"Bankers Cheque" then
                                                                    Report.Run(Report::"Bankers Cheque Slip", false, true, Trans)
                                                                else
                                                                    if Rec.Type = Rec.Type::"Bankers Cheque GL" then
                                                                        Report.Run(Report::"Bankers Cheque Slip", false, true, Trans)
                                    //REPORT.RUN(50199,TRUE,TRUE,Trans)
                                end;

                            end;
                        end;

                        CurrPage.close();

                    end;
                end;
            }
            action("Reset Transaction Date")
            {
                ApplicationArea = Basic;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;

                trigger OnAction()
                begin

                    //Trans.RESET;
                    //Trans.SETRANGE(Trans.Posted,FALSE);
                    //Trans.SETRANGE(Trans.No,No);
                    //IF Trans.FIND('-') THEN BEGIN
                    Rec.TestField(Posted, false);
                    Rec."Transaction Date" := Today;
                    Rec."Transaction Time" := Time;
                    Rec.Modify;

                    Message('Transaction date updated');

                    //END ELSE
                    //ERROR('Transaction already posted');
                end;
            }
            action("Reprint Slip")
            {
                ApplicationArea = Basic;
                Caption = 'Reprint Slip';
                Image = DepositSlip;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField(Posted);
                    Trans.Reset;
                    Trans.SetRange("Transaction No.", Rec."Transaction No.");
                    if Trans.Find('-') then begin
                        Trans.Dublicate := true;
                        Trans.Modify;
                        Commit;
                    end;

                    if UserSetup.Get(UserId) then begin
                        if UserSetup."Use POS Printer" then begin
                            Trans.Reset;
                            Trans.SetRange("Transaction No.", Rec."Transaction No.");
                            if Trans.Find('-') then begin
                                if Rec.Type = Rec.Type::"Cash Withdrawal" then begin
                                    if Rec."Group Account" then
                                        Report.Run(Report::"POS Dep_With Slip", true, false, Trans)
                                    else
                                        Report.Run(Report::"POS Dep_With Slip", true, false, Trans)
                                end
                                else
                                    if Rec.Type = Rec.Type::"Cash Deposit" then
                                        Report.Run(Report::"POS Dep_With Slip", true, false, Trans)
                                    else
                                        if Rec.Type = Rec.Type::"Credit Receipt" then
                                            Report.Run(Report::"POS Credit Receipt Slip", true, false, Trans)
                                        else
                                            if Rec.Type = Rec.Type::"Income Transactions" then
                                                Report.Run(Report::"POS Dep_With Slip", true, false, Trans)
                                            else
                                                if Rec.Type = Rec.Type::"Cheque Deposit" then
                                                    Report.Run(Report::"POS Cheque Slip", true, false, Trans)
                                                else
                                                    if Rec.Type = Rec.Type::"Cheque Withdrawal" then
                                                        Report.Run(Report::"POS Cheque Slip", true, false, Trans)
                                                    else
                                                        if Rec.Type = Rec.Type::"Credit Cheque" then
                                                            Report.Run(Report::"POS Credit Receipt Slip", true, false, Trans)
                                                        else
                                                            if Rec.Type = Rec.Type::"Bankers Cheque" then
                                                                Report.Run(Report::"POS Credit Receipt Slip", true, false, Trans)
                                //REPORT.RUN(50199,TRUE,TRUE,Trans)
                            end;
                        end
                        else begin

                            Trans.Reset;
                            Trans.SetRange("Transaction No.", Rec."Transaction No.");
                            if Trans.Find('-') then begin
                                if Rec.Type = Rec.Type::"Cash Withdrawal" then begin
                                    if Rec."Group Account" then
                                        Report.Run(Report::"Group Withdrawal Slip", false, true, Trans)
                                    else
                                        Report.Run(Report::"Withdrawal Slip", true, false, Trans)
                                end
                                else
                                    if Rec.Type = Rec.Type::"Cash Deposit" then
                                        Report.Run(Report::"Deposit Slip", false, true, Trans)
                                    else
                                        if Rec.Type = Rec.Type::"Credit Receipt" then
                                            Report.Run(Report::"Credit Cheque Deposit Slip", false, true, Trans)
                                        else
                                            if Rec.Type = Rec.Type::"Income Transactions" then
                                                Report.Run(Report::"Credit Cheque Deposit Slip", false, true, Trans)
                                            else
                                                if Rec.Type = Rec.Type::"Cheque Deposit" then
                                                    Report.Run(Report::"Cheque Deposit Slip", false, true, Trans)
                                                else
                                                    if Rec.Type = Rec.Type::"Cheque Withdrawal" then
                                                        Report.Run(Report::"Withdrawal Slip", false, true, Trans)
                                                    else
                                                        if Rec.Type = Rec.Type::"Credit Cheque" then
                                                            Report.Run(Report::"Credit Cheque Deposit Slip", false, true, Trans)
                                                        else
                                                            if Rec.Type = Rec.Type::"Bankers Cheque" then
                                                                Report.Run(Report::"Bankers Cheque Slip", false, true, Trans)
                                                            else
                                                                if Rec.Type = Rec.Type::"Bankers Cheque GL" then
                                                                    Report.Run(Report::"Bankers Cheque Slip", false, true, Trans)
                                //REPORT.RUN(50199,TRUE,TRUE,Trans)
                            end;

                        end;
                    end;
                end;
            }
            action("Till Balance")
            {
                ApplicationArea = Basic;
                Image = Balance;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin

                    if (Rec.Type = Rec.Type::"Credit Cheque") or (Rec.Type = Rec.Type::"Cheque Deposit") then begin

                        BankAcc.Reset;
                        BankAcc.SetRange("No.", Rec."Bank Account");
                        if BankAcc.FindFirst then
                            Page.Run(370, BankAcc);
                    end
                    else begin
                        BankAcc.Reset;
                        BankAcc.SetRange("No.", Rec."Till Code");

                        if BankAcc.FindFirst then
                            Page.Run(370, BankAcc);
                    end;
                end;
            }
            action("Discount Cheque")
            {
                ApplicationArea = Basic;
                Image = MakeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;
                RunObject = Page "Cheque Discounting";
                RunPageLink = "Transaction No." = field("Transaction No."),
                              Type = const("Cheque Deposit");
                Visible = DiscCH;
            }
            action("Stop Cheque")
            {
                ApplicationArea = Basic;
                Image = VoidCheck;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin

                    BankingActivities.StopCheque(Rec);
                end;
            }
            action("Clear Lien")
            {
                ApplicationArea = Basic;
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin


                    if Rec.Type <> Rec.Type::Lien then
                        Error('Only applicable to Lien');

                    if Confirm('Are you sure you want to process the selected transactions?', false) = true then begin

                        Rec."Cheque Status" := Rec."cheque status"::Honoured;
                        Rec."Date Cleared" := Today;
                        Rec."Cleared By" := UserId;
                        Rec.Modify;

                        Message('Lien processed successfully');

                    end;
                end;
            }
            action("Savings Accounts")
            {
                ApplicationArea = Basic;
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Member Accounts List";
                RunPageLink = "Member No." = field("Member No.");
            }
            action("Suggest Lines")
            {
                ApplicationArea = Basic;
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Enabled = "Transaction Type" = "Transaction Type"::
                trigger OnAction()
                var
                    myInt: Integer;
                    AmtReceived: Decimal;
                begin
                    Rec.TestField(Amount);
                    AmtReceived := Rec.Amount;
                    BankingActivities.InsertTellerLines(Rec, Rec.Amount);
                    Rec.Amount := AmtReceived;
                    Rec.Modify();
                end;
            }
            action("Open Loans")
            {
                ApplicationArea = Basic;
                Image = PostedPayment;
                RunObject = Page "Loan Posted List";
                RunPageLink = "Member No." = field("Member No.");
            }
            /*action("Mark As Posted")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    TestField(Cashier, UserId);
                    BankRec.Reset;
                    BankRec.SetRange("Document No.", "Transaction No.");
                    if BankRec.FindFirst then begin
                        if Abs(BankRec.Amount) = Abs(Amount) then begin
                            Posted := true;
                            "Posted By" := Cashier;
                            "Date Posted" := "Transaction Date";
                            Message('Marked as Posted');
                        end;
                    end;
                end;
            }*/
        }
        area(creation)
        {
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


                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."Transaction No.", Rec.Amount, Documenttype::"Teller Transaction", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
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
                        Rec.TestField(Status, Rec.Status::"Pending Approval");

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."Transaction No.");
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
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Teller Transaction";

                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."Transaction No.");
                        ApprovalTracker.SetRange("Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin

                        if Rec.Status = Rec.Status::"Pending Approval" then begin
                            VarVariant := Rec;
                            CalwideApprovals.CancelTracker(VarVariant, Rec."Transaction No.");
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        FChequeVisible := false;
        BChequeVisible := false;
        BReceiptVisible := false;
        BOSAReceiptChequeVisible := false;
        AllAmount := false;
        DiscCH := false;
        FLien := false;
        ChqTrans := false;

        if (Rec.Type = Rec.Type::"Cheque Deposit") or (Rec.Type = Rec.Type::"Cheque Withdrawal") then begin
            FChequeVisible := true;
            DiscCH := true;
            ChqTrans := false;
        end;

        if (Rec.Type = Rec.Type::"Inhouse Cheque Transfer") then begin
            FChequeVisible := true;
            DiscCH := true;
            ChqTrans := true;
        end;


        if Rec.Type = Rec.Type::"Bankers Cheque GL" then
            BChequeVisible := true;

        if Rec.Type = Rec.Type::"Bankers Cheque" then
            BChequeVisible := true;

        if Rec.Type = Rec.Type::"Credit Receipt" then begin
            BReceiptVisible := true;
            AllAmount := true;
            BOSAReceiptChequeVisible := true
        end;

        if Rec."Account Type" = Rec."account type"::"G/L Account" then
            AllAmount := true;

        if Rec.Type = Rec.Type::"Credit Cheque" then begin
            FChequeVisible := true;
            BOSAReceiptChequeVisible := true;
            AllAmount := true;
        end;

        if Rec.Type = Rec.Type::Lien then begin
            FLien := true;
        end;

        SetControlAppearance;
        UpdateControl;
        if Rec."Account Type" = Rec."account type"::Account then
            AccNo := true
        else
            if (Rec."Account Type" = Rec."account type"::"G/L Account") or (Rec."Account Type" = Rec."account type"::Customer) then
                AccNo := true
            else
                AccNo := false;
    end;

    trigger OnInit()
    begin

        UpdateControl;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec.Posted = false then begin
            if Rec.Cashier <> UserId then
                Error('You cannot modify a transaction being processed by user %1', Rec.Cashier);
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        if Rec."Account Type" = Rec."account type"::Account then
            AccNo := true
        else
            if Rec."Account Type" = Rec."account type"::"G/L Account" then
                AccNo := true
            else
                AccNo := false;
    end;

    trigger OnOpenPage()
    begin

        if Rec.Posted = true then
            CurrPage.Editable := false;
        if Rec."Account Type" = Rec."account type"::Account then
            AccNo := true
        else
            if Rec."Account Type" = Rec."account type"::"G/L Account" then
                AccNo := true
            else
                AccNo := false;



        FChequeVisible := false;
        BChequeVisible := false;
        BReceiptVisible := false;
        BOSAReceiptChequeVisible := false;
        AllAmount := false;
        DiscCH := false;
        FLien := false;
        ChqTrans := false;

        if (Rec.Type = Rec.Type::"Cheque Deposit") or (Rec.Type = Rec.Type::"Cheque Withdrawal") then begin
            FChequeVisible := true;
            DiscCH := true;
            ChqTrans := false;
        end;

        if (Rec.Type = Rec.Type::"Inhouse Cheque Transfer") then begin
            FChequeVisible := true;
            DiscCH := true;
            ChqTrans := true;
        end;


        if Rec.Type = Rec.Type::"Bankers Cheque GL" then
            BChequeVisible := true;
        if Rec.Type = Rec.Type::"Bankers Cheque" then
            BChequeVisible := true;

        if Rec.Type = Rec.Type::"Credit Receipt" then begin
            BReceiptVisible := true;
            AllAmount := true;
            BOSAReceiptChequeVisible := true
        end;

        if Rec.Type = Rec.Type::"Income Transactions" then begin
            BReceiptVisible := true;
            AllAmount := true;
            BOSAReceiptChequeVisible := true
        end;

        if Rec."Account Type" = Rec."account type"::"G/L Account" then
            AllAmount := true;

        if Rec.Type = Rec.Type::"Credit Cheque" then begin
            FChequeVisible := true;
            BOSAReceiptChequeVisible := true;
            AllAmount := true;
        end;

        if Rec.Type = Rec.Type::Lien then begin
            FLien := true;
        end;

        SetControlAppearance;
        UpdateControl;
        if Rec."Account Type" = Rec."account type"::Account then
            AccNo := true
        else
            if Rec."Account Type" = Rec."account type"::"G/L Account" then
                AccNo := true
            else
                AccNo := false;
    end;

    var

        FChequeVisible: Boolean;

        BChequeVisible: Boolean;

        BReceiptVisible: Boolean;

        BOSAReceiptChequeVisible: Boolean;
        FLien: Boolean;
        Account: Record "Savings Accounts";
        UserSetup: Record "User Setup";
        DBranch: Code[20];
        DActivity: Code[20];
        Temp: Record "Banking User Setup";
        Jtemplate: Code[20];
        Jbatch: Code[20];
        TillNo: Code[20];
        MemberNo: Code[20];
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        AccNo: Boolean;
        TransType: Boolean;
        Amont: Boolean;
        Remarrrks: Boolean;
        AllAmount: Boolean;
        Trans: Record "Teller Transaction";
        Excess: Code[20];
        Shortage: Code[20];
        Currr: Boolean;
        ImageData: Record "Member Images";
        DiscCH: Boolean;
        NoEditTeller: Boolean;
        BankAcc: Record "Bank Account";
        LoansG: Record "Loan Security";
        Loans: Record Loans;
        DefGuarLoan: Record Loans;
        ChqTrans: Boolean;
        TransactionCharges: Record "Transaction Charges Lines";
        BankRec: Record "Bank Account Ledger Entry";
        BankingActivities: Codeunit "Banking Activities";

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
    begin

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;


    procedure UpdateControl()
    begin
        if Rec.Status = Rec.Status::Open then begin
            AccNo := true;
            TransType := true;
            Remarrrks := true;
            Amont := true;
            Currr := true;
        end;


        if Rec.Status = Rec.Status::"Pending Approval" then begin
            AccNo := false;
            TransType := false;
            Remarrrks := false;
            Amont := false;
            Currr := false;
        end;


        if Rec.Status = Rec.Status::Rejected then begin
            AccNo := false;
            TransType := false;
            Remarrrks := false;
            Amont := false;
            Currr := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            AccNo := false;
            TransType := false;
            Remarrrks := false;
            Amont := false;
            Currr := false;

        end;
        if Rec."Account Type" = Rec."account type"::Account then
            AccNo := true
        else
            if (Rec."Account Type" = Rec."account type"::"G/L Account") or (Rec."Account Type" = Rec."account type"::Customer) then
                AccNo := true
            else
                AccNo := false;
    end;
}

