
Table 50177 "Cheque Book Application"
{

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;

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
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." where("Product Category" = filter(" "));

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."No.", "Account No.");
                if Vend.Find('-') then begin
                    Vend.TestField(Vend."Member No.");
                    Name := Vend.Name;
                    "ID No." := Vend."ID No.";
                    //"Staff No.":=Vend."Payroll/Staff No.";
                    "Member No." := Vend."Member No.";
                    "Cheque Account No." := Vend."Cheque Account No.";

                    /*
                    //for existing cheque book holders
                    Translation.RESET;
                    Translation.SETRANGE(Translation."Member No",Vend."Member No.");
                    IF Translation.FIND('-') THEN BEGIN
                      "Cheque Account No.":="Cheque Account No.";
                      "Translation Code":=Translation.Code;
                      END ELSE BEGIN

                    //for new cheque book applicants
                    Translation.RESET;
                    Translation.SETRANGE(Translation.Used,FALSE);
                    IF Translation.FIND('-') THEN BEGIN
                    "Cheque Account No.":='2'+Translation.Code+'1025';
                      "Translation Code":=Translation.Code;
                      Translation."Cheque Account No":="Cheque Account No.";
                      Translation."Member No":=Vend."Member No.";
                      Translation."Member Name":=Vend.Name;
                      Translation.Used:=TRUE;
                      Translation.MODIFY;
                        END;


                     END;
                     */
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
            DataClassification = ToBeClassified;
        }
        field(4; "ID No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Cheque Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Staff No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Export Format"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Member No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Responsibility Centre"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(12; "Begining Cheque No."; Code[60])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*ChequeSetUp.RESET;
                ChequeSetUp.SETRANGE(ChequeSetUp."Cheque Code","Cheque Book Type");
                IF ChequeSetUp.FIND('-') THEN BEGIN
                
                EVALUATE(BeginNo,"Begining Cheque No.");
                EVALUATE(NoofLF,ChequeSetUp."Number Of Leaf");
                "End Cheque No.":=FORMAT(BeginNo+NoofLF);
                END;
                */

                /*
                Chqreg.RESET;
                Chqreg.SETRANGE("Cheque No.","Begining Cheque No.");
                Chqreg.SETRANGE("Account No.","Cheque Account No.");
                IF Chqreg.FIND('-') THEN
                ERROR('That cheque range has been used');
                */

            end;
        }
        field(13; "End Cheque No."; Code[60])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                Chqreg.RESET;
                Chqreg.SETRANGE("Cheque No.","End Cheque No.");
                Chqreg.SETRANGE("Account No.","Cheque Account No.");
                IF Chqreg.FIND('-') THEN
                ERROR('That cheque range has been used');
                */

            end;
        }
        field(14; "Application Exported"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Cheque Register Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; Select; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Cheque Book charges Posted" = false then
                    Error('Please Post Cheque book charges before exporting');
            end;
        }
        field(17; "Cheque Book charges Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Cheque Book Type"; Code[10])
        {
            DataClassification = ToBeClassified;

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
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(68006; "Last check"; Code[30])
        {
            //FieldClass = FlowField;
        }
        field(68007; "Transaction Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(68008; "Translation Code"; Code[20])
        {
            DataClassification = ToBeClassified;
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

        end;
    end;

    var
        Vend: Record "Savings Accounts";
        Noseries: Codeunit "No. Series";
        SalesSetup: Record "Sales & Receivables Setup";
        acctypes: Record "Product Setup";
        LASTNUMBER: Code[60];
        ChequeSetUp: Record "Cheque Setup";
        "number of leafs": Code[20];
        ChApp: Record "Cheque Book Application";
        BeginNo: Integer;
        NoofLF: Integer;
        UserSetup: Record "User Setup";
        Chqreg: Record "Cheque Return Codes";
}

