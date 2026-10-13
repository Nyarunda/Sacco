report 50034 "MFI CSR Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/MFI CSR Report.rdlc';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Group No.", "Date Filter";
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(MemberNo_Loans; Members."No.")
            {
            }
            column(MemberName_Loans; Members.Name)
            {
            }
            column(StaffNo; Loans."Staff No")
            {
            }
            column(LoanStatus; Loans.Status)
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(Employer; Loans."Employer Code")
            {
            }
            column(RequestedAmount; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount; LoanAmount)
            {
            }
            column(Topup; TopUpAmnt)
            {
            }
            column(NetAmount; NetAmount)
            {
            }
            column(Installemnt; Prd)
            {
            }
            column(Repayment; Loans.Repayment)
            {
            }
            column(IssueDate; IssuedDate)
            {
            }
            column(RepaymentStart; Loans."Repayment Start Date")
            {
            }
            column(OutInt; IntBal)
            {
            }
            column(OutBal; LoanBal)
            {
            }
            column(ExpectedDateOf; Loans."Completion Date")
            {
            }
            column(Boosting; '')
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }
            column(OutBill; '')
            {
            }
            column(Picture; Company.Picture)
            {
            }
            column(Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(sno; sno)
            {
            }
            column(ArrearsDays; ArrearsDays)
            {
            }
            column(Abbrev; ABBR)
            {
            }
            column(AbbrevC; ABBRC)
            {
            }
            column(AmountPaid; Amountpaid)
            {
            }
            column(Outstandingbal; totalbal)
            {
            }
            column(TotalActual; TotalActual)
            {
            }
            column(AmountDefaulted; "Amount defaulted")
            {
            }
            column(LaSTpaydate; Loans."Last Pay Date")
            {
            }
            column(InstallmentDefaulted; Loans.Installments)
            {
            }
            column(Total_Schedule; Loans."Schedule Repayment")
            {
            }
            column(Schedule_Repayment; Expected)
            {
            }
            column(Schedule_Balance; Schedule_Balance)
            {
            }
            column(Arreas; Arrears)
            {
            }
            column(Days_Defaulted; Days_Defaulted)
            {
            }
            column(CateGory; Loans."Loans Category-SASRA")
            {
            }
            column(GroupCode; '')
            {
            }
            column(GroupName; GroupName)
            {
            }
            column(ShareCap; SHareCap)
            {
            }
            column(Deposits; Deposits)
            {
            }
            column(MonthCont; MonthCont)
            {
            }
            column(DateFilter; DateFilter)
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF meb.GET("Group No.") THEN
                    GroupName := meb.Name;


                Deposits := 0;
                SHareCap := 0;
                MonthCont := 0;


                Sav.RESET;
                Sav.SETFILTER(Sav."Product Category", '%1|%2', Sav."Product Category"::"Deposit Contribution", Sav."Product Category"::"Micro Member Deposit");
                Sav.SETRANGE(Sav."Member No.", "No.");
                IF Sav.FIND('-') THEN BEGIN
                    Sav.CALCFIELDS(Sav.Balance, Sav."Balance (LCY)");
                    Deposits := Sav.Balance;

                END;

                SavAccReg.RESET;
                SavAccReg.SETRANGE(SavAccReg."No.", "No.");
                SavAccReg.SetFilter(SavAccReg."Product Category", '%1|%2', SavAccReg."Product Category"::"Deposit Contribution", SavAccReg."Product Category"::"Micro Member Deposit");// THEN BEGIN
                IF SavAccReg.FIND('-') THEN BEGIN
                    REPEAT
                        if SavAccReg."Monthly Contribution" > 0 then
                            MonthCont := SavAccReg."Monthly Contribution";
                    UNTIL SavAccReg.NEXT = 0;
                END;





                Sav.RESET;
                Sav.SETRANGE(Sav."Product Category", Sav."Product Category"::"Share Capital");
                Sav.SETRANGE(Sav."Member No.", "No.");
                IF Sav.FIND('-') THEN BEGIN
                    Sav.CALCFIELDS(Sav.Balance, Sav."Balance (LCY)");
                    SHareCap := Sav.Balance;
                END;

                Prd := 0;
                LoanBal := 0;
                IntBal := 0;
                Expected := 0;
                Amountpaid := 0;
                Arrears := 0;
                LoanAmount := 0;
                IssuedDate := 0D;

                Loans.RESET;
                Loans.SETRANGE("Member No.", Members."No.");
                Loans.SETFILTER("Date Filter", Members.GETFILTER("Date Filter"));
                Loans.SETFILTER("Outstanding Principal", '>0');
                IF Loans.FINDFIRST THEN BEGIN
                    Loans.CALCFIELDS("Schedule Repayment", "Interest Paid", "Schedule Repayment", "Outstanding Principal", "Principal Paid", "Outstanding Interest", "Total Arrears");
                    LoanAmount := Loans."Approved Amount";
                    IssuedDate := Loans."Disbursement Date";
                    LoanBal := Loans."Outstanding Principal";
                    IntBal := Loans."Outstanding Interest";
                    Prd := Loans.Installments;

                    Expected := Loans."Schedule Repayment";
                    Amountpaid := Loans."Principal Paid" + Loans."Interest Paid";

                    Arrears := Loans."Total Arrears"; //Loans."Schedule Repayment" - Amountpaid;

                    IF Arrears < 0 THEN
                        Arrears := 0;

                    IF ProdFac.GET(Loans."Loan Product Type") THEN BEGIN
                        ABBR := ProdFac."USSD Product Name";
                    END;

                END;
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

    trigger OnInitReport()
    begin
        StatusPermission.RESET;
        StatusPermission.SETRANGE(StatusPermission."User ID", USERID);
        StatusPermission.SETRANGE(StatusPermission.reports, TRUE);
        IF NOT StatusPermission.FIND('-') THEN BEGIN
            ERROR('You Do Not have Permission to perform this action');
        END;
    end;

    trigger OnPreReport()
    begin
        IF Members.GETFILTER("Date Filter") = '' THEN
            ERROR('Please specify a Date filter before proceeding');

        IF Members.GETFILTER("Group No.") = '' THEN
            ERROR('Please specify Group Account No before proceeding');

        Company.GET;
        Company.CALCFIELDS(Company.Picture);

        DateFilter := Members.GETFILTER("Date Filter");
    end;

    var
        ProductType: Text;
        MemberBiodata: Text;
        Company: Record "Company Information";
        sno: Integer;
        ArrearsDays: Integer;
        Topup: Record "Loan Top Up";
        NetAmount: Decimal;
        TopUpAmnt: Decimal;
        ABBR: Code[10];
        ProdFac: Record "Product Setup";
        Cust: Record Customer;
        ABBRC: Code[20];
        "Amount defaulted": Decimal;
        "Defaulted install": Decimal;
        TotalActual: Decimal;
        ExpIntallment: Decimal;
        HesabuWeeks: Decimal;
        ExpectedPrinc: Decimal;
        TotExpPr: Decimal;
        TotExpAmount: Decimal;
        Amountpaid: Decimal;
        TotalAmountDefaulted: Decimal;
        totalbal: Decimal;
        CurrDate: Date;
        Schedule_Balance: Decimal;
        Arrears: Decimal;
        Days_Defaulted: Integer;
        Sav: Record "Savings Accounts";
        SHareCap: Decimal;
        Deposits: Decimal;
        MonthCont: Decimal;
        GroupName: Text[100];
        meb: Record Members;
        Loans: Record Loans;
        LoanBal: Decimal;
        IntBal: Decimal;
        Expected: Decimal;
        Paid: Decimal;
        LoanAmount: Decimal;
        IssuedDate: Date;
        Prd: Integer;
        DateFilter: Text[25];
        SavAccReg: Record "Savings Accounts";
        MemCat: Record "Member Class";
        StatusPermission: Record "user setup";
}

