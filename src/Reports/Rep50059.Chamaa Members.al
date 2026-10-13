namespace UnitedWomen_Production.UnitedWomen_Production;

report 50059 "Chamaa Members"
{
    Caption = 'Chamaa Members';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Chamaa Members.rdlc';
    UsageCategory = ReportsandAnalysis;
    dataset
    {
        dataitem(Members; "Account Signatories.")
        {
            column(No; "Code")
            {
            }
            column(ID_No_; "ID No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Date_Of_Birth; "Date Of Birth")
            {
            }
            column(Signatory; Signatory)
            {
            }
            column(Staff_Payroll; "Staff/Payroll")
            {
            }
            column(Position; Position)
            {
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

    labels
    {
        PreparedBy = 'Prepared by :...........................................................Date :.............................          Signature :..............................................';

        ApprovedBy = 'Approved by :...........................................................Date :.............................          Signature :...............................................';

    }
}
