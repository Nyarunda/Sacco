report 50051 "Close Dormant Savings 0 bal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Close Dormant Savings 0 bal.rdlc';

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            CalcFields = Balance;
            DataItemTableView = WHERE(Status = CONST(Dormant));

            trigger OnAfterGetRecord()
            begin
                "Savings Accounts".CALCFIELDS("Savings Accounts".Balance);
                IF "Savings Accounts".Balance = 0 THEN BEGIN
                    ProdFac.GET("Savings Accounts"."Product Type");
                    IF ProdFac."Product Class" = ProdFac."Product Class"::Savings THEN BEGIN
                        IF ("Savings Accounts"."Product Category" <> "Savings Accounts"."Product Category"::"Deposit Contribution") AND
                          ("Savings Accounts"."Product Category" <> "Savings Accounts"."Product Category"::"Mfi Deposit") AND
                          ("Savings Accounts"."Product Category" <> "Savings Accounts"."Product Category"::"Registration Fee") AND
                          ("Savings Accounts"."Product Category" <> "Savings Accounts"."Product Category"::"Share Capital") AND
                          ("Savings Accounts"."Product Category" <> "Savings Accounts"."Product Category"::"Unallocated Fund") THEN BEGIN
                            "Savings Accounts".Status := "Savings Accounts".Status::Closed;
                            "Savings Accounts".MODIFY;
                        END;
                    END;
                END;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('COMPLETED');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ProdFac: Record "Product Setup";
}

