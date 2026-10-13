report 50047 "Move Zero Balance A/C"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Move Zero Balance AC.rdlc';

    dataset
    {
        dataitem(Members; Members)
        {

            trigger OnAfterGetRecord()
            begin
                TotAmnt := 0;
                SA.RESET;
                SA.SETRANGE("Member No.", Members."No.");
                IF SA.FIND('-') THEN BEGIN
                    REPEAT
                        SA.CALCFIELDS(Balance);
                        IF SA."Product Type" <> 'RF' THEN
                            TotAmnt := TotAmnt + SA.Balance;
                    UNTIL SA.NEXT = 0;
                    IF TotAmnt <= 0 THEN BEGIN
                        SA2.RESET;
                        SA2.SETRANGE("Member No.", Members."No.");
                        IF SA2.FIND('-') THEN BEGIN
                            REPEAT
                                SA2."Employer Code" := 'EMPLW101';
                                SA2.MODIFY;
                            UNTIL SA2.NEXT = 0;
                            Members."Employer Code" := 'EMPLW101';
                            Members.MODIFY;
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
        SA: Record "Savings Accounts";
        TotAmnt: Decimal;
        SA2: Record "Savings Accounts";
}

