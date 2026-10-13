namespace CentralDB.CentralDB;

using Microsoft.FixedAssets.Setup;

pageextension 50136 "fa subclass" extends "FA Subclasses"
{
    layout
    {
        addafter("Default FA Posting Group")
        {
            field("No of years of Depreciation"; Rec."No of years of Depreciation")
            {
                ApplicationArea = Basic;
            }
            field("Depreciation Rate"; Rec."Depreciation Rate")
            {
                ApplicationArea = Basic;
            }

        }
    }
}
