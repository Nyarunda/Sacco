
Report 50069 "Loan Interest Reversal"
{
    DefaultLayout = RDLC;
#pragma warning disable AL0835
    ProcessingOnly = true;
    //ProcessingOnly = true;

#pragma warning restore AL0835

    dataset
    {
        dataitem(Loans; Loans)
        {

            RequestFilterFields = "Last Int. Paid Date", "Loan No.", "Application Date", "Loan Product Type", "Member No.", Source;
            DataItemTableView = where("Total Outstanding Balance" = filter(> 0));
            column(ReportForNavId_1; 1)
            {
            }
            column(Repayment; Repayment)
            {
            }
            column(SecurityType; SecurityType)
            {
            }
            column(SecurityValue; SecurityValue)
            {
            }
            column(Total_Guaranteed; "Total Guaranteed")
            {
            }
            column(Member_Category; "Member Category")
            {
            }
            column(Last_Principal_Pay_Date; "Last Principal Pay Date")
            {
            }
            column(Repay_Mode; "Repay Mode")
            {
            }
            column(Debt_Collector; "Debt Collector")
            {
            }
            column(Debt_Collector_Name; "Debt Collector Name")
            {
            }
            column(Total_Arrears; "Total Arrears")
            {
            }
            column(Loan; "Schedule Repayment")
            {
            }
            column(Schedule_Interest; "Schedule Interest")
            {
            }
            column(EmpCode; EmpCode)
            {
            }
            column(EmpName; EmpName)
            {
            }
            column(RShipOfficer; RShipOfficer)
            {
            }
            column(BranchCode; BranchCode)
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
            column(OutInt; IntAmt)
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
            column(TotalLoanBal; Loans."Total Outstanding Balance")
            {
            }
            column(OutstandingPenalty_Loans; Loans."Outstanding Penalty")
            {
            }

            trigger OnPreDataItem()
            var
                myInt: Integer;
                Usersetup: Record "User Setup";
            begin
                Usersetup.get(UserId);
                if not usersetup."Reverse Interest" then
                    Error('You do have permission to reverse interest!');
            end;

            trigger OnAfterGetRecord()
            var
                Cledger: Record "Credit Ledger Entry";
                GLentry: Record "G/L Entry";

                ReversalEntry: Record "Reversal Entry";
                GLRegister: Record "G/L Register";


            begin

                IntAmt := 0;
                DocumentNo := '';

                if StrLen(Loans."Loan No." + ' REF') > 20 then
                    CurrReport.Skip();

                DocumentNo := Loans."Loan No.";// + ' REF';

                sno += 1;
                Cledger.Reset();
                Cledger.SetRange(Cledger."Loan No.", Loans."Loan No.");
                Cledger.SetRange(Cledger."Posting Date", Pdate);
                Cledger.SetRange(Cledger."Document No.", DocumentNo);
                Cledger.SetFilter(Cledger."User ID", UserPosted);
                Cledger.SetRange(Cledger.Reversed, false);
                Cledger.SetRange(Cledger."Transaction Type", Cledger."Transaction Type"::"Interest Due");
                if Cledger.FindLast() then begin
                    //if Cledger."Document No." = 'DEF-OFFSET' then begin
                    ReversalEntry.SetHideWarningDialogs;
                    ReversalEntry.ReverseTransaction(Cledger."Transaction No.");
                    /* GLentry.Reset();
                    GLentry.SetRange(GLentry."Entry No.", Cledger."Entry No.");
                    GLentry.SetRange(GLentry."Document No.", Cledger."Document No.");
                    GLentry.SetRange(GLentry."Posting Date", Cledger."Posting Date");
                    GLentry.SetRange(GLentry."Reversed", false);
                    //GLentry.SetRange(Amount, Cledger."Amount (LCY)")
                    if GLentry.FindFirst() then begin

                        GLRegister.Reset();
                        GLRegister.SetFilter(GLRegister."From Entry No.", '<=%1', GLentry."Entry No.");
                        GLRegister.SetFilter(GLRegister."To Entry No.", '>=%1', GLentry."Entry No.");
                        GLRegister.SetRange(GLRegister.Reversed, false);
                        if GLRegister.FindFirst() then begin
                            ReversalEntry.SetHideWarningDialogs;
                            ReversalEntry.ReverseTransaction(GLentry."Transaction No.");
                            IntAmt := GLentry.Amount;
                        end;
                    end; */
                    //end
                    //else
                    //CurrReport.Skip();
                end;
                Clear(DocumentNo);
                /* else
                    CurrReport.skip; */




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
                field(PDate; PDate)
                {
                    ApplicationArea = Basic;
                }

                field(DocumentNo; DocumentNo)
                {
                    ApplicationArea = Basic;
                }
                field(UserPosted; UserPosted)
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
        IntAmt: Decimal;
        SecurityType: Text;
        SecurityValue: Decimal;
        EmpCode: Code[20];
        EmpName: Text;
        LoanSec: Record "Loan Security";
        PSetup: Record "Product Setup";
        MemberBiodata: Text;
        Company: Record "Company Information";
        sno: Integer;
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
        DocumentNo: Code[20];
        PDate: Date;
        UserPosted: Code[100];
}

