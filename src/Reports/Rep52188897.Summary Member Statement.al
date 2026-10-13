report 50599 "Summary Member Statement"
{
    ApplicationArea = All;
    Caption = 'Detailed Member Statement';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Summary Member Statement.rdlc';
    PreviewMode = Normal;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(ReportForNavId_1; 1)
            {
            }
            column(UserId; UserId)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(MobilePhoneNo_Members; Members."Mobile Phone No.")
            {
            }
            column(PayrollStaffNo_Members; Members."Payroll/Staff No.")
            {
            }
            column(IDNo_Members; Members."ID No.")
            {
            }
            column(E_Mail; "E-Mail")
            {
            }
            column(No_Members; Members."No.")
            {
            }
            column(Old_Member_No_; Members."Old Member No.")
            {
            }
            column(MSection; MSection)
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            dataitem("Product Setup"; "Product Setup")
            {
                DataItemTableView = where("Product Class" = const(Savings), "Dont Show on Statement" = const(false));
                column(ReportForNavId_4; 4)
                {
                }
                column(ProductID_ProductFactory; "Product ID")
                {
                }
                column(ProductDescription_ProductFactory; Description)
                {
                }
                dataitem(Vendor; "Savings Accounts")
                {
                    DataItemLink = "Product Type" = field("Product ID");
                    column(ReportForNavId_7; 7)
                    {
                    }
                    column(No_SavingsAccounts; "No.")
                    {
                    }
                    column(ChildName_SavingsAccounts; "Child Name")
                    {
                    }
                    dataitem("Savings Ledger Entry"; "Savings Ledger Entry")
                    {
                        DataItemLink = "Account No." = field("No.");
                        DataItemTableView = sorting("Posting Date") where(Reversed = const(false));
                        column(ReportForNavId_9; 9)
                        {
                        }
                        column(ProductID; "Product Setup"."Product ID")
                        {
                        }
                        column(CustomerNo_SavingsLedgerEntry; "Savings Ledger Entry"."Account No.")
                        {
                        }
                        column(ProductDescription; "Product Setup".Description)
                        {
                        }
                        column(PostingDate_SavingsLedgerEntry; "Savings Ledger Entry"."Posting Date")
                        {
                        }
                        column(DocumentNo_SavingsLedgerEntry; "Savings Ledger Entry"."Document No.")
                        {
                        }
                        column(External_DocumentNo_SavingsLedgerEntry; "Savings Ledger Entry"."External Document No.")
                        {
                        }
                        column(Description_SavingsLedgerEntry; "Savings Ledger Entry".Description)
                        {
                        }
                        column(BankCode_SavingsLedgerEntry; GetBankAccountNo("Savings Ledger Entry"."Document No.", "Savings Ledger Entry"."Posting Date"))
                        {
                        }
                        column(AmountLCY_SavingsLedgerEntry; "Savings Ledger Entry"."Amount (LCY)")
                        {
                        }
                        column(DebitAmountLCY_SavingsLedgerEntry; "Savings Ledger Entry"."Debit Amount (LCY)")
                        {
                        }
                        column(CreditAmountLCY_SavingsLedgerEntry; "Savings Ledger Entry"."Credit Amount (LCY)")
                        {
                        }
                        column(RunBal; RunBal)
                        {
                        }
                        column(BalanceBF; BalanceBF)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin

                            RunBal += ("Savings Ledger Entry"."Amount (LCY)" * -1);
                        end;

                        trigger OnPreDataItem()
                        begin
                            RunBal := BalanceBF;

                            if DateFilter <> '' then
                                "Savings Ledger Entry".SetFilter("Posting Date", DateFilter);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        BalanceBF := 0;
                        if DateFilterBF <> '' then begin
                            SavAcc.Reset;
                            SavAcc.SetRange("No.", "No.");
                            SavAcc.SetFilter("Date Filter", DateFilterBF);
                            if SavAcc.FindFirst then begin
                                SavAcc.CalcFields("Balance (LCY)");
                                BalanceBF := SavAcc."Balance (LCY)";
                            end;
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if SavingsAccount <> '' then
                            SetRange("No.", SavingsAccount);


                        if CreditAccount <> '' then
                            SetRange("No.", CreditAccount);

                        SetRange("Member No.", Members."No.");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if LoansStatement then
                        CurrReport.Skip;

                    if ShowClearedLoans then
                        CurrReport.Skip;

                    if ShowAllLoans then
                        CurrReport.skip;

                    if ProductSpecific <> '' then
                        if "Product Setup"."Product ID" <> ProductSpecific then
                            CurrReport.Skip;
                end;
            }
            dataitem(LoanProduct; "Product Setup")
            {
                DataItemTableView = where("Product Class" = const(Credit));
                column(ReportForNavId_41; 41)
                {
                }
                column(ProductID_LoanProduct; LoanProduct."Product ID")
                {
                }
                column(ProductDescription_LoanProduct; LoanProduct.Description)
                {
                }
                dataitem(Loans; Loans)
                {
                    DataItemLink = "Loan Product Type" = field("Product ID");
                    column(Total_Arrears; "Total Arrears")
                    {
                    }
                    column(Repayment; Repayment)
                    {
                    }
                    column(ReportForNavId_38; 38)
                    {
                    }
                    column(LoanProductType_Loans; Loans."Loan Product Type")
                    {
                    }
                    column(ApprovedAmount_Loans; Loans."Approved Amount")
                    {
                    }
                    column(DisbursementDate_Loans; Loans."Disbursement Date")
                    {
                    }
                    column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
                    {
                    }
                    column(LoanNo_Loans; Loans."Loan No.")
                    {
                    }
                    dataitem("Credit Ledger Entry"; "Credit Ledger Entry")
                    {
                        DataItemLink = "Loan No." = field("Loan No.");
                        DataItemTableView = sorting("Posting Date") where(Reversed = const(false), "Transaction Type" = filter("Loan Disbursement" | "Principal Repayment" | "Interest Due" | "Interest Paid" | "Insurance Due" | "Insurance Paid" | "Penalty Due" | "Penalty Paid"), "User ID" = filter(<> ''));
                        column(ReportForNavId_36; 36)
                        {
                        }
                        column(CustomerNo_CreditLedgerEntry; "Credit Ledger Entry"."Account No.")
                        {
                        }
                        column(PostingDate_CreditLedgerEntry; "Credit Ledger Entry"."Posting Date")
                        {
                        }
                        column(DocumentNo_CreditLedgerEntry; "Credit Ledger Entry"."Document No.")
                        {
                        }
                        column(External_DocumentNo_CreditLedgerEntry; "Credit Ledger Entry"."External Document No.")
                        {
                        }
                        column(Description_CreditLedgerEntry; "Credit Ledger Entry".Description)
                        {
                        }
                        column(DebitAmountLCY_CreditLedgerEntry; "Credit Ledger Entry"."Debit Amount (LCY)")
                        {
                        }
                        column(CreditAmountLCY_CreditLedgerEntry; "Credit Ledger Entry"."Credit Amount (LCY)")
                        {
                        }
                        column(AmountLCY_CreditLedgerEntry; "Credit Ledger Entry"."Amount (LCY)")
                        {
                        }
                        column(LoanNo_CreditLedgerEntry; "Credit Ledger Entry"."Loan No.")
                        {
                        }
                        column(TransactionType_CreditLedgerEntry; "Credit Ledger Entry"."Transaction Type")
                        {
                        }
                        column(EntryNo_CreditLedgerEntry; "Credit Ledger Entry"."Entry No.")
                        {
                        }
                        column(BankCode_CreditLedgerEntry; GetBankAccountNo("Credit Ledger Entry"."Document No.", "Credit Ledger Entry"."Posting Date"))
                        {
                        }
                        column(PrincipalRunBal; PrincipalRunBal) { }
                        column(InterestRunBal; InterestRunBal) { }
                        column(InsuranceRunBal; InsuranceRunBal) { }
                        column(PenaltyRunBal; PenaltyRunBal) { }
                        column(PrincipalBalanceBF; PrincipalBalanceBF) { }
                        column(InterestBalanceBF; InterestBalanceBF) { }
                        column(InsuranceBalanceBF; InsuranceBalanceBF) { }
                        column(PenaltyBalanceBF; PenaltyBalanceBF) { }
                        column(IsPrincipalTransaction; IsPrincipalTransaction) { }
                        column(IsInterestTransaction; IsInterestTransaction) { }
                        column(IsInsuranceTransaction; IsInsuranceTransaction) { }
                        column(IsPenaltyTransaction; IsPenaltyTransaction) { }
                        column(LoansRunBal; RunBal)
                        {
                        }
                        column(LoansBalanceBF; BalanceBF)
                        {
                        }
                        column(PrPaid; PrPaid)
                        {
                        }
                        column(IntPaid; IntPaid)
                        {
                        }
                        column(PrDue; PrDue)
                        {
                        }
                        column(IntDue; IntDue)
                        {
                        }
                        column(InsDue; InsDue)
                        { }
                        column(InsPaid; InsPaid)
                        {
                        }
                        column(PenDue; PenDue)
                        { }

                        trigger OnAfterGetRecord()
                        begin
                            RunBal += ("Credit Ledger Entry"."Amount (LCY)");
                            IntPaid := 0;
                            PrPaid := 0;
                            IntDue := 0;
                            Prdue := 0;
                            InsDue := 0;
                            InsPaid := 0;
                            PenDue := 0;
                            IsPrincipalTransaction := false;
                            IsInterestTransaction := false;
                            IsInsuranceTransaction := false;
                            IsPenaltyTransaction := false;

                            if ("Credit Ledger Entry"."Transaction Type" = "Credit Ledger Entry"."Transaction Type"::"Interest Due") or ("Credit Ledger Entry"."Transaction Type" = "Credit Ledger Entry"."Transaction Type"::"Interest Paid") then begin
                                IsInterestTransaction := true;
                                IntDue := ("Credit Ledger Entry"."Amount (LCY)");
                                InterestRunBal += GetLoanLedgerMovement("Credit Ledger Entry");
                            end;
                            if ("Credit Ledger Entry"."Transaction Type" = "Credit Ledger Entry"."Transaction Type"::"Loan Disbursement") or ("Credit Ledger Entry"."Transaction Type" = "Credit Ledger Entry"."Transaction Type"::"Principal Repayment") then begin
                                IsPrincipalTransaction := true;
                                Prdue := ("Credit Ledger Entry"."Amount (LCY)");
                                PrincipalRunBal += GetLoanLedgerMovement("Credit Ledger Entry");
                            end;
                            if ("Credit Ledger Entry"."Transaction Type" = "Credit Ledger Entry"."Transaction Type"::"Insurance Due") or ("Credit Ledger Entry"."Transaction Type" = "Credit Ledger Entry"."Transaction Type"::"Insurance Paid") then begin
                                IsInsuranceTransaction := true;
                                InsDue := ("Credit Ledger Entry"."Amount (LCY)");
                                InsuranceRunBal += GetLoanLedgerMovement("Credit Ledger Entry");
                            end;
                            if ("Credit Ledger Entry"."Transaction Type" = "Credit Ledger Entry"."Transaction Type"::"Penalty Due") or ("Credit Ledger Entry"."Transaction Type" = "Credit Ledger Entry"."Transaction Type"::"Penalty Paid") then begin
                                IsPenaltyTransaction := true;
                                PenDue := ("Credit Ledger Entry"."Amount (LCY)");
                                PenaltyRunBal += GetLoanLedgerMovement("Credit Ledger Entry");
                            end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            RunBal := BalanceBF;
                            PrincipalRunBal := PrincipalBalanceBF;
                            InterestRunBal := InterestBalanceBF;
                            InsuranceRunBal := InsuranceBalanceBF;
                            PenaltyRunBal := PenaltyBalanceBF;

                            if DateFilter <> '' then
                                "Credit Ledger Entry".SetFilter("Posting Date", DateFilter);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        BalanceBF := 0;
                        PrincipalBalanceBF := 0;
                        InterestBalanceBF := 0;
                        InsuranceBalanceBF := 0;
                        PenaltyBalanceBF := 0;
                        if DateFilterBF <> '' then begin
                            LRec.Reset;
                            LRec.SetRange("Loan No.", Loans."Loan No.");
                            LRec.SetFilter("Date Filter", DateFilterBF);
                            if LRec.FindFirst then begin
                                LRec.CalcFields("Total Outstanding Balance", "Outstanding Principal", "Outstanding Interest", "Outstanding Insurance", "Outstanding Penalty");
                                BalanceBF := LRec."Total Outstanding Balance";
                                PrincipalBalanceBF := LRec."Outstanding Principal";
                                InterestBalanceBF := LRec."Outstanding Interest";
                                InsuranceBalanceBF := LRec."Outstanding Insurance";
                                PenaltyBalanceBF := LRec."Outstanding Penalty";

                                PrincipalBalanceBF := GetLoanComponentBalance(Loans."Loan No.", DateFilterBF, 0);
                                InterestBalanceBF := GetLoanComponentBalance(Loans."Loan No.", DateFilterBF, 1);
                                InsuranceBalanceBF := GetLoanComponentBalance(Loans."Loan No.", DateFilterBF, 2);
                                PenaltyBalanceBF := GetLoanComponentBalance(Loans."Loan No.", DateFilterBF, 3);
                            end;
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin

                        if CreditAccount <> '' then
                            SetRange("Loan No.", CreditAccount);

                        if SavingsAccount <> '' then
                            SetRange("Loan No.", SavingsAccount);

                        Loans.SetRange("Member No.", Members."No.");
                        if LoansStatement then
                            Loans.SetFilter("Total Outstanding Balance", '>0')
                        else if ShowClearedLoans then
                            Loans.SetFilter("Total Outstanding Balance", '<=0')
                        else if ShowAllLoans then;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if SavingsStatement then
                        CurrReport.Skip;

                    if ProductSpecific <> '' then
                        if LoanProduct."Product ID" <> ProductSpecific then
                            CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if Members.GetFilter("Date Filter") <> '' then begin
                    DateFilter := Members.GetFilter("Date Filter");
                    if CopyStr(DateFilter, 1, 2) <> '..' then begin
                        DateFilterBF := '..' + Format(CalcDate('-1D', Members.GetRangeMin("Date Filter")));
                    end;
                end;

                if Members."Trading As" <> '' then
                    Members.Name += ' Trading As ' + Members."Trading As";
            end;

            trigger OnPreDataItem()
            begin
                if CompanyInformation.Get then
                    CompanyInformation.CalcFields(CompanyInformation.Picture);
                CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
                CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
                CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Product Filters")
                {
                    field(ShowClearedLoans; ShowClearedLoans)
                    {
                        ApplicationArea = Basic;
                        trigger OnValidate()
                        begin
                            if ShowClearedLoans then begin
                                SavingsStatement := false;
                                ProductSpecific := '';
                                Sbool := false;
                            end;
                        end;
                    }
                    field("Loans Statement"; LoansStatement)
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            if LoansStatement then begin
                                SavingsStatement := false;
                                ProductSpecific := '';
                                Sbool := false;
                                ShowAllLoans := false;
                            end;
                        end;
                    }
                    field("Show All Loans"; ShowAllLoans)
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            if ShowAllLoans then begin
                                SavingsStatement := false;
                                ProductSpecific := '';
                                Sbool := false;
                                LoansStatement := false;
                            end;
                        end;
                    }
                    field("Savings Statement"; SavingsStatement)
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            if SavingsStatement then begin
                                LoansStatement := false;
                                ProductSpecific := '';
                                LBool := false;
                                ShowAllLoans := false;
                            end;
                        end;
                    }
                    field("Product Specific"; ProductSpecific)
                    {
                        ApplicationArea = Basic;
                        TableRelation = "Product Setup" where("Dont Show on Statement" = const(false));

                        trigger OnValidate()
                        begin
                            if ProductSpecific <> '' then begin
                                SavingsStatement := false;
                                LoansStatement := false;
                                LBool := false;
                                Sbool := false;
                                ShowAllLoans := false;
                            end;
                        end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Member Statement" then
            Error('You do not have any permissions to access this report. Contact the administrator!');
    end;

    procedure AccountFilter(Acc: Code[20])
    var
        myInt: Integer;
        Loans: Record Loans;
    begin
        if Loans.get(Acc) then
            CreditAccount := Acc
        else
            SavingsAccount := Acc;
    end;

    local procedure GetBankAccountNo(DocumentNo: Code[20]; PostingDate: Date): Code[20]
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        BankAccountLedgerEntry.SetRange("Document No.", DocumentNo);
        BankAccountLedgerEntry.SetRange("Posting Date", PostingDate);
        if BankAccountLedgerEntry.FindFirst() then
            exit(BankAccountLedgerEntry."Bank Account No.");

        exit('');
    end;

    local procedure GetLoanComponentBalance(LoanNo: Code[20]; PostingDateFilter: Text; Component: Option Principal,Interest,Insurance,Penalty): Decimal
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
        Balance: Decimal;
    begin
        CreditLedgerEntry.SetRange("Loan No.", LoanNo);
        CreditLedgerEntry.SetRange(Reversed, false);
        CreditLedgerEntry.SetFilter("Posting Date", PostingDateFilter);

        case Component of
            Component::Principal:
                CreditLedgerEntry.SetFilter("Transaction Type", '%1|%2',
                    CreditLedgerEntry."Transaction Type"::"Loan Disbursement",
                    CreditLedgerEntry."Transaction Type"::"Principal Repayment");
            Component::Interest:
                CreditLedgerEntry.SetFilter("Transaction Type", '%1|%2',
                    CreditLedgerEntry."Transaction Type"::"Interest Due",
                    CreditLedgerEntry."Transaction Type"::"Interest Paid");
            Component::Insurance:
                CreditLedgerEntry.SetFilter("Transaction Type", '%1|%2',
                    CreditLedgerEntry."Transaction Type"::"Insurance Due",
                    CreditLedgerEntry."Transaction Type"::"Insurance Paid");
            Component::Penalty:
                CreditLedgerEntry.SetFilter("Transaction Type", '%1|%2',
                    CreditLedgerEntry."Transaction Type"::"Penalty Due",
                    CreditLedgerEntry."Transaction Type"::"Penalty Paid");
        end;

        if CreditLedgerEntry.FindSet() then
            repeat
                Balance += GetLoanLedgerMovement(CreditLedgerEntry);
            until CreditLedgerEntry.Next() = 0;

        exit(Balance);
    end;

    local procedure GetLoanLedgerMovement(CreditLedgerEntry: Record "Credit Ledger Entry"): Decimal
    begin
        if (CreditLedgerEntry."Debit Amount (LCY)" <> 0) or
           (CreditLedgerEntry."Credit Amount (LCY)" <> 0)
        then
            exit(CreditLedgerEntry."Debit Amount (LCY)" - CreditLedgerEntry."Credit Amount (LCY)");

        exit(CreditLedgerEntry."Amount (LCY)");
    end;


    var
        UserSetup: Record "User Setup";
        MSection: Text;
        ShowClearedLoans: Boolean;
        ShowAllLoans: Boolean;
        RunBal: Decimal;
        BalanceBF: Decimal;
        DateFilter: Text;
        SavAcc: Record "Savings Accounts";
        DateFilterBF: Text;
        LRec: Record Loans;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        LoansStatement: Boolean;
        SavingsStatement: Boolean;
        ProductSpecific: Code[20];
        LBool: Boolean;
        Sbool: Boolean;
        PBool: Boolean;
        PrPaid: Decimal;
        IntPaid: Decimal;
        PrDue: Decimal;
        IntDue: Decimal;
        PenDue: Decimal;

        InsDue: Decimal;
        InsPaid: Decimal;
        SavingsAccount: Code[20];
        CreditAccount: Code[20];
        PrincipalRunBal: Decimal;
        InterestRunBal: Decimal;
        InsuranceRunBal: Decimal;
        PenaltyRunBal: Decimal;
        PrincipalBalanceBF: Decimal;
        InterestBalanceBF: Decimal;
        InsuranceBalanceBF: Decimal;
        PenaltyBalanceBF: Decimal;
        IsPrincipalTransaction: Boolean;
        IsInterestTransaction: Boolean;
        IsInsuranceTransaction: Boolean;
        IsPenaltyTransaction: Boolean;


}

