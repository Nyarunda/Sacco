Report 50272 "Loans PAR Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans PAR Report.rdlc';

    dataset
    {
        dataitem(Employee; Employee)
        {
            column(ReportForNavId_26; 26)
            {
            }
            column(No_HREmployees; Employee."No.")
            {
            }
            column(FullName_HREmployees; Employee."First Name")
            {
            }
            column(TLoanBal; TLoanBal)
            {
            }
            column(LoanCount; LoanCount)
            {
            }
            column(TLoanDef; TLoanDef)
            {
            }
            column(DefCount; DefCount)
            {
            }
            column(PAR; PAR)
            {
            }
            column(RecoveryRate; RecoveryRate)
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
            column(LoanGroup; LoanGroup)
            {
            }
            column(AsAt; Format(AsAt))
            {
            }
            column(GTotalLoanBal; GTotalLoanBal)
            {
            }
            column(GTotalDefAmt; GTotalDefAmt)
            {
            }
            column(GTPAR; GTPAR)
            {
            }
            column(GTRecoveryRate; GTRecoveryRate)
            {
            }
            column(DefAmt; DefAmt)
            {
            }
            column(PARCategory; PARCategory)
            {
            }

            trigger OnAfterGetRecord()
            var
                GracePeriod: DateFormula;
            begin

                LoanCount := 0;
                DefCount := 0;
                TLoanBal := 0;
                TLoanDef := 0;
                PAR := 0;
                RecoveryRate := 0;
                DefAmt := 0;

                Loans.Reset;
                if LoanGroup <> Loangroup::" " then
                    Loans.SetRange(Source, LoanGroup);


                if PARCategory = Parcategory::ALLOCATED then
                    Loans.SetRange("Recommended By", Employee."No.");
                if PARCategory = Parcategory::RECOMMENDED then
                    Loans.SetRange("Recommended By", Employee."No.");

                Loans.SetFilter("Date Filter", '..%1', AsAt);
                Loans.SetFilter("Outstanding Principal", '>0');
                if Loans.Find('-') then begin
                    LoanCount := Loans.Count;
                    repeat

                        Loans.CalcFields("Outstanding Principal");
                        TLoanBal += Loans."Outstanding Principal";

                        MDef := 0;
                        AmtDef := 0;

                        //        LoansProcess.GetLoanDefaulter(Loans."Loan No.",MDef,AmtDef,AsAt);
                        LoansProcess.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, AmtDef, DaysInArrear, ArrearsDate, false, GracePeriod);
                        MDef := ROUND(DaysInArrear / 30, 1, '=');
                        if AmtDef > 0 then begin
                            DefAmt += AmtDef;

                            AmtDef := Loans."Outstanding Principal";
                            DefCount += 1;
                            TLoanDef += AmtDef;
                        end;

                    until Loans.Next = 0;
                end
                else
                    CurrReport.Skip;

                PAR := ROUND(TLoanDef / TLoanBal * 100, 0.01, '=');
                RecoveryRate := 100 - PAR;

                GTotalDefAmt += TLoanDef;
                GTotalLoanBal += TLoanBal;

                GTPAR := ROUND(GTotalDefAmt / GTotalLoanBal * 100, 0.01, '=');
                GTRecoveryRate := 100 - GTPAR;
            end;

            trigger OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Company.Picture);

                if AsAt = 0D then
                    AsAt := Today;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("As At"; AsAt)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Group"; LoanGroup)
                {
                    ApplicationArea = Basic;
                }
                field(Category; PARCategory)
                {
                    ApplicationArea = Basic;
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
        ProductType: Text;
        MemberBiodata: Text;
        Company: Record "Company Information";
        ID: Code[20];
        Members: Record Members;
        AsAt: Date;
        LoansProcess: Codeunit "Sacco Activities";
        MDef: Integer;
        AmtDef: Decimal;
        SASRACategorization: Record "Sasra Categorization";
        LRec: Record Loans;
        MemberCode: Code[20];
        ProductFactory: Record "Product Setup";
        SavingsAccounts: Record "Savings Accounts";
        PFact: Record "Product Setup";
        KTDA: Code[20];
        AppraisalDue: Decimal;
        TDef: Decimal;
        Loans: Record Loans;
        LoanCount: Integer;
        DefCount: Integer;
        TLoanBal: Decimal;
        PAR: Decimal;
        RecoveryRate: Decimal;
        TLoanDef: Decimal;
        LoanGroup: Option " ",BOSA,FOSA,MFI,BUSINESS;
        GTotalLoanBal: Decimal;
        GTotalDefAmt: Decimal;
        GTPAR: Decimal;
        GTRecoveryRate: Decimal;
        DefAmt: Decimal;
        PARCategory: Option ALLOCATED,RECOMMENDED;
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
}

