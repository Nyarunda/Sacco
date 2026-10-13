report 51019 "Collection Report"
{
    DefaultLayout = RDLC;
    Caption = 'Collection Report';
    RDLCLayout = './src/Layouts/Collection_Report_.rdlc';

    dataset
    {
        dataitem(Buffer; "Daily Trans-Buffer")
        {
            DataItemTableView = sorting("Product ID", "User ID");

            column(ReportForNavId_4645; 4645)
            {
            }
            column(LoanBalance_Buffer; Buffer."Loan Balance")
            {
            }
            column(NonPerforming_Buffer; Buffer."Non-Performing")
            {
            }
            column(DefaultedAmount_Buffer; Buffer."Defaulted Amount")
            {
            }
            column(PAR_Buffer; Buffer.PAR)
            {
            }
            column(CompPicture; CompanyInformation.Picture)
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(ProductID_Buffer; Buffer."Product ID")
            {
            }
            column(Issued_Buffer; Buffer.Issued)
            {
            }
            column(Paid_Buffer; Buffer.Paid)
            {
            }
            column(IssuedCount_Buffer; Buffer."Issued Count")
            {
            }
            column(PaidCount_Buffer; Buffer."Paid Count")
            {
            }
            column(LedgerFees_Buffer; Buffer."Ledger Fees")
            {
            }
            column(Insurance_Buffer; Buffer.Insurance)
            {
            }
            column(ProductGroup_Buffer; Buffer."Product Group")
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            column(Branch; Branch)
            {
            }
            column(LoanOfficer; LoanOfficer)
            {
            }

            // New report columns mapped from Daily Trans-Buffer
            column(ExpectedCollectionTarget_Buffer; Buffer.Issued)
            {
            }
            column(ActualAmountCollected_Buffer; Buffer.Paid)
            {
            }
            column(PercentAchieved_Buffer; Buffer."Issued Count")
            {
            }
            column(AccountConverted_Buffer; Buffer."Paid Count")
            {
            }
            column(ConversionPercent_Buffer; Buffer."Ledger Fees")
            {
            }

            trigger OnPreDataItem()
            begin
                BuildCollectionBuffer();
                Buffer.SetRange("User ID", UserId);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field("As At"; AsAtDate)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("From Date"; FromDate)
                {
                    ApplicationArea = Basic;
                }
                field("To Date"; ToDate)
                {
                    ApplicationArea = Basic;
                }
                field(Branch; Branch)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
                }
                field("Loan Officer"; LoanOfficer)
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Manager';
                    TableRelation = "User Setup";
                }
            }
        }
    }

    var
        DailyBuffer: Record "Daily Trans-Buffer";
        Loans: Record Loans;
        LoansProcess: Codeunit "Sacco Activities";
        CompanyInformation: Record "Company Information";
        DateFilter: Text;
        Branch: Code[20];
        LoanOfficer: Code[50];
        AsAtDate: Date;
        FromDate: Date;
        ToDate: Date;

    local procedure BuildCollectionBuffer()
    var
        GracePeriod: DateFormula;
        Expected: Decimal;
        Paid: Decimal;
        AmtDefaulted: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        BucketLabel: array[6] of Text[200];
        LoanBalanceByBucket: array[6] of Decimal;
        AccountsByBucket: array[6] of Decimal;
        ArrearsByBucket: array[6] of Decimal;
        ExpectedByBucket: array[6] of Decimal;
        ActualByBucket: array[6] of Decimal;
        AchievedPctByBucket: array[6] of Decimal;
        AccountsConvertedByBucket: array[6] of Decimal;
        ConversionPctByBucket: array[6] of Decimal;
        PARByBucket: array[6] of Decimal;
        TotalLoanBalance: Decimal;
        TotalExpectedAll: Decimal;
        TotalActualAll: Decimal;
        TotalAccountsAll: Decimal;
        TotalConvertedAccounts: Decimal;
        ActualCollected: Decimal;
        PrepaymentAmount: Decimal;
        ActualArrearsCollected: Decimal;
        ExpectedTarget: Decimal;
        TargetPct: Decimal;
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        i: Integer;
        BucketNo: Integer;
    begin
        if ToDate = 0D then
            ToDate := AsAtDate;

        if FromDate = 0D then
            FromDate := CalcDate('<-CM>', ToDate) + 1;

        AsAtDate := ToDate;

        if AsAtDate = 0D then
            AsAtDate := Today;

        if FromDate = 0D then
            Error('From Date must not be blank.');

        if ToDate = 0D then
            Error('To Date must not be blank.');

        if FromDate > ToDate then
            Error('From Date cannot be greater than To Date.');

        DateFilter := StrSubstNo('%1..%2', FromDate, ToDate);

        BucketLabel[1] := 'Performing';
        BucketLabel[2] := '1 MONTH';
        BucketLabel[3] := '2-6 MONTHS';
        BucketLabel[4] := '7-12 MONTHS';
        BucketLabel[5] := 'Above 12 Months';
        BucketLabel[6] := 'Total';

        DailyBuffer.Reset();
        DailyBuffer.SetRange("User ID", UserId);
        DailyBuffer.DeleteAll();

        Loans.Reset();
        Loans.SetRange(Posted, true);
        Loans.SetFilter("Outstanding Principal", '<>0');
        Loans.SetRange("Date Filter", 0D, AsAtDate);

        if Branch <> '' then
            Loans.SetRange("Booking Branch", Branch);

        if LoanOfficer <> '' then
            Loans.SetRange("Loan Officer", LoanOfficer);

        NoOfRecords := Loans.Count();

        if NoOfRecords > 0 then
            ProgressInit(dWindow, CurrentRecordNo, NoOfRecords);

        if Loans.FindSet() then
            repeat
                CurrentRecordNo += 1;

                if NoOfRecords > 0 then
                    ProgressBarProcessing(dWindow, CurrentRecordNo, NoOfRecords, Loans."Loan No.");

                Clear(Expected);
                Clear(Paid);
                Clear(AmtDefaulted);
                Clear(DaysInArrear);
                Clear(ArrearsDate);
                Clear(ActualCollected);
                Clear(PrepaymentAmount);
                Clear(ActualArrearsCollected);
                Clear(ExpectedTarget);
                Clear(TargetPct);

                Loans.CalcFields("Outstanding Principal");

                LoansProcess.GetDefaultedAmount(
                    Loans."Loan No.",
                    AsAtDate,
                    Expected,
                    Paid,
                    AmtDefaulted,
                    DaysInArrear,
                    ArrearsDate,
                    false,
                    GracePeriod);

                BucketNo := GetBucketNo(DaysInArrear);
                TargetPct := GetTargetPercentage(BucketNo);

                ActualCollected := GetActualCollected(Loans."Loan No.", FromDate, ToDate);

                // Prepayment = amount paid above the arrears amount.
                // This prevents advance payments from inflating arrears collection achievement.
                if ActualCollected > AmtDefaulted then
                    PrepaymentAmount := ActualCollected - AmtDefaulted
                else
                    PrepaymentAmount := 0;

                ActualArrearsCollected := ActualCollected - PrepaymentAmount;

                if ActualArrearsCollected < 0 then
                    ActualArrearsCollected := 0;

                ExpectedTarget := Round(AmtDefaulted * TargetPct / 100, 0.01, '=');

                LoanBalanceByBucket[BucketNo] += Loans."Outstanding Principal" + Loans."Outstanding Interest";
                AccountsByBucket[BucketNo] += 1;
                ArrearsByBucket[BucketNo] += AmtDefaulted;
                ExpectedByBucket[BucketNo] += ExpectedTarget;
                ActualByBucket[BucketNo] += ActualArrearsCollected;

                // A/c converted = account achieved its expected target.
                if (ExpectedTarget > 0) and (ActualArrearsCollected >= ExpectedTarget) then
                    AccountsConvertedByBucket[BucketNo] += 1;

                TotalLoanBalance += (Loans."Outstanding Principal" + Loans."Outstanding Interest");
            until Loans.Next() = 0;

        if NoOfRecords > 0 then
            dWindow.Close();

        for i := 1 to 5 do begin
            if TotalLoanBalance <> 0 then
                PARByBucket[i] := Round((LoanBalanceByBucket[i] / TotalLoanBalance) * 100, 1, '=')
            else
                PARByBucket[i] := 0;

            if ExpectedByBucket[i] <> 0 then
                AchievedPctByBucket[i] := Round((ActualByBucket[i] / ExpectedByBucket[i]) * 100, 1, '=')
            else
                AchievedPctByBucket[i] := 0;

            if AccountsByBucket[i] <> 0 then
                ConversionPctByBucket[i] := Round((AccountsConvertedByBucket[i] / AccountsByBucket[i]) * 100, 1, '=')
            else
                ConversionPctByBucket[i] := 0;
        end;

        for i := 1 to 5 do
            InsertBufferLine(
                BucketLabel[i],
                LoanBalanceByBucket[i],
                AccountsByBucket[i],
                ArrearsByBucket[i],
                PARByBucket[i],
                ExpectedByBucket[i],
                ActualByBucket[i],
                AchievedPctByBucket[i],
                AccountsConvertedByBucket[i],
                ConversionPctByBucket[i]);

        TotalExpectedAll :=
            ExpectedByBucket[1] +
            ExpectedByBucket[2] +
            ExpectedByBucket[3] +
            ExpectedByBucket[4] +
            ExpectedByBucket[5];

        TotalActualAll :=
            ActualByBucket[1] +
            ActualByBucket[2] +
            ActualByBucket[3] +
            ActualByBucket[4] +
            ActualByBucket[5];

        TotalAccountsAll :=
            AccountsByBucket[1] +
            AccountsByBucket[2] +
            AccountsByBucket[3] +
            AccountsByBucket[4] +
            AccountsByBucket[5];

        TotalConvertedAccounts :=
            AccountsConvertedByBucket[1] +
            AccountsConvertedByBucket[2] +
            AccountsConvertedByBucket[3] +
            AccountsConvertedByBucket[4] +
            AccountsConvertedByBucket[5];

        if TotalExpectedAll <> 0 then
            AchievedPctByBucket[6] := Round((TotalActualAll / TotalExpectedAll) * 100, 1, '=')
        else
            AchievedPctByBucket[6] := 0;

        if TotalAccountsAll <> 0 then
            ConversionPctByBucket[6] := Round((TotalConvertedAccounts / TotalAccountsAll) * 100, 1, '=')
        else
            ConversionPctByBucket[6] := 0;

        InsertBufferLine(
            BucketLabel[6],
            LoanBalanceByBucket[1] +
            LoanBalanceByBucket[2] +
            LoanBalanceByBucket[3] +
            LoanBalanceByBucket[4] +
            LoanBalanceByBucket[5],
            TotalAccountsAll,
            ArrearsByBucket[1] +
            ArrearsByBucket[2] +
            ArrearsByBucket[3] +
            ArrearsByBucket[4] +
            ArrearsByBucket[5],
            100,
            TotalExpectedAll,
            TotalActualAll,
            AchievedPctByBucket[6],
            TotalConvertedAccounts,
            ConversionPctByBucket[6]);

        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    local procedure GetBucketNo(DaysInArrear: Integer): Integer
    begin
        // 1 = Performing
        // 2 = 1 Month
        // 3 = 2-6 Months
        // 4 = 7-12 Months
        // 5 = Above 12 Months

        if DaysInArrear <= 0 then
            exit(1);

        if DaysInArrear <= 30 then
            exit(2);

        if DaysInArrear <= 180 then
            exit(3);

        if DaysInArrear <= 360 then
            exit(4);

        exit(5);
    end;

    local procedure GetTargetPercentage(BucketNo: Integer): Decimal
    begin
        case BucketNo of
            1:
                exit(80); // Performing
            2:
                exit(70); // 1 Month
            3:
                exit(40); // 2-6 Months
            4:
                exit(30); // 7-12 Months
            5:
                exit(10); // Above 12 Months
        end;

        exit(0);
    end;

    local procedure GetActualCollected(LoanNo: Code[20]; CollectionFromDate: Date; CollectionToDate: Date): Decimal
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
        TotalCollected: Decimal;
    begin
        CreditLedgerEntry.Reset();
        CreditLedgerEntry.SetRange("Loan No.", LoanNo);
        CreditLedgerEntry.SetRange(Reversed, false);
        CreditLedgerEntry.SetRange("Posting Date", CollectionFromDate, CollectionToDate);
        CreditLedgerEntry.SetFilter("Transaction Type", '%1|%2|%3|%4',
            CreditLedgerEntry."Transaction Type"::"Principal Repayment",
            CreditLedgerEntry."Transaction Type"::"Interest Paid",
            CreditLedgerEntry."Transaction Type"::"Penalty Paid",
            CreditLedgerEntry."Transaction Type"::"Insurance Paid"
        );
        if CreditLedgerEntry.FindSet() then
            repeat
                TotalCollected += Abs(CreditLedgerEntry.Amount);
            until CreditLedgerEntry.Next() = 0;

        exit(TotalCollected);
    end;

    local procedure InsertBufferLine(
        Classification: Text[200];
        LoanBalance: Decimal;
        NoOfAccounts: Decimal;
        ArrearsAmount: Decimal;
        PARPct: Decimal;
        ExpectedCollection: Decimal;
        ActualCollected: Decimal;
        AchievedPct: Decimal;
        AccountsConverted: Decimal;
        ConversionPct: Decimal)
    begin
        DailyBuffer.Init();
        DailyBuffer."User ID" := UserId;
        DailyBuffer."Product ID" := Classification;
        DailyBuffer."Loan Balance" := LoanBalance;
        DailyBuffer."Non-Performing" := NoOfAccounts;
        DailyBuffer."Defaulted Amount" := ArrearsAmount;
        DailyBuffer.PAR := PARPct;

        // New collection report columns using existing buffer fields.
        DailyBuffer.Issued := ExpectedCollection;                // Expected Collection / Target
        DailyBuffer.Paid := ActualCollected;                     // Actual Amount Collected
        DailyBuffer."Issued Count" := Round(AchievedPct, 1, '='); // % Achieved
        DailyBuffer."Paid Count" := AccountsConverted;           // A/c converted
        DailyBuffer."Ledger Fees" := Round(ConversionPct, 1, '='); // Conversion %

        DailyBuffer.Insurance := 0;
        DailyBuffer."Product Group" := DailyBuffer."Product Group"::MICRO;
        DailyBuffer.Insert();
    end;

    procedure ProgressInit(var dWindow: Dialog; var CurrentRecordNo: Integer; var NoOfRecords: Integer)
    begin
        dWindow.Open(
            'Generating Entries:     #1#########\\' +
            'Total:                #2#########\\' +
            'Counter:              #3#########\\' +
            'Progress:             @4@@@@@@@@@\\' +
            'Press Esc to abort');

        CurrentRecordNo := 0;
        dWindow.Update(2, NoOfRecords);
    end;

    procedure ProgressBarProcessing(var dWindow: Dialog; var CurrentRecordNo: Integer; var NoOfRecords: Integer; Name: Text)
    begin
        dWindow.Update(1, Name);
        dWindow.Update(3, CurrentRecordNo);

        if NoOfRecords > 0 then
            dWindow.Update(4, Round(CurrentRecordNo / NoOfRecords * 10000, 1))
        else
            dWindow.Update(4, 0);
    end;
}