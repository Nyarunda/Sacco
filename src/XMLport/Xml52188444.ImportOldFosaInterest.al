namespace UnitedWomen_Production.UnitedWomen_Production;

xmlport 50088 "Import Old Fosa Interest"
{
    Caption = 'Import Old Fosa Interest';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(OldFosaInterest; "Old Fosa Interest")
            {
                fieldelement(No; OldFosaInterest.No)
                {
                }
                fieldelement(AccountType; OldFosaInterest."Account Type")
                {
                }
                fieldelement(AccountNo; OldFosaInterest."Account No")
                {
                }
                fieldelement(InterestDate; OldFosaInterest."Interest Date")
                {
                }
                fieldelement(InterestRate; OldFosaInterest."Interest Rate")
                {
                }
                fieldelement(InterestAmount; OldFosaInterest."Interest Amount")
                {
                }
                fieldelement(Description; OldFosaInterest.Description)
                {
                }
                fieldelement(ProductFactoryCode; OldFosaInterest."Product Factory Code")
                {
                }
                fieldelement(BalAccountType; OldFosaInterest."Bal. Account Type")
                {
                }
                fieldelement(PayableAccount; OldFosaInterest."Payable Account")
                {
                }
                fieldelement(Blocked; OldFosaInterest.Blocked)
                {
                }
                fieldelement(Status; OldFosaInterest.Status)
                {
                }
                fieldelement(AccountBalance; OldFosaInterest."Account Balance")
                {
                }
                fieldelement(Posted; OldFosaInterest.Posted)
                {
                }
                fieldelement(ExpenseAccount; OldFosaInterest."Expense Account")
                {
                }
                fieldelement(Name; OldFosaInterest.Name)
                {
                }
                fieldelement(OldInterestAmount; OldFosaInterest."Old Interest Amount")
                {
                }
            }
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
}
