report 50190 "Member Listing"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Member Listing.rdlc';
    Caption = 'Member Listing';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Members)
        {
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(IDNo; "ID No.")
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(MobilePhoneNo; "Mobile Phone No.")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(LastDepositDateBF; "Last Deposit Date BF")
            {
            }
            column(RegistrationDate; "Registration Date")
            {
            }
            column(Type; "Type")
            {
            }
            column(Status; Status)
            {
            }
            column(MemberStatus; "Member Status")
            {
            }
            column(MemberCategory; "Member Category")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Deposits; Deposits)
            {
            }
            column(ShareCap; ShareCap)
            {
            }
            column(FreeShares; FreeShares)
            {
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("Member No.");
                DataItemTableView = where("Outstanding Principal" = filter(> 0));
                column(ReportForNavId_50; 50)
                {
                }
                column(Total_Outstanding_Balance; "Total Outstanding Balance")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", "No.");
                if MemberAccounts.FindFirst then begin
                    repeat
                        if MemberAccounts."Product Category" = MemberAccounts."product category"::"Deposit Contribution" then begin
                            Deposits := MemberActivities.GetAccountBalance(MemberAccounts."No.");

                            LoanSecurity.CalculateAvailableShares(MemberAccounts, DepAmt, GuaranteedInApplication, Committed, Available, false);
                            FreeShares := Available;
                        end;
                        if MemberAccounts."Product Category" = MemberAccounts."product category"::"Share Capital" then
                            ShareCap := MemberActivities.GetAccountBalance(MemberAccounts."No.");

                        if MemberAccounts."Product Category" = MemberAccounts."product category"::"Dividend Account" then
                            Dividend := MemberActivities.GetAccountBalance(MemberAccounts."No.");

                    until MemberAccounts.Next = 0;
                end;
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
        Text000: label 'Overdue Amounts (LCY) as of %1';
        ProdType: Record "Product Setup";
        MinBalance: Decimal;
        MemberActivities: Codeunit "Member Activities";
        AvailBalance: Decimal;
        Deposits: Decimal;
        ShareCap: Decimal;
        FreeShares: Decimal;
        LoanSecurity: Record "Loan Security";
        MemberAccounts: Record "Savings Accounts";
        SaccoActivities: Codeunit "Sacco Activities";
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Dividend: Decimal;
        Committed: Decimal;
        Available: Decimal;

}
