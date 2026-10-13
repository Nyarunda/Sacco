xmlport 51005 "UPG_Loan Collateral"
{
    Caption = 'UPG_Loan Collateral';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(UPG_LoanCollateral; "UPG_Loan Collateral")
            {
                fieldelement(LoanNo; UPG_LoanCollateral."Loan No.")
                {
                }
                fieldelement(Type; UPG_LoanCollateral."Type")
                {
                }
                fieldelement(SecurityDetails; UPG_LoanCollateral."Security Details")
                {
                }
                fieldelement(Remarks; UPG_LoanCollateral.Remarks)
                {
                }
                fieldelement(Value; UPG_LoanCollateral."Value")
                {
                }
                fieldelement(GuaranteeValue; UPG_LoanCollateral."Guarantee Value")
                {
                }
                fieldelement(MotorVehicleRegistrationNo; UPG_LoanCollateral."Motor Vehicle Registration No")
                {
                }
                fieldelement(TitleDeedNo; UPG_LoanCollateral."Title Deed No.")
                {
                }
                fieldelement(ComittedCollateralValue; UPG_LoanCollateral."Comitted Collateral Value")
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
