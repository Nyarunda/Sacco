namespace CentralDB.CentralDB;

using Microsoft.FixedAssets.FixedAsset;

tableextension 50083 File_21 extends "FA Posting Group"
{
    fields
    {
        field(50000; "Depreciation Rate"; Decimal)
        {
            Caption = 'Depreciation Rate';
            DataClassification = ToBeClassified;
        }
    }
}
