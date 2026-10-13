namespace UnitedWomen.UnitedWomen;
using System.Security.User;
using Microsoft.HumanResources.Employee;

report 50556 "Lawyer Clearance Letter"
{
    ApplicationArea = All;
    Caption = 'Lawyer Clearance Letter';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './src/Layouts/LawyerClearance.docx';
    dataset
    {
        dataitem(Loans; Loans)
        {
            column(LoanNo; "Loan No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(NetToBeDisbursed; "Net To Be Disbursed")
            {
            }
            column(DisbursementDate; "Disbursement Date")
            {
            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {
            }
            column(TopupInt; TopupInt)
            { }
            column(PrincipalTopUp; PrincipalTopUp)
            { }
            column(CreditOfficerName; CreditOfficerName)
            { }
            column(CreditOfficerPost; CreditOfficerPost)
            { }
            column(Amount_To_Disburse; "Amount To Disburse")
            { }
            column(Installments; Installments)
            { }
            dataitem(Lawyerclearance; "Other Committments Clearance")
            {
                column(Type; Type)
                { }
                column(Description; Description)
                { }
                column(Amount; Amount)
                { }
                column(Account_Name; "Account Name")
                { }
            }
            trigger OnAfterGetRecord()
            var
                LoanTopUp: Record "Loan Top Up";
                MemberRec: Record Members;
            begin
                LoanTopUp.Reset();
                LoanTopUp.SetRange("Loan No.", Loans."Loan No.");
                if LoanTopUp.FindFirst() then begin
                    PrincipalTopUp := LoanTopUp."Principle Top Up";
                    TopupInt := LoanTopUp."Total Top Up" - LoanTopUp."Principle Top Up";

                end;
                usersetup.Reset();
                usersetup.SetRange("Is CEO", true);
                if usersetup.FindFirst() then begin
                    Employee.get(usersetup."Staff No");
                    CreditOfficerName := Employee.FullName();
                    CreditOfficerPost := Employee."Job Title";
                end;
                if MemberRec.get("Member No.") then begin
                    MemberEmail := MemberRec."E-Mail";
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        PrincipalTopUp: Decimal;
        TopupInt: Decimal;
        CreditOfficerPost: Text;
        CreditOfficerName: Text;
        Employee: Record Employee;
        usersetup: Record "User Setup";
        MemberEmail: Text;

}