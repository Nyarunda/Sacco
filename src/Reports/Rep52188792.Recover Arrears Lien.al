
report 50474 "Recover Arrears Lien"
{
    ApplicationArea = All;
    Caption = 'Recover Arrears Lien ';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            DataItemTableView = where("Product Category" = filter("Ordinary Savings"), Balance = filter(> 0), "Total Loan Arrears" = filter(> 0));
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(ProductName; "Product Name")
            {
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
                confirmMsg: Text;
            begin
                JTemplate := '';
                JBatch := '';
                SaccoActivities.GetGeneralJournalTemplate(JTemplate, JBatch);
                SaccoActivities.JournalInit(JTemplate, JBatch);

                confirmMsg := StrSubstNo('Kindly note the entries will be inserted into the General Journal Table[%1 & %2] from which you will post them.', JTemplate, JBatch);
                if not Confirm(confirmMsg, false) then
                    error('Aborting');
            end;

            trigger OnAfterGetRecord()
            var
                LoanSecurity: Record "Loan Security";
                DepAmt: Decimal;
                GuaranteedInApplication: Decimal;
                Committed: Decimal;
                Available: Decimal;
                FreeShares: Decimal;
                RunBal: Decimal;
                DedAmt: Decimal;
                Loans: Record Loans;
                j: integer;
                AcctType: Enum "Gen. Journal Account Type";
                BalAcctType: Enum "Gen. Journal Account Type";
                TransType: Enum "Transaction Type Enum";
                InterestArrears: Decimal;
                PrincipalArrears: Decimal;
                MonthlyBalance: Decimal;
                Desc: Text[50];
                PDate: Date;
                DocNo: Code[20];
                ExtDocNo: Code[20];
                ExpectedBal: Decimal;
                CurrentBal: Decimal;
                DaysInArrear: integer;
                ArrearsDate: Date;
                DimSetID: Integer;
                TChannel: Enum "Transaction Channel";
                Memb: Record Members;
                GracePeriod: DateFormula;
            begin
                IF Memb.Get(SavingsAccounts."Member No.") THEN
                    IF (Memb."Member Status" <> Memb."Member Status"::Deceased) THEN
                        CurrReport.Skip();

                FreeShares := 0;
                Committed := 0;
                Available := 0;
                DepAmt := 0;
                RunBal := 0;
                DedAmt := 0;
                ExpectedBal := 0;
                CurrentBal := 0;
                DaysInArrear := 0;
                ArrearsDate := 0D;

                PDate := Today;


                LoanSecurity.CalculateAvailableShares(SavingsAccounts, DepAmt, GuaranteedInApplication, Committed, Available, false);
                RunBal := Available;

                if RunBal > 0 then begin
                    for j := 1 to 2 do begin


                        Loans.Reset();
                        Loans.setcurrentkey("Recovery Priority");
                        Loans.SetRange("Member No.", SavingsAccounts."Member No.");
                        //Loans.setRange("Mobile Loan", false);
                        Loans.SetFilter("Total Outstanding Balance", '>0');
                        if j = 1 then
                            Loans.SetFilter("Outstanding Interest", '>0')
                        else if j = 2 then
                            Loans.SetFilter("Outstanding Principal", '>0')
                        else
                            Error('Programming Error');

                        if Loans.FindFirst() then begin
                            repeat
                                DedAmt := 0;
                                ExpectedBal := 0;
                                CurrentBal := 0;
                                DaysInArrear := 0;
                                ArrearsDate := 0D;
                                DocNo := '';

                                DimSetID := SavingsAccounts."Dimension Set ID";
                                if DimSetID = 0 then
                                    DimSetID := Loans."Dimension Set ID";

                                DocNo := Loans."Loan No." + ' REV';


                                RunBal -= SaccoActivities.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Principal Repayment")
                                        - SaccoActivities.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Interest Paid");


                                if j = 1 then begin
                                    Loans.CalcFields("Outstanding Interest");

                                    if Loans."Outstanding Interest" < 0 then
                                        Loans."Outstanding Interest" := 0;

                                    InterestArrears := SaccoActivities.GetInterestArrears(Loans."Loan No.", CalcDate('-1M+CM', PDate));
                                    if InterestArrears > 0 then
                                        InterestArrears -= SaccoActivities.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Interest Paid");

                                    if InterestArrears < 0 then
                                        InterestArrears := 0;
                                    DedAmt := InterestArrears;

                                    if DedAmt > Loans."Outstanding Interest" then
                                        DedAmt := Loans."Outstanding Interest";


                                    Desc := 'Interest Arrears: Recovery';
                                    TransType := TransType::"Interest Paid";
                                end;

                                if j = 2 then begin

                                    Loans.CalcFields("Outstanding Principal");

                                    if Loans."Outstanding Principal" < 0 then
                                        Loans."Outstanding Principal" := 0;

                                    PrincipalArrears := 0;
                                    SaccoActivities.GetDefaultedAmount(Loans."Loan No.", CalcDate('-1M+CM', PDate), ExpectedBal, CurrentBal, PrincipalArrears, DaysInArrear, ArrearsDate, true, GracePeriod);

                                    if PrincipalArrears > 0 then
                                        PrincipalArrears -= SaccoActivities.GetJournalLoanCredits(Jtemplate, Jbatch, Accttype::Credit, Loans."Loan Account", Loans."Loan No.", Transtype::"Principal Repayment");

                                    if PrincipalArrears < 0 then
                                        PrincipalArrears := 0;
                                    DedAmt := PrincipalArrears;

                                    if DedAmt > Loans."Outstanding Principal" then
                                        DedAmt := Loans."Outstanding Principal";


                                    Desc := 'Principal Arrears: Recovery';
                                    TransType := TransType::"Principal Repayment";

                                end;

                                if DedAmt > 0 then begin

                                    if DedAmt > RunBal then
                                        DedAmt := RunBal;

                                    SaccoActivities.JournalInsert(Jtemplate, Jbatch, DocNo, PDate, AcctType::Credit, Loans."Loan Account", CopyStr(Desc, 1, 50),
                                    AcctType::"G/l Account", '', -DedAmt, ExtDocNo, Loans."Loan No.", TransType, '', '', true, TChannel, DimSetID);
                                    RunBal -= DedAmt;


                                    if SavingsAccounts."No." <> '' then begin
                                        SaccoActivities.JournalInsert(Jtemplate, Jbatch, DocNo, PDate, BalAcctType::Savings, SavingsAccounts."No.", copystr(Loans."Loan No." + ': ' + Desc, 1, 50),
                                        AcctType::"G/l Account", '', DedAmt, ExtDocNo, Loans."Loan No.", TransType, '', '', true, TChannel, DimSetID);
                                    end;
                                end;

                            until Loans.Next = 0;
                        end;
                    end;
                end;


            end;

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    var
        JTemplate: code[20];
        JBatch: Code[20];
        SaccoActivities: Codeunit "Sacco Activities";
}
