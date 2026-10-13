report 50378 "Modify Description Ledger Ent"
{
    ApplicationArea = All;
    Caption = 'Modify Description Ledger Ent';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Modify_Ledgers.rdlc';
    dataset
    {
        dataitem(GLEntry; "G/L Entry")
        {
            DataItemTableView = where("G/L Account No." = filter('22120'));
            RequestFilterFields = "Document No.";
            column(DocumentNo; "Document No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Amount; Amount)
            {
            }
            column(GLEDescription; GLEDescription) { }

            trigger OnAfterGetRecord()
            var
                VLE: Record "Savings Ledger Entry";
                Customer: Record "Savings Accounts";
                GLE: Record "G/L Entry";
            begin
                VLE.Reset();
                VLE.SetRange("Document No.", GLEntry."Document No.");
                if VLE.FindFirst() then begin
                    repeat
                        CustName := '';
                        if Customer.get(VLE."Account No.") then
                            CustName := Customer.Name;

                        GLE.Reset();
                        GLE.SetRange("Document No.", GLEntry."Document No.");
                        GLE.SetFilter(Description, '%1', 'Tax');
                        if GLE.FindFirst() then begin
                            GLEDescription := '';
                            // GLE.Description
                            GLEDescription := StrSubstNo('Tax' + '-' + CustName);
                            GLE.Description := GLEDescription;
                            GLE.Modify();

                        end;

                    until VLE.Next() = 0;
                end;

            end;

            trigger OnPreDataItem()
            begin
                Setfilter(Description, 'Tax');
            end;
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

    var
        CustName: Text;
        GLEDescription: Text;
}
