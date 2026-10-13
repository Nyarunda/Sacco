Page 50585 "Bulk SMS Lines Part"
{
    PageType = ListPart;
    SourceTable = "Bulk SMS Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TelephoneNo; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Telephone No';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        /*
                     BulkSMSHeader.RESET;
                     BulkSMSHeader.SETRANGE(BulkSMSHeader.No,No);
                     IF BulkSMSHeader.FIND('-') THEN BEGIN
                     //DIMENSION
                     IF BulkSMSHeader."SMS Type"=BulkSMSHeader."SMS Type"::Dimension THEN BEGIN
                     DimensionValue.RESET;
                     DimensionValue.SETRANGE(DimensionValue."Global Dimension No.",2);
                     IF PAGE.RUNMODAL(560,DimensionValue) = ACTION::LookupOK THEN BEGIN
                     Code:=DimensionValue.Code;
                     Description:=DimensionValue.Name;
                     END;

                     END;

                     END;
                        */

                    end;
                }
                field(SmsMessage; Rec."Sms Message")
                {
                    ApplicationArea = Basic;
                }
                field(AccounttoCharge; Rec."Account to Charge")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        BulkSMSHeader: Record "Bulk SMS Header";
        DimensionValue: Record "Dimension Value";
}

