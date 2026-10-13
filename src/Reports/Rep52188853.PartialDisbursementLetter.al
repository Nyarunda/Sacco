namespace UnitedWomen.UnitedWomen;
using Microsoft.HumanResources.Employee;
using System.Security.User;
using Microsoft.Foundation.Company;
report 50555 "Partial Disbursement Letter"
{
    ApplicationArea = All;
    Caption = 'Partial Disbursement Letter';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './src/Layouts/PartialDisbursment_.docx';
    dataset
    {
        dataitem(Loans; Loans)
        {
            column(CompanyInformation_CEOSignature; CompanyInformation."CEO Signature") { }
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
            column(Repayment_Start_Date; "Repayment Start Date")
            { }
            column(Loan_Product_Type_Name; LoanTypeDesc)
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
            column(Approved_Amount; "Approved Amount")
            { }
            column(Installments; Installments)
            { }
            column(MemberEmail; MemberEmail)
            { }
            column(Repayment; Repayment)
            { }
            column(FirstName; FirstName)
            { }
            column(Loan_Interest_Repayment; "Loan Interest Repayment")
            { }
            column(Total_Monthly_Repayment; "Total Monthly Repayment")
            { }
            column(GetLastDay; GetLastDay)
            { }
            dataitem("Partial Loans Disb. Header"; "Partial Loans Disb. Header")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                column(PartialLoanNo; "Loan No.")
                {
                }
                column(PartialDisbursementAccNo; "Disbursement Account No")
                {
                }
                column(PartialDisbursementDate; "Posting Date")
                {
                }
                column(PartialDisbursementAmount; "Amount to Disburse")
                {
                }
                column(TotalDisbursed2Date; TotalDisbursed + "Amount to Disburse" + Loans."Amount To Disburse")
                {
                }
                trigger OnAfterGetRecord()
                var
                    PartialHeader: Record "Partial Loans Disb. Header";
                    PartialLoansDisbLine: Record "Partial Loans Disb. Lines";
                begin
                    TotalDisbursed := 0;
                    PartialHeader.Reset();
                    PartialHeader.SetRange("Loan No.", Loans."Loan No.");
                    PartialHeader.SetRange(Status, PartialHeader.Status::Approved);
                    PartialHeader.SetRange(Posted, true);
                    if PartialHeader.FindSet() then begin
                        repeat
                            PartialLoansDisbLine.Reset();
                            PartialLoansDisbLine.SetRange("Header No.", PartialHeader."No.");
                            if PartialLoansDisbLine.FindFirst() then
                                TotalDisbursed += PartialLoansDisbLine."Amount to Disbuse";
                        until PartialLoansDisbLine.Next() = 0;
                    end;

                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SetFilter(Reversed, '%1', false);
                    //SetFilter(Status, '%1', Status::Approved);
                end;
            }
            dataitem("HR Employee Bank Accounts"; "HR Employee Bank Accounts")
            {
                DataItemTableView = sorting("Line No.", "Loan No.");
                DataItemLink = "Loan No." = field("Loan No.");

                column(BankLineNo; BankLineNo)
                {
                }
                column(BankModeOfDisbursement; "Mode of Disbursement")
                {
                }
                column(BankDisbursementAccountNo; "Disbursement Account No.")
                {
                }
                column(BankChequeNo; "Cheque No.")
                {
                }
                column(BankCode; "Bank Code")
                {
                }
                column(BankName; "Bank Name")
                {
                }
                column(BankBranchCode; "Branch Code")
                {
                }
                column(BankBranchName; "Branch Name")
                {
                }
                column(BankAccountNo; "A/C Number")
                {
                }
                column(BankAmountToTransfer; "Amount to Transfer")
                {
                }
                column(BankRemarks; Remarks)
                {
                }
                // Compatibility names for the copied Word table row.
                column(LineNo_Bank; BankLineNo)
                {
                }
                column(PartialDisbursementAmount_Bank; "Amount to Transfer")
                {
                }
                column(PartialRemarks_Bank; Remarks)
                {
                }

                trigger OnPreDataItem()
                var
                    HeaderNoFilter: Text;
                begin

                    SetFilter("Loan No.", HeaderNoFilter);
                    BankLineNo := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    BankLineNo += 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                LoanTopUp: Record "Loan Top Up";
                MemberRec: Record Members;
                MemberAct: Codeunit "Member Activities";
            begin

                LoanTypeDesc := UpperCase(Loans."Loan Product Type Name");
                if Loans."Type of Disbursement" = Loans."Type of Disbursement"::"Partial Disbursement" then
                    LoanTypeDesc := 'PARTIAL ' + UpperCase(Loans."Loan Product Type Name");

                LoanTopUp.Reset();
                LoanTopUp.SetRange("Loan No.", Loans."Loan No.");
                if LoanTopUp.FindFirst() then begin
                    PrincipalTopUp := LoanTopUp."Principle Top Up";
                    TopupInt := LoanTopUp."Total Top Up" - LoanTopUp."Principle Top Up";
                end;

                GetLastDay := CalcDate('CM', Loans."Repayment Start Date");
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
                FirstName := MemberAct.GetMemberFirstName(MemberRec.Name);
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if CompanyInformation.Get() then
                    CompanyInformation.CalcFields("CEO Signature");
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
        CompanyInformation: Record "Company Information";
        PrincipalTopUp: Decimal;
        TopupInt: Decimal;
        CreditOfficerPost: Text;
        CreditOfficerName: Text;
        Employee: Record Employee;
        usersetup: Record "User Setup";
        MemberEmail: Text;
        FirstName: Text;
        GetLastDay: Date;
        TotalDisbursed: Decimal;
        LoanTypeDesc: Text[100];
        BankLineNo: integer;

}

