xmlport 50017 UploadSTO
{

    Format = VariableText;
    Caption = 'UploadSTO';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(UPG_STO; UPG_STO)
            {
                fieldattribute(No; UPG_STO."No.")
                {
                }
                fieldattribute(SourceAccountNo; UPG_STO."Source Account No.")
                {
                }
                fieldattribute(StandingOrderType; UPG_STO."Standing Order Type")
                {
                }
                fieldattribute(DestinationAccountNo; UPG_STO."Destination Account No.")
                {
                }
                fieldattribute(EffectiveStartDate; UPG_STO."Effective/Start Date")
                {
                }
                fieldattribute(EndDate; UPG_STO."End Date")
                {
                }
                fieldattribute(Duration; UPG_STO."Duration")
                {
                }
                fieldattribute(Frequency; UPG_STO.Frequency)
                {
                }
                fieldattribute(Status; UPG_STO.Status)
                {
                }
                fieldattribute(Description; UPG_STO.Description)
                {
                }
                fieldattribute(Amount; UPG_STO.Amount)
                {
                }
                fieldattribute(BankCode; UPG_STO."Bank Code")
                {
                }
                fieldattribute(NoneSalary; UPG_STO."None Salary")
                {
                }
                fieldattribute(ResponsibilityCenter; UPG_STO."Responsibility Center")
                {
                }
                fieldattribute(BankName; UPG_STO."Bank Name")
                {
                }
                fieldattribute(BankBranch; UPG_STO."Bank Branch")
                {
                }
                fieldattribute(DestinationAccount; UPG_STO."Destination Account")
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
