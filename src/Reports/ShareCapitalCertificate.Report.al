Report 50197 "Share Capital Certificate"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Share Capital Certificate.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Date Filter";//removed ,"Loan Product Filter"
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(ShareCap; ShareCap) //---> Share capital
            {
            }
            column(IDNo_Members; Members."ID No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(No_MembersRegister; Members."No.")
            {
            }
            column(current_Date; currentDate)
            {
            }
            column(Name_MembersRegister; Members.Name)
            {
            }
            column(Ordinary_Shares; ordinaryShares)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ShareCap := 0;

                MemberAccounts.Reset();
                MemberAccounts.SetRange("Member No.", Members."No.");
                MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Share Capital");
                if MemberAccounts.FindFirst() then begin
                    MemberAccounts.CalcFields("Balance (LCY)");
                    ShareCap := MemberAccounts."Balance (LCY)";
                end;
                //if ShareCap < 10000 then
                //  Error('Member does not have enough shares');

                ordinaryShares := 0;
                ordinaryShares := ShareCap / 20;
            end;
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
        currentDate := Today;
    end;

    var
        Company: Record "Company Information";
        currentDate: Date;
        ordinaryShares: Decimal;
        ShareCap: Decimal;
        MemberAccounts: Record "Savings Accounts";
}

