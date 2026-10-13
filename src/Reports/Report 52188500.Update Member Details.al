
Report 50163 "Update Member Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Update Member Details.rdlc';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*MemberBuffer.RESET;
                MemberBuffer.SETRANGE("Member No",Members."No.");
                MemberBuffer.SETRANGE("Old Member No",Members."Old Member No.");
                IF MemberBuffer.FIND('-') THEN BEGIN
                   IF Members."Date of Birth"=0D THEN
                   Members."Date of Birth":=MemberBuffer.DOB;
                   IF Members."Registration Date"=0D THEN
                   Members."Registration Date":=MemberBuffer."Registration Date";
                   IF Members."ID No."='' THEN
                   Members."ID No.":=MemberBuffer."ID No";
                   Members.MODIFY;
                
                END;
                */
                Accounts.Reset;
                //Accounts.SETRANGE("Old Member No.",Members."Old Member No.");
                Accounts.SetRange("Member No.", Members."No.");
                if Accounts.Find('-') then begin
                    Message('num %1', Members."No.");
                    Accounts.Name := Members.Name;
                    Accounts.Modify;

                end;

            end;

            trigger OnPostDataItem()
            begin
                Message('Done');
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
        MemberBuffer: Record "Member Buffer";
        Accounts: Record "Savings Accounts";
}

