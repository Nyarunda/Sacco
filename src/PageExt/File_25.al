namespace CentralDB.CentralDB;

using Microsoft.FixedAssets.FixedAsset;

pageextension 50137 File_25 extends "FA Posting Groups"
{
    layout
    {

        addafter("Depreciation Expense Acc.")
        {
            field("Depreciation Rate"; Rec."Depreciation Rate")
            {
                ApplicationArea = Basic;
            }
        }
    }
}
