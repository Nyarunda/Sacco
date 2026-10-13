tableextension 50067 "Account Schedule Ext" extends "Acc. Schedule Name"
{
    fields
    {
        field(90000; "User Group Code"; Code[20])
        {
            Caption = 'User Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "Security Group Member Buffer"."Security Group Code";
        }
    }
    trigger OnInsert()
    var
        UserSetup: Record "User Setup";
    begin

        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Account Schedule", true);
        if not UserSetup.findfirst then
            error('You do not have the permission to Open and Process Account schedules!');
    end;

}
