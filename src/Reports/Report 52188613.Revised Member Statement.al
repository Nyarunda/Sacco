
Report 50276 "Revised Member Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Revised Member Statement.rdlc';

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
            column(No_Members; Members."No.")
            {
            }
            column(MSection; MSection)
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(PayMode; Receipt."Pay Mode")
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
                    dataitem("Savings Ledger Entry"; "Savings Ledger Entry")
                    {
                        DataItemLink = "Account No." = field("No.");
                        DataItemTableView = where(Reversed = const(false));
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
                        column(Description_SavingsLedgerEntry; "Savings Ledger Entry".Description)
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

                        SetRange("Member No.", Members."No.");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if LoansStatement then
                        CurrReport.Skip;

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
                    column(LoanNumber; Loans."Loan No.")
                    {
                    }
                    column(ProductType; Loans."Loan Product Type Name")
                    {
                    }
                    column(IssueDate; Format(Loans."Disbursement Date"))
                    {
                    }
                    column(RequestedAmount; Loans."Requested Amount")
                    {
                    }
                    column(Interest; Loans."Annual Interest %")
                    {
                    }
                    column(Installments; Loans.Installments)
                    {
                    }
                    column(LoanPrincipleRepayment; Loans."Loan Principle Repayment")
                    {
                    }

                    column(Repayment_Loans; Loans.Repayment)
                    {
                    }
                    column(ModeofDisbursement_Loans; Loans."Mode of Disbursement")
                    {
                    }
                    column(VarCurrOutstandingBalance; 0)
                    {
                    }
                    column(VarCurrOutstandingInterest; 0)
                    {
                    }


                    dataitem(Date; Date)
                    {
                        column(ReportForNavId_1102755031; 1102755031)
                        {
                        }
                        column(PostingDate_loan; Loan."Posting Date")
                        {
                        }
                        column(DocumentNo_loan; Loan."Receipt No")
                        {
                        }
                        column(LoanNo; Loan."Loan No.")
                        {
                        }
                        column(Amount_Loan; 0)
                        {
                        }
                        column(IntBalance; Loan."Interest Balance")
                        {
                        }
                        column(AmountPaid_loan; Loan."Amount Paid")
                        {
                        }
                        column(openBalance_loan; Loan."Opening Balance")
                        {
                        }
                        column(CLosingBalance_loan; Loan."Loan Balance")
                        {
                        }
                        column(APrincipalPaid; Loan."Principal Paid")
                        {
                        }
                        column(AInterestPaid; Loan."Interest Paid")
                        {
                        }
                        column(InterestDue; Loan."Interest Due")
                        {
                        }
                        column(NewInterestDue_loan; 0)
                        {
                        }
                        column(InterestBalance; Loan."Interest Balance")
                        {
                        }
                        column(IntBal; Loan."Interest Balance")
                        {
                        }
                        column(EntryNo; Loan.entryNo)
                        {
                        }
                        column(TransactionType_loan; '')
                        {
                        }
                        column(Description_loan; '')
                        {
                        }
                        column(DebitAmoun_loan; 0)
                        {
                        }
                        column(CreditAmount_loan; 0)
                        {
                        }
                        column(LoansAccBalance; Loan."Loan Balance")
                        {
                        }

                        trigger OnAfterGetRecord()
                        var

                        begin
                            //MESSAGE(FORMAT(Date."Period Name"));

                            InterestPaid := 0;
                            PrincipalPaid := 0;
                            InterestDue := 0;
                            NewIntBal := 0;
                            NewPrinBal := 0;
                            NewOPenBal := 0;





                            Loan.Reset;
                            Loan.SetRange("Loan No.", LNo);
                            Loan.SetRange("Posting Date", Date."Period Start");

                            if not Loan.FindFirst then
                                CurrReport.Skip;

                            Loan.Reset;
                            Loan.SetRange("Loan No.", LNo);
                            Loan.SetRange("Posting Date", Date."Period Start");
                            Loan.SetFilter("Interest Balance", '<>0');
                            if Loan.FindFirst then begin
                                NewIntBal := Loan."Interest Balance";
                            end;

                            Loan.Reset;
                            Loan.SetRange("Loan No.", LNo);
                            Loan.SetRange("Posting Date", Date."Period Start");
                            Loan.SetFilter("Interest Balance", '<>0');
                            if Loan.FindFirst then begin
                                NewIntBal := Loan."Interest Balance";
                            end;

                            Loan.Reset;
                            Loan.SetRange("Loan No.", LNo);
                            Loan.SetRange("Posting Date", Date."Period Start");
                            Loan.SetFilter("Loan Balance", '<>0');
                            if Loan.FindFirst then begin
                                NewIntBal := Loan."Loan Balance";
                            end;




                            Loan.Reset;
                            Loan.SetRange("Loan No.", LNo);
                            Loan.SetRange("Posting Date", Date."Period Start");
                            Loan.SetFilter("Opening Balance", '<>0');
                            if Loan.FindFirst then begin
                                NewIntBal := Loan."Opening Balance";
                            end;


                            Loan.Reset;
                            Loan.SetRange("Loan No.", LNo);
                            Loan.SetRange("Posting Date", Date."Period Start");
                            //Loan.SETRANGE("Receipt No",ReceiptNumber);
                            //ADDED HERE
                            if Loan.FindFirst then begin
                                Loan.CalcSums(Loan."Amount Paid");
                                Loan.CalcSums(Loan."Principal Paid");
                                Loan.CalcSums(Loan."Interest Paid");
                                Loan.CalcSums(Loan."Interest Due");
                            end
                            else
                                CurrReport.Skip;



                        end;

                        trigger OnPreDataItem()
                        begin
                            Date.SetRange("Period Type", Date."period type"::Date);
                            Date.SetRange("Period Start", SDate, EDate);
                        end;
                    }

                    dataitem(Buffer; "Loan Statement Buffer")
                    {
                        DataItemLink = "Loan No." = field("Loan No.");
                        column(ReportForNavId_36; 36)
                        {
                        }
                        column(LoanNo_CreditLedgerEntry; Buffer."Loan No.")
                        {
                        }
                        column(CustomerNo_CreditLedgerEntry; Buffer."Member No.")
                        {
                        }
                        column(PostingDate_CreditLedgerEntry; Buffer.Date)
                        {
                        }
                        column(DocumentNo_CreditLedgerEntry; Buffer."Document No.")
                        {
                        }
                        column(Description_CreditLedgerEntry; '')
                        {
                        }
                        column(AccruedInterest; Buffer."Accrued Interest")
                        {
                        }
                        column(InterestPaid; Buffer."Interest Paid")
                        {
                        }
                        column(PrincipalPaid; Buffer."Principal Paid")
                        {
                        }
                        column(TotalPaid; Buffer."Total Paid")
                        {
                        }
                        column(NewLoan; Buffer."New Loan")
                        {
                        }
                        column(LoansRunBal; RunBal)
                        {
                        }
                        column(IntRunBal; IntRunBal)
                        {
                        }
                        column(LoansBalanceBF; BalanceBF)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin


                            RunBal += Buffer."New Loan" - Buffer."Principal Paid";
                            IntRunBal += Buffer."Accrued Interest" - Buffer."Interest Paid";

                        end;

                        trigger OnPreDataItem()
                        begin
                            RunBal := BalanceBF;
                            IntRunBal := IntBalanceBF;

                            if DateFilter <> '' then
                                Buffer.SetFilter("Date", DateFilter);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    var
                        MemberActivities: Codeunit "Member Activities";
                    begin
                        BalanceBF := 0;
                        IntBalanceBF := 0;
                        if DateFilterBF <> '' then begin
                            LRec.Reset;
                            LRec.SetRange("Loan No.", Loans."Loan No.");
                            LRec.SetFilter("Date Filter", DateFilterBF);
                            if LRec.FindFirst then begin
                                LRec.CalcFields("Outstanding Principal", "Outstanding Interest");
                                BalanceBF := LRec."Outstanding Principal";
                                IntBalanceBF := LRec."Outstanding Interest";
                            end;
                        end;
                        LNo := Loans."Loan No.";

                        SDate := DMY2Date(01, 01, 2017);
                        MLedger.RESET;
                        MLedger.SETCURRENTKEY("Posting Date");
                        MLedger.SETRANGE("Loan No.", Loans."Loan No.");
                        IF MLedger.FINDFIRST THEN BEGIN
                            SDate := MLedger."Posting Date";
                        END;


                        //===============-ADDED HERE

                        EDate := Today;
                        MLedger.RESET;
                        MLedger.SETCURRENTKEY("Posting Date");
                        MLedger.SETRANGE("Loan No.", Loans."Loan No.");
                        IF MLedger.FINDLAST THEN
                            EDate := MLedger."Posting Date";

                        MemberActivities.GenerateLoanStatementBuffer(Loans."Loan No.", Loans."Member No.", true);

                        //POPULATE HERE
                        MemberActivities.populateStatement(Loans."Loan No.", Loans."Member No.");
                    end;


                    trigger OnPreDataItem()
                    begin

                        Loans.SetRange("Member No.", Members."No.");
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
            end;

            trigger OnPreDataItem()
            begin
                if CompanyInformation.Get then
                    CompanyInformation.CalcFields(CompanyInformation.Picture);
                CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
                CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
#pragma warning disable AL0432
                CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432
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
                    field("Loans Statement"; LoansStatement)
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            if LoansStatement then begin
                                SavingsStatement := false;
                                ProductSpecific := '';
                                Sbool := false;
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

    labels
    {
    }

    var
        MSection: Text;
        RunBal: Decimal;
        BalanceBF: Decimal;
        IntRunBal: Decimal;
        IntBalanceBF: Decimal;
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
        Loan: Record "Statement Buffer";
        MLedger: Record "Credit Ledger Entry";
        SDate: Date;
        EDate: Date;
        InterestPaid: Decimal;
        PrincipalPaid: Decimal;
        InterestDue: Decimal;
        NewIntBal: Decimal;
        NewPrinBal: Decimal;
        NewOPenBal: Decimal;
        Receipt: Record "Receipt Header";
        LNo: Code[20];
}

