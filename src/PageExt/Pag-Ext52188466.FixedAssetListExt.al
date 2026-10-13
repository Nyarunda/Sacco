namespace UnitedWomen_Production.UnitedWomen_Production;

using Microsoft.FixedAssets.FixedAsset;

pageextension 50129 "Fixed Asset List Ext" extends "Fixed Asset List"
{
    layout
    {
        addafter("FA Location Code")
        {
            field("Book Value"; Rec."Book Value")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

