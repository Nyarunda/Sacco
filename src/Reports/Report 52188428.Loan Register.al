
Report 50063 "Loan Register"
{
    DefaultLayout = RDLC;
    Caption = 'Loan Summary Sheet';
    RDLCLayout = './src/Layouts/Loan Register.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Application Date", "Loan Product Type", "Member No.", Source, "Total Outstanding Balance";

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

            column(Last_Principal_Pay_Date; "Last Principal Pay Date")
            {
            }

            column(Total_Arrears; "Total Arrears")
            {
            }
            column(Loan; "Schedule Repayment")
            {
            }
            column(Loan_Principle_Repayment; "Loan Principle Repayment")
            { }
            column(Repayment_Start_Date; "Repayment Start Date")
            { }
            column(Schedule_Balance; "Schedule Balance")
            { }
            column(Completion_Date; "Completion Date")
            { }
            column(SASRA_Months_Arrears; "SASRA Months Arrears")
            { }
            column(ID_No_; "ID No.")
            {
            }
            column(Appraised_By; "Appraised By")
            {
            }
            column(Outstanding_Penalty; "Outstanding Penalty")
            {
            }
            column(Total_Outstanding_Balance; "Total Outstanding Balance")
            {
            }
            column(Disbursement_Date; "Disbursement Date")
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
            column(MemberAge; MemberAge)
            { }

            column(RShipOfficer; "Loan Officer")
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
            column(Date_Rescheduled; "Date Rescheduled")
            {
            }
            column(Captured_By; "Captured By")
            {
            }

            column(Approved_By; "Approved By")
            {
            }
            column(Top_Up_Amount; "Top Up Amount")
            {
            }
            column(NetAmount; NetAmount)
            {
            }
            column(Booking_Branch; "Booking Branch")
            {
            }
            column(Status; Status)
            {
            }
            column(Email; Email)
            {
            }
            column(Phone; Phone)
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
            column(Insurance_Due; "Insurance Due")
            { }
            column(Installments; Installments)
            {
            }
            column(IDNO; "ID No.")
            {
            }
            column(ShareCapital; MemberDetails[1])
            {
            }
            column(Deposits; MemberDetails[2])
            {
            }
            column(AsAt; AsAt)
            { }

            trigger OnAfterGetRecord()
            var
                i: Integer;
            begin
                Loans.CalcFields("Top Up Amount", "SASRA Months Arrears", "Schedule Balance");

                for i := 1 to 4 do
                    MemberDetails[i] := '';

                sno += 1;
                EmpCode := '';
                EmpName := '';
                NetAmount := 0;
                Email := '';
                Phone := '';
                NetAmount := Loans."Approved Amount" - Loans."Top Up Amount";

                if Cust.Get(Loans."Member No.") then begin

                    EmpCode := Cust."Employer Code";
                    EmpName := Cust."Employer Name";
                    if Cust."Date of Birth" <> 0D then
                        MemberAge := Date2DMY(Today, 3) - Date2DMY(Cust."Date of Birth", 3);

                    Email := Cust."E-Mail";
                    Phone := Cust."Mobile Phone No." + '|' + Cust."Phone No.";

                    if Cust."Old Member No." <> '' then begin

                        if "Old Member No." = '' then begin
                            "Old Member No." := Cust."Old Member No.";
                            Loans.Modify;
                        end;
                    end;
                end;

                MemberDetails[1] := Format(MemberActivities.GetAccountBalance(Legacy.GetShareCapitalAccount("Member No.")));
                MemberDetails[2] := Format(MemberActivities.GetAccountBalanceAsAt(Legacy.GetDepositAccounts("Member No."), AsAt));




            end;

            trigger OnPreDataItem()
            var
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

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        UserSetup.Get(UserId);
        if not UserSetup.Reports then
            Error('You do not have any permissions to access this report. Contact the administrator!');
    end;

    var
        AsAt: Date;
        MemberDetails: array[4] of Text[50];
        MemberActivities: Codeunit "Member Activities";
        Legacy: Codeunit Legacy;
        NetAmount: Decimal;
        UserSetup: Record "User Setup";
        ProductType: Text;
        SecurityType: Text;
        SecurityValue: Decimal;
        EmpCode: Code[20];
        EmpName: Text;
        Email: Text;
        Phone: Text;
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
        MemberAge: Integer;
}

