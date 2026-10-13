namespace CentralDB.CentralDB;

report 50418 "GFE Members"
{
    DefaultLayout = RDLC;
    Caption = 'Next of Kin';
    RDLCLayout = './src/Layouts/GFE Members.rdlc';
    UsageCategory = ReportsandAnalysis;
    dataset
    {
        dataitem(Members; Members)
        {
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            dataitem(NextofKin; "Next of Kin.")
            {
                DataItemLink = "No." = field("No.");
                column(ID_No_; "ID No.")
                {

                }
                column(Mobile_Phone_No_; "Mobile Phone No.")
                {

                }
                column(Relationship; Relationship)
                {

                }
                column(Beneficiary; Beneficiary)
                {

                }
                column(Email; Email)
                {

                }
                column(Date_of_Birth; "Date of Birth")
                {

                }
                column(KinName; NextofKin.Name)
                {

                }
                column(Allocation; "%Allocation")
                {
                }
                column(Deceased; Deceased)
                {
                }
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
