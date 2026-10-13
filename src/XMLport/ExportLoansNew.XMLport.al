XmlPort 50031 "Export Loans New"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Loans; SaccoLoans)
            {
                AutoReplace = true;
                AutoUpdate = false;
                XmlName = 'Import_Loans';
                fieldelement(a; Loans."Loan No.")
                {
                    FieldValidate = no;
                }

                fieldelement(az; Loans."Outstanding Balance")
                {
                }
                fieldelement(aa; Loans."Oustanding Interest")
                {
                }
                /*
                fieldelement(b; Loans."Application Date")
                {
                }
                fieldelement(c; Loans."Member No.")
                {
                }
                fieldelement(d; Loans."Loan Product Type")
                {
                    FieldValidate = no;
                }
                fieldelement(e; Loans."Requested Amount")
                {
                    FieldValidate = no;
                }
                fieldelement(f; Loans."Approved Amount")
                {
                    FieldValidate = no;
                }
                fieldelement(g; Loans.Installments)
                {
                }
                fieldelement(h; Loans.Interest)
                {
                }
                fieldelement(i; Loans."Issued Date")
                {
                }
                fieldelement(j; Loans."Loan Account")
                {
                }
                fieldelement(k; Loans."Instalment Period")
                {
                }
                fieldelement(l; Loans."Repayment Method")
                {
                    FieldValidate = no;
                }
                fieldelement(m; Loans."Repayment Frequency")
                {
                }
                fieldelement(n; Loans."Global Dimension 1 Code")
                {
                }
                fieldelement(o; Loans."Branch Code")
                {
                }
                fieldelement(p; Loans."Date Approved")
                {
                }
                fieldelement(q; Loans."Repayment Start Date")
                {
                }
                fieldelement(r; Loans."BOSA No")
                {
                }
                fieldelement(s; Loans."Disbursement Account No")
                {
                }
                fieldelement(t; Loans."Defaulter SMS Date")
                {
                }
                fieldelement(u; Loans."payslip month")
                {
                }
                fieldelement(v; Loans."Sasra Main")
                {
                }
                fieldelement(w; Loans."Sasra Sub I")
                {
                }
                fieldelement(x; Loans."Sasra Sub II")
                {
                }
                fieldelement(y; Loans."Captured By")
                {
                }
                fieldelement(z; Loans."Repay Mode")
                {
                }
                fieldelement(aw; Loans."Outstanding Bal")
                {
                }
                */
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

