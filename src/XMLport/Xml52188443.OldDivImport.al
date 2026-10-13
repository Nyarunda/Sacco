namespace UnitedWomen_Production.UnitedWomen_Production;

xmlport 50087 "Old Div Import"
{
    Caption = 'Old Div Import 2024';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(OldDividendProgresion; "Old Dividend Progresion 2024")
            {

                fieldelement(AccountNo; OldDividendProgresion."Account No")
                {

                }
                fieldelement(ProcessingDate; OldDividendProgresion."Processing Date")
                {

                }
                fieldelement(Product; OldDividendProgresion.Product)
                {
                }
                fieldelement(ProductName; OldDividendProgresion."Product Name")
                {
                }
                fieldelement(MemberNo; OldDividendProgresion."Member No")
                {
                }
                fieldelement(QualifyingShares; OldDividendProgresion."Qualifying Shares")
                {
                }
                fieldelement(Shares; OldDividendProgresion.Shares)
                {
                }
                fieldelement(GrossDividends; OldDividendProgresion."Gross Dividends")
                {
                }
                fieldelement(WithHoldingTax; OldDividendProgresion."WithHolding Tax")
                {
                }
                fieldelement(NetDividends; OldDividendProgresion."Net Dividends")
                {
                }
                fieldelement(StartDate; OldDividendProgresion."Start Date")
                {
                }
                fieldelement(EndDate; OldDividendProgresion."End Date")
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
