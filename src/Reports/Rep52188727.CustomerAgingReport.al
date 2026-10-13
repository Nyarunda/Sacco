/// <summary>
/// Report Customer Aging Report (ID 50390).
/// </summary>
report 50390 "Customer Aging Report"
{
    ApplicationArea = All;
    Caption = 'Customer Aging Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Customer Aging Report.rdlc';
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(No; "No.") { }
            column(Name; Name) { }
            column(BalanceLCY; "Balance (LCY)") { }
            column(Amt1; DebAmount[1]) { }
            column(Amt2; DebAmount[2]) { }
            column(Amt3; DebAmount[3]) { }
            column(Amt4; DebAmount[4]) { }
            column(Amt5; DebAmount[5]) { }
            column(Amt6; DebAmount[6]) { }
            column(Amt7; DebAmount[7]) { }
            column(Amt8; DebAmount[8]) { }
            column(Amt9; DebAmount[9]) { }
            column(Amt10; DebAmount[10]) { }
            column(Amt11; DebAmount[11]) { }
            column(Amt12; DebAmount[12]) { }
            //Debits
            column(DAmt1; DebAmount[1]) { }
            column(DAmt2; DebAmount[2]) { }
            column(DAmt3; DebAmount[3]) { }
            column(DAmt4; DebAmount[4]) { }
            column(DAmt5; DebAmount[5]) { }
            column(DAmt6; DebAmount[6]) { }
            column(DAmt7; DebAmount[7]) { }
            column(DAmt8; DebAmount[8]) { }
            column(DAmt9; DebAmount[9]) { }
            column(DAmt10; DebAmount[10]) { }
            column(DAmt11; DebAmount[11]) { }
            column(DAmt12; DebAmount[12]) { }
            trigger OnAfterGetRecord()
            var
                i: Integer;
            begin

                MonthName := '';
                SDate := 0D;
                EDate := 0D;
                SDate := SPeriod;

                for i := 1 TO 12 do begin

                    DebAmount[i] := 0;
                    CrdAmount[i] := 0;

                    DateFilter := '';
                    DateFilter := Format(SDate) + '..' + Format(CalcDate('CM', SDate));

                    SetFilter("Date Filter", DateFilter);
                    CalcFields("Credit Amount (LCY)", "Debit Amount (LCY)");
                    case i of
                        1:
                            begin
                                CrdAmount[1] := Customer."Credit Amount (LCY)";
                                DebAmount[1] := Customer."Debit Amount (LCY)";
                            end;
                        2:
                            begin
                                CrdAmount[2] := Customer."Credit Amount (LCY)";
                                DebAmount[2] := Customer."Debit Amount (LCY)";
                            end;
                        3:
                            begin
                                CrdAmount[3] := Customer."Credit Amount (LCY)";
                                DebAmount[3] := Customer."Debit Amount (LCY)";
                            end;
                        4:
                            begin
                                CrdAmount[4] := Customer."Credit Amount (LCY)";
                                DebAmount[4] := Customer."Debit Amount (LCY)";
                            end;
                        5:
                            begin
                                CrdAmount[5] := Customer."Credit Amount (LCY)";
                                DebAmount[5] := Customer."Debit Amount (LCY)";
                            end;
                        6:
                            begin
                                CrdAmount[6] := Customer."Credit Amount (LCY)";
                                DebAmount[6] := Customer."Debit Amount (LCY)";
                            end;
                        7:
                            begin
                                CrdAmount[7] := Customer."Credit Amount (LCY)";
                                DebAmount[7] := Customer."Debit Amount (LCY)";
                            end;
                        8:
                            begin
                                CrdAmount[8] := Customer."Credit Amount (LCY)";
                                DebAmount[8] := Customer."Debit Amount (LCY)";
                            end;
                        9:
                            begin
                                CrdAmount[9] := Customer."Credit Amount (LCY)";
                                DebAmount[9] := Customer."Debit Amount (LCY)";
                            end;
                        10:
                            begin
                                CrdAmount[10] := Customer."Credit Amount (LCY)";
                                DebAmount[10] := Customer."Debit Amount (LCY)";
                            end;
                        11:
                            begin
                                CrdAmount[11] := Customer."Credit Amount (LCY)";
                                DebAmount[11] := Customer."Debit Amount (LCY)";
                            end;
                        12:
                            begin
                                CrdAmount[12] := Customer."Credit Amount (LCY)";
                                DebAmount[12] := Customer."Debit Amount (LCY)";
                            end;

                    end;

                    SDate := CalcDate('1M', SDate);
                end;

            end;
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

    trigger OnPreReport()
    begin

        if SPeriod = 0D then SPeriod := CalcDate('-CY', Today);

        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
#pragma warning disable AL0432
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432

    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
        DateFilter: Text[50];
        SPeriod: Date;
        SDate: Date;
        EDate: Date;
        OpenBal: Decimal;
        Month: array[12] of Integer;
        MonthName: Text[20];
        DebAmount: array[12] of Decimal;
        CrdAmount: array[12] of Decimal;
        TextError1: Label 'Starting Date is required';
}
