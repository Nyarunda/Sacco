Table 55016 "ATM Card Applications"
{

    fields
    {
        field(1; "Account No"; Code[19])
        {


        }
        field(2; "Branch Code"; Code[10])
        {
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(3; "Account Type"; Option)
        {
            OptionCaption = 'Savings,Current';
            OptionMembers = Savings,Current;

            trigger OnValidate()
            begin
                /*IF "Receipt Journal Batch"="Receipt Journal Batch"::"0" THEN
                "Account Type C":='05'
                ELSE
                "Account Type C":='04'
                   */

            end;
        }
        field(4; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(5; "Address 1"; Text[35])
        {
        }
        field(6; "Address 2"; Text[35])
        {
        }
        field(7; "Address 3"; Text[35])
        {
        }
        field(8; "Address 4"; Text[35])
        {
        }
        field(9; "Address 5"; Text[35])
        {
        }
        field(10; "Customer ID"; Code[10])
        {

            trigger OnValidate()
            begin
                /*  "Account No":=' ';
                  "Account Name":=' ';
                  "Phone No.":=' ';
                  "Application Date":=0D;
                  */

                Account.Reset;
                Account.SetRange(Account."ID No.", "Customer ID");
                Account.SetFilter(Account."Product Type", '0102');
                if Account.Find('-') then begin
                    "Account No" := Account."No.";
                    "Account Name" := Account.Name;
                    "Phone No." := Account."Phone No.";
                    "Address 1" := Account."Post Code" + ' ' + Account.City;
                    "Address 2" := Account.City;
                    "Application Date" := WorkDate;

                end;


                if "Card No" = '' then begin
                    "Card No" := '42993391';
                    StrTel := CopyStr("Card No", 1, 8);
                end;

            end;
        }
        field(11; "Relation Indicator"; Option)
        {
            OptionCaption = 'Primary,Suplimentary';
            OptionMembers = Primary,Suplimentary;

            trigger OnValidate()
            begin
                /*IF "Default Payment Bank"="Default Payment Bank"::"0" THEN
                "Relation Indicator C":='P'
                ELSE
                "Relation Indicator C":='S'
                   */

            end;
        }
        field(12; "Card Type"; Text[30])
        {
        }
        field(13; "Request Type"; Option)
        {
            OptionCaption = 'New,Replacement,Re-Pin';
            OptionMembers = New,Replacement,"Re-Pin",Supplementary;

            trigger OnValidate()
            begin
                if "Request Type" = "request type"::New then begin
                end;
                if "Request Type" = "request type"::Replacement then
                    TestField("Replacement For Card No");
            end;
        }
        field(14; "Application Date"; Date)
        {
        }
        field(15; "Card No"; Code[30])
        {
        }
        field(16; "Date Issued"; Date)
        {
        }
        field(17; Limit; Decimal)
        {
        }
        field(18; "Terms Read and Understood"; Boolean)
        {
        }
        field(19; "Card Issued"; Boolean)
        {
        }
        field(20; "Form No"; Code[30])
        {
        }
        field(21; "Sent To External File"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(22; "Card Status"; Option)
        {
            OptionMembers = Pending,Active,Frozen;
        }
        field(23; "Date Activated"; Date)
        {
        }
        field(24; "Date Frozen"; Date)
        {
        }
        field(27; "Replacement For Card No"; Code[20])
        {
        }
        field(28; "Has Other Accounts"; Boolean)
        {
        }
        field(29; "Account Type C"; Code[2])
        {
        }
        field(30; "Relation Indicator C"; Code[1])
        {
        }
        field(31; "Request Type C"; Code[1])
        {
        }
        field(32; "Account No C"; Code[19])
        {
        }
        field(33; "Phone No."; Code[20])
        {

            trigger OnValidate()
            begin

                /*IF "Phone No."<>'' THEN BEGIN
                StrTel:=COPYSTR("Phone No.",1,4);
                
                
                IF StrTel<>'+254' THEN BEGIN
                ERROR('The MPESA Mobile Phone No. should be in the format +254XXXYYYZZZ.');
                END;
                
                IF STRLEN("Phone No.")<>13 THEN BEGIN
                ERROR('Invalid MPESA mobile phone number. Please enter the correct mobile phone number.');
                END;
                END;
                    */

            end;
        }
        field(34; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                /*IF "No." <> xRec."No." THEN BEGIN
                  SalesSetup.GET;
                  NoSeriesMgt.TestManual(SalesSetup."ATM Applications");
                  "No. Series" := '';
                END;
                 */

            end;
        }
        field(35; "No. Series"; Code[10])
        {
        }
        field(36; Collected; Boolean)
        {
        }
        field(37; "Application Approved"; Boolean)
        {
        }
        field(38; "Date Collected"; Date)
        {
        }
        field(39; "Card Issued By"; Code[50])
        {
        }
        field(40; "Approval Date"; Date)
        {
        }
        field(41; "Captured By"; Code[30])
        {
        }
        field(42; "Confirm receipt from co op"; Boolean)
        {

            trigger OnValidate()
            begin
                "Date received from co op" := 0D;
                if "Confirm receipt from co op" = true then
                    "Date received from co op" := Today;
            end;
        }
        field(43; "Date received from co op"; Date)
        {
        }
        field(44; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;

        }
        field(45; "Responsibility Center"; Code[10])
        {
            //TableRelation = "Responsibility Center BR";
        }
        field(46; "Card Expiry Date"; Date)
        {
        }
        field(47; "Card Linked"; Boolean)
        {
        }
        field(48; "Card Linked By"; Code[30])
        {
        }
        field(49; "Pin Issued"; Boolean)
        {
        }
        field(50; "Pin Issued By"; Code[30])
        {
        }
        field(51; "Card Delinked By"; Code[30])
        {
        }
        field(52; "Check No/Payroll No"; Code[20])
        {

            trigger OnValidate()
            begin
                Account.Reset;
                Account.SetRange(Account."Payroll/Staff No", "Check No/Payroll No");
                Account.SetFilter(Account."Product Type", '0102');
                if Account.Find('-') then begin
                    "Account No" := Account."No.";
                    "Account Name" := Account.Name;
                    "Phone No." := Account."Phone No.";
                    "Address 1" := Account."Post Code" + ' ' + Account.City;
                    "Address 2" := Account.City;
                    "Application Date" := WorkDate;

                end;


                if "Card No" = '' then begin
                    "Card No" := '42993391';
                    StrTel := CopyStr("Card No", 1, 8);
                end;
            end;
        }

        field(53; "Mobile Application"; Boolean)
        {
            Caption = 'Mobile Application';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Account No", "Relation Indicator")
        {
        }
        key(Key3; "Application Date", "Account No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if "Application Approved" then
            Error('Cannot delete an approved ATM Application');
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin

        end;


        "Account Type C" := '05';
        "Relation Indicator C" := 'P';
        "Request Type C" := 'N';
        "Application Date" := Today;
    end;

    var
        Account: Record "SACCO Account";
        StrTel: Text[30];
        ChargeAmount: Decimal;
        MinBal: Decimal;
}

