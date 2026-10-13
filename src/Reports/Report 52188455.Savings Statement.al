
Report 50118 "Savings Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Savings Statement.rdlc';


    dataset
    {
        dataitem(Savings; "Savings Accounts")
        {
            RequestFilterFields = "No.", "Date Filter";
            column(ReportForNavId_52; 52)
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
            column(Child_Name; "Child Name")
            {
            }
            column(Email; Email)
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
                DataItemLink = "Product ID" = field("Product Type");
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
                                SavAcc.CalcFields("Net Change (LCY)");
                                BalanceBF := SavAcc."Net Change (LCY)";
                            end;
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin

                        SetRange("Member No.", Members."No.");
                        SetRange("No.", Savings."No.");
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                Members.Get(Savings."Member No.");
                Email := Members."E-Mail";

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
                if CompanyInformation.Get then
                    CompanyInformation.CalcFields(CompanyInformation.Picture);
                CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
                CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
                CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail";



                if Savings.GetFilter("Date Filter") <> '' then begin
                    DateFilter := Savings.GetFilter("Date Filter");
                    if CopyStr(DateFilter, 1, 2) <> '..' then begin
                        DateFilterBF := '..' + Format(CalcDate('-1D', Savings.GetRangeMin("Date Filter")));
                    end;
                end;
            end;

        }

    }



    requestpage
    {

        layout
        {
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
        Members: Record Members;
        StartDate: Date;
        EndDate: Date;
        Email: Text[50];



    procedure SetDateFilter(SDate: Date; EDate: Date)
    var
        myInt: Integer;
    begin
        StartDate := SDate;
        EndDate := EDate
    end;
}

