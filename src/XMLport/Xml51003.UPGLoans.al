xmlport 51003 UPG_Loans
{
    Caption = 'UPG_Loans';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(UPG_Loans; UPG_Loans)
            {
                fieldelement(LoanNo; UPG_Loans."Loan No.")
                {
                }
                fieldelement(ClientCode; UPG_Loans."Client Code")
                {
                }
                fieldelement(ClientName; UPG_Loans."Client Name")
                {
                }
                fieldelement(LoanProductType; UPG_Loans."Loan Product Type")
                {
                }
                fieldelement(LoanProductTypeName; UPG_Loans."Loan Product Type Name")
                {
                }
                fieldelement(ApplicationDate; UPG_Loans."Application Date")
                {
                }
                fieldelement(RequestedAmount; UPG_Loans."Requested Amount")
                {
                }
                fieldelement(ApprovedAmount; UPG_Loans."Approved Amount")
                {
                }
                fieldelement(Interest; UPG_Loans.Interest)
                {
                }
                fieldelement(LoanStatus; UPG_Loans."Loan Status")
                {
                }
                fieldelement(IssuedDate; UPG_Loans."Issued Date")
                {
                }
                fieldelement(Installments; UPG_Loans.Installments)
                {
                }
                fieldelement(LoanDisbursementDate; UPG_Loans."Loan Disbursement Date")
                {
                }
                fieldelement(LastPayDate; UPG_Loans."Last Pay Date")
                {
                }
                fieldelement(RepaymentStartDate; UPG_Loans."Repayment Start Date")
                {
                }
                fieldelement(RepaymentFrequency; UPG_Loans."Repayment Frequency")
                {
                }
                fieldelement(RepaymentMethod; UPG_Loans."Repayment Method")
                {
                }
                fieldelement(OutstandingBalance; UPG_Loans."Outstanding Balance")
                {
                }
                fieldelement(OustandingInterest; UPG_Loans."Oustanding Interest")
                {
                }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
