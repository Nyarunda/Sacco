namespace CentralDB.CentralDB;

using Microsoft.Finance.GeneralLedger.Journal;

tableextension 50559 "Gen. Journal Batch Ext" extends "Gen. Journal Batch"
{
    fields
    {
        field(90000; Status; Enum "Approval Status Enum")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
    }
}
