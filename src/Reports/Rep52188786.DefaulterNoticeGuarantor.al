report 50468 "Defaulter Notice - Guarantor"
{
    ApplicationArea = All;
    Caption = 'Defaulter Notice - Guarantor';
    DefaultLayout = Word;
    WordLayout = './Layouts/Defaulter Notice - Guarantor.docx';

    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(LSecurity; "Loan Security")
        {
            column(Amount_Guaranteed; "Amount Guaranteed")
            {
            }
            column(Current_Committed; "Current Committed")
            {
            }
            column(CompanyInformation_Picture; CompanyInformation."Letter Head")
            {
            }
            column(Name; Name)
            {
            }
            column(GuarantorEmail; GuarantorEmail)
            { }
            column(CreditOfficerName; CreditOfficerName)
            { }
            column(CreditOfficerPost; CreditOfficerPost)
            { }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Loan No." = field("Loan No.");
                CalcFields = "Total Arrears";

                column(LoanNo; "Loan No.")
                {
                }
                column(MemberNo; "Member No.")
                {
                }
                column(MemberName; "Member Name")
                {
                }
                column(LoanProductTypeName; "Loan Product Type Name")
                {
                }
                column(ApprovedAmount; "Approved Amount")
                {
                }
                column(OutstandingInterest; "Outstanding Interest")
                {
                }
                column(OutstandingPrincipal; "Outstanding Principal")
                {
                }
                column(TotalOutstandingBalance; "Total Outstanding Balance")
                {
                }
                column(DisbursementDate; "Disbursement Date")
                {
                }
                column(Total_Arrears; "Total Arrears")
                {
                }


            }
            trigger OnPreDataItem()
            begin
                CompanyInformation.CalcFields("Letter Head");
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                Amt: Decimal;
                Members: Record Members;
            begin
                Amt := LSecurity."Amount Guaranteed";
                If Members.Get(LSecurity."Member No") then
                    GuarantorEmail := Members."E-Mail";
                usersetup.Reset();
                usersetup.SetRange("Is CEO", true);
                if usersetup.FindFirst() then
                    if Employee.Get(usersetup."Staff No") then begin
                        CreditOfficerName := Employee.FullName();
                        CreditOfficerPost := Employee."Job Title";
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
        CompanyInformation: record "Company Information";
        UserSetup: record "User Setup";
        Employee: record Employee;
        CreditOfficerName: text[100];
        CreditOfficerPost: text[100];
        GuarantorEmail: Text[100];



}
