report 51134 "Posted Member Changes Log"
{
    ApplicationArea = All;
    Caption = 'Posted Member Changes Log';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/PostedMemberChangesLog.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(MemberChanges; "Member Changes")
        {
            DataItemTableView = sorting(Code) where(Posted = const(true));
            RequestFilterFields = "Member No.", Date, "Entered By";

            column(MembershipNumber; "Member No.") { }
            column(MembershipName; Name) { }
            column(ReasonForChange; "Reason For Change") { }
            column(DateEffected; Date) { }
            column(UserID; "Entered By") { }
            column(GeneratedBy; UserId) { }
            column(GeneratedDateTime; Format(CurrentDateTime)) { }
        }
    }
}
