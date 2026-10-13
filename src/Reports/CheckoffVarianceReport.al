
/// <summary>
/// Report Checkoff Variance Report (ID 50331).
/// </summary>
Report 50331 "Checkoff Variance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Checkoff Variance Report.rdlc';

    dataset
    {
        dataitem("Monthly Checkoff Header"; "Monthly Checkoff Header")
        {

            dataitem(Loans; Loans)
            {
                RequestFilterFields = "Loan No.", "Application Date", "Loan Product Type", "Member No.", Source;
                DataItemTableView = where(Posted = const(true), "Outstanding Principal" = filter(> 0));
                DataItemLink = "Employer Code" = field("Employer Code");
                column(ReportForNavId_1; 1)
                {
                }

                column(ExpAmt; ExpAmt)
                {
                }
                column(AmtPaid; AmtPaid)
                {
                }
                column(Variance; Variance)
                {
                }
                column(ID_No_; "ID No.")
                {
                }
                column(Staff_No; "Staff No")
                {
                }
                column(LoanNo_Loans; Loans."Loan No.")
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
                column(MemberName_Loans; Loans."Member Name")
                {
                }


                trigger OnAfterGetRecord()
                var
                    CheckOffLines: Record "Monthly Checkoff Lines";
                begin

                    sno += 1;
                    EmpCode := '';
                    EmpName := '';
                    ExpAmt := Repayment;
                    if "Adjusted Repayment" > 0 then
                        ExpAmt := "Adjusted Repayment";

                    AmtPaid := 0;
                    Variance := 0;

                    CheckOffLines.Reset();
                    CheckOffLines.SetRange("Checkoff Header", CheckOffHeader);
                    CheckOffLines.SetRange("Loan No.", Loans."Loan No.");
                    if CheckOffLines.FindFirst() then begin
                        CheckOffLines.CalcSums(Amount);
                        AmtPaid := CheckOffLines.Amount;
                    end;

                    Variance := ExpAmt - AmtPaid;


                end;
            }
            dataitem(Account; "Savings Accounts")
            {
                RequestFilterFields = "No.";
                DataItemTableView = where("Product Category" = filter("Deposit Contribution" | "Share Capital"));
                DataItemLink = "Employer Code" = field("Employer Code");
                column(No_; "No.")
                {
                }
                column(Member_No_; "Member No.")
                {
                }
                column(Name; Name)
                {
                }
                column(Product_Name; "Product Name")
                {
                }
                column(SExpAmt; SExpAmt)
                {
                }
                column(SAmtPaid; SAmtPaid)
                {
                }
                column(SVariance; SVariance)
                {
                }
                trigger OnAfterGetRecord()
                var
                    CheckOffLines: Record "Monthly Checkoff Lines";
                begin

                    sno += 1;
                    EmpCode := '';
                    EmpName := '';
                    ExpAmt := "Monthly Contribution";

                    AmtPaid := 0;
                    Variance := 0;

                    CheckOffLines.Reset();
                    CheckOffLines.SetRange("Checkoff Header", CheckOffHeader);
                    CheckOffLines.SetRange("Account No.", Account."No.");
                    if CheckOffLines.FindFirst() then begin
                        CheckOffLines.CalcSums(Amount);
                        AmtPaid := CheckOffLines.Amount;
                    end;

                    Variance := ExpAmt - AmtPaid;



                end;
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                CheckOffHeader := "No.";
            end;

        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Repayment Day"; day)
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
        ExpAmt: Decimal;
        AmtPaid: Decimal;
        Variance: Decimal;
        SExpAmt: Decimal;
        SAmtPaid: Decimal;
        SVariance: Decimal;
        ProductType: Text;
        SecurityType: Text;
        SecurityValue: Decimal;
        EmpCode: Code[20];
        EmpName: Text;
        LoanSec: Record "Loan Security";
        PSetup: Record "Product Setup";
        MemberBiodata: Text;
        Company: Record "Company Information";
        sno: Integer;
        CheckOffHeader: Code[20];
        day: Integer;
        BridgeAmt: Decimal;
        RSchedule: Record "Loan Repayment Schedule";
        TopUp: Record "Loan Top Up";
        Members: Record Members;
        RO: Text;
        MDep: Decimal;
        RShipOfficer: Code[20];
        Cust: Record Members;
        BranchCode: Text;
}

