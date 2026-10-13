namespace CentralDB.CentralDB;

report 50417 "Collateral Return"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Collateral Return.rdlc';
    UsageCategory = ReportsandAnalysis;
    dataset
    {
        dataitem(CollateralCollection; "Collateral Collection")
        {
            DataItemTableView = where("Inward/Outward" = const(Returned));

            column(No_; "No.")
            {
            }
            column(AccountName; "Account Name")
            {
            }
            column(AccountNo; "Account No.")
            {
            }
            column(ChargedValue; "Charged Value")
            {
            }
            column(ClearedBy; "Cleared By")
            {
            }
            column(Collateral; Collateral)
            {
            }
            column(CollateralDetails; "Collateral Details")
            {
            }
            column(CollateralLimit; "Collateral Limit")
            {
            }
            column(CollateralMultiplier; "Collateral Multiplier")
            {
            }
            column(CollateralName; "Collateral Name")
            {
            }
            column(CollateralNo; "Collateral No.")
            {
            }
            column(CollateralPerfected; "Collateral Perfected")
            {
            }
            column(CollateralType; "Collateral Type")
            {
            }
            column(CollateralValue; "Collateral Value")
            {
            }
            column(CollectionStatus; "Collection Status")
            {
            }
            column(CollectorIDNo; "Collector ID No")
            {
            }
            column(CollectorName; "Collector Name")
            {
            }
            column(CollectorPhoneNo; "Collector Phone No.")
            {
            }
            column(DateCollected; "Date Collected")
            {
            }
            column(DateReOpened; "Date Re-Opened")
            {
            }
            column(ForcedSaleValue; "Forced Sale Value")
            {
            }
            column(LegallyCleared; "Legally Cleared")
            {
            }
            column(Narration; Narration)
            {
            }
            column(Status; Status)
            {
            }
            column(Mark_For_Collection; "Mark For Collection")
            {
            }
            column(Next_Valuation_Date; "Next Valuation Date")
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
}
