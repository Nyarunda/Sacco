page 50797 "Categories Chart"
{
    Caption = 'Categories Chart';
    PageType = CardPart;
    SourceTable = "Sacco Cues";

    layout
    {
        area(content)
        {
            usercontrol(Chart; "BusinessChart")
            {
                ApplicationArea = Basic;

                trigger AddInReady()
                begin
                    UpdateChart();
                end;

                trigger Refresh()
                begin
                    UpdateChart();
                end;

                trigger DataPointClicked(Point: JsonObject)
                begin
                    // Handle chart data point clicks if needed
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RefreshChart)
            {
                Caption = 'Refresh Chart';
                ApplicationArea = Basic;
                Image = Refresh;

                trigger OnAction()
                begin
                    UpdateChart();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;

        Rec.SetFilter("User Filter", UserId);

        CurrPage.Update(false); // Optional: triggers OnAfterGetRecord
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateChart();
    end;

    local procedure UpdateChart()
    var
        BusinessChartBuffer: Record "Business Chart Buffer" temporary;
        CategoryLabels: array[5] of Text[50];
        CategoryValues: array[5] of Decimal;
        i: Integer;
        HasData: Boolean;
        TotalValue: Decimal;
        ColumnIndex: Integer;
    begin
        CategoryLabels[1] := 'Performing';
        CategoryLabels[2] := 'Watch';
        CategoryLabels[3] := 'Substandard';
        CategoryLabels[4] := 'Doubtful';
        CategoryLabels[5] := 'Loss';

        Rec.CalcFields(Performing, Watch, Substandard, Doubtful, Loss);
        CategoryValues[1] := Rec.Performing;
        CategoryValues[2] := Rec.Watch;
        CategoryValues[3] := Rec.Substandard;
        CategoryValues[4] := Rec.Doubtful;
        CategoryValues[5] := Rec.Loss;

        for i := 1 to 5 do begin
            TotalValue += CategoryValues[i];
            if CategoryValues[i] > 0 then
                HasData := true;
        end;

        if HasData then begin
            BusinessChartBuffer.Initialize();
            BusinessChartBuffer."Chart Type" := BusinessChartBuffer."Chart Type"::Pie;
            BusinessChartBuffer.SetXAxis('Categories', BusinessChartBuffer."Data Type"::String);
#pragma warning disable AL0603
            BusinessChartBuffer.AddMeasure('Value', 1, BusinessChartBuffer."Data Type"::Decimal, BusinessChartBuffer."Chart Type"::Pie);
#pragma warning restore AL0603

            ColumnIndex := 0;
            for i := 1 to 5 do begin
                if CategoryValues[i] > 0 then begin
                    BusinessChartBuffer.AddColumn(CategoryLabels[i]);
                    BusinessChartBuffer.SetValue('Value', ColumnIndex, CategoryValues[i]);
                    ColumnIndex += 1;
                end;
            end;

            BusinessChartBuffer.UpdateChart(CurrPage.Chart);
        end;
    end;

}