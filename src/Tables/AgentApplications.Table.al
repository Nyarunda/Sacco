Table 50383 "Agent Applications"
{

    fields
    {
        field(1; "Agent Code"; Code[30])
        {
            Editable = false;
        }
        field(2; "Date Entered"; Date)
        {
            Editable = false;
        }
        field(3; "Time Entered"; Time)
        {
            Editable = false;
        }
        field(4; "Entered By"; Code[30])
        {
            Editable = false;
        }
        field(5; "Document Serial No"; Text[50])
        {
        }
        field(6; "Document Date"; Date)
        {
        }
        field(7; "Customer ID No"; Code[50])
        {
        }
        field(8; Name; Text[200])
        {
        }
        field(9; "Mobile No"; Text[50])
        {

            trigger OnValidate()
            begin
                //
                // SavingsAccounts.RESET;
                // SavingsAccounts.SETRANGE(SavingsAccounts."No.",Account);
                // IF SavingsAccounts.FIND ('-') THEN BEGIN
                // PhoneNumber:=SavingsAccounts."Transactional Mobile No";
                // END;
                //
                // IF (PhoneNumber = '') OR ("Mobile No" <> '') THEN BEGIN
                //  IF COPYSTR("Mobile No",1,4) <> '+254' THEN ERROR('Mobile number must start with +254');
                //  IF STRLEN("Mobile No") < 13 THEN ERROR('Kindly enter a valid mobile number (at least 13 digits)');
                //  SavingsAccounts."Transactional Mobile No" := "Mobile No";
                //  SavingsAccounts."Mobile Phone No" := "Mobile No";
                //  SavingsAccounts."Phone No." := "Mobile No";
                //  SavingsAccounts.MODIFY;
                //  MESSAGE('Savings accounts mobile number have been updated to '+"Mobile No");
                // END;
                //
                // IF (PhoneNumber <> "Mobile No") AND  (PhoneNumber <> '') THEN BEGIN
                //  IF  (COPYSTR(PhoneNumber,1,4) = '+254') AND (STRLEN(PhoneNumber) = 130) AND
                //      (COPYSTR("Mobile No",1,4) = '+254') AND (STRLEN("Mobile No") = 13)
                //  THEN
                //      ERROR('The phone number entered here is not equal to phone number in the account: '+PhoneNumber);
                //
                //  IF (COPYSTR(PhoneNumber,1,4) <> '+254') OR (STRLEN(PhoneNumber) < 13) THEN BEGIN
                //    //Phone number in the savings is faulty
                //    IF COPYSTR("Mobile No",1,4) <> '+254' THEN ERROR('Mobile number must start with +254');
                //    IF STRLEN("Mobile No") < 13 THEN ERROR('Kindly enter a valid mobile number (at least 13 digits)');
                //    SavingsAccounts."Transactional Mobile No" := "Mobile No";
                //    SavingsAccounts."Mobile Phone No" := "Mobile No";
                //    SavingsAccounts."Phone No." := "Mobile No";
                //    SavingsAccounts.MODIFY;
                //    MESSAGE('Savings accounts mobile number have been updated to '+"Mobile No");
                //  END ELSE BEGIN
                //    //Phone number in the savings is not faulty
                //    ERROR('The phone number entered here is not equal to phone number in the account: '+PhoneNumber);
                //  END;
                // END;
            end;
        }
        field(10; Role; Option)
        {
            OptionMembers = Admin,Teller;
        }
        field(11; "Approval Status"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;

            trigger OnValidate()
            begin
                if "Approval Status" = "approval status"::Approved then begin
                    "Date 1st Approval" := Today;
                    "Date Approved" := Today;
                    "Time Approved" := Time;
                    "Approved By" := UserId;
                end else
                    if "Approval Status" = "approval status"::Rejected then begin
                        "Date Rejected" := Today;
                        "Time Rejected" := Time;
                        "Rejected By" := UserId;
                    end;
            end;
        }
        field(12; Comments; Text[200])
        {
        }
        field(13; "Rejection Reason"; Text[30])
        {
        }
        field(14; "Date Approved"; Date)
        {
            Editable = false;
        }
        field(15; "Time Approved"; Time)
        {
            Editable = false;
        }
        field(16; "Approved By"; Code[30])
        {
            Editable = false;
        }
        field(17; "Date Rejected"; Date)
        {
            Editable = false;
        }
        field(18; "Time Rejected"; Time)
        {
            Editable = false;
        }
        field(19; "Rejected By"; Code[30])
        {
            Editable = false;
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
            Editable = false;
        }
        field(23; "Date 1st Approval"; Date)
        {
            Editable = false;
        }
        field(24; "Time First Approval"; Time)
        {
            Editable = false;
        }
        field(25; "Withdrawal Limit Code"; Code[20])
        {

        }
        field(26; "Withdrawal Limit Amount"; Decimal)
        {
        }
        field(27; Account; Code[30])
        {
            TableRelation = Vendor."No." where("Product Category" = const("Agent Float"));

            trigger OnValidate()
            begin
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."No.", Account);
                if SavingsAccounts.FindFirst then begin
                    SavingsAccounts.calcfields("ID No.");
                    "Customer ID No" := SavingsAccounts."ID No.";
                    Name := SavingsAccounts.Name;

                    Members.Get(SavingsAccounts."Member No.");
                    "Date of Birth" := Members."Date of Birth";
                    if "Mobile No" = '' then "Mobile No" := Members."Mobile Phone No.";

                    if CopyStr("Mobile No", 1, 4) <> '+254' then Error('Mobile number must start with +254');
                    if StrLen("Mobile No") <> 13 then Error('Kindly enter a valid mobile number (at least 13 digits)');

                    if "Mobile No" = '' then Error('Kindly update the user''s phone number on the savings account');
                end;
            end;
        }
        field(28; "Name of the Proposed Agent"; Text[200])
        {
        }
        field(29; "Date of Birth"; Date)
        {
        }
        field(30; "Type of Business"; Text[200])
        {
        }
        field(31; "Place of Business"; Text[50])
        {
        }
        field(32; "Business/Work Experience"; Text[100])
        {
        }
        field(33; "Name of Banker"; Text[50])
        {
        }
        field(34; "PIN(KRA)"; Code[30])
        {
        }
        field(35; Branch; Boolean)
        {
        }
        field(36; NewApps; Integer)
        {
        }
        field(37; "Comm Account"; Code[30])
        {
            Editable = true;
            TableRelation = Vendor."No." where("Product Category" = const("Agent Commission"));

            trigger OnValidate()
            begin
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."No.", Account);
                /*
                IF SavingsAccounts.FIND ('-') THEN BEGIN
                "Customer ID No":=SavingsAccounts."ID No.";
                Name:=SavingsAccounts.Name;
                "Mobile No":=SavingsAccounts."Phone No.";
                "Date of Birth":=SavingsAccounts."Date of Birth";
                MODIFY;
                END;
                */

            end;
        }
        field(38; "Internal Agent"; Boolean)
        {
        }
        field(39; "Agent No"; Code[30])
        {
        }
        field(40; "Document No"; Code[30])
        {
        }
        field(41; "Date Sent"; Date)
        {
            Editable = false;
        }
        field(42; "Time Sent"; Time)
        {
            Editable = false;
        }
        field(43; Status; Option)
        {
            OptionMembers = "New PIN Sent";
        }
        field(44; "Teller Account"; Code[20])
        {
            TableRelation = "Bank Account"."No." where("Bank Type" = const(Cashier));
        }
        field(45; "Device ID"; Text[200])
        {
        }
        field(46; "Is Admin"; Boolean)
        {
            Editable = false;
        }
        field(47; "Last Updated By"; Code[50])
        {
            Editable = false;
        }
        field(48; "Last Update On"; DateTime)
        {
            Editable = false;
        }
        field(49; "Device IMEI"; Text[50])
        {
        }
        field(50; "Device Serial No"; Text[50])
        {
        }
        field(51; "Device Make"; Text[50])
        {
        }
        field(52; "Device Model"; Text[50])
        {
        }
        field(53; "Software ID"; Text[50])
        {
        }
        field(54; "Processor ID"; Text[50])
        {
        }
        field(55; "App Environment"; Text[50])
        {
        }
        field(56; "Float Balance"; Decimal)
        {
            CalcFormula = - sum("Savings Ledger Entry"."Amount (LCY)" where("Account No." = field(Account)));
            FieldClass = FlowField;
        }
        field(57; "Commision Balance"; Decimal)
        {
            CalcFormula = - sum("Savings Ledger Entry"."Amount (LCY)" where("Account No." = field("Comm Account")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Agent Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        // IF "Approval Status"<>"Approval Status"::Open THEN BEGIN
        // ERROR(Text001);
        // END;
    end;

    trigger OnInsert()
    var
        AgApp: Record "Agent Applications";
        ErrOpen: label 'An open application %1 still exists. Please utilize it before proceeding.';
    begin
        AgApp.Reset;
        AgApp.SetRange("Approval Status", AgApp."approval status"::Open);
        if AgApp.FindLast then
            Error(ErrOpen, AgApp."Agent Code");


        GeneralSetUp.Get;
        GeneralSetUp.TestField(GeneralSetUp."Agency No Series");
        //RandomizeNoSeriesIncrementNo(GeneralSetUp."Agency No Series");
        if "Agent Code" = '' then begin
            NoSeries.GetNextNo(GeneralSetUp."Agency No Series", WorkDate(), true);
        end;


        "Entered By" := UserId;
        "Date Entered" := Today;
        "Time Entered" := Time;
    end;

    trigger OnModify()
    begin
        // IF "Approval Status"<>"Approval Status"::Open THEN BEGIN
        // ERROR(Text000);
        // END;
    end;

    var
        GeneralSetUp: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        SavingsAccounts: Record "Savings Accounts";
        Text000: label 'Only Open agent applications can be modified';
        Text001: label 'Deletion of agent applications is not allowed';
        PhoneNumber: Text[20];
        Members: Record Members;

    local procedure RandomizeNoSeriesIncrementNo(AgencyNoSeries: Code[10])
    var
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
        PadStrInt: Integer;
    begin
        NoSeries.Get(AgencyNoSeries);
        NoSeriesLine.Reset;
        NoSeriesLine.SetRange("Series Code", NoSeries.Code);
        if NoSeriesLine.FindFirst then
            repeat
                NoSeriesLine."Increment-by No." := GetRandomNumber(100000, 200000);
                //PadStrInt := GetPadstrInt(NoSeriesLine."Starting No.");
                NoSeriesLine."Last No. Used" := PadStr(NoSeriesLine."Last No. Used", PadStrInt) + Format(GetRandomNumber(100000, 200000) * Random(2));
                NoSeriesLine.Modify;
            until NoSeriesLine.Next = 0;
    end;

    local procedure GetRandomNumber(StartingNo: Integer; EndingNo: Integer): Integer
    var
        RandomNo: Integer;
        CanExit: Boolean;
    begin
        CanExit := false;
        repeat
            Randomize();
            RandomNo := Random(200000);
            CanExit := (RandomNo >= StartingNo) and (RandomNo <= EndingNo);
        until CanExit;
        exit(RandomNo);
    end;

    local procedure GetPadstrInt(StringInput: Text): Integer
    var
        Txt: Text;
        no: Integer;
        output: Integer;
    begin
        // foreach Txt in StringInput do begin
        //     if not Evaluate(no, Txt) then
        //         output += 1;
        // end;

        // exit(output);
    end;
}

