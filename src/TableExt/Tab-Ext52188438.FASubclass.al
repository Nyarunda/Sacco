namespace CentralDB.CentralDB;

using Microsoft.FixedAssets.Setup;

tableextension 50082 "FA Subclass" extends "FA Subclass"
{
    fields
    {
        field(90000; "No of years of Depreciation"; DateFormula)
        {
            Caption = 'No of years of Depreciation';
            DataClassification = ToBeClassified;
        }
        field(50013; "Depreciation Rate"; Decimal)
        {
            Caption = 'Depreciation Rate';
            DataClassification = ToBeClassified;
        }
    }
}
