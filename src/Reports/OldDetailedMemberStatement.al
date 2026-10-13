
/// <summary>
/// Report Old Detailed Member Statement (ID 50300).
/// </summary>
Report 50300 "Old Detailed Member Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Old Detailed Member Statement.rdlc';

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
                    dataitem("Savings Ledger Entry"; "Member Ledger Entry")
                    {
                        DataItemLink = "Customer No." = field("No.");
                        DataItemTableView = where(Reversed = const(false));
                        column(ReportForNavId_9; 9)
                        {
                        }
                        column(ProductID; "Product Setup"."Product ID")
                        {
                        }
                        column(CustomerNo_SavingsLedgerEntry; "Savings Ledger Entry"."Customer No.")
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
                                SavAcc.CalcFields("Old Net Change");
                                BalanceBF := SavAcc."Old Net Change";
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
                dataitem(Loans; "Old Loans")
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
                    column(DisbursementDate_Loans; Loans."Issued Date")
                    {
                    }
                    column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
                    {
                    }
                    column(LoanNo_Loans; Loans."Loan  No.")
                    {
                    }
                    dataitem("Credit Ledger Entry"; "Member Ledger Entry")
                    {
                        DataItemLink = "Loan No" = field("Loan  No.");
                        DataItemTableView = where(Reversed = const(false), "Transaction Types" = filter("Loan" | "Repayment" | "Interest Due" | "Interest Paid"), "User ID" = filter(<> ''), Amount = filter(<> 0), "Amount (LCY)" = filter(<> 0));
                        column(ReportForNavId_36; 36)
                        {
                        }
                        column(CustomerNo_CreditLedgerEntry; "Credit Ledger Entry"."Customer No.")
                        {
                        }
                        column(PostingDate_CreditLedgerEntry; "Credit Ledger Entry"."Posting Date")
                        {
                        }
                        column(DocumentNo_CreditLedgerEntry; "Credit Ledger Entry"."Document No.")
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
                        column(LoanNo_CreditLedgerEntry; "Credit Ledger Entry"."Loan No")
                        {
                        }
                        column(TransactionType_CreditLedgerEntry; "Credit Ledger Entry"."Transaction Types")
                        {
                        }
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

                        trigger OnAfterGetRecord()
                        begin
                            RunBal += ("Credit Ledger Entry"."Amount (LCY)");
                            IntPaid := 0;
                            PrPaid := 0;
                            IntDue := 0;
                            Prdue := 0;

                            if "Credit Ledger Entry"."Transaction Types" = "Credit Ledger Entry"."Transaction Types"::"Interest Paid" then
                                IntPaid := ("Credit Ledger Entry"."Amount (LCY)" * -1);
                            if "Credit Ledger Entry"."Transaction Types" = "Credit Ledger Entry"."Transaction Types"::"Repayment" then
                                PrPaid := ("Credit Ledger Entry"."Amount (LCY)" * -1);

                            if "Credit Ledger Entry"."Transaction Types" = "Credit Ledger Entry"."Transaction Types"::"Interest Due" then
                                IntDue := ("Credit Ledger Entry"."Amount (LCY)" * -1);
                            if "Credit Ledger Entry"."Transaction Types" = "Credit Ledger Entry"."Transaction Types"::"Loan" then
                                Prdue := ("Credit Ledger Entry"."Amount (LCY)" * -1);
                        end;

                        trigger OnPreDataItem()
                        begin
                            RunBal := BalanceBF;

                            if DateFilter <> '' then
                                "Credit Ledger Entry".SetFilter("Posting Date", DateFilter);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        BalanceBF := 0;
                        if DateFilterBF <> '' then begin
                            LRec.Reset;
                            LRec.SetRange("Loan  No.", Loans."Loan  No.");
                            LRec.SetFilter("Date Filter", DateFilterBF);
                            if LRec.FindFirst then begin
                                //LRec.
                                //LRec.CalcFields(ou);
                                //BalanceBF := LRec."Total Outstanding Balance";
                            end;
                        end;
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
        DateFilter: Text;
        SavAcc: Record "Savings Accounts";
        DateFilterBF: Text;
        LRec: Record "Old Loans";
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


}

