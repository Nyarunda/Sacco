report 50352 "FOSA Inteerest Summary"
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/Layouts/FosaInterestSummary.rdl';
    dataset
    {
        dataitem("FOSA Interest Header"; "FOSA Interest Header")
        {

            dataitem(productsetup; "product setup")
            {
                DataItemTableView = where("Product Class" = filter(Savings));
                column(ProductID; productsetup."Product ID")
                {

                }
                column(ProductDescription; productsetup.Description)
                {

                }
                column(TotalInterest; TotalInterest)
                {

                }

                trigger OnAfterGetRecord()
                begin
                    TotalInterest := 0;

                    FosaIntLines.RESET;
                    FosaIntLines.SETFILTER("Header No", HeaderNo);
                    FosaIntLines.SetRange("Saving Product", "Product ID");
                    IF FosaIntLines.FindFirst() then begin
                        repeat
                            TotalInterest += FosaIntLines.Amount;
                        until FosaIntLines.NEXT = 0;
                    end;

                    if TotalInterest = 0 then
                        CurrReport.Skip();

                end;

            }

            trigger OnAfterGetRecord()
            begin
                HeaderNo := No;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
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
        FosaIntLines: Record "FOSA Interest Lines";
        SearchDate: Date;
        TotalInterest: Decimal;
        HeaderNo: Code[20];

}
