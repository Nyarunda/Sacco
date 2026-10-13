
Table 50281 "MBanking Applications"
{
    DrillDownPageID = "MBanking Application List";
    LookupPageID = "MBanking Application List";

    fields
    {
        field(1; No; Code[30])
        {
        }
        field(2; "Date Entered"; Date)
        {
        }
        field(3; "Time Entered"; Time)
        {
        }
        field(4; "Entered By"; Code[40])
        {
        }
        field(5; "Document Serial No"; Text[50])
        {
        }
        field(6; "Document Date"; Date)
        {
        }
        field(7; "Customer ID No"; Code[50])
        {

            trigger OnValidate()
            begin
                "Customer ID No" := DelChr("Customer ID No", '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|+|-|_');

                //FieldLength("Customer ID No",10);
            end;
        }
        field(8; "Customer Name"; Text[200])
        {

            trigger OnValidate()
            begin

                /*
                "Customer Name":=DELCHR("Customer Name",'=','0|1|2|3|4|5|6|7|8|9|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|-|+|_|~');
                //FieldLength("MPESA Mobile No",10);
                */

            end;
        }
        field(9; "MPESA Mobile No"; Text[50])
        {
            Editable = true;

            trigger OnValidate()
            begin

                ValidateInternationalPhoneNo("MPESA Mobile No");


                /*
                
                "MPESA Mobile No":=DELCHR("MPESA Mobile No",'=','A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|-');
                 FieldLength("MPESA Mobile No",13);
                */

            end;
        }
        field(10; "MPESA Corporate No"; Code[30])
        {
        }
        field(11; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(12; Comments; Text[200])
        {
        }
        field(13; "Rejection Reason"; Text[30])
        {
        }
        field(14; "Date Approved"; Date)
        {
        }
        field(15; "Time Approved"; Time)
        {
        }
        field(16; "Approved By"; Code[30])
        {
        }
        field(17; "Date Rejected"; Date)
        {
        }
        field(18; "Time Rejected"; Time)
        {
        }
        field(19; "Rejected By"; Code[30])
        {
        }
        field(20; "Sent To Server"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(21; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(22; "1st Approval By"; Code[30])
        {
        }
        field(23; "Date 1st Approval"; Date)
        {
        }
        field(24; "Time First Approval"; Time)
        {
        }
        field(26; "Withdrawal Limit Amount"; Decimal)
        {
        }
        field(27; "Application Type"; Option)
        {
            OptionMembers = Initial,Change,Additional;

            trigger OnValidate()
            begin
                if "Application Type" = "application type"::Initial then begin
                    if "Application No" <> '' then begin
                        Error('Please ensure the application number field is blank if the application is not a change application.');
                    end;
                end;
            end;
        }
        field(28; "Application No"; Code[30])
        {
            TableRelation = "MBanking Applications".No where(Status = const(Approved));

            trigger OnValidate()
            begin

                if "Application Type" <> "application type"::Change then begin
                    Error('The application must be a change application before selecting this option.');
                end;

                MPESAApp.Reset;
                MPESAApp.SetRange(MPESAApp.No, "Application No");
                if MPESAApp.Find('-') then begin
                    "Old Telephone No" := MPESAApp."MPESA Mobile No";
                    "Document Serial No" := MPESAApp."Document Serial No";
                    "Customer ID No" := MPESAApp."Customer ID No";
                    "Customer Name" := MPESAApp."Customer Name";
                    "Membership No" := MPESAApp."Membership No";
                    "Country/Region Code" := MPESAApp."Country/Region Code";
                    "Phone Code" := MPESAApp."Phone Code";
                    "MPESA Mobile No" := MPESAApp."MPESA Mobile No";

                end
                else begin

                    "Old Telephone No" := '';

                end;

                MPESAAppDetails.Reset;
                MPESAAppDetails.SetRange(MPESAAppDetails."Application No", No);
                if MPESAAppDetails.Find('-') then begin
                    repeat
                        MPESAAppDetails.Delete;
                    until MPESAAppDetails.Next = 0
                end;


                MPESAAppDetails.Reset;
                MPESAAppDetails.SetRange(MPESAAppDetails."Application No", "Application No");
                if MPESAAppDetails.Find('-') then begin
                    repeat

                        MPESAAppDet2.Reset;
                        MPESAAppDet2.Init;
                        MPESAAppDet2."Application No" := No;
                        MPESAAppDet2."Account Type" := MPESAAppDetails."Account Type";
                        MPESAAppDet2."Account No." := MPESAAppDetails."Account No.";
                        MPESAAppDet2.Description := MPESAAppDetails.Description;
                        MPESAAppDet2.Insert;

                    until MPESAAppDetails.Next = 0
                end;
            end;
        }
        field(29; Changed; Option)
        {
            OptionMembers = No,Yes;
        }
        field(30; "Date Changed"; Date)
        {
        }
        field(31; "Time Changed"; Time)
        {
        }
        field(32; "Changed By"; Code[30])
        {
        }
        field(33; "Old Telephone No"; Code[30])
        {
        }
        field(34; "I agree information is true"; Boolean)
        {
        }
        field(35; "App Status"; Option)
        {
            OptionMembers = Pending,"1st Approval",Approved,Rejected;
        }
        field(37; "Virtual Registration"; Boolean)
        {
        }
        field(38; "Membership No"; Code[30])
        {
            TableRelation = Members;
        }
        field(39; "Account No"; Code[80])
        {
            TableRelation = "Savings Accounts" where("Product Category" = const("Ordinary Savings"));

            trigger OnValidate()
            var
                MBankingApp: record "MBanking Applications";
            begin

                SavingsAccount.Reset;
                SavingsAccount.SetRange(SavingsAccount."No.", "Account No");
                if SavingsAccount.Find('-') then begin

                    if StrLen(SavingsAccount."Transactional Mobile No") = 13 then
                        if "Application Type" = "application type"::Initial then
                            Error('Transactional Phone No: %1 already linked to this account', SavingsAccount."Transactional Mobile No");

                    MBankingApp.Reset();
                    MBankingApp.SetRange("Account No", "Account No");
                    MBankingApp.SetFilter(Status, '<>%1', MBankingApp.status::Approved);
                    MBankingApp.SetFilter("Application Type", '%1', MBankingApp."Application Type"::Initial);
                    if MBankingApp.FindLast() then Error('There is an existing application with Transactional Phone No: %1 already linked to this account', SavingsAccount."Transactional Mobile No");

                    Members.Reset;
                    Members.SetRange(Members."No.", SavingsAccount."Member No.");
                    if Members.Find('-') then begin

                        if "Application Type" = "application type"::Initial then
                            AppendMobile := Members."Mobile Phone No."
                        else
                            AppendMobile := SavingsAccount."Transactional Mobile No";


                        /*
                        Length := StrLen(AppendMobile);
                        if Length = 10 then begin
                            AppendMobile := '+254' + CopyStr(AppendMobile, 2, 9);
                        end
                        else begin
                            AppendMobile := '+254' + CopyStr(AppendMobile, 4, 12);
                        end;
                        */

                        "Customer ID No" := Members."ID No.";
                        if "Customer ID No" = '' then
                            "Customer ID No" := Members.Passport;
                        if Members."Country/Region Code" <> '' then
                            Validate("Country/Region Code", Members."Country/Region Code");
                        "MPESA Mobile No" := AppendMobile;
                        "Customer Name" := SavingsAccount.Name;

                    end;


                    MPESAAppDet2.Reset;
                    MPESAAppDet2.SetRange(MPESAAppDet2."Application No", No);
                    if MPESAAppDet2.Find('-') then begin

                        //ERROR('FOUND');

                        MPESAAppDet2."Account Type" := MPESAAppDet2."Account Type";
                        MPESAAppDet2."Account No." := "Account No";
                        MPESAAppDet2.Description := "Customer Name";
                        MPESAAppDet2.Modify(true);

                    end

                    else begin

                        MPESAAppDet2.Init;
                        MPESAAppDet2."Application No" := No;
                        MPESAAppDet2."Account Type" := 1;
                        MPESAAppDet2."Account No." := "Account No";
                        MPESAAppDet2.Description := "Customer Name";
                        MPESAAppDet2.Insert;

                    end;

                end;
            end;
        }
        field(40; Delinked; Boolean)
        {
        }
        field(41; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                CountryRegion: Record "Country/Region";
            begin
                "Phone Code" := '';
                if "Country/Region Code" = '' then
                    exit;

                CountryRegion.Get("Country/Region Code");
                CountryRegion.TestField("Phone Code Format");
                CountryRegion.TestField("Mobile Phone. No. Length");
                "Phone Code" := CountryRegion."Phone Code Format";

                if ("MPESA Mobile No" = '') or ("MPESA Mobile No" = xRec."Phone Code") then
                    "MPESA Mobile No" := "Phone Code"
                else
                    Validate("MPESA Mobile No");
            end;
        }
        field(42; "Phone Code"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin


        /*
        IF Status<>Status::Open THEN BEGIN
        ERROR('You cannot delete the MPESA transaction because it has already been sent for first approval.');
        END;
        */

    end;

    trigger OnInsert()
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin

            if UserSetup."Max. Open Documents" > 0 then begin
                MPESAApp.Reset();
                MPESAApp.SetRange("Entered By", UserId);
                MPESAApp.SetRange(Status, MPESAApp.Status::Open);
                if MPESAApp.FindFirst() then
                    if MPESAApp.Count > UserSetup."Max. Open Documents" then
                        Error('You are not allowed to open multiple documents. Complete %1 first.', MPESAApp.No);

            end;
        end;

        if No = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."Mbanking Application Nos");
            No := NoSeries.GetNextNo(NoSetup."Mbanking Application Nos", WorkDate(), true);
        end;


        "Entered By" := UserId;
        "Date Entered" := Today;
        "Time Entered" := Time;
    end;

    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        MPESAApp: Record "MBanking Applications";
        MPESAAppDetails: Record "MBanking Lines";
        MPESAAppDet2: Record "MBanking Lines";
        SavingsAccount: Record "Savings Accounts";
        AppendMobile: Text[30];
        Members: Record Members;
        Length: Integer;
        UserSetup: Record "User setup";


    procedure FieldLength(VarVariant: Text; FldLength: Integer): Text
    var
        FieldLengthError: label 'Field cannot be more than %1 Characters.';
    begin
        if StrLen(VarVariant) > FldLength then
            Error(FieldLengthError, FldLength);
    end;

    local procedure ValidateInternationalPhoneNo(PhoneNo: Text[50])
    var
        CountryRegion: Record "Country/Region";
        i: Integer;
        CodeLength: Integer;
        PhoneDigit: Text[1];
        TestPhone: Text[50];
    begin
        PhoneNo := DelChr(PhoneNo, '=', ' ');

        if PhoneNo = '' then
            exit;

        TestField("Country/Region Code");
        CountryRegion.Get("Country/Region Code");
        CountryRegion.TestField("Phone Code Format");
        CountryRegion.TestField("Mobile Phone. No. Length");
        CodeLength := StrLen(CountryRegion."Phone Code Format");

        if CopyStr(PhoneNo, 1, CodeLength) <> CountryRegion."Phone Code Format" then
            Error('Invalid MPESA Mobile No. Country phone code %1 is required.', CountryRegion."Phone Code Format");

        if StrLen(PhoneNo) <> CountryRegion."Mobile Phone. No. Length" then
            Error('Invalid MPESA Mobile No. Length should be %1.', CountryRegion."Mobile Phone. No. Length");

        if "Phone Code" = '+254' then
            TestPhone := DelChr(UpperCase(PhoneNo), '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|-|_')
        else
            TestPhone := DelChr(UpperCase(PhoneNo), '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|_');

        if TestPhone <> PhoneNo then
            Error('Invalid MPESA Mobile No. Invalid character detected.');

        for i := 2 to StrLen(PhoneNo) do begin
            PhoneDigit := CopyStr(PhoneNo, i, 1);
            if not (PhoneDigit in ['0' .. '9']) then begin
                if not ((i = 1) and (PhoneDigit = '+')) then
                    Error('Invalid MPESA Mobile No. Only digits are allowed after the + sign.');
            end;
        end;
    end;
}

