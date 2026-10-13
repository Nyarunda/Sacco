
Report 50332 "Loan Appraisal List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Appraisal List.rdlc';

    dataset
    {

        dataitem(Appraisal; "Member Salary Appraisal")
        {
            dataitem(Loans; Loans)
            {
                RequestFilterFields = "Loan No.", "Application Date", "Loan Product Type", "Member No.", Source;
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

                trigger OnAfterGetRecord()
                begin

                    sno += 1;
                    EmpCode := '';
                    EmpName := '';
                    if Cust.Get(Loans."Member No.") then begin
                        EmpCode := Cust."Employer Code";
                        EmpName := Cust."Employer Name";

                        if Cust."Old Member No." <> '' then begin

                            if "Old Member No." = '' then begin
                                "Old Member No." := Cust."Old Member No.";
                                Loans.Modify;
                            end;
                        end;
                    end;

                    if "Loan Account" = '' then begin
                        "Loan Account" := "Loan Product Type" + '-' + "Member No.";
                        Modify();
                    end;

                    RO := Cust."Relationship Officer Name";
                    BranchCode := Cust."Global Dimension 2 Code";

                    SecurityType := '';
                    SecurityValue := 0;
                    LoanSec.Reset();
                    LoanSec.SetRange("Loan No.", "Loan No.");
                    LoanSec.SetRange("Guarantor Type", LoanSec."Guarantor Type"::Collateral);
                    LoanSec.SetFilter("Amount Guaranteed", '>0');
                    if LoanSec.FindFirst() then begin
                        SecurityType := 'Collateral';
                        repeat
                            SecurityValue += LoanSec."Available Guarantorship";
                        until LoanSec.Next() = 0;
                    end
                    else begin
                        LoanSec.Reset();
                        LoanSec.SetRange("Loan No.", "Loan No.");
                        LoanSec.SetRange("Guarantor Type", LoanSec."Guarantor Type"::Guarantor);
                        LoanSec.SetFilter("Amount Guaranteed", '>0');
                        if LoanSec.FindFirst() then begin
                            SecurityType := 'Guarantor';
                            repeat
                                SecurityValue += LoanSec."Available Guarantorship";
                            until LoanSec.Next() = 0;
                        end;
                    end;



                    /*
                    ProdFac.GET(Loans."Loan Product Type");
                    Loans.Interest := ProdFac."Interest Rate (Max.)";
                    Loans."Monthly Interest" := Loans.Interest/12;
                    Loans.MODIFY;
                    */

                    if day <> 0 then begin
                        if Loans."Disbursement Date" <> 0D then begin
                            if day <> Date2dmy(Loans."Disbursement Date", 1) then
                                CurrReport.Skip;
                        end
                        else
                            CurrReport.Skip;
                    end;

                    /*
                    RSchedule.RESET;
                    RSchedule.SETRANGE("Loan No.",Loans."Loan No.");
                    RSchedule.SETFILTER("Repayment Date",'<>%1',0D);
                    IF RSchedule.FINDLAST THEN
                      IF Loans."Completion Date"<>RSchedule."Repayment Date" THEN BEGIN
                          Loans."Completion Date":=RSchedule."Repayment Date";
                          Loans.MODIFY;
                    END;
                    */

                    BridgeAmt := 0;
                    TopUp.Reset;
                    TopUp.SetRange("Loan No.", Loans."Loan No.");
                    TopUp.SetRange("Member No.", Loans."Member No.");
                    if TopUp.FindFirst then begin
                        TopUp.CalcSums("Total Top Up");
                        BridgeAmt := TopUp."Total Top Up";
                    end;

                    if Loans.Source = Loans.Source::MICRO then begin
                        Members.Get(Loans."Member No.");
                        Loans."Group Code" := Members."Group No.";
                        Loans.Modify;
                    end;

                end;
            }
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

