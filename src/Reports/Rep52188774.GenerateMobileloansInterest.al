report 50456 "Generate Mobile loans Interest"
{
    Caption = 'Generate Mobile loans Interest';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Mobile Loan" = const(true), "Loan Product Type" = filter(<> 'L43' & <> 'L30'));
            RequestFilterFields = "Disbursement Date", "Member No.", "Loan No.", "Loan Product Type", "Mobile Loan";

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                Members: Record Members;
            begin
                if loans."Schedule Start Date" > Today then
                    CurrReport.skip();

                Members.Reset();
                Members.setrange("No.", Loans."Member No.");
                Members.Setrange("Member Status", Members."Member Status"::Deceased);
                if Members.findfirst() then
                    CurrReport.Skip();

                Sky.GenerateMobileLoanInterest(Loans."Loan No.", BillDate, PDate);
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin

                SaccoActivities.PostMobileLoanInterest();
            end;
        }
    }
    requestpage
    {
        layout
        {

            area(content)
            {
                field("Interest Date"; BillDate)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; PDate)
                {
                    ApplicationArea = Basic;
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
    var
        Sky: Codeunit "Sky MBanking";
        SaccoActivities: Codeunit "Sacco Activities";
        BillDate: Date;
        PDate: Date;
}
