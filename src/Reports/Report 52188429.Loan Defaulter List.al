
Report 50064 "Loan Defaulter List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Defaulter List.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Loan Product Type", "Member No.", "Disbursement Date", "Recommended by Type", "Recommended By";
            column(ReportForNavId_1; 1)
            {
            }
            column(MDef; MDef)
            {
            }
            column(MemberCode; MemberCode)
            {
            }
            column(KTDA; '')
            {
            }
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(CustomerCID; Loans."Form Serial No")
            {
            }
            column(MemberName_Loans; Loans."Member Name")
            {
            }
            column(Installemnt; Loans.Installments)
            {
            }
            column(RequestedAmount; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(OutBal; Loans."Outstanding Principal")
            {
            }
            column(OutPen; Loans."Outstanding Penalty")
            {
            }
            column(OutInt; Loans."Outstanding Interest")
            {
            }
            column(Picture; Company.Picture)
            {
            }
            column(TotalBalance; Loans."Total Outstanding Balance")
            {
            }
            column(OutstandingAppraisal_Loans; AppraisalDue)
            {
            }
            column(Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(IDNo; ID)
            {
            }
            column(LoanRepayment; Loans.Repayment)
            {
            }
            column(DisbursementDate; Loans."Disbursement Date")
            {
            }
            column(ExpectedDateCompl; Format(Loans."Completion Date"))
            {
            }
            column(AmtDef; DefAmount)
            {
            }
            column(RecommType; "Recommended by Type")
            {
            }
            column(RecommBy; "Recommended By" + '  ' + "Recommended By Name")
            {
            }
            column(DepAmt; DepAmt)
            {
            }
            column(ExpectedAmount; ExpectedAmt)
            {
            }
            column(AmounttPaid; AmtPaid)
            {
            }
            column(DefAmount; DefAmount)
            {
            }
            column(DaysInArrear; DaysInArrear)
            {
            }
            column(ArrearsDate; ArrearsDate)
            {
            }

            trigger OnAfterGetRecord()
            var
                GracePeriod: DateFormula;
            begin
                MemberCode := '';

                Loans.CalcFields("Outstanding Appraisal", "Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Schedule Appraisal", "Appraisal Fee Paid");

                if "Outstanding Principal" <= 0 then
                    CurrReport.Skip;

                if Loans."Disbursement Date" = 0D then
                    CurrReport.Skip;

                if Loans."Approved Amount" <= 0 then
                    CurrReport.Skip;


                MDef := 0;



                SaccoActivities.GetDefaultedAmount(Loans."Loan No.", AsAt, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GracePeriod);

                if DefAmount > 0 then
                    MDef := ROUND(DaysInArrear / 30, 1, '=');

                //IF MDef <= 0 THEN
                // CurrReport.SKIP;


                //IF DefFilter > 0 THEN BEGIN
                if DefFormula = Defformula::"Equal to" then
                    if MDef <> DefFilter then
                        CurrReport.Skip;

                if DefFormula = Defformula::"Greater Than" then
                    if MDef < DefFilter then
                        CurrReport.Skip;


                if DefFormula = Defformula::"Less Than" then
                    if MDef > DefFilter then
                        CurrReport.Skip;
                //END;


                IntDue := SaccoActivities.GetInterestDue(Loans, AsAt);

                DefAmount += IntDue + Loans."Outstanding Penalty";

                ID := '';
                if Members.Get(Loans."Member No.") then begin
                    ID := Members."ID No.";
                end;
            end;

            trigger OnPreDataItem()
            begin

                if AsAt = 0D then
                    AsAt := Today;

                Loans.SetFilter("Date Filter", '..%1', AsAt);
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
                field("Months Defaulted Filter"; DefFilter)
                {
                    ApplicationArea = Basic;
                }
                field(Formula; DefFormula)
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

    trigger OnPreReport()
    begin
        Company.Get;
        Company.CalcFields(Company.Picture);
    end;

    var
        ProductType: Text;
        MemberBiodata: Text;
        Company: Record "Company Information";
        ID: Code[50];
        Members: Record Members;
        RSchedule: Record "Loan Repayment Schedule";
        AsAt: Date;
        SaccoActivities: Codeunit "Sacco Activities";
        MDef: Integer;
        LRec: Record Loans;
        MemberCode: Code[50];
        ProductSetup: Record "Product Setup";
        AppraisalDue: Decimal;
        TDef: Decimal;
        DefFilter: Integer;
        DefFormula: Option " ","Less Than","Equal to","Greater Than";
        DepAmt: Decimal;
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        IntDue: Decimal;
}

