XmlPort 50032 "Import Sacco accounts"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("SACCO Account"; SaccoAccounts)
            {
                XmlName = 'Savings';
                fieldelement(a; "SACCO Account"."No.")
                {
                }
                fieldelement(b; "SACCO Account".Name)
                {
                }
                fieldelement(c; "SACCO Account"."Phone No.")
                {
                }
                fieldelement(e; "SACCO Account"."Global Dimension 1 Code")
                {
                }
                fieldelement(f; "SACCO Account"."Global Dimension 2 Code")
                {
                }
                fieldelement(g; "SACCO Account"."Customer Posting Group")
                {
                }
                fieldelement(h; "SACCO Account"."Customer Type")
                {
                }
                fieldelement(i; "SACCO Account".Status)
                {
                }
                fieldelement(j; "SACCO Account"."Savings Account")
                {
                }
                fieldelement(k; "SACCO Account"."Payroll/Staff No")
                {
                }
                fieldelement(l; "SACCO Account"."ID No.")
                {
                }
                fieldelement(m; "SACCO Account"."Mobile Phone No")
                {
                }
                fieldelement(n; "SACCO Account"."Account Category")
                {
                }
                fieldelement(o; "SACCO Account"."MPESA Mobile No")
                {
                }
                fieldelement(p; "SACCO Account"."Product Type")
                {
                }
                fieldelement(q; "SACCO Account"."Product Name")
                {
                }
                fieldelement(r; "SACCO Account"."Account Product Category")
                {
                }
                fieldelement(s; "SACCO Account".Blocked)
                {
                }
                fieldelement(t; "SACCO Account"."Member No.")
                {
                }
                fieldelement(u; "SACCO Account"."Loan Disbursement Account")
                {
                }
                fieldelement(v; "SACCO Account"."Employer Code")
                {
                }
                fieldelement(w; "SACCO Account".Blocked)
                {
                }
                fieldelement(x; "SACCO Account"."Balance (LCY)")
                {
                }
                fieldelement(y; "SACCO Account"."Registration Date")
                {
                }
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

