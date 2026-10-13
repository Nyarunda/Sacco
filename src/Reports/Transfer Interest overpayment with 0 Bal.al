report 50486 "Transfer Int Overpy 0 Balance"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;


    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = WHERE("Outstanding Interest" = FILTER(< 0));
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; 'CurrReport.PageNo')
            {
            }
            column(USERID; USERID)
            {
            }
            column(Loans__Loan__No__; "Loan No.")
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

            trigger OnAfterGetRecord()

            begin
                LoanRepayment := 0;
                Loans.CALCFIELDS(Loans."Outstanding Interest");
                LoanRepayment := Loans."Outstanding Interest" * -1;

                Savings.Get(Loans."Member No.");

                IF Loans."Outstanding Interest" < 0 THEN BEGIN
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
                    Gnljnline.Description := 'Overpayment to Deposits';
                    Gnljnline.Amount := LoanRepayment;
                    Gnljnline."External Document No." := Loans."Member No.";
                    Gnljnline.VALIDATE(Gnljnline.Amount);
                    //Gnljnline."Loan No" := Loans."Loan No.";
                    IF Gnljnline.Amount <> 0 THEN
                        Gnljnline.INSERT;


                    LineNo := LineNo + 10000;
                    Gnljnline.INIT;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := 'LNOVERPAID';
                    Gnljnline."Line No." := LineNo;
                    Gnljnline."Account Type" := Gnljnline."Account Type"::Savings;
                    Gnljnline."Account No." := Savings."No.";
                    Gnljnline."Transaction Type" := TransType::" ";
                    Gnljnline.VALIDATE(Gnljnline."Account No.");
                    Gnljnline."Document No." := DocNo;
                    Gnljnline."Posting Date" := PDate;
                    Gnljnline.Description := 'Overpayment to Deposits ' + Loans."Loan No.";
                    Gnljnline.Amount := LoanRepayment * -1;
                    Gnljnline."External Document No." := Loans."Member No.";
                    Gnljnline.VALIDATE(Gnljnline.Amount);
                    //Gnljnline."Loan No":=Loans."Loan No.";
                    IF Gnljnline.Amount <> 0 THEN
                        Gnljnline.INSERT;

                END;
            end;

            trigger OnPreDataItem()
            begin
                Gnljnline.RESET;
                Gnljnline.SETRANGE(Gnljnline."Journal Template Name", 'GENERAL');
                Gnljnline.SETRANGE(Gnljnline."Journal Batch Name", 'LNOVERPAID');
                IF Gnljnline.FIND('-') THEN
                    Gnljnline.DELETEALL;
                LoanRepayment := 0;//00104185
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
        LoanType: Record "Product Setup";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        LoanRepayment: Decimal;
        LoansCaptionLbl: Label 'Loans';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TransType: Enum "Transaction Type Enum";
        Savings: Record "Savings Accounts";
}

