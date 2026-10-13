Report 50267 "Cashier Branch Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Cashier Branch Summary.rdlc';

    dataset
    {
        dataitem(TransType; "Transaction Charges")
        {
            DataItemTableView = where("Product Type" = filter(<> ' '));
            column(ReportForNavId_25; 25)
            {
            }
            column(Code_TransType; TransType.Code)
            {
            }
            column(Type_TransType; TransType.Type)
            {
            }
            column(ProductType_TransType; TransType."Product Type")
            {
            }
            column(DFilter; DFilter)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            dataitem(Dim; "Dimension Value")
            {
                DataItemTableView = where("Global Dimension No." = const(2));
                column(ReportForNavId_24; 24)
                {
                }
                column(Code_DimensionValue; Dim.Code)
                {
                }
                column(Name_DimensionValue; Dim.Name)
                {
                }
                dataitem(Dimension; "Dimension Value")
                {
                    DataItemLink = Code = field(Code);
                    DataItemTableView = where("Global Dimension No." = const(2));
                    column(ReportForNavId_26; 26)
                    {
                    }
                    column(RCount; RCount)
                    {
                    }
                    column(RAmt; RAmt)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        NoOfProgressed: Integer;
                    begin

                        RCount := 0;
                        RAmt := 0;


                        CashTrans.Reset;
                        CashTrans.SetRange("Global Dimension 2 Code", DimCode);
                        CashTrans.SetRange("Transaction Date", SDate, EDate);
                        CashTrans.SetRange("Transaction Type", TType);
                        CashTrans.SetRange(Posted, true);
                        if CashTrans.Find('-') then begin
                            repeat
                                RCount += 1;
                                RAmt += CashTrans.Amount;
                            until CashTrans.Next = 0;
                        end;
                    end;

                    trigger OnPostDataItem()
                    var
                        Txt0001: label 'Auto Recovery Successful';
                    begin
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    NoOfProgressed: Integer;
                begin
                    DimCode := Dim.Code;
                end;

                trigger OnPostDataItem()
                var
                    Txt0001: label 'Auto Recovery Successful';
                begin
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TType := TransType.Code;
            end;

            trigger OnPreDataItem()
            begin
                DFilter := Format(SDate) + '..' + Format(EDate);
                if SDate = EDate then
                    DFilter := Format(SDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; SDate)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; EDate)
                {
                    ApplicationArea = Basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
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
        DFilter: Text;
        SDate: Date;
        EDate: Date;
        SavAcc: Record "Savings Accounts";
        RCount: Integer;
        RAmt: Decimal;
        CashTrans: Record "Teller Transaction";
        TType: Code[20];
        DimCode: Code[10];
}

