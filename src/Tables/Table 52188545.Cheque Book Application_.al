
Table 50208 "Cheque Book Application_"
{
    //DrillDownPageID = UnknownPage51532133;
    //LookupPageID = UnknownPage51532133;

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    Noseries.TestManual(SalesSetup."Cheque Application Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Account No."; Code[20])
        {
            TableRelation = Vendor."No." where("Product Category" = filter(Business));

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."No.", "Account No.");
                if Vend.Find('-') then begin
                    //Vend.TESTFIELD(Vend."Member No.");
                    Name := Vend.Name;
                    "ID No." := Vend."ID No.";
                    //"Staff No.":=Vend."Payroll/Staff No.";
                    "Member No." := Vend."Member No.";
                    "Cheque Account No." := Vend."Cheque Account No.";

                    //for existing cheque book holders
                    Translation.Reset;
                    Translation.SetRange(Translation."Member No", Vend."Member No.");
                    if Translation.Find('-') then begin
                        "Cheque Account No." := "Cheque Account No.";
                        "Translation Code" := Translation.Code;
                    end else begin

                        //for new cheque book applicants
                        Translation.Reset;
                        Translation.SetRange(Translation.Used, false);
                        if Translation.Find('-') then begin
                            "Cheque Account No." := '2' + Translation.Code + '1025';
                            "Translation Code" := Translation.Code;
                            Translation."Cheque Account No" := "Cheque Account No.";
                            Translation."Member No" := Vend."Member No.";
                            Translation."Member Name" := Vend.Name;
                            Translation.Used := true;
                            Translation.Modify;
                        end;


                    end;
                end else begin
                    Error('Member no. not found');
                end;

                /*
                IF Vend.GET("Account No.")  THEN BEGIN
                IF Vend."ChqAcount Number" = '' THEN BEGIN
                IF acctypes.GET(Vend."Account Type") THEN BEGIN
                //LASTNUMBER:=acctypes.ChqNumbers;
                acctypes.ChqNumbers:=INCSTR(acctypes.ChqNumbers);
                acctypes.MODIFY;
                END;
                Vend."ChqAcount Number":=LASTNUMBER;
                IF "Cheque Account No." = '' THEN BEGIN
                "Cheque Account No.":=Vend."ChqAcount Number";
                MODIFY;
                END;
                Vend.MODIFY;
                END;
                END;
                 */

            end;
        }
        field(3; Name; Text[50])
        {
        }
        field(4; "ID No."; Code[20])
        {
        }
        field(5; "Application Date"; Date)
        {
        }
        field(6; "Cheque Account No."; Code[20])
        {
        }
        field(7; "Staff No."; Code[20])
        {
        }
        field(8; "Export Format"; Code[10])
        {
        }
        field(9; "No. Series"; Code[10])
        {
        }
        field(10; "Member No."; Code[10])
        {
        }
        field(11; "Responsibility Centre"; Code[20])
        {
        }
        field(12; "Begining Cheque No."; Code[60])
        {

            trigger OnValidate()
            begin
                ChequeSetUp.Reset;
                ChequeSetUp.SetRange(ChequeSetUp."Cheque Code", "Cheque Book Type");
                if ChequeSetUp.Find('-') then begin

                    Evaluate(BeginNo, "Begining Cheque No.");
                    Evaluate(NoofLF, Format(ChequeSetUp."Number Of Leaf"));
                    "End Cheque No." := Format(BeginNo + NoofLF - 1);
                end;


                /*Chqreg.RESET;
                Chqreg.SETRANGE("Cheque No.","Begining Cheque No.");
                Chqreg.SETRANGE("Account No.","Cheque Account No.");
                IF Chqreg.FIND('-') THEN
                ERROR('That cheque range has been used');*/

                if StrLen("Begining Cheque No.") <> 6 then
                    Error('Must be 6 characters');

            end;
        }
        field(13; "End Cheque No."; Code[60])
        {

            trigger OnValidate()
            begin
                /*Chqreg.RESET;
                Chqreg.SETRANGE("Cheque No.","End Cheque No.");
                Chqreg.SETRANGE("Account No.","Cheque Account No.");
                IF Chqreg.FIND('-') THEN
                ERROR('That cheque range has been used');*/

            end;
        }
        field(14; "Application Exported"; Boolean)
        {
        }
        field(15; "Cheque Register Generated"; Boolean)
        {
            Editable = false;
        }
        field(16; Select; Boolean)
        {

            trigger OnValidate()
            begin
                if "Cheque Book charges Posted" = false then
                    Error('Please Post Cheque book charges before exporting');
            end;
        }
        field(17; "Cheque Book charges Posted"; Boolean)
        {
            Editable = false;
        }
        field(18; "Cheque Book Type"; Code[10])
        {
            TableRelation = "Cheque Set Up_";

            trigger OnValidate()
            begin
                ChApp.Reset;
                ChApp.SetRange(ChApp."Account No.", "Account No.");
                ChApp.SetRange(ChApp.Status, ChApp.Status::Approved);
                if ChApp.Find('+') then begin
                    "Begining Cheque No." := IncStr(ChApp."End Cheque No.");

                end;


                //VALIDATE("Begining Cheque No.");
            end;
        }
        field(68005; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(68006; "Last check"; Code[30])
        {
            CalcFormula = max("Cheques Register_"."Cheque No." where("Account No." = field("Account No.")));
            FieldClass = FlowField;
        }
        field(68007; "Transaction Type"; Code[20])
        {
            TableRelation = "Transaction Charges".Code where(Type = const("Cheque Application"));
        }
        field(68008; "Translation Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Cheque Application Nos");
            "No." := Noseries.GetNextNo(SalesSetup."Cheque Application Nos", WorkDate(), true);
        end;

        "Application Date" := Today;


        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            //UserSetup.TESTFIELD(UserSetup."Responsibility Centre");
            //"Responsibility Centre":=UserSetup."Responsibility Centre";
        end;
    end;

    trigger OnModify()
    begin

        // IF Status=Status::Approved THEN BEGIN
        if "Cheque Register Generated" = true then;
    end;

    var
        Vend: Record "Savings Accounts";
        Noseries: Codeunit "No. Series";
        SalesSetup: Record "Sales & Receivables Setup";
        acctypes: Record "Product Setup";
        LASTNUMBER: Code[60];
        ChequeSetUp: Record "Cheque Setup";
        "number of leafs": Code[20];
        ChApp: Record "Cheque Book Application_";
        BeginNo: Integer;
        NoofLF: Integer;
        UserSetup: Record "User Setup";
        Chqreg: Record "Cheques Register_";
        Translation: Record "Data Translation";
}

