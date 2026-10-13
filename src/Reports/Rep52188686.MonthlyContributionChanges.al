report 50349 "Monthly Contribution Changes"
{
    Caption = 'Monthly Contribution Changes';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/MonthlyContributionChanges.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Vendor; "Savings Accounts")
        {
            DataItemTableView = where("Contribution Updated By" = filter(<> ''));
            RequestFilterFields = "Product Category", "Contribution Updated By";
            column(No; "No.")
            {

            }
            column(Name; Name)
            {

            }
            column(ProductType; "Product Type")
            {

            }
            column(ProductName; "Product Name")
            {

            }
            column(ProductCategory; "Product Category")
            {

            }
            column(Old_Amount; "Old Amount")
            {

            }
            column(MonthlyContribution; "Monthly Contribution")
            {

            }
            column(Payroll_Staff_No_; "Payroll/Staff No.")
            {
            }
            column(Repay_Mode; "Repay Mode")
            {

            }
            column("Change_Balance"; "Change Balance")
            {

            }
            column(Current_Balance; balance)
            {

            }
            column(Cummulative_Contribution; "Cummulative Contribution")
            {

            }
            column(MonthlyContributionDate; "Monthly Contribution Date")
            {

            }
            column(ContributionUpdatedBy; "Contribution Updated By")
            {
            }
            column(LastDateChanged; LastDateChanged)
            {
            }
            trigger OnAfterGetRecord()
            var
                MemberChanges: Record "Member Changes";
                Members: Record Members;
            begin
                LastDateChanged := 0DT;
                "Old Amount" := 0;

                MemberChanges.Reset();
                MemberChanges.SetRange("Account No.", Vendor."No.");
                MemberChanges.SetRange("Created Date Time", StartDate, EndDate);
                if MemberChanges.FindLast() then begin
                    "Old Amount" := MemberChanges."Monthly Contribution";
                    LastDateChanged := MemberChanges."Created Date Time";
                end;

                if Members.Get("Contribution Updated By") then
                    "Contribution Updated By" := Members.Name;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group("Date Filters")
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
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
    var

        StartDate: DateTime;
        EndDate: DateTime;
        LastDateChanged: DateTime;
}
