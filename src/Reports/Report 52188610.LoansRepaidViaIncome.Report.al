Report 50273 "Loans Repaid Via Income"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans Repaid Via Income.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Member No.", "Loan Product Type";
            column(ReportForNavId_1; 1)
            {
            }
            column(TotalRepaid; TotalRepaid)
            {
            }
            column(SDate; SDate)
            {
            }
            column(EDate; EDate)
            {
            }
            column(PrincipalAmt; PrincipalAmt)
            {
            }
            column(InterestAmt; InterestAmt)
            {
            }
            column(PenaltyAmt; PenaltyAmt)
            {
            }
            column(AppraisalAmt; AppraisalAmt)
            {
            }
            column(IDNo; IDNo)
            {
            }
            column(Interest_Loans; "Annual Interest %")
            {
            }
            column(Repayment_Loans; Loans.Repayment)
            {
            }
            column(LoanPrincipleRepayment_Loans; Loans."Loan Principle Repayment")
            {
            }
            column(GlobalDimension2Code_Loans; Loans."Booking Branch")
            {
            }
            column(InterestCalculationMethod_Loans; Loans."Interest Calculation Method")
            {
            }
            column(DisbursementDate_Loans; Format(Loans."Disbursement Date"))
            {
            }
            column(LastPayDate_Loans; Format(Loans."Last Pay Date"))
            {
            }
            column(ExpectedDateofCompletion_Loans; Format(Loans."Completion Date"))
            {
            }
            column(LoansCategorySASRA_Loans; Loans."Loans Category-SASRA")
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
            column(OutInt; Loans."Outstanding Interest")
            {
            }
            column(OutBill; Loans."Principal Arrears")
            {
            }
            column(OutApp; Loans."Outstanding Appraisal")
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
            column(BridgeAmt; BridgeAmt)
            {
            }
            column(Phone; Phone)
            {
            }
            column(DepAmt; DepAmt)
            {
            }
            column(SecurityAmt; SecurityAmt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                sno += 1;

                if day <> 0 then begin
                    if Loans."Disbursement Date" <> 0D then begin
                        if day <> Date2dmy(Loans."Disbursement Date", 1) then
                            CurrReport.Skip;
                    end
                    else
                        CurrReport.Skip;
                end;


                PrincipalAmt := 0;
                InterestAmt := 0;
                PenaltyAmt := 0;
                AppraisalAmt := 0;

                CLedger.Reset;
                CLedger.SetRange("Loan No.", Loans."Loan No.");
                CLedger.SetRange("Posting Date", SDate, EDate);
                if not CLedger.FindFirst then begin
                    CurrReport.Skip;
                end;


                CLedger.Reset;
                CLedger.SetRange("Loan No.", Loans."Loan No.");
                CLedger.SetRange("Posting Date", SDate, EDate);
                CLedger.SetRange("Transaction Type", CLedger."transaction type"::"Principal Repayment");
                if CLedger.FindFirst then begin
                    repeat
                        SalaryLines.Reset;
                        SalaryLines.SetRange("Salary Header No.", CLedger."Document No.");
                        SalaryLines.SetRange("Member No.", Loans."Member No.");
                        if SalaryLines.FindFirst then
                            PrincipalAmt += CLedger."Amount (LCY)" * -1;
                    until CLedger.Next = 0;
                end;

                CLedger.Reset;
                CLedger.SetRange("Loan No.", Loans."Loan No.");
                CLedger.SetRange("Posting Date", SDate, EDate);
                CLedger.SetRange("Transaction Type", CLedger."transaction type"::"Interest Paid");
                if CLedger.FindFirst then begin
                    repeat
                        SalaryLines.Reset;
                        SalaryLines.SetRange("Salary Header No.", CLedger."Document No.");
                        SalaryLines.SetRange("Member No.", Loans."Member No.");
                        if SalaryLines.FindFirst then
                            InterestAmt += CLedger."Amount (LCY)" * -1;
                    until CLedger.Next = 0;
                end;

                CLedger.Reset;
                CLedger.SetRange("Loan No.", Loans."Loan No.");
                CLedger.SetRange("Posting Date", SDate, EDate);
                CLedger.SetRange("Transaction Type", CLedger."transaction type"::"Appraisal Paid");
                if CLedger.FindFirst then begin
                    repeat
                        SalaryLines.Reset;
                        SalaryLines.SetRange("Salary Header No.", CLedger."Document No.");
                        SalaryLines.SetRange("Member No.", Loans."Member No.");
                        if SalaryLines.FindFirst then
                            AppraisalAmt += CLedger."Amount (LCY)" * -1;
                    until CLedger.Next = 0;
                end;

                CLedger.Reset;
                CLedger.SetRange("Loan No.", Loans."Loan No.");
                CLedger.SetRange("Posting Date", SDate, EDate);
                CLedger.SetRange("Transaction Type", CLedger."transaction type"::"Penalty Paid");
                if CLedger.FindFirst then begin
                    repeat
                        SalaryLines.Reset;
                        SalaryLines.SetRange("Salary Header No.", CLedger."Document No.");
                        SalaryLines.SetRange("Member No.", Loans."Member No.");
                        if SalaryLines.FindFirst then
                            PenaltyAmt += CLedger."Amount (LCY)" * -1;
                    until CLedger.Next = 0;
                end;

                TotalRepaid := PrincipalAmt + InterestAmt + AppraisalAmt + PenaltyAmt;

                if TotalRepaid = 0 then
                    CurrReport.Skip;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; SDate)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; EDate)
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
        sno: Integer;
        ProdFac: Record "Product Setup";
        LoansProcess: Codeunit "Sacco Activities";
        day: Integer;
        BridgeAmt: Decimal;
        Cust: Record Members;
        Phone: Code[40];
        Savings: Record "Savings Accounts";
        DepAmt: Decimal;
        SecurityAmt: Decimal;
        IDNo: Code[200];
        PrincipalAmt: Decimal;
        InterestAmt: Decimal;
        PenaltyAmt: Decimal;
        AppraisalAmt: Decimal;
        TotalRepaid: Decimal;
        SalaryLines: Record "Salary Lines";
        SalaryHeader: Record "Salary Header";
        SDate: Date;
        EDate: Date;
        CLedger: Record "Credit Ledger Entry";
}

