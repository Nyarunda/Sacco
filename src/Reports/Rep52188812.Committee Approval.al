namespace CentralDB.CentralDB;

report 50494 "Committee Approval"
{
    Caption = 'Committee Approval';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Committee Approval.rdlc';
    dataset
    {

        dataitem(Committee_Approval_Entry; "Committee Approval Entry")
        {
            column(Board_Committee_Members_Approved_By; Committee_Approval_Entry."Approved By")
            {
            }
            column(Board_Committee_Members_Document_No; Committee_Approval_Entry."Document No.")
            {
            }
            column(Board_Committee_Members_Desc; Committee_Approval_Entry."Description 1")
            {
            }
            column(Board_Committee_Members_Sender; Committee_Approval_Entry."Sender ID")
            {
            }
            column(Board_Committee_Members_approve_amt; Committee_Approval_Entry."Document Amount")
            {
            }
            column(Board_Committee_Members_Date_Created; Committee_Approval_Entry."Date Created")
            {
            }
            column(Board_Committee_Members_Date_Approves; Committee_Approval_Entry."Date Approved")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
