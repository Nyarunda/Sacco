codeunit 50122 "Custom Notifications"
{
    trigger OnRun()
    begin
        //GenerateDefaulterNotices();
    end;

    var
        MyNotification: Notification;
        Msg: Text;
        DMsg: Text;
        DDay: Integer;
        StatementNo: Integer;
        Mail: Codeunit Mail;
        MemberActivities: Codeunit "Member Activities";
        Heading: Text[50];
        SalutationTxt: Text[50];
        Receiver: Text[45];
        RegardsTxt: Text[50];
        BodyTxt: Text;
        Notice: Integer;
    //FilePath: Text[50];

    local procedure ShowNotification()
    var
        NotificationMessage: Label 'Your Notification Message.';
    begin
        MyNotification.Scope := NotificationScope::LocalScope;
        MyNotification.Message := NotificationMessage;
        MyNotification.Send();
    end;

    procedure NotifyFinanceOfExitNotice()
    var
        SaccoSetup: Record "Sacco Setup";
        ExitNotice: Record "Member Exit Notice";
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        ToRecipients: List of [Text];
        CCRecipients: List of [Text];
        BCCRecipients: List of [Text];
        MyNotification: Notification;
        EmailBody: Text;
        NoticeList: Text;
        NoticeCount: Integer;
        EmailSubject: Label 'MEMBER EXIT NOTICE SUBMITTED';
    begin
        Clear(NoticeList);
        Clear(NoticeCount);

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", UserId);
        UserSetup.SetRange("Finance Approval", true);
        if UserSetup.FindFirst() then begin

            ExitNotice.Reset();
            ExitNotice.SetRange("Notice Stage", ExitNotice."Notice Stage"::"HOD");

            if ExitNotice.FindSet() then
                repeat
                    NoticeCount += 1;

                    if NoticeList = '' then
                        NoticeList := ExitNotice."No."
                    else
                        NoticeList += ', ' + ExitNotice."No.";
                until ExitNotice.Next() = 0;

            if NoticeCount = 0 then
                exit;

            MyNotification.Scope := NotificationScope::LocalScope;
            MyNotification.Message :=
                StrSubstNo('%1 member exit notice(s) pending finance review: %2', NoticeCount, NoticeList);
            MyNotification.Send();

        end;
    end;

    procedure NotifyCrditOfExitNotice()
    var
        SaccoSetup: Record "Sacco Setup";
        ExitNotice: Record "Member Exit Notice";
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        ToRecipients: List of [Text];
        CCRecipients: List of [Text];
        BCCRecipients: List of [Text];
        MyNotification: Notification;
        EmailBody: Text;
        NoticeList: Text;
        NoticeCount: Integer;
        EmailSubject: Label 'MEMBER EXIT NOTICE SUBMITTED';
    begin
        Clear(NoticeList);
        Clear(NoticeCount);

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", UserId);
        UserSetup.SetRange("Is Credit Department", true);
        if UserSetup.FindFirst() then begin

            ExitNotice.Reset();
            ExitNotice.SetRange("Notice Stage", ExitNotice."Notice Stage"::"Credit Department 1");

            if ExitNotice.FindSet() then
                repeat
                    NoticeCount += 1;

                    if NoticeList = '' then
                        NoticeList := ExitNotice."No."
                    else
                        NoticeList += ', ' + ExitNotice."No.";
                until ExitNotice.Next() = 0;

            if NoticeCount = 0 then
                exit;

            MyNotification.Scope := NotificationScope::LocalScope;
            MyNotification.Message :=
                StrSubstNo('%1 member exit notice(s) pending credit review: %2', NoticeCount, NoticeList);
            MyNotification.Send();

        end;
    end;

    procedure GetPendingChequeNotifications()
    Var
        Banks: Record "Bank Account";
        Trans: Record "Teller Transaction";
        Cheques: text;
        Msg: Text;
    begin
        BankingSetup.Reset();
        BankingSetup.SetFilter("User Name", UserId);
        if BankingSetup.FindFirst() then begin
            if (BankingSetup."Chief Accountant" = true) or (BankingSetup."Chief Cashier" = true) then begin

                Trans.Reset();
                Trans.SetFilter(Type, '%1|%2', Trans.Type::"Cheque Deposit", Trans.Type::"Credit Cheque");
                Trans.SetRange("Cheque Status", Trans."Cheque Status"::Pending);
                Trans.SetFilter("Expected Maturity Date", '<%1', Today);
                if Trans.FindFirst() then begin
                    repeat
                        Cheques += '|' + Trans."Cheque No";
                    until trans.Next() = 0;
                end;

                Msg := 'Cheques ' + Cheques + ' is ready for processing.';

                if StrLen(Cheques) > 5 then begin

                    MyNotification.Scope := NotificationScope::LocalScope;
                    MyNotification.Message := Msg;

                    MyNotification.Send();
                    Message(Msg);
                end;

            end;
        end;
    end;

    procedure GetATMExpiry()
    Var
        Banks: Record "Bank Account";
        Trans: Record "Teller Transaction";
        ATM: Record "ATM Linking Applications";
        Cheques: text;
        Msg: Text;
    begin
        BankingSetup.Get(UserId);

        ATM.Reset();
        ATM.SetRange(Status, ATM.Status::Approved);
        ATM.SetRange("Card Issued", true);
        ATM.SetFilter("Card Expiry Date", '%1..%2', CalcDate('-2M', Today), Today);
        if ATM.FindFirst() then begin
            repeat
                Cheques += ATM."No." + '' + ATM."Account Name";
            until ATM.Next() = 0;
            if (BankingSetup."Chief Accountant" = true) or (BankingSetup."Chief Cashier" = true) then begin

                Msg := 'ATM/s ' + Cheques + ' is due to expire.';

                if StrLen(Cheques) > 10 then begin

                    MyNotification.Scope := NotificationScope::LocalScope;
                    MyNotification.Message := Msg;

                    MyNotification.Send();
                    Message(Msg);
                end;

            end;
        end;
    end;

    procedure TreasuryNotifications()
    Var
        Banks: Record "Bank Account";
        Trans: Record "Teller Transaction";
        Cheques: text;
        Msg: Text;
    begin
        BankingSetup.Reset();
        BankingSetup.SetFilter("User Name", UserId);
        if BankingSetup.FindFirst() then begin

            if (BankingSetup.Type = BankingSetup.Type::Treasury) then begin
                Msg := '';
                Banks.Reset();
                Banks.SetRange("No.", BankingSetup."Default  Bank");
                if Banks.FindFirst() then begin

                    Banks.CalcFields("Balance (LCY)");
                    if (Banks."Balance (LCY)" * BankingSetup."Treasury Alert %" / 100) >= (BankingSetup."Max. Cashier Withholding" * BankingSetup."Treasury Alert %" / 100) then
                        Msg := StrSubstNo('Your treasury balance has exceeded 75% %1. Its time to plan a return trip to the bank.', BankingSetup."Max. Cashier Withholding");

                end;


                if StrLen(Msg) > 5 then begin

                    MyNotification.Scope := NotificationScope::LocalScope;
                    MyNotification.Message := Msg;

                    MyNotification.Send();
                    Message(Msg);
                end;

            end;
        end;
    end;

    /*  
    procedure CachierNotifications()
      Var
          Banks: Record "Bank Account";
          Trans: Record "Teller Transaction";
          Cheques: text;
          Msg: Text;
      begin
          BankingSetup.Reset();
          BankingSetup.SetFilter("User Name", UserId);
          if BankingSetup.FindFirst() then begin

              if (BankingSetup.Type = BankingSetup.Type::Cashier) then begin
                  Msg := '';
                  Banks.Reset();
                  Banks.SetRange("No.", BankingSetup."Default  Bank");
                  if Banks.FindFirst() then begin

                      Banks.CalcFields("Balance (LCY)");
                      if Banks."Balance (LCY)"  >= BankingSetup."Max. Cashier Withholding"  then
                          Msg := StrSubstNo('Your teller balance exceeds 90%. Initiate a transfer of funds back to the treasury', BankingSetup."Max. Cashier Withholding");

                  end;


                  if StrLen(Msg) > 5 then begin

                      MyNotification.Scope := NotificationScope::LocalScope;
                      MyNotification.Message := Msg;

                      MyNotification.Send();
                      Message(Msg);
                  end;

              end;
          end;
      end;

  */
    Procedure GetLeaveBalanceNotifications()
    var
        HREmp: Record Employee;
        Msg: Text;
        Bal: Decimal;
        LeaveBalance: Decimal;
    begin
        Bal := 15;
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", UserId);
        UserSetup.SetRange("Is HR", true);
        if UserSetup.FindFirst() then begin

            HREmp.Reset();
            HREmp.SetRange("User ID", UserId);
            if HREmp.FindFirst() then begin
                LeaveBalance := HREmp.GetLeaveBalance(HREmp."No.", 'Annual', Today);

                if LeaveBalance >= Bal then begin

                    Msg := 'Your Leave Balance is: ' + Format(LeaveBalance) + ' Please schedule your well-deserved leave in the next 30 days';

                    MyNotification.Scope := NotificationScope::LocalScope;
                    MyNotification.Message := Msg;

                    MyNotification.Send();
                    Message(Msg);
                end;
            end;

        end;
    end;

    Procedure GetJuniorAccountAgeNotifications()
    var
        JuniorAccount: Record "Member Accounts";
        Msg: Text;
        BirthDate: Date;
        DaysUntil18: Integer;
        TurnsEighteenDate: Date;
        UpcomingList: Text;
        MaturedList: Text;
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", UserId);
        if UserSetup.FindFirst() then begin

            JuniorAccount.Reset();
            JuniorAccount.SetFilter("Child Date Of Birth", '<>%1', 0D);
            if JuniorAccount.FindSet() then
                repeat
                    BirthDate := JuniorAccount."Child Date Of Birth";
                    TurnsEighteenDate := CalcDate('<18Y>', BirthDate);
                    DaysUntil18 := TurnsEighteenDate - Today;

                    if DaysUntil18 <= 0 then
                        MaturedList += StrSubstNo('\\- %1 (%2) turned 18 on %3. ', JuniorAccount."No.", JuniorAccount.Name, TurnsEighteenDate)
                    else
                        if DaysUntil18 <= 30 then
                            UpcomingList += StrSubstNo('\\- %1 (%2) turns 18 on %3 (%4 days). ', JuniorAccount."No.", JuniorAccount.Name, TurnsEighteenDate, DaysUntil18);
                until JuniorAccount.Next() = 0;

            if MaturedList <> '' then begin
                Msg := 'The following Junior Accounts have reached 18 years. Please convert them to normal member accounts/users: ' + MaturedList;
                MyNotification.Scope := NotificationScope::LocalScope;
                MyNotification.Message := Msg;
                MyNotification.Send();
                Message(Msg);
            end;

            if UpcomingList <> '' then begin
                Msg := 'The following Junior Accounts are approaching 18 years. Prepare account/user transition: ' + UpcomingList;
                MyNotification.Scope := NotificationScope::LocalScope;
                MyNotification.Message := Msg;
                MyNotification.Send();
                Message(Msg);
            end;
        end;
    end;

    Procedure GetApprovedStoreRequisitions()
    var
        HREmp: Record Employee;
        Msg: Text;
        Bal: Decimal;
        LeaveBalance: Decimal;
        Str: text[200];
        Str1: text[200];
        itemsMsg: Text;
        Store: Record "Store Requisition Header";
    begin

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", UserId);
        //UserSetup.SetRange(store, true);
        if UserSetup.FindFirst() then begin

            Store.Reset();
            Store.SetRange(Status, Store.Status::Released);
            Store.SetRange("User ID", UserId);
            if Store.FindFirst() then begin
                Str := 'Store requisition: ';
                Str1 := ' has been approved. Pending Posting';
                repeat
                    Msg += Format(Store."No.") + ' ' + Store."Item Description";
                until Store.Next() = 0;
                itemsMsg := Str + Msg + Str1;
                Message(itemsMsg);

                MyNotification.Scope := NotificationScope::LocalScope;
                MyNotification.Message := itemsMsg;

                MyNotification.Send();
            end;

        end;
    end;

    Procedure GetApprovedFixedDeposits()
    var
        FDMaturityNotification: Notification;
        Msg: Text;
        Fixed: Record "Fixed Deposit Accounts";
        ReminderEndDate: Date;
        FixedDepositCount: Integer;
        FirstFixedDepositNo: Code[20];
        FirstMaturityDate: Date;
        PowerEvents: Codeunit "UW Power Automate Bus. Events";
    begin


        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Fixed Deposit", true);
        if UserSetup.FindFirst() then begin

            ReminderEndDate := CalcDate('<1W>', Today);

            Fixed.Reset();
            Fixed.SetRange("FD Status", Fixed."FD Status"::Active);
            Fixed.SetFilter("FD Maturity Date", '..%1', ReminderEndDate);
            if Fixed.FindSet() then
                repeat
                    PowerEvents.RaiseFixedDepositMaturingSoon(
                        Fixed."No.",
                        Fixed."Member No.",
                        Fixed.Name,
                        Fixed."FD Amount",
                        Fixed."FD Maturity Date",
                        Fixed."Global Dimension 1 Code");
                    FixedDepositCount += 1;
                    if FirstFixedDepositNo = '' then begin
                        FirstFixedDepositNo := Fixed."No.";
                        FirstMaturityDate := Fixed."FD Maturity Date";
                    end;
                until Fixed.Next() = 0;

            if FixedDepositCount = 0 then
                exit;

            if FixedDepositCount = 1 then
                if FirstMaturityDate <= Today then
                    Msg := StrSubstNo('Fixed Deposit: %1 has matured.', FirstFixedDepositNo)
                else
                    Msg := StrSubstNo('Fixed Deposit: %1 will mature on %2.', FirstFixedDepositNo, FirstMaturityDate)
            else
                Msg := StrSubstNo('%1 active fixed deposits have matured or will mature by %2.', FixedDepositCount, ReminderEndDate);

            FDMaturityNotification.Scope := NotificationScope::LocalScope;
            FDMaturityNotification.Message := Msg;
            FDMaturityNotification.Send();

            Message(Msg);

        end;
    end;

    Procedure GetExpiringContract()
    var
        HREmp: Record Employee;
        Msg: Text;
        Bal: Decimal;
        Name: Text[200];
    begin

        //Check expiring notifications
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", UserId);
        UserSetup.SetRange("Is HR", true);
        if UserSetup.FindFirst() then begin
            HREmp.Reset();
            HREmp.SetFilter("End of Contract Date", '<>%1', 0D);
            if HREmp.FindFirst() then begin
                repeat
                    if CalcDate('-1M', HREmp."End of Contract Date") = Today then begin
                        Name += 'Emp ' + HREmp."No." + ' ' + HREmp.FullName() + '|'
                    end;
                until HREmp.next() = 0;

                if Name <> '' then begin
                    Msg := 'Contract for : ' + Format(Name) + ' is due to expire';

                    MyNotification.Scope := NotificationScope::LocalScope;
                    MyNotification.Message := Msg;

                    MyNotification.Send();
                    Message(Msg);
                end;
            end;
        end;
    end;

    Procedure GetExpiringProbation()
    var
        HREmp: Record Employee;
        Msg: Text;
        Bal: Decimal;
        Name: Text[200];
    begin

        //Check expiring notifications
        Msg := '';

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", UserId);
        UserSetup.SetRange("Is HR", true);
        if UserSetup.FindFirst() then begin
            HREmp.Reset();
            HREmp.SetFilter("Probation End Date", '<>%1', 0D);
            if HREmp.FindFirst() then begin

                repeat
                    if CalcDate('-1M', HREmp."Probation End Date") = Today then begin
                        Name += 'Employee ' + HREmp."No." + ' ' + HREmp.FullName() + '|'
                    end;
                until HREmp.next() = 0;

                if name <> '' then begin
                    Msg := 'Probation for : ' + Format(Name) + ' is due to expire';

                    MyNotification.Scope := NotificationScope::LocalScope;
                    MyNotification.Message := Msg;

                    MyNotification.Send();
                    Message(Msg);
                end;
            end
        end;
    end;

    procedure GetInsuranceExpiringCollateral()
    var
        Coll: Record "Loan Collateral Register";
        Collateral: Text[250];
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", UserId);
        UserSetup.SetRange(UserSetup."Is Credit Department", true);
        if UserSetup.FindFirst() then begin

            Coll.Reset();
            Coll.SetRange("Inward/Outward", Coll."Inward/Outward"::"In-Store");
            Coll.SetFilter("Insurance Expiry Date", '<>%1', 0D);
            if Coll.FindSet() then
                repeat
                    if CalcDate('-1M', Coll."Insurance Expiry Date") = Today then
                        Collateral += 'Collateral ' + Coll."No.";
                until Coll.Next() = 0;

            if Collateral <> '' then begin
                Msg := 'Insurance for : ' + Format(Collateral) + ' is due to expire';

                MyNotification.Scope := NotificationScope::LocalScope;
                MyNotification.Message := Msg;

                MyNotification.Send();
                Message(Msg);
            end;
        end;
    end;

    procedure GetNextValuationExpiringCollateral()
    var
        Coll: Record "Loan Collateral Register";
        Collateral: Text[250];
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", UserId);
        UserSetup.SetRange(UserSetup."Is Credit Department", true);
        if UserSetup.FindFirst() then begin

            Coll.Reset();
            Coll.SetRange("Inward/Outward", Coll."Inward/Outward"::"In-Store");
            Coll.SetFilter("Next Valuation Date", '<>%1', 0D);
            if Coll.FindSet() then
                repeat
                    if CalcDate('-1M', Coll."Next Valuation Date") = Today then
                        Collateral += 'Collateral ' + Coll."No.";
                until Coll.Next() = 0;

            if Collateral <> '' then begin
                Msg := 'Next valuation date for : ' + Format(Collateral) + ' is due in a months time';

                MyNotification.Scope := NotificationScope::LocalScope;
                MyNotification.Message := Msg;

                MyNotification.Send();
                Message(Msg);
            end;
        end;
    end;

    procedure GetApprovalsNotification()
    var
        ApprovalEntry: Record "Approval Entry";
        Msg: Text;
        CustomApprover: Code[200];
        WUserGroup: Record "Workflow User Group";
        WUserGroupMember: Record "Workflow User Group Member";
    begin

        CustomApprover := UserId;
        WUserGroupMember.Reset();
        WUserGroupMember.SetRange("User Name", UserId);
        if WUserGroupMember.FindSet() then
            repeat
                CustomApprover += '|' + WUserGroupMember."Workflow User Group Code";
            until WUserGroupMember.Next() = 0;


        ApprovalEntry.RESET;
        ApprovalEntry.SetFilter("Approver ID", CustomApprover);
        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
        IF ApprovalEntry.FIND('-') THEN BEGIN
            REPEAT

                Msg := 'Approval Requests FYA: ' + FORMAT(ApprovalEntry."Custom Document Type") + ': ' + ApprovalEntry."Document No." + ' From ' + ApprovalEntry."Sender ID";

                //Message(Msg);
                MyNotification.Scope := NotificationScope::LocalScope;
                MyNotification.Message := Msg;

                MyNotification.Send();

            UNTIL ApprovalEntry.NEXT = 0;
        END;
    end;

    procedure GetFileMovementNotifications()
    var
        ApprovalEntry: Record "Approval Entry";
        Msg: Text;
        FileMsg: Text;
        SupMsg: Text;
        SupFileMsg: Text;
        UserFileMsg: Text;
        /* #pragma warning disable AL0432
                WUserGroup: Record "User Group";
                WUserGroupMember: Record "User Group Member"; */
        Log: Record "File Movement Log";
        UName: Text;
        Pos: integer;
        UserSetup: Record "User Setup";
    begin

        FileMsg := '';
        UserFileMsg := '';
        SupFileMsg := '';
        UserSetup.Reset();
        UserSetup.SetRange("File Movement Admin", true);
        UserSetup.SetFilter("File Movement Group", '<>%1', '');
        if UserSetup.FindFirst() then begin
            Log.Reset();
            //Log.SetRange(Returned, false);

            Log.SetRange("Date Returned", 0D);
            Log.SetRange(Deceased, false);
            Log.SetFilter("Current Location", '<>%1', UserSetup."File Movement Group");
            Log.SetFilter("Expected Return Date", '<%1', Today);
            if Log.FindFirst() then begin
                repeat


                    UName := Log."Current User";
                    Pos := 0;
                    Pos := StrPos(Log."Current User", '\');
                    if Pos > 1 then begin
                        UName := CopyStr(Log."Current User", Pos + 1, StrLen(Log."Current User"));
                    end;

                    FileMsg += '\- ' + UName + ': File No.: ' + Log."Member No.";
                    /* if WUserGroup.Get(Log."Current Location") then begin
#pragma warning disable AL0432
                        if WUserGroup.Supervisor = UserId then begin
#pragma warning restore AL0432
                            SupFileMsg += '\- ' + UName + ': File No.: ' + Log."Member No.";
                        end; 
                    end;*/
                    if log."Current User" = UserId then begin
                        UserFileMsg += '\- File No.: ' + Log."Member No.";
                    end;

                until Log.Next() = 0;
            end;
        end;


        if FileMsg <> '' then begin
            UserSetup.Reset();
            UserSetup.SetRange("File Movement Admin", true);
            UserSetup.SetFilter("User ID", UserId);
            if UserSetup.FindFirst() then begin
                Msg := 'The following Users need to return the listed files back to Registry: ' + FileMsg;
                //Message(Msg);
                MyNotification.Scope := NotificationScope::LocalScope;
                MyNotification.Message := Msg;

                MyNotification.Send();
                Message(Msg);
            end;
        end;

        if SupFileMsg <> '' then begin
            Msg := 'The following Users need to return the listed files back to Registry: ' + SupFileMsg;
            //Message(Msg);
            MyNotification.Scope := NotificationScope::LocalScope;
            MyNotification.Message := Msg;

            MyNotification.Send();
            Message(Msg);
        end;


        if UserFileMsg <> '' then begin
            Msg := 'You need to return the listed files back to Registry: ' + UserFileMsg;
            //Message(Msg);
            MyNotification.Scope := NotificationScope::LocalScope;
            MyNotification.Message := Msg;

            MyNotification.Send();
            Message(Msg);
        end;
    end;

    procedure SendLoanAppraiserNotification()
    var
        UserSetup: record "User Setup";
        LoanAppraisal: Record "Member Salary Appraisal";
    begin
        if UserSetup.get(UserId) then begin
            LoanAppraisal.Reset();
            LoanAppraisal.SetRange(Status, LoanAppraisal.Status::Open);
            LoanAppraisal.SetRange("Loan Stage", LoanAppraisal."Loan Stage"::"Loan Appraisal");
            if LoanAppraisal.FindFirst() then begin
                repeat

                    Msg := 'Loan Appraisals awaiting your Action: ' + FORMAT(LoanAppraisal."Product Description") + ': ' + LoanAppraisal."Appraisal No." + ' From ' + Format(LoanAppraisal."Captured By");

                    //Message(Msg);
                    MyNotification.Scope := NotificationScope::LocalScope;
                    MyNotification.Message := Msg;

                    MyNotification.Send();
                until LoanAppraisal.Next() = 0;

            end;

        end;

    end;

    // Define the function that sends a notification to a user
    // The function takes a user ID and a message as input, and returns void

    [Scope('OnPrem')]
    procedure SendNotification(userId: Guid; message: Text)
    var
        notification: Notification;
    begin
        // Create a new Notification object and set its properties
        /*notification.Init;
        notification.Subject := 'New Notification';
        notification.Message := message;
        notification.ActionLink := '';
        notification.Sender := 'My App';*/

        // Add the user ID to the recipient list and send the notification
        /*notification.AddRecipient(userId);
        notification.Send;*/
    end;

    procedure GenerateDefaulterNotices(LoanNo: Code[20]; NoticeType: enum "Notice Type")
    var
        Loans: Record Loans;
        LedgerEntries: Record "Credit Ledger Entry";
        IssuedDate: Date;
        LastPayDate: Date;
        Member: Record Members;
        MemberActivities: Codeunit "Member Activities";
        LDefaulter: Record "Loans Defaulter Notices";
        Source: Enum "SMS Source Enum";
        FullString: Text[130];
        String: Text[50];
        DimID: Integer;
        SasraLoans: Record "Sasra Categorization";
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        MDef: Integer;
        AsAt: Date;
        GracePriod: DateFormula;
        ReceiverList: List of [text];
        SaccoActivities: Codeunit "Sacco Activities";
        SaccoSetup: Record "Sacco Setup";
    begin
        StatementNo := 0;
        SaccoSetup.Get();

        Loans.Reset();
        Loans.SetRange(Posted, true);
        //if MemberNo <> '' then
        Loans.SetFilter("Loan No.", LoanNo);
        Loans.SetFilter("Total Outstanding Balance", '>0');
        Loans.SetRange("Mobile Loan", false);
        Loans.SetFilter("Loans Category-SASRA", '<>%1', Loans."Loans Category-SASRA"::Performing);
        if Loans.FindFirst() then begin
            repeat

                /*LedgerEntries.Reset;
                LedgerEntries.SetRange("Member No.", Loans."Member No.");
                LedgerEntries.SetRange("Loan No.", Loans."Loan No.");
                LedgerEntries.SetFilter("Transaction Type", '%1|%2',
                                        LedgerEntries."transaction type"::"Loan Disbursement",
                                        LedgerEntries."transaction type"::"Principal Repayment"
                );
                if LedgerEntries.FindLast then begin*/
                ExpectedAmt := 0;
                AmtPaid := 0;
                DefAmount := 0;
                DaysInArrear := 0;
                ArrearsDate := 0D;
                MDef := 0;
                if AsAt = 0D then
                    AsAt := today;
                DDay := 0;

                SaccoActivities.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GracePriod);

                if DaysInArrear > 0 then begin
                    StatementNo := 0;
                    DMsg := '';
                    Heading := '';
                    Notice := 0;

                    DDay := DaysInArrear;
                    if (DaysInArrear > 0) and (DaysInArrear < 30) then
                        MDef := 1
                    else
                        if DefAmount > 0 then
                            MDef := ROUND(DaysInArrear / 30, 1, '=');


                    if NoticeType = NoticeType::" " then begin
                        case MDef of
                            1:
                                begin
                                    //send first defaulter notice
                                    DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is OVERDUE. Make IMMEDIATE PAYMENTS to avoid further accruals.';
                                    StatementNo := 50154;
                                    Heading := 'DEFAULTER NOTICE-1 ' + Loans."Loan No.";
                                    Notice := 1;
                                end;
                            2:
                                begin
                                    //send second defaulter notice
                                    DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is OVERDUE. Make IMMEDIATE PAYMENTS to avoid attaching to Guarantors.';
                                    StatementNo := 50155;
                                    Heading := 'DEFAULTER NOTICE-2 ' + Loans."Loan No.";
                                    Notice := 2;
                                end;
                            3:
                                begin
                                    //send 3rd defaulter notice
                                    DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is IN DEFAULT. WE ARE ATTACHING ACCRUALS TO YOUR GUARANTORS IMMEDIATLY WITHOUT FUTHER NOTICE.';
                                    StatementNo := 50156;
                                    Heading := 'DEFAULTER NOTICE-3 ' + Loans."Loan No.";
                                    Notice := 3;
                                end;
                        end;
                    end else begin
                        if NoticeType = NoticeType::"Notice 1" then begin
                            //send first defaulter notice
                            DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is OVERDUE. Make IMMEDIATE PAYMENTS to avoid further accruals.';
                            StatementNo := 50154;
                            Heading := 'DEFAULTER NOTICE-1 ' + Loans."Loan No.";
                            Notice := 1;
                        end;
                        if NoticeType = NoticeType::"Notice 2" then begin
                            //send second defaulter notice
                            DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is OVERDUE. Make IMMEDIATE PAYMENTS to avoid attaching to Guarantors.';
                            StatementNo := 50155;
                            Heading := 'DEFAULTER NOTICE-2 ' + Loans."Loan No.";
                            Notice := 2;
                        end;
                        if NoticeType = NoticeType::"Notice 3" then begin
                            //send 3rd defaulter notice
                            DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is IN DEFAULT. WE ARE ATTACHING ACCRUALS TO YOUR GUARANTORS IMMEDIATLY WITHOUT FUTHER NOTICE.';
                            StatementNo := 50156;
                            Heading := 'DEFAULTER NOTICE-3 ' + Loans."Loan No.";
                            Notice := 3;
                        end;
                    end;
                end;

                LDefaulter.Reset();
                LDefaulter.SetRange(LDefaulter."Loan No", Loans."Loan No.");
                LDefaulter.SetRange(LDefaulter.Notice, Notice);
                if (NOT LDefaulter.FindFirst()) and (Notice <> 0) and (StatementNo <> 0) then begin

                    Member.Reset;
                    Member.SetRange(Member."No.", Loans."Member No.");
                    if Member.Find('-') then begin
                        //if Member."Mobile Phone No." = '' then
                        //Member."Mobile Phone No." := '0725622461';
                        if (Member."E-Mail" <> '') and (SaccoActivities.ValidEmailAddress(Member."E-Mail")) then begin

                            String := '';
                            FullString := '';
                            SalutationTxt := '';
                            RegardsTxt := '';
                            Receiver := '';

                            FullString := ConvertStr(Member.Name, ' ', ',');

                            String := SelectStr(1, FullString);

                            //SalutationTxt := 'Dear' + ' ' + String + ',';
                            clear(Receiverlist);

                            RegardsTxt := 'Kind Regards';

                            if SaccoSetup."Is Defaulter Tetsing" then begin
                                Receiverlist.add(SaccoSetup."Credit 1 Email");
                                Receiverlist.add(SaccoSetup."Credit 2 Email");
                                Receiver := SaccoSetup."Credit 2 Email";
                            end else begin
                                ReceiverList.Add(Member."E-Mail");
                                Receiver := Member."E-Mail";
                                Receiverlist.add(SaccoSetup."Credit 1 Email");
                                Receiverlist.add(SaccoSetup."Credit 2 Email");
                            end;


                            Msg := STRSUBSTNO(DMsg, String, Loans."Loan Product Type Name", FORMAT(Loans.Repayment), Format(Today));

                            MemberActivities.SendSms(Source::"Loan Bill Due", Member."Mobile Phone No.", Msg, Member."No.", Loans."Loan No.", false, false);

                            DimID := Loans."Dimension Set ID";

                            AddSMSChargeFee(Member."No.", DimID);

                            //GenerateDefaulterNoticeNew(Loans.RecordId, 'DEFAULTER NOTICE', Loans."Member No.");

                            // DefInsert(Member."No.", Loans."Loan No.", Loans."Loan Product Type", Notice);

                            /* if Notice = 3 then //send guarantor notification
                                GenerateGuarantorDefaulterNotice(ReceiverList, Loans.RecordId, 'GUARANTORS DEFAULTER NOTICE', Loans); */
                        end;
                    end;
                end;
            until Loans.Next() = 0;
        end;

    end;

    procedure GenerateDefaulterNoticesNew(LoanNo: Code[20]; NoticeType: Enum "Notice Type")
    var
        Loans: Record Loans;
        Member: Record Members;
        MemberActivities: Codeunit "Member Activities";
        LDefaulter: Record "Loans Defaulter Notices";
        SaccoActivities: Codeunit "Sacco Activities";
        SaccoSetup: Record "Sacco Setup";
        Source: Enum "SMS Source Enum";
        ReceiverList: List of [Text];
        FullString: Text[130];
        String: Text[50];
        DimID: Integer;
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        AsAt: Date;
        MDef: Integer;
        GracePeriod: DateFormula;
        LastNotice: Integer;
        LastNoticeDate: Date;
        DaysSinceLastNotice: Integer;
        EscalationWindowDays: Integer;
        ShouldEscalate: Boolean;
        NoticeLabel: Text[100];
        ReportStatementNo: Integer;
        ListCRB: Boolean;
        SecurityType: Option " ","Guarantor","Motor Vehicle","Title Deed","NSE Shares","Money Market Fund","Insurance","Own Deposit";
    begin
        SaccoSetup.Get();

        Loans.Reset();
        Loans.SetRange(Posted, true);
        Loans.SetFilter("Loan No.", LoanNo);
        Loans.SetFilter("Total Outstanding Balance", '>0');
        Loans.SetRange("Mobile Loan", false);
        Loans.SetFilter("Loans Category-SASRA", '<>%1', Loans."Loans Category-SASRA"::Performing);

        if not Loans.FindFirst() then
            exit;

        repeat
            ExpectedAmt := 0;
            AmtPaid := 0;
            DefAmount := 0;
            DaysInArrear := 0;
            ArrearsDate := 0D;
            MDef := 0;
            AsAt := Today;
            DDay := 0;
            Notice := 0;
            DMsg := '';
            Heading := '';
            StatementNo := 0;
            ShouldEscalate := false;
            EscalationWindowDays := 30;
            NoticeLabel := '';
            ReportStatementNo := 0;
            LastNotice := 0;
            LastNoticeDate := 0D;
            DaysSinceLastNotice := 0;
            ListCRB := false;
            SecurityType := SecurityType::" ";

            SaccoActivities.GetDefaultedAmount(
                Loans."Loan No.", AsAt,
                ExpectedAmt, AmtPaid, DefAmount,
                DaysInArrear, ArrearsDate, false, GracePeriod);

            // If not in arrears, skip this loan entirely
            if DaysInArrear <= 0 then
                Continue;

            DDay := DaysInArrear;
            if (DaysInArrear > 0) and (DaysInArrear < 30) then
                MDef := 1
            else
                if DefAmount > 0 then
                    MDef := ROUND(DaysInArrear / 30, 1, '=');


            // Handle prolonged default (>3 months) - Board referral
            if MDef > 3 then begin
                HandleBoardReferral(Loans);
                Continue;
            end;

            // Get loan security type
            GetLoanSecurityType(Loans."Loan No.", SecurityType);

            // Get last notice sent
            LDefaulter.Reset();
            LDefaulter.SetRange("Loan No", Loans."Loan No.");
            LDefaulter.SetCurrentKey("Date Sent");
            if LDefaulter.FindLast() then begin
                LastNotice := LDefaulter.Notice;
                LastNoticeDate := LDefaulter."Date Sent";
                DaysSinceLastNotice := Today - LastNoticeDate;
            end;

            // ============================================================
            // NOTICE ESCALATION FLOW
            // ============================================================
            case LastNotice of

                // ------------------------------------------------------------
                // STAGE 0: No notice sent yet
                // ACTION: Send Initial Contact (Notice 1)
                // REQUIREMENT: "Immediately contact the borrower"
                // ------------------------------------------------------------
                0:
                    begin
                        if MDef >= 1 then begin
                            Notice := 1;
                            ShouldEscalate := true;
                            ListCRB := false;

                            DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is OVERDUE. ' +
                                    'Please contact us immediately to regularize your account ' +
                                    'and avoid further action.';
                            Heading := 'INITIAL DEFAULT CONTACT - ' + Loans."Loan No.";

                            // Notice 1 is just SMS/email, no formal letter
                            ReportStatementNo := 0;  // No report needed
                            NoticeLabel := 'INITIAL CONTACT';
                        end;
                    end;

                // ------------------------------------------------------------
                // STAGE 1: Initial Contact sent
                // ACTION: Send First Demand Letter (Notice 2) after 30 days
                // REQUIREMENT: "Issue First Demand Letter, giving 30 days notice"
                // CRB WARNING: Yes (except Own Deposit)
                // ------------------------------------------------------------
                1:
                    begin
                        if DaysSinceLastNotice >= 30 then begin

                            if SecurityType = SecurityType::"Own Deposit" then begin
                                // Own Deposit: Offset immediately, no First Demand Letter
                                // REQUIREMENT: "Offset the outstanding loan amount"
                                Notice := 2;
                                ShouldEscalate := true;
                                ListCRB := false;

                                DMsg := 'Dear %1, Your %2 loan of Ksh %3 has been offset ' +
                                        'against your deposits as per loan agreement.';
                                Heading := 'DEPOSIT OFFSET NOTICE - ' + Loans."Loan No.";
                                ReportStatementNo := 50183;  // Offset notice template
                                NoticeLabel := 'DEPOSIT OFFSET';

                                // Trigger actual offset process
                                // HandleOwnDepositOffset(Loans);

                            end else begin
                                // All other security types: Send First Demand Letter
                                Notice := 2;
                                ShouldEscalate := true;
                                ListCRB := false;  // CRB listing happens at Notice 3

                                case SecurityType of
                                    SecurityType::Guarantor:
                                        begin
                                            DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is OVERDUE. ' +
                                                    'This is your FIRST DEMAND LETTER. ' +
                                                    'You have 30 days to regularize your account ' +
                                                    'or be listed with Credit Reference Bureaus (CRBs).';
                                            Heading := 'FIRST DEMAND LETTER (GUARANTOR) - ' + Loans."Loan No.";
                                            ReportStatementNo := 50154;
                                            NoticeLabel := 'FIRST DEMAND LETTER - GUARANTOR';
                                        end;

                                    SecurityType::"Motor Vehicle":
                                        begin
                                            DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is OVERDUE. ' +
                                                    'This is your FIRST DEMAND LETTER. ' +
                                                    'You have 30 days to regularize or face ' +
                                                    'vehicle repossession and CRB listing.';
                                            Heading := 'FIRST DEMAND LETTER (MOTOR VEHICLE) - ' + Loans."Loan No.";
                                            ReportStatementNo := 50184;
                                            NoticeLabel := 'FIRST DEMAND LETTER - MOTOR VEHICLE';
                                        end;

                                    SecurityType::"Title Deed":
                                        begin
                                            DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is OVERDUE. ' +
                                                    'This is your FIRST DEMAND LETTER. ' +
                                                    'You have 30 days to regularize or face ' +
                                                    'statutory notices and CRB listing.';
                                            Heading := 'FIRST DEMAND LETTER (TITLE DEED) - ' + Loans."Loan No.";
                                            ReportStatementNo := 50185;
                                            NoticeLabel := 'FIRST DEMAND LETTER - TITLE DEED';
                                        end;

                                    SecurityType::"NSE Shares":
                                        begin
                                            DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is OVERDUE. ' +
                                                    'This is your FIRST DEMAND LETTER. ' +
                                                    'You have 30 days to regularize or face ' +
                                                    'share liquidation and CRB listing.';
                                            Heading := 'FIRST DEMAND LETTER (NSE SHARES) - ' + Loans."Loan No.";
                                            ReportStatementNo := 50186;
                                            NoticeLabel := 'FIRST DEMAND LETTER - NSE SHARES';
                                        end;

                                    SecurityType::"Money Market Fund":
                                        begin
                                            DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is OVERDUE. ' +
                                                    'This is your FIRST DEMAND LETTER. ' +
                                                    'You have 30 days to regularize or face ' +
                                                    'fund liquidation and CRB listing.';
                                            Heading := 'FIRST DEMAND LETTER (MONEY MARKET) - ' + Loans."Loan No.";
                                            ReportStatementNo := 50187;
                                            NoticeLabel := 'FIRST DEMAND LETTER - MONEY MARKET';
                                        end;

                                    SecurityType::Insurance:
                                        begin
                                            DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is OVERDUE. ' +
                                                    'This is your FIRST DEMAND LETTER. ' +
                                                    'You have 30 days to regularize or face ' +
                                                    'policy surrender and CRB listing.';
                                            Heading := 'FIRST DEMAND LETTER (INSURANCE) - ' + Loans."Loan No.";
                                            ReportStatementNo := 50188;
                                            NoticeLabel := 'FIRST DEMAND LETTER - INSURANCE';
                                        end;
                                end;
                            end;
                        end;
                    end;

                // ------------------------------------------------------------
                // STAGE 2: First Demand Letter sent
                // ACTION: Send Second Demand Letter (Notice 3) + List CRB
                // TIMELINE: Motor Vehicle = 14 days, Others = 30 days
                // REQUIREMENT: Different actions per security type
                // ------------------------------------------------------------
                2:
                    begin
                        // Determine escalation window based on security type
                        if SecurityType = SecurityType::"Motor Vehicle" then
                            EscalationWindowDays := 14
                        else
                            EscalationWindowDays := 30;

                        if DaysSinceLastNotice >= EscalationWindowDays then begin
                            Notice := 3;
                            ShouldEscalate := true;

                            case SecurityType of
                                SecurityType::Guarantor:
                                    begin
                                        // REQUIREMENT: "Issue Second Demand Letter copied to guarantors"
                                        // CRB listing happens NOW for guarantor loans
                                        ListCRB := true;

                                        DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is IN DEFAULT. ' +
                                                'This is your SECOND DEMAND LETTER. ' +
                                                'Your guarantors are being formally notified. ' +
                                                'You have 30 days to regularize before guarantor ' +
                                                'deposits are attached. You have been listed with CRBs.';
                                        Heading := 'SECOND DEMAND LETTER (GUARANTOR) - ' + Loans."Loan No.";
                                        ReportStatementNo := 50155;
                                        NoticeLabel := 'SECOND DEMAND LETTER - GUARANTOR';
                                    end;

                                SecurityType::"Motor Vehicle":
                                    begin
                                        // REQUIREMENT: "14 days notice of intention to sell vehicle"
                                        ListCRB := true;

                                        DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is IN DEFAULT. ' +
                                                'This is your SECOND DEMAND LETTER. ' +
                                                'You have 14 days to regularize your account. ' +
                                                'Failure to pay will result in repossession of ' +
                                                'your vehicle. You have been listed with CRBs.';
                                        Heading := 'SECOND DEMAND LETTER (MOTOR VEHICLE) - ' + Loans."Loan No.";
                                        ReportStatementNo := 50156;
                                        NoticeLabel := 'SECOND DEMAND LETTER - MOTOR VEHICLE';
                                    end;

                                SecurityType::"Title Deed":
                                    begin
                                        // REQUIREMENT: "Serve statutory notices to exercise power of sale"
                                        ListCRB := true;

                                        DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is IN DEFAULT. ' +
                                                'Statutory notices are being served against your property. ' +
                                                'Failure to regularize will result in public auction. ' +
                                                'You have been listed with CRBs.';
                                        Heading := 'STATUTORY NOTICE (TITLE DEED) - ' + Loans."Loan No.";
                                        ReportStatementNo := 50157;
                                        NoticeLabel := 'STATUTORY NOTICE - TITLE DEED';
                                    end;

                                SecurityType::"NSE Shares":
                                    begin
                                        // REQUIREMENT: "30 days notice of intention to liquidate shares"
                                        ListCRB := true;

                                        DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is IN DEFAULT. ' +
                                                'This is your SECOND DEMAND LETTER. ' +
                                                'You have 30 days before your NSE shares are liquidated. ' +
                                                'You have been listed with CRBs.';
                                        Heading := 'SECOND DEMAND LETTER (NSE SHARES) - ' + Loans."Loan No.";
                                        ReportStatementNo := 50158;
                                        NoticeLabel := 'SECOND DEMAND LETTER - NSE SHARES';
                                    end;

                                SecurityType::"Money Market Fund":
                                    begin
                                        // REQUIREMENT: "30 days notice to liquidate funds"
                                        ListCRB := true;

                                        DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is IN DEFAULT. ' +
                                                'This is your SECOND DEMAND LETTER. ' +
                                                'You have 30 days before your Money Market Funds ' +
                                                'are liquidated. You have been listed with CRBs.';
                                        Heading := 'SECOND DEMAND LETTER (MONEY MARKET) - ' + Loans."Loan No.";
                                        ReportStatementNo := 50159;
                                        NoticeLabel := 'SECOND DEMAND LETTER - MONEY MARKET';
                                    end;

                                SecurityType::Insurance:
                                    begin
                                        // REQUIREMENT: "30 days notice, copy to insurance company"
                                        ListCRB := true;

                                        DMsg := 'Dear %1, Your %2 repayment of Ksh %3 is IN DEFAULT. ' +
                                                'This is your SECOND DEMAND LETTER. ' +
                                                'You have 30 days before your insurance policy ' +
                                                'is surrendered. A copy has been sent to your insurer. ' +
                                                'You have been listed with CRBs.';
                                        Heading := 'SECOND DEMAND LETTER (INSURANCE) - ' + Loans."Loan No.";
                                        ReportStatementNo := 50160;
                                        NoticeLabel := 'SECOND DEMAND LETTER - INSURANCE';
                                    end;

                                SecurityType::"Own Deposit":
                                    begin
                                        // Own Deposit was already offset at Notice 2
                                        // Should not reach here, but handle gracefully
                                        ShouldEscalate := false;
                                    end;
                            end;
                        end;
                    end;

                // ------------------------------------------------------------
                // STAGE 3: Second Demand Letter sent
                // ACTION: Enforcement (Notice 4)
                // TIMELINE: Motor Vehicle = 14 days, Others = 30 days
                // REQUIREMENT: Execute recovery per security type
                // ------------------------------------------------------------
                3:
                    begin
                        // Determine enforcement window
                        if SecurityType = SecurityType::"Motor Vehicle" then
                            EscalationWindowDays := 14
                        else
                            EscalationWindowDays := 30;

                        if DaysSinceLastNotice >= EscalationWindowDays then begin
                            Notice := 4;
                            ShouldEscalate := true;
                            ListCRB := false;  // Already listed at Notice 3

                            case SecurityType of
                                SecurityType::Guarantor:
                                    begin
                                        // REQUIREMENT: "Recover from guarantor deposits"
                                        DMsg := 'Dear %1, Your %2 loan balance of Ksh %3 is being ' +
                                                'recovered from your guarantors deposits ' +
                                                'with immediate effect.';
                                        Heading := 'GUARANTOR RECOVERY - ' + Loans."Loan No.";
                                        ReportStatementNo := 50161;
                                        NoticeLabel := 'GUARANTOR ENFORCEMENT';

                                        // TODO: Trigger guarantor recovery process
                                    end;

                                SecurityType::"Motor Vehicle":
                                    begin
                                        // REQUIREMENT: "Instruct auctioneer to repossess vehicle"
                                        DMsg := 'Dear %1, Your %2 vehicle pledged against ' +
                                                'Ksh %3 is being repossessed by our ' +
                                                'appointed auctioneer with immediate effect.';
                                        Heading := 'VEHICLE REPOSSESSION - ' + Loans."Loan No.";
                                        ReportStatementNo := 50162;
                                        NoticeLabel := 'VEHICLE REPOSSESSION';
                                    end;

                                SecurityType::"Title Deed":
                                    begin
                                        // REQUIREMENT: "Liquidate property through public auction"
                                        DMsg := 'Dear %1, Your property pledged against your ' +
                                                '%2 loan of Ksh %3 is proceeding to public auction.';
                                        Heading := 'PUBLIC AUCTION NOTICE - ' + Loans."Loan No.";
                                        ReportStatementNo := 50163;
                                        NoticeLabel := 'PROPERTY AUCTION';
                                    end;

                                SecurityType::"NSE Shares":
                                    begin
                                        // REQUIREMENT: "Liquidate shares, notify borrower"
                                        DMsg := 'Dear %1, Your NSE shares pledged against your ' +
                                                '%2 loan of Ksh %3 are being liquidated ' +
                                                'with immediate effect.';
                                        Heading := 'SHARE LIQUIDATION - ' + Loans."Loan No.";
                                        ReportStatementNo := 50164;
                                        NoticeLabel := 'NSE SHARE LIQUIDATION';
                                    end;

                                SecurityType::"Money Market Fund":
                                    begin
                                        // REQUIREMENT: "Instruct fund manager to liquidate"
                                        DMsg := 'Dear %1, Your Money Market Fund pledged against ' +
                                                'your %2 loan of Ksh %3 is being liquidated. ' +
                                                'Your fund manager has been instructed accordingly.';
                                        Heading := 'FUND LIQUIDATION - ' + Loans."Loan No.";
                                        ReportStatementNo := 50165;
                                        NoticeLabel := 'MONEY MARKET LIQUIDATION';
                                    end;

                                SecurityType::Insurance:
                                    begin
                                        // REQUIREMENT: "Instruct insurance company to liquidate policy"
                                        DMsg := 'Dear %1, Your insurance policy pledged against ' +
                                                'your %2 loan of Ksh %3 is being surrendered. ' +
                                                'Your insurer has been formally notified.';
                                        Heading := 'POLICY SURRENDER - ' + Loans."Loan No.";
                                        ReportStatementNo := 50166;
                                        NoticeLabel := 'INSURANCE SURRENDER';
                                    end;

                                SecurityType::"Own Deposit":
                                    begin
                                        // Already offset, should not reach here
                                        ShouldEscalate := false;
                                    end;
                            end;
                        end;
                    end;

            end; // end case LastNotice

            // ============================================================
            // SEND THE NOTICE
            // ============================================================
            if ShouldEscalate then begin
                // Check if this exact notice was already sent
                LDefaulter.Reset();
                LDefaulter.SetRange("Loan No", Loans."Loan No.");
                LDefaulter.SetRange(Notice, Notice);

                if not LDefaulter.FindFirst() then begin
                    // Create new notice record
                    Member.Reset();
                    Member.SetRange("No.", Loans."Member No.");
                    if Member.Find('-') then begin
                        if (Member."E-Mail" <> '') and
                           (SaccoActivities.ValidEmailAddress(Member."E-Mail")) then begin

                            // Build first name
                            FullString := ConvertStr(Member.Name, ' ', ',');
                            String := SelectStr(1, FullString);

                            // Build receiver list
                            Clear(ReceiverList);
                            if SaccoSetup."Is Defaulter Tetsing" then begin
                                ReceiverList.Add(SaccoSetup."Credit 1 Email");
                                ReceiverList.Add(SaccoSetup."Credit 2 Email");
                                Receiver := SaccoSetup."Credit 2 Email";
                            end else begin
                                ReceiverList.Add(Member."E-Mail");
                                Receiver := Member."E-Mail";
                                ReceiverList.Add(SaccoSetup."Credit 1 Email");
                                ReceiverList.Add(SaccoSetup."Credit 2 Email");
                            end;

                            // Format SMS message
                            Msg := StrSubstNo(DMsg, String,
                                              Loans."Loan Product Type Name",
                                              Format(Loans.Repayment));

                            // Send SMS
                            MemberActivities.SendSms(Source::"Loan Bill Due",
                                Member."Mobile Phone No.", Msg,
                                Member."No.", Loans."Loan No.", false, false);

                            // Charge SMS fee
                            DimID := Loans."Dimension Set ID";
                            AddSMSChargeFee(Member."No.", DimID);

                            // Create the defaulter notice record
                            DefInsert(Member."No.", Loans."Loan No.",
                                      Loans."Loan Product Type", Notice,
                                      SecurityType, ListCRB);

                            // Generate the formal letter (if report number is specified)
                            if ReportStatementNo <> 0 then begin
                                LDefaulter.Reset();
                                LDefaulter.SetRange("Loan No", Loans."Loan No.");
                                LDefaulter.SetRange(Notice, Notice);

                                if LDefaulter.FindFirst() then begin
                                    if LDefaulter."Approved to Send" and not LDefaulter.Sent then begin
                                        StatementNo := ReportStatementNo;
                                        GenerateDefaulterNoticeBasedonNo(Loans.RecordId, NoticeLabel,
                                            Loans."Member No.", Loans."Loan No.", Notice);

                                        // If guarantor loan at Notice 3+, copy guarantors
                                        if (Notice >= 3) and (SecurityType = SecurityType::Guarantor) then
                                            GenerateGuarantorDefaulterNotice(ReceiverList,
                                                Loans.RecordId,
                                                'GUARANTORS DEFAULTER NOTICE', Loans);

                                        // Mark as sent
                                        LDefaulter.Sent := true;
                                        LDefaulter."Date Sent" := Today;
                                        LDefaulter.Modify();
                                    end;
                                end;
                            end;

                            // Trigger CRB listing if required
                            if ListCRB then begin
                                // TODO: Implement CRB listing
                                // ListWithCRB(Loans."Loan No.", Member."No.");
                            end;
                        end;
                    end;
                end;
            end;

        until Loans.Next() = 0;
    end;

    local procedure GetLoanSecurityType(LoanNo: Code[20]; var SecurityType: Option " ","Guarantor","Motor Vehicle","Title Deed","NSE Shares","Money Market Fund","Insurance","Own Deposit")
    var
        LoanSecurity: Record "Loan Security";
    begin
        SecurityType := SecurityType::" ";
        LoanSecurity.Reset();
        LoanSecurity.SetRange("Loan No.", LoanNo);
        if not LoanSecurity.FindFirst() then
            exit;

        case LoanSecurity."Guarantor Type" of
            LoanSecurity."Guarantor Type"::Guarantor:
                SecurityType := SecurityType::Guarantor;
            LoanSecurity."Guarantor Type"::Lien:
                SecurityType := SecurityType::"Own Deposit";
            LoanSecurity."Guarantor Type"::Collateral:
                case LoanSecurity."Collateral Type" of
                    LoanSecurity."Collateral Type"::"Motor Vehicle":
                        SecurityType := SecurityType::"Motor Vehicle";
                    LoanSecurity."Collateral Type"::"Title Deed":
                        SecurityType := SecurityType::"Title Deed";
                    LoanSecurity."Collateral Type"::"NSE Shares":
                        SecurityType := SecurityType::"NSE Shares";
                    LoanSecurity."Collateral Type"::"Money Market Fund":
                        SecurityType := SecurityType::"Money Market Fund";
                    LoanSecurity."Collateral Type"::Insurance:
                        SecurityType := SecurityType::Insurance;
                end;
        end;
    end;

    local procedure DefInsert(MemberNo: Code[20]; LoanNo: Code[20]; LNType: Code[10]; Notice: Integer; SecurityType: Option; CRBListed: Boolean)
    var
        LDefaulter: Record "Loans Defaulter Notices";
    begin
        LDefaulter.Init();
        LDefaulter."Member No" := MemberNo;
        LDefaulter."Loan No" := LoanNo;
        LDefaulter."Loan Product" := LNType;
        LDefaulter.Notice := Notice;
        LDefaulter.Days := DDay;
        LDefaulter.Sent := false;
        LDefaulter."Approved to Send" := false;
        LDefaulter."Date Sent" := 0D;
        LDefaulter."Security Type" := SecurityType;
        LDefaulter."CRB Listed" := CRBListed;
        LDefaulter.Insert(true);
    end;

    local procedure HandleBoardReferral(var Loans: Record Loans)
    var
        LDefaulter: Record "Loans Defaulter Notices";
    begin
        LDefaulter.Reset();
        LDefaulter.SetRange("Loan No", Loans."Loan No.");
        LDefaulter.SetRange("Board Referral", true);
        if LDefaulter.FindFirst() then
            exit; // already referred, do not duplicate

        LDefaulter.Init();
        LDefaulter."Loan No" := Loans."Loan No.";
        LDefaulter."Member No" := Loans."Member No.";
        LDefaulter."Board Referral" := true;
        LDefaulter."Date Sent" := Today;
        LDefaulter.Notice := 99;
        LDefaulter.Sent := true;
        LDefaulter.Insert(true);
    end;

    local procedure FlagCRBListing(LoanNo: Code[20]; MemberNo: Code[20])
    var
        LDefaulter: Record "Loans Defaulter Notices";
    begin
        LDefaulter.Reset();
        LDefaulter.SetRange("Loan No", LoanNo);
        if LDefaulter.FindLast() then begin
            LDefaulter."CRB Listed" := true;
            LDefaulter.Modify(true);
        end;
        // TODO: trigger your CRB listing integration here
    end;

    PROCEDURE GenerateGuarantorDefaulterNotice(Receiver: List of [Text]; TheRecordID: RecordID; AttachmentName: Text; LRec: record Loans)
    VAR
        RecRef: RecordRef;
        EXTENSION: label 'ENU=pdf';
        VarVariant: Variant;
        FileName: Text;
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
        DocumentAtt: Record "Document Attachment";
        CCRecepients: List of [Text];
        BccRecepients: List of [Text];
        LSecurity: Record "Loan Security";
        LSecurity2: Record "Loan Security";
        Member: Record Members;
        Loanee: Record Members;
        SaccoSetup: Record "Sacco Setup";
        SaccoActivities: Codeunit "Sacco Activities";
        MemberActivities: Codeunit "Member Activities";
        ReportInStream: InStream;
        ReportOutStream: OutStream;
        TempFile: File;
        Heading: Text;
        SalutationTxt: Text;
        Msg: Text;
        RegardsTxt: Text;
        ReportRef: RecordRef;
    BEGIN
        RecRef.OPEN(TheRecordID.TABLENO);
        RecRef.GET(TheRecordID);
        RecRef.SETRECFILTER;
        VarVariant := RecRef;

        SaccoSetup.Get();

        LSecurity.Reset();
        LSecurity.SetRange("Loan No.", LRec."Loan No.");
        LSecurity.SetRange("Guarantor Type", LSecurity."Guarantor Type"::Guarantor);
        LSecurity.SetRange(Substituted, false);
        if LSecurity.FindFirst() then begin
            repeat
                Clear(Receiver);
                Msg := 'You guaranteed ' + LRec."Member Name" + ' ' + LRec."Loan Product Type Name" + '.';
                SalutationTxt := 'Dear, ' + LSecurity.Name;
                RegardsTxt := 'Regards,';

                Member.Reset();
                Member.SetRange("No.", LSecurity."Member No");
                Member.SetFilter("Member Status", '%1|%2|%3',
                        Member."Member Status"::Active,
                        Member."Member Status"::New,
                        Member."Member Status"::Dormant
                );
                if Member.FindFirst() then begin
                    Loanee.Get(LRec."Member No.");

                    if (Member."E-Mail" <> '') and (SaccoActivities.ValidEmailAddress(Member."E-Mail")) then begin

                        Receiver.Add(Member."E-Mail");
                        // CCRecepients.add(Member."E-Mail");
                        CCRecepients.add(SaccoSetup."Credit 1 Email");
                        CCRecepients.add(Loanee."E-Mail");

                        // Generate unique filename for cloud environment
                        FileName := LSecurity."Account No." + '-' + 'Guarantor-Defaulter-Notice.pdf';

                        LSecurity2.Reset();
                        LSecurity2.SetRange("Loan No.", LSecurity."Loan No.");
                        LSecurity2.SetRange("Account No.", LSecurity."Account No.");
                        LSecurity2.SetRange(Substituted, false);
                        LSecurity2.SetRange("Guarantor Type", LSecurity2."Guarantor Type"::Guarantor);
                        if LSecurity2.FindFirst() then begin
                            // Cloud-ready approach: Use TempBlob for in-memory operations
                            Clear(TempBlob);
                            TempBlob.CreateOutStream(ReportOutStream);

                            ReportRef.GetTable(LSecurity2);

                            Report.SaveAs(report::"Defaulter Notice - Guarantor", '', ReportFormat::Pdf, ReportOutStream, ReportRef);

                            TempBlob.CreateInStream(ReportInStream);

                            // Send email with attachment using standard AL Email methods
                            MemberActivities.SendEmailWithAttachment(
                                Heading,
                                SalutationTxt,
                                Msg,
                                RegardsTxt,
                                Receiver,
                                FileName,
                                ReportInStream,
                                CCRecepients,
                                BCCRecepients
                            );
                        end;

                        clear(CCRecepients);
                        clear(BCCRecepients);
                    end;
                end;
            until LSecurity.Next() = 0;
        end;
    END;

    procedure AddSMSChargeFee(MembrNo: Code[50]; DimID: Integer)
    var
        DefaulterSMSCharge: Decimal;
        ChargeAcc: Code[50];
        SMSCharges: Record "Sms Charges";
        SAcc: Record "Savings Accounts";
        DebitAcc: code[60];
        SActv: Codeunit "Sacco Activities";
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        SMSSource: Enum "SMS Source Enum";
        JTemplate: Code[10];
        JBatch: Code[10];
        UserSetup: record "User Setup";
        DActivity2: Code[20];
        DBranch2: Code[20];
        DocNo: Text;
        MA: Codeunit "Member Activities";
        RunBal: Decimal;
        TChannel: Enum "Transaction Channel";

    begin
        DefaulterSMSCharge := 0;
        SMSCharges.Reset;
        SMSCharges.SetRange(Source, SMSCharges.Source::"Loan defaulted");
        if SMSCharges.FindFirst then begin
            DefaulterSMSCharge := SMSCharges."Charge Amount";


            //Get Member Fosa Acc to Debit SMS amount
            SAcc.Reset();
            SAcc.SetRange("Member No.", MembrNo);
            SAcc.SetRange("Product Category", SAcc."Product Category"::"Ordinary Savings");
            if SAcc.FindFirst() then DebitAcc := SAcc."No.";
            RunBal := MA.GetAccountBalance(DebitAcc);
            if RunBal < DefaulterSMSCharge then exit;


            UserSetup.Get(UserId);
            UserSetup.TestField("CashRec Journal Template");
            UserSetup.TestField("CashRec Journal Batch");

            DActivity2 := UserSetup."Global Dimension 1 Code";
            DBranch2 := UserSetup."Global Dimension 2 Code";
            Jtemplate := UserSetup."CashRec Journal Template";
            JBatch := UserSetup."CashRec Journal Batch";
            DocNo := StrSubstNo(MembrNo + '-' + Format(Today));

            SActv.JournalInit(JTemplate, JBatch);
            SActv.JournalInsert(
                JTemplate,
                JBatch,
                DocNo,
                Today,
                AcctType::Savings,
                DebitAcc,
                'Defaulter SMS Charge',
                Balaccttype::"G/L Account",
                SMScharges."Charge G/L Account",
                SMScharges."Charge Amount",
                '',
                '',
                TransType::" ",
                DActivity2,
                DBranch2,
                true,
                TChannel::Defaulter,
                DimID
            );
            SActv.JournalPost(JTemplate, JBatch);


        end;




    end;

    procedure GenerateDefaulterNoticeBasedonNo(TheRecordID: RecordID; AttachmentName: Text; MNo: code[50]; LoanNo: Code[20]; NoticeStage: Integer)
    VAR
        RecRef: RecordRef;
        EXTENSION: label 'ENU=pdf';
        VarVariant: Variant;
        FileName: Text;
        DocumentAtt: Record "Document Attachment";
        SaccoSetup: Record "Sacco Setup";
        Member: Record Members;
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        MgsEcryt: Label 'To open this report use your valid ID No.';
        EmailMsg: Codeunit "Email Message";
        BCCRecipients: List of [Text];
        CCRecipients: List of [Text];
        ToRecipients: List of [Text];
        Email: Codeunit Email;
        Base64Convert: Codeunit "Base64 Convert";
        LDefaulter: Record "Loans Defaulter Notices";

    BEGIN
        // Initialize record reference
        RecRef.OPEN(TheRecordID.TABLENO);
        RecRef.GET(TheRecordID);
        RecRef.SETRECFILTER;
        VarVariant := RecRef;

        // Get setup and member data
        SaccoSetup.Get();
        Member.Get(MNo);

        // Clear recipient lists
        Clear(CCRecipients);
        Clear(BCCRecipients);
        Clear(ToRecipients);

        // Set up BCC recipients
        if SaccoSetup."Credit 1 Email" <> '' then
            BCCRecipients.Add(SaccoSetup."Credit 1 Email");
        if SaccoSetup."Credit 2 Email" <> '' then
            BCCRecipients.Add(SaccoSetup."Credit 2 Email");

        // Generate filename for attachment
        FileName := MNo + '-' + 'Defaulter Notice.pdf';

        // Create temporary blob to store PDF
        TempBlob.CreateOutStream(OutStr);

        // Generate PDF report directly to blob stream
        REPORT.SAVEAS(StatementNo, '', REPORTFORMAT::Pdf, OutStr, VarVariant);

        // Get input stream from blob for email attachment
        TempBlob.CreateInStream(InStr);

        // Prepare email recipients
        if Receiver <> '' then
            ToRecipients.Add(Receiver);

        // Create and send email with PDF attachment
        EmailMsg.Create(ToRecipients, AccountStatementTxt, Msg, true, CCRecipients, BCCRecipients);
        EmailMsg.AddAttachment(FileName, 'application/pdf', InStr);

        // Send email

        if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then begin
            LDefaulter.Reset();
            LDefaulter.SetRange("Loan No", LoanNo);
            LDefaulter.SetRange(Notice, NoticeStage);
            if LDefaulter.FindFirst() then begin
                LDefaulter.Sent := true;
                LDefaulter."Date Sent" := Today;
                LDefaulter.Modify(true);
            end;
        end;



    END;

    procedure GenerateLoanGuarantorGuaranteed(MNo: code[50])
    VAR
        RecRef: RecordRef;
        //FILEFOLDER: Text 'C:\QNAVREPORTS\';
        EXTENSION: label 'ENU=pdf';
        VarVariant: Variant;
        FileName: Text;
        FilePath: Text;
        FileManagement: Codeunit "File Management";
        DocumentAtt: Record "Document Attachment";
        SaccoSetup: Record "Sacco Setup";
        Members: Record "Members";
        FullString: Text[130];
        String: Text[50];
        TheRecordID: RecordId;
        SMTPMail: Codeunit "Email Message";
        Base64: Text;
        OusStr: OutStream;
        InStr: InStream;
        TempBlob: Codeunit "Temp Blob";
        LoanRec: RecordRef;
        CCRecipients: List of [Text];
        Email: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        EmailMessage: Codeunit "Email Message";
        SaccoActivities: Codeunit "Sacco Activities";
        Mem: RecordRef;
    begin

        Members.Reset();
        if MNo <> '' then
            Members.SetRange("No.", MNo);
        Members.SetFilter("Member Status", '%1|%2', Members."Member Status"::Active, Members."Member Status"::Dormant);
        if Members.FindSet() then begin
            repeat


                TheRecordID := Members.RecordId;

                SaccoSetup.Get();

                RecRef.OPEN(TheRecordID.TABLENO);
                RecRef.GET(TheRecordID);
                RecRef.SETRECFILTER;
                VarVariant := RecRef;

                String := '';
                FullString := '';
                SalutationTxt := '';
                RegardsTxt := '';
                Receiver := '';
                clear(ToRecipients);
                clear(BCCRecipients);
                clear(CCRecipients);

                MNo := Members."No.";
                Receiver := Members."E-Mail"; //'kelvin.mwangi@maishaborasacco.com';

                if SaccoActivities.ValidEmailAddress(Receiver) then begin


                    FullString := ConvertStr(Members.Name, ' ', ',');

                    String := SelectStr(1, FullString);

                    SalutationTxt := 'Dear' + ' ' + String + ',';

                    RegardsTxt := 'Kind Regards';

                    Msg := STRSUBSTNO('Find attached Loans guaranteed report. %1', Format(Today));

                    CCRecipients.Add((SaccoSetup."Credit 1 Email"));
                    CCRecipients.Add((SaccoSetup."Credit 2 Email"));
                    FilePath := SaccoSetup."Email File Path";
                    if FilePath = '' then
                        Error('File path must not be empty');

                    //'C:\QNAVREPORTS\';
                    //FilePath := FileManagement.ServerTempFileName(EXTENSION);


                    FileName := FilePath + 'Loans Guaranteed.pdf';//LOWERCASE(STRSUBSTNO('%1.%2', AttachmentName, EXTENSION));

                    ////Report.SaveAsPdf(Report::"Loan Guaranteed", FileName, VarVariant);

                    Mem.GetTable(Members);

                    ToRecipients.Add(Receiver);
                    //MemberActivities.SendEmailNotification(Heading, SalutationTxt, Msg, RegardsTxt, Receiver, FileName);
                    //EmailMessage.Create(Receiver, SalutationTxt, Msg, true);
                    EmailMsg.Create(ToRecipients, AccountStatementTxt, Msg, true, CCRecipients, BCCRecipients);

                    TempBlob.CreateOutStream(OusStr);
                    Report.SaveAs(Report::"Loan Guaranteed", '', ReportFormat::Pdf, OusStr, Mem);
                    TempBlob.CreateInStream(InStr);
                    EmailMsg.AddAttachment('Loans Guaranteed' + '.pdf', '', InStr);
                    Email.Send(EmailMsg);

                end;

            until Members.Next() = 0;
        end;

    end;

    local procedure InIt(MemberNo: Code[20]; LoanNo: Code[20]; LNType: code[10]; Notice: Integer; SecurityType: Option; CRBListed: Boolean)
    LDefaulter: Record "Loans Defaulter Notices";
    begin
        LDefaulter.Init();
        LDefaulter."Member No" := MemberNo;
        LDefaulter."Loan No" := LoanNo;
        LDefaulter."Loan Product" := LNType;
        LDefaulter.Notice := Notice;
        LDefaulter.Days := DDay;
        LDefaulter.Sent := true;
        LDefaulter."Date Sent" := Today;
        LDefaulter."Security Type" := SecurityType;
        LDefaulter."CRB Listed" := CRBListed;
        LDefaulter.Insert(true);
    end;

    procedure UpdateLoansArrears()
    var
        Loans: Record Loans;
    begin
        Loans.Reset();
        Loans.SetRange(Loans."Last Pay Date", Today);
        /*if Loans.FindSet() then
            repeat
                Report.Run(Report::"Loan Category Per Last Pay Day", false, false, Loans);
                sleep(300);
            until Loans.Next() = 0;
            */

    end;

    procedure SendLoanRepaymentReminders(ReminderDate: Date)
    var
        Loans: Record Loans;
        RepaymentSchedule: Record "Loan Repayment Schedule";
        Members: Record Members;
        LoanType: Record "Product Setup";
        NextRepayment: Record "Loan Repayment Schedule";
        MessageText: Text;
        MemberName: Text[100];
        LoanProductName: Text[100];
        InstallmentAmount: Decimal;
        RepaymentDate: Date;
        OverdueAmount: Decimal;
        PenaltyPercentage: Decimal;
        PenaltyGraceDays: Integer;
        PenaltyDueDate: Date;
        SaccoSetup: Record "Sacco Setup";
        Source: Enum "SMS Source Enum";
    begin
        SaccoSetup.Get();

        Loans.Reset();
        Loans.SetFilter("Outstanding Principal", '>0');
        Loans.SetRange(Posted, true);

        if Loans.FindSet() then
            repeat
                if Members.Get(Loans."Member No.") then begin
                    if Members."Phone No." <> '' then begin
                        LoanType.Get(Loans."Loan Product Type");
                        MemberName := Members.Name;
                        LoanProductName := LoanType.Description;

                        // Check if loan is overdue
                        if IsLoanOverdue(Loans, ReminderDate, OverdueAmount, RepaymentDate) then begin
                            // Send overdue message
                            MessageText := BuildOverdueMessage(
                                MemberName,
                                LoanProductName,
                                OverdueAmount,
                                RepaymentDate,
                                Loans,
                                LoanType,
                                ReminderDate
                            );
                        end else begin
                            // Send upcoming payment reminder
                            if GetNextRepayment(Loans."Loan No.", ReminderDate, NextRepayment) then begin
                                InstallmentAmount := NextRepayment."Monthly Repayment";
                                RepaymentDate := NextRepayment."Repayment Date";

                                MessageText := BuildReminderMessage(
                                    MemberName,
                                    LoanProductName,
                                    InstallmentAmount,
                                    RepaymentDate
                                );
                            end;
                        end;

                        // Send SMS
                        if MessageText <> '' then
                            MemberActivities.SendSms(Source::"Loan Bill Due", Members."Mobile Phone No.", MessageText, Members."No.", Loans."Loan No.", false, false);

                    end;
                end;
            until Loans.Next() = 0;
    end;

    local procedure IsLoanOverdue(Loans: Record Loans; CheckDate: Date; var OverdueAmount: Decimal; var OverdueDate: Date): Boolean
    var
        RepaymentSchedule: Record "Loan Repayment Schedule";
        TotalExpected: Decimal;
        TotalPaid: Decimal;
    begin
        OverdueAmount := 0;
        OverdueDate := 0D;

        // Get all repayments due before check date
        RepaymentSchedule.Reset();
        RepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
        RepaymentSchedule.SetFilter("Repayment Date", '<%1', CheckDate);

        if RepaymentSchedule.FindSet() then begin
            repeat
                TotalExpected += RepaymentSchedule."Monthly Repayment";
                if OverdueDate = 0D then
                    OverdueDate := RepaymentSchedule."Repayment Date";
            until RepaymentSchedule.Next() = 0;
        end;

        // Get total amount paid
        Loans.CalcFields("Principal paid", "Interest paid");
        TotalPaid := Loans."Principal paid" + Loans."Interest paid";

        OverdueAmount := TotalExpected - TotalPaid;

        exit(OverdueAmount > 0);
    end;

    local procedure GetNextRepayment(LoanNo: Code[20]; CheckDate: Date; var NextRepayment: Record "Loan Repayment Schedule"): Boolean
    begin
        NextRepayment.Reset();
        NextRepayment.SetRange("Loan No.", LoanNo);
        NextRepayment.SetFilter("Repayment Date", '>=%1', CheckDate);
        NextRepayment.SetCurrentKey("Repayment Date");
        NextRepayment.Ascending(true);

        exit(NextRepayment.FindFirst());
    end;

    local procedure BuildReminderMessage(MemberName: Text[100]; LoanProduct: Text[100]; Amount: Decimal; DueDate: Date): Text
    var
        MessageText: Text;
    begin
        MessageText := StrSubstNo(
            'Dear %1, this is a reminder that your %2 loan installment of Kshs %3 is due on %4 as indicated in your repayment schedule. Please arrange to make payment by the due date.',
            MemberName,
            LoanProduct,
            Format(Amount, 0, '<Precision,2:2><Standard Format,0>'),
            Format(DueDate, 0, '<Day,2>-<Month,2>-<Year4>')
        );

        exit(MessageText);
    end;

    local procedure BuildOverdueMessage(
        MemberName: Text[100];
        LoanProduct: Text[100];
        OverdueAmount: Decimal;
        OverdueDate: Date;
        Loans: Record Loans;
        LoanType: Record "Product Setup";
        CurrentDate: Date
    ): Text
    var
        MessageText: Text;
        PenaltyPercentage: Decimal;
        PenaltyDueDate: Date;
        NextInstallment: Decimal;
        NextDueDate: Date;
        NextRepayment: Record "Loan Repayment Schedule";
        SaccoSetup: Record "Sacco Setup";
        GraceDays: Integer;
    begin
        SaccoSetup.Get();
        PenaltyPercentage := LoanType."Penalty Percentage";
        GraceDays := SaccoSetup."Penalty Grace Days";

        if GraceDays = 0 then
            GraceDays := 15; // Default 15 days

        PenaltyDueDate := CalcDate(StrSubstNo('<%1D>', GraceDays), CurrentDate);

        // Get next upcoming installment
        MessageText := StrSubstNo(
           'Dear %1,Your %2 loan is overdue by Ksh.%3 as of %4. If payment is not received by %5, a penalty of %6%% will be incurred. Please clear this overdue amount immediately.',
           MemberName,
           UpperCase(LoanProduct),
           Format(OverdueAmount, 0, '<Precision,2:2><Standard Format,0>'),
           Format(OverdueDate, 0, '<Day,2> <Month Text> <Year4>'),
           Format(PenaltyDueDate, 0, '<Day,2>-<Month,2>-<Year,2>'),
           Format(PenaltyPercentage, 0, '<Precision,2:2><Standard Format,0>')
       );
        exit(MessageText);
    end;


    var
        UserSetup: Record "User Setup";
        BankingSetup: Record "Banking User Setup";
        AccountStatementTxt: label 'DEFAULTER NOTICE';
        BCCRecipients: List of [Text];
        CCRecipients: List of [Text];
        ToRecipients: List of [Text];

}
