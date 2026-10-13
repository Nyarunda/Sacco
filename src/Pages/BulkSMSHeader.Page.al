Page 50583 "Bulk SMS Header"
{
    ApplicationArea = All;
    SourceTable = "Bulk SMS Header";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateEntered; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TimeEntered; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(EnteredBy; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SMSType; Rec."SMS Type")
                {
                    ApplicationArea = Basic;
                }
                group(Employer)
                {
                    Visible = Rec."SMS Type" = Rec."SMS Type"::Employer;
                    field("Employer Code"; Rec."Employer Code")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Religion.")
                {
                    Visible = Rec."SMS Type" = Rec."SMS Type"::Religion;
                    field(Religion; Rec.Religion)
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Gender.")
                {
                    Visible = Rec."SMS Type" = Rec."SMS Type"::Gender;
                    field(Gender; Rec.Gender)
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(FilterType)
                {
                    Visible = Rec."SMS Type" = Rec."SMS Type"::Everyone;
                    field("Filter Type"; Rec."Filter Type")
                    {
                        ApplicationArea = basic;
                    }
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Product; Rec.Product)
                {
                    ApplicationArea = Basic;
                }
                field(ProductBalanceFilter; Rec."Product Balance Filter")
                {
                    ApplicationArea = Basic;
                }
                field(ActiveMembersOnly; Rec."Active Members Only")
                {
                    ApplicationArea = Basic;
                }
                field("Member Category"; Rec."Member Category")
                {
                    ApplicationArea = Basic;
                }
                field(MessagetoUse; Rec."Message to Use")
                {
                    ApplicationArea = Basic;
                }
                field(SMSStatus; Rec."SMS Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(StatusDate; Rec."Status Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(StatusTime; Rec."Status Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(StatusBy; Rec."Status By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Entries; Rec.Entries)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Message; Rec.Message_)
                {
                    ApplicationArea = Basic;
                    Editable = Mssage;
                }
                field(ChargeSMSFee; Rec."Charge SMS Fee")
                {
                    ApplicationArea = Basic;
                }
                field(ApprovalStatus; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1000000012; "Bulk SMS Lines Part")
            {
                Editable = BulkSMSLines;
                SubPageLink = No = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Send)
            {
                ApplicationArea = Basic;
                Image = PutawayLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    //IF "Approval Status" <> "Approval Status"::Approved THEN
                    //  ERROR('This document requires approval');


                    if Rec."SMS Status" <> Rec."sms status"::Pending then
                        Error('This sms has already been sent');


                    if Rec."Message to Use" = Rec."message to use"::" " then
                        Error('Message to Use Must have a value');

                    if Confirm('Are you sure you would like to send the SMS(ES)?', false) = true then begin

                        Msg := '';
                        if Rec."Message to Use" = Rec."message to use"::"Header Message" then begin
                            Rec.TestField(Message_);
                            Msg := Rec.Message_;
                        end;


                        BulkLines.Reset;
                        BulkLines.SetRange(BulkLines.No, Rec.No);
                        if BulkLines.Find('-') then begin
                            repeat

                                if Rec."Message to Use" = Rec."message to use"::"Line Message" then begin


                                    BulkLines.TestField("Sms Message");
                                    Msg := BulkLines."Sms Message";
                                end
                                else
                                    if Rec."Message to Use" = Rec."message to use"::"Header Message" then begin
                                        Rec.TestField(Message_);
                                        Msg := Rec.Message_;

                                        FName := 'Dear Member, ';
                                        Member.Reset;
                                        Member.SetRange("Mobile Phone No.", BulkLines."Phone No.");
                                        if Member.FindFirst then begin
                                            FName := 'Dear ';
                                            FName += MBanking.FirstName(Member.Name);
                                            FName += ', '
                                        end;
                                        Msg := FName + Msg;
                                    end;

                                if Rec."Charge SMS Fee" then
                                    if BulkLines."Account to Charge" = '' then
                                        Msg := '';

                                if Msg <> '' then
                                    MBanking.SendSms(Sourcetype::Bulk, BulkLines."Phone No.", Msg, Rec.No, BulkLines."Account to Charge", false, 230, false);

                            until BulkLines.Next = 0
                        end;


                        Rec."SMS Status" := Rec."sms status"::Sent;
                        Rec."Status Date" := Today;
                        Rec."Status Time" := Time;
                        Rec."Status By" := UserId;
                        Rec.Modify;

                    end;
                end;
            }
            action("Import Telephone Nos")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    // IF "SMS Type"<>"SMS Type"::Branch THEN BEGIN
                    // ERROR('SMS Type must be Telephone.');
                    // END;
                    //
                    // BulkHeader.RESET;
                    // BulkHeader.SETRANGE(BulkHeader.No,No);
                    // IF BulkHeader.FIND('-') THEN BEGIN
                    // BulkLines.RESET;
                    // BulkLines.SETRANGE(BulkLines.No,BulkHeader.No);
                    // XMLPORT.RUN(39004245);
                    // END;

                    Rec.ImportTelephoneFromExcel;
                end;
            }
            separator(Action4)
            {
            }
            action("Generate Telephone Nos")
            {
                ApplicationArea = Basic;
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Rec."SMS Status" <> Rec."sms status"::Pending then
                        Error('This sms has already been sent');


                    BulkLines.Reset;
                    BulkLines.SetRange(BulkLines.No, Rec.No);
                    if BulkLines.Find('-') then
                        if not Confirm('There are ' + Format(BulkLines.Count) + ' line entries that will be overwritten. Do you want to continue?') then
                            Error('Aborted');

                    BulkLines.Reset;
                    BulkLines.SetRange(BulkLines.No, Rec.No);
                    if BulkLines.Find('-') then
                        BulkLines.DeleteAll;

                    if Rec."Filter Type" = Rec."Filter Type"::None then begin
                        if (Rec."SMS Type" = Rec."sms type"::Everyone) or
                            (Rec."SMS Type" = Rec."sms type"::Employer) or
                            (Rec."SMS Type" = Rec."sms type"::Gender) or
                            (Rec."SMS Type" = Rec."sms type"::Religion)
                        then begin


                            Member.Reset;
                            if Rec."Active Members Only" then
                                Member.SetRange("Member Status", Member."Member Status"::Active);

                            if Rec."SMS Type" = Rec."sms type"::Employer then begin
                                Rec.TestField("Employer Code");
                                Member.SetRange("Employer Code", Rec."Employer Code");
                            end;
                            if Rec."SMS Type" = Rec."sms type"::Religion then begin
                                Rec.TestField(Religion);
                                Member.SetRange(Religion, Rec.Religion);
                            end;
                            if Rec."SMS Type" = Rec."sms type"::Status then begin
                                Rec.TestField(Status);
                                Member.SetRange("Member Status", Rec."Member Status");
                            end;
                            if Rec."SMS Type" = Rec."sms type"::Gender then begin
                                Rec.TestField(Gender);
                                Member.SetRange(Gender, Rec.Gender);
                            end;

                            if Rec."Member Category" <> Rec."Member Category"::" " then
                                Member.SetRange("Member Category", Rec."Member Category");


                            Member.SetFilter("Mobile Phone No.", '<>%1', '');
                            if Member.Find('-') then begin

                                dWindow.Open('Generating Lines:     @1@@@@@@@@@\'
                                            + 'Counter               #2#########\'
                                            + 'Total                 #3#########\'
                                            + 'Press Esc to abort');

                                NoOfRecords := Member.Count;
                                CurrentRecordNo := 0;
                                repeat
                                    CurrentRecordNo += 1;

                                    BulkLines.Init;
                                    BulkLines.No := Rec.No;
                                    BulkLines.Validate("Phone No.", Member."Mobile Phone No.");

                                    BLines.Reset;
                                    BLines.SetRange(BLines.No, Rec.No);
                                    BLines.SetRange("Phone No.", Member."Mobile Phone No.");
                                    if not BLines.Find('-') then
                                        BulkLines.Insert;

                                    dWindow.Update(2, CurrentRecordNo);
                                    dWindow.Update(3, NoOfRecords);
                                    dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                                until Member.Next = 0;

                                dWindow.Close;
                                Message('Completed');
                            end;
                        end;

                        if Rec."SMS Type" = Rec."sms type"::Branch then begin
                            Rec.TestField("Global Dimension 2 Code");
                            Member.Reset;
                            if Rec."Active Members Only" then
                                Member.SetRange("Member Status", Member."Member Status"::Active);
                            if Rec."Member Category" <> Rec."Member Category"::" " then
                                Member.SetRange("Member Category", Rec."Member Category");

                            Member.SetFilter("Mobile Phone No.", '<>%1', '');
                            Member.SetRange("Global Dimension 2 Code", Rec."Global Dimension 2 Code");
                            if Member.Find('-') then begin
                                dWindow.Open('Generating Lines:     @1@@@@@@@@@\'
                                            + 'Counter               #2#########\'
                                            + 'Total                 #3#########\'
                                            + 'Press Esc to abort');

                                NoOfRecords := Member.Count;
                                CurrentRecordNo := 0;
                                repeat
                                    CurrentRecordNo += 1;

                                    BulkLines.Init;
                                    BulkLines.No := Rec.No;
                                    BulkLines.Validate("Phone No.", Member."Mobile Phone No.");

                                    BLines.Reset;
                                    BLines.SetRange(BLines.No, Rec.No);
                                    BLines.SetRange("Phone No.", Member."Mobile Phone No.");
                                    if not BLines.Find('-') then
                                        BulkLines.Insert;

                                    dWindow.Update(2, CurrentRecordNo);
                                    dWindow.Update(3, NoOfRecords);
                                    dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                                until Member.Next = 0;

                                dWindow.Close;
                                Message('Completed');
                            end;
                        end;


                        if Rec."SMS Type" = Rec."sms type"::Product then begin
                            Rec.TestField(Product);
                            SavingsAccounts.Reset;
                            if Rec."Active Members Only" then
                                SavingsAccounts.SetRange(Status, SavingsAccounts.Status::Active);
                            SavingsAccounts.SetRange("Product Type", Rec.Product);
                            SavingsAccounts.SetFilter("Balance (LCY)", Rec."Product Balance Filter");
                            if SavingsAccounts.Find('-') then begin
                                dWindow.Open('Generating Lines:     @1@@@@@@@@@\'
                                            + 'Counter               #2#########\'
                                            + 'Total                 #3#########\'
                                            + 'Press Esc to abort');

                                NoOfRecords := SavingsAccounts.Count;
                                CurrentRecordNo := 0;
                                repeat
                                    CurrentRecordNo += 1;

                                    if Member.Get(SavingsAccounts."Member No.") then
                                        if Member."Mobile Phone No." <> '' then begin
                                            BulkLines.Init;
                                            BulkLines.No := Rec.No;
                                            BulkLines.Validate("Phone No.", Member."Mobile Phone No.");
                                            if SavingsAccounts."Product Category" = SavingsAccounts."product category"::" " then
                                                BulkLines."Account to Charge" := SavingsAccounts."No.";


                                            BLines.Reset;
                                            BLines.SetRange(BLines.No, Rec.No);
                                            BLines.SetRange("Phone No.", Member."Mobile Phone No.");
                                            if not BLines.Find('-') then
                                                BulkLines.Insert;

                                        end;

                                    dWindow.Update(2, CurrentRecordNo);
                                    dWindow.Update(3, NoOfRecords);
                                    dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                                until SavingsAccounts.Next = 0;

                                dWindow.Close;
                                Message('Completed');
                            end;
                        end;


                        if Rec."SMS Type" = Rec."sms type"::"Branch & Product" then begin
                            Rec.TestField(Product);
                            Rec.TestField("Global Dimension 2 Code");
                            SavingsAccounts.Reset;
                            if Rec."Active Members Only" then
                                SavingsAccounts.SetRange(Status, SavingsAccounts.Status::Active);
                            SavingsAccounts.SetRange("Product Type", Rec.Product);
                            SavingsAccounts.SetRange("Global Dimension 2 Code", Rec."Global Dimension 2 Code");
                            if SavingsAccounts.Find('-') then begin
                                dWindow.Open('Generating Lines:     @1@@@@@@@@@\'
                                            + 'Counter               #2#########\'
                                            + 'Total                 #3#########\'
                                            + 'Press Esc to abort');

                                NoOfRecords := SavingsAccounts.Count;
                                CurrentRecordNo := 0;

                                repeat
                                    CurrentRecordNo += 1;
                                    if Member.Get(SavingsAccounts."Member No.") then
                                        if Member."Mobile Phone No." <> '' then begin
                                            BulkLines.Init;
                                            BulkLines.No := Rec.No;
                                            BulkLines.Validate("Phone No.", Member."Mobile Phone No.");
                                            if SavingsAccounts."Product Category" = SavingsAccounts."product category"::" " then
                                                BulkLines."Account to Charge" := SavingsAccounts."No.";

                                            BLines.Reset;
                                            BLines.SetRange(BLines.No, Rec.No);
                                            BLines.SetRange("Phone No.", Member."Mobile Phone No.");
                                            if not BLines.Find('-') then
                                                BulkLines.Insert;

                                        end;

                                    dWindow.Update(2, CurrentRecordNo);
                                    dWindow.Update(3, NoOfRecords);
                                    dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                                until SavingsAccounts.Next = 0;

                                dWindow.Close;
                                Message('Completed');
                            end;
                        end;

                    end else if (Rec."Filter Type" <> Rec."Filter Type"::None) and (Rec."SMS Type" = Rec."SMS Type"::Everyone) then begin
                        ProcessBulkSmsFilter();
                    end;
                end;
            }


            action("Generate Members Without Loans")
            {
                ApplicationArea = Basic;
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Loans: Record Loans;
                    Legacy: Codeunit Legacy;
                    Sky: Codeunit "Sky MBanking";
                    DepBal: Decimal;
                begin

                    if Rec."SMS Status" <> Rec."sms status"::Pending then
                        Error('This sms has already been sent');


                    BulkLines.Reset;
                    BulkLines.SetRange(BulkLines.No, Rec.No);
                    if BulkLines.Find('-') then
                        if not Confirm('There are ' + Format(BulkLines.Count) + ' line entries that will be overwritten. Do you want to continue?') then
                            Error('Aborted');

                    BulkLines.Reset;
                    BulkLines.SetRange(BulkLines.No, Rec.No);
                    if BulkLines.Find('-') then
                        BulkLines.DeleteAll;

                    Rec."Message to Use" := Rec."Message to Use"::"Line Message";

                    if Rec."SMS Type" = Rec."sms type"::Everyone then begin


                        Member.Reset;
                        Member.SetFilter("Member Status", '%1|%2', Member."Member Status"::Active, Member."Member Status"::Dormant);
                        Member.SetFilter("Mobile Phone No.", '<>%1', '');
                        Member.SetFilter("Registration Date", '<%1', CalcDate('-6M', Today));
                        if Member.Find('-') then begin

                            dWindow.Open('Generating Lines:     @1@@@@@@@@@\'
                                        + 'Counter               #2#########\'
                                        + 'Total                 #3#########\'
                                        + 'Press Esc to abort');

                            NoOfRecords := Member.Count;
                            CurrentRecordNo := 0;
                            repeat
                                CurrentRecordNo += 1;

                                Loans.Reset();
                                Loans.SetRange("Member No.", Member."No.");
                                if not Loans.FindFirst() then begin
                                    DepBal := Round(Sky.GetAccountBalance(Legacy.GetDepositAccounts(Member."No.")), 1, '<');
                                    if DepBal >= 12000 then begin

                                        BulkLines.Init;
                                        BulkLines.No := Rec.No;
                                        BulkLines.Validate("Phone No.", Member."Mobile Phone No.");
                                        BulkLines."Sms Message" := 'Dear ' + Sky.FirstName(Member.Name) + ', did you know that you can access a loan of up to Ksh ' + Format(DepBal * 5) + '. Kindly visit our offices or talk to us today. T&C Apply. #MsaPortSacco #MySaccoOfChoice';
                                        BLines.Reset;
                                        BLines.SetRange(BLines.No, Rec.No);
                                        BLines.SetRange("Phone No.", Member."Mobile Phone No.");
                                        if not BLines.Find('-') then
                                            BulkLines.Insert;

                                    end;
                                end;



                                dWindow.Update(2, CurrentRecordNo);
                                dWindow.Update(3, NoOfRecords);
                                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
                            until Member.Next = 0;

                            dWindow.Close;
                            Message('Completed');
                        end;
                    end;

                end;
            }
            action(UpdateAccountToCharge)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin


                    /*
                    BulkLines.RESET;
                    BulkLines.SETRANGE(BulkLines.No,No);
                    IF BulkLines.FIND('-') THEN BEGIN
                        dWindow.OPEN('Updating Lines:      @1@@@@@@@@@\'
                                    +'Counter               #2#########\'
                                    +'Total                 #3#########\'
                                    +'Press Esc to abort');

                        NoOfRecords:=BulkLines.COUNT;
                        CurrentRecordNo:=0;

                        REPEAT
                            CurrentRecordNo+=1;

                            Sms.RESET;
                            Sms.SETRANGE("Document No",No);
                            Sms.SETRANGE("Telephone No",BulkLines.Code);
                            IF Sms.FINDFIRST THEN BEGIN
                                IF Sms."Account No" = '' THEN BEGIN
                                    Sms."Account No" := BulkLines."Account to Charge";
                                    Sms.MODIFY;
                                END;
                            END;


                            dWindow.UPDATE(2,CurrentRecordNo);
                            dWindow.UPDATE(3,NoOfRecords);
                            dWindow.UPDATE(1,ROUND(CurrentRecordNo /  NoOfRecords * 10000,1));
                        UNTIL BulkLines.NEXT=0;
                        dWindow.CLOSE();
                    END;
                    */

                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    var
        BulkHeader: Record "Bulk SMS Header";
        BulkLines: Record "Bulk SMS Lines";
        Loans: Record Loans;
        Savings: Record "Savings Accounts";
        iEntryNo: Integer;
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","Member Refund",FosaAct,mpesaTrans,"change Pin","Bulk SMS";
        text001: label 'Status must be Open';
        text002: label 'Status must be Pending';
        Mssage: Boolean;
        UseHeader: Boolean;
        BulkSMSLines: Boolean;
        Member: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        Msg: Text;
        MBanking: Codeunit "Sky MBanking";
        SourceType: Enum "SMS Source Enum";
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        BLines: Record "Bulk SMS Lines";
        FName: Text;

    procedure UpdateControl()
    begin
        if Rec.Status = Rec.Status::Open then begin
            Mssage := true;
            UseHeader := true;
            BulkSMSLines := true;
        end;


        if Rec.Status = Rec.Status::Pending then begin
            Mssage := false;
            UseHeader := false;
            BulkSMSLines := false;
        end;

        if Rec.Status = Rec.Status::Rejected then begin
            Mssage := false;
            UseHeader := false;
            BulkSMSLines := false;
        end;


        if Rec.Status = Rec.Status::Approved then begin
            Mssage := false;
            UseHeader := false;
            BulkSMSLines := false;
        end;
    end;

    procedure ProcessBulkSmsFilter()
    var
        Member: Record Members;
        dWindow: Dialog;
        NoOfRecords, CurrentRecordNo : Integer;
    begin
        Member.Reset();
        ApplyMemberStatusFilter(Member, Rec."Filter Type");
        Member.SetFilter("Mobile Phone No.", '<>%1', '');

        if Member.FindSet() then begin
            NoOfRecords := Member.Count;
            CurrentRecordNo := 0;

            dWindow.Open('Generating Lines:     @1@@@@@@@@@\' +
                         'Counter               #2#########\' +
                         'Total                 #3#########\' +
                         'Press Esc to abort');

            repeat
                if ShouldInsertLine(Member."No.", Rec."Filter Type") then
                    TryInsertBulkLine(Member."Mobile Phone No.");

                CurrentRecordNo += 1;
                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));
            until Member.Next() = 0;

            dWindow.Close;
            Message('Completed');
        end;
    end;

    procedure ShouldInsertLine(MemberNo: Code[20]; FilterType: Enum "Bulk Sms Filter Type"): Boolean
    begin
        case FilterType of
            FilterType::DormantWithDeposits:
                exit(HasSavings(MemberNo, true, FilterType));

            FilterType::MembersWithOutLoans:
                exit(not HasAnyLoan(MemberNo));

            FilterType::MemberWithLoanBalance:
                exit(HasActiveLoan(MemberNo));

            FilterType::MemberActiveWithDeposits:
                exit(HasSavings(MemberNo, true, FilterType));

            FilterType::MemberActiveWithNoDeposits:
                exit(not HasSavings(MemberNo, true, FilterType));

            FilterType::ActiveMemberFosaAccount:
                exit(HasSavings(MemberNo, false, FilterType));

            FilterType::DormantMemberWithFosaAccount:
                exit(HasSavings(MemberNo, false, FilterType));

            FilterType::MemberWithFixedDeposits:
                exit(HasSavings(MemberNo, false, FilterType));

            FilterType::JuniorAccount:
                exit(HasSavings(MemberNo, false, FilterType));

            FilterType::HolidaySavings:
                exit(HasSavings(MemberNo, false, FilterType));
        end;

        exit(false);
    end;

    procedure ApplyMemberStatusFilter(var Member: Record Members; FilterType: Enum "Bulk Sms Filter Type")
    begin
        case FilterType of
            FilterType::DormantWithDeposits,
            FilterType::DormantMemberWithFosaAccount:
                Member.SetRange("Member Status", Member."Member Status"::Dormant);

            FilterType::ActiveMemberFosaAccount,
            FilterType::MemberActiveWithDeposits,
            FilterType::MemberActiveWithNoDeposits:
                Member.SetRange("Member Status", Member."Member Status"::Active);
        end;
    end;

    procedure HasSavings(MemberNo: Code[20]; CheckBalance: Boolean; FilterType: Enum "Bulk Sms Filter Type"): Boolean
    var
        Savings: Record "Savings Accounts";
    begin
        Savings.Reset();
        Savings.SetRange("Member No.", MemberNo);
        if CheckBalance then
            Savings.SetFilter("Balance (LCY)", '>0');
        if (FilterType = FilterType::ActiveMemberFosaAccount) or
            (FilterType = FilterType::DormantMemberWithFosaAccount)
        then
            Savings.SetRange("Product Category", Savings."Product Category"::"Ordinary Savings")
        else
            if FilterType = FilterType::MemberWithFixedDeposits then
                Savings.SetRange("Product Category", Savings."Product Category"::"Fixed Deposit")
            else
                if FilterType = FilterType::JuniorAccount then
                    Savings.SetRange("Product Category", Savings."Product Category"::"Junior Savings")
                else
                    if FilterType = FilterType::HolidaySavings then
                        Savings.SetRange("Product Category", Savings."Product Category"::"Holiday Savings")
                else
                    Savings.SetRange("Product Category", Savings."Product Category"::"Deposit Contribution");

        exit(Savings.FindFirst());
    end;

    procedure HasAnyLoan(MemberNo: Code[20]): Boolean
    var
        Loans: Record "Loans";
    begin
        Loans.Reset();
        Loans.SetRange("Member No.", MemberNo);
        exit(Loans.FindFirst());
    end;

    procedure HasActiveLoan(MemberNo: Code[20]): Boolean
    var
        Loans: Record "Loans";
    begin
        Loans.Reset();
        Loans.SetRange("Member No.", MemberNo);
        Loans.SetFilter("Total Outstanding Balance", '>0');
        exit(Loans.FindFirst());
    end;

    procedure TryInsertBulkLine(PhoneNo: Code[20])
    begin
        BulkLines.Init();
        BulkLines.No := Rec.No;
        BulkLines.Validate("Phone No.", PhoneNo);

        BLines.Reset();
        BLines.SetRange(BLines.No, Rec.No);
        BLines.SetRange("Phone No.", PhoneNo);
        if not BLines.Find('-') then
            BulkLines.Insert();
    end;
}

