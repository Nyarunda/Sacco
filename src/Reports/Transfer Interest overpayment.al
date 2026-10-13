report 50488 "Transfer Overpayment Interest"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = WHERE("Outstanding Interest" = FILTER(< 0)
                                      //"Outstanding Principal" = FILTER(> 0)
                                      );
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; 'CurrReport.PAGENO')
            {
            }
            column(USERID; USERID)
            {
            }
            column(Loans__Loan__No__; "Loan No.")
            {
            }
            column(Loans__Loan_Product_Type_; "Application Date")
            {
            }
            column(Loans__Client_Name_; "Member Name")
            {
            }
            column(Loans__Outstanding_Balance_; "Outstanding Principal")
            {
            }
            column(LoansCaption; LoansCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption; FIELDCAPTION("Loan No."))
            {
            }
            column(Loans__Loan_Product_Type_Caption; FIELDCAPTION("Application Date"))
            {
            }
            column(Loans__Client_Name_Caption; FIELDCAPTION("Member Name"))
            {
            }
            column(Loans__Outstanding_Balance_Caption; FIELDCAPTION("Outstanding Principal"))
            {
            }
            column(LoanRepayment; LoanRepayment)
            {
            }

            trigger OnAfterGetRecord()
            var
                TChannel: Enum "Transaction Channel";
            begin
                LoanRepayment := 0;
                Amt := 0;

                Loans.CALCFIELDS(Loans."Outstanding Interest", "Outstanding Principal");
                LoanRepayment := Loans."Outstanding Interest" * -1;

                IF LoanRepayment > Loans."Outstanding Principal" THEN
                    LoanRepayment := Loans."Outstanding Principal";



                LoanType.GET(Loans."Loan Product Type");

                LineNo := LineNo + 10000;
                Gnljnline.INIT;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := 'LNOVERPAID';
                Gnljnline."Line No." := LineNo;
                Gnljnline."Account Type" := Gnljnline."Account Type"::Credit;
                Gnljnline."Account No." := Loans."Loan Account";
                Gnljnline."Transaction Type" := Gnljnline."Transaction Type"::"Interest Paid";
                Gnljnline.VALIDATE(Gnljnline."Account No.");
                Gnljnline."Document No." := DocNo;
                Gnljnline."Posting Date" := PDate;
                Gnljnline.Description := 'Overpayment to loan';
                Gnljnline.Amount := LoanRepayment;
                Gnljnline."External Document No." := Loans."Member No.";
                Gnljnline.VALIDATE(Gnljnline.Amount);
                //Gnljnline."Loan No":=Loans."Loan No.";
                IF Gnljnline.Amount <> 0 THEN
                    Gnljnline.INSERT;

                user.Get(UserId);

                LoanTemp.Reset();
                LoanTemp.SetRange("Member No.", Loans."Member No.");
                LoanTemp.SetFilter("Outstanding Principal", '>0');
                LoanTemp.SetAutoCalcFields("Outstanding Principal");
                if LoanTemp.FindFirst() then
                    repeat
                        if LoanRepayment > 0 then begin

                            Desc := 'Overpayment to loan';
                            Amt := LoanTemp."Outstanding Principal";
                            if Amt > LoanRepayment then
                                Amt := LoanRepayment;
                            SaccoActivities.JournalInsert('GENERAL', 'LNOVERPAID', DocNo, PDate, AcctType::Credit, LoanTemp."Loan Account", Desc, BalAcctType::"G/L Account", '', Amt * -1, LoanTemp."Loan No.", LoanTemp."Loan No.", TransType::"Principal Repayment", '', '', false, TChannel, user."Dimension Set ID");
                            LoanRepayment -= Amt;
                        end;
                    until LoanTemp.Next() = 0;

                if LoanRepayment > 0 then begin
                    Amt := LoanRepayment;
                    Acc.Reset();
                    Acc.SetRange("Member No.", LoanTemp."Member No.");
                    Acc.SetRange("Product Category", Acc."Product Category"::"Unallocated Fund");
                    if Acc.FindFirst() then begin
                        SaccoActivities.JournalInsert('GENERAL', 'LNOVERPAID', DocNo, PDate, AcctType::Savings, Acc."No.", Desc, BalAcctType::"G/L Account", '', Amt * -1, LoanTemp."Loan No.", LoanTemp."Loan No.", TransType::" ", '', '', false, TChannel, user."Dimension Set ID");
                        LoanRepayment -= Amt;
                    end else begin
                        Acc.Reset();
                        Acc.SetRange("Member No.", LoanTemp."Member No.");
                        Acc.SetRange("Product Category", Acc."Product Category"::"Deposit Contribution");
                        if Acc.FindFirst() then begin
                            SaccoActivities.JournalInsert('GENERAL', 'LNOVERPAID', DocNo, PDate, AcctType::Savings, Acc."No.", Desc, BalAcctType::"G/L Account", '', Amt * -1, LoanTemp."Loan No.", LoanTemp."Loan No.", TransType::" ", '', '', false, TChannel, user."Dimension Set ID");
                            LoanRepayment -= Amt;
                        end;
                    end;
                end;

            end;

            trigger OnPreDataItem()
            begin

                Gnljnline.RESET;
                Gnljnline.SETRANGE(Gnljnline."Journal Template Name", 'GENERAL');
                Gnljnline.SETRANGE(Gnljnline."Journal Batch Name", 'LNOVERPAID');
                IF Gnljnline.FIND('-') THEN
                    Gnljnline.DELETEALL;

                //00104185
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Document No :"; DocNo)
                {
                    ApplicationArea = All;
                }
                field("Posting Date :"; PDate)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        user: Record "User Setup";
        LoanType: Record "Product Setup";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        AcctType: Enum "Gen. Journal Account Type";
        LoanRepayment: Decimal;
        SaccoActivities: Codeunit "Sacco Activities";
        LoanTemp: Record Loans;
        Desc: Text[50];
        Amt: Decimal;
        Acc: Record "Savings Accounts";
        TransType: Enum "Transaction Type Enum";
        BalAcctType: Enum "Gen. Journal Account Type";
        LoansCaptionLbl: Label 'Loans';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

