Table 50084 "Loan Disbursement Header"
{
    DrillDownPageID = "Loan Disbursement List";
    LookupPageID = "Loan Disbursement List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Description = 'Stores the reference of the payment voucher in the database';
            NotBlank = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    MembNoSeries.Get;
                    NoSeries.TestManual(MembNoSeries."Loan Batch Nos");
                    "No. Series" := '';

                end;
            end;
        }
        field(2; Date; Date)
        {
            Description = 'Stores the date when the payment voucher was inserted into the system';
        }
        field(3; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(4; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(5; Posted; Boolean)
        {
            Description = 'Stores whether the payment voucher is posted or not';
        }
        field(6; "Date Posted"; Date)
        {
            Description = 'Stores the date when the payment voucher was posted';
            Editable = false;
        }
        field(7; "Time Posted"; Time)
        {
            Description = 'Stores the time when the payment voucher was posted';
            Editable = false;
        }
        field(8; "Posted By"; Code[50])
        {
            Description = 'Stores the name of the person who posted the payment voucher';
            Editable = false;
        }
        field(9; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Loan Disbursement Lines"."Disbursement Amount" where(No = field("No.")));
            Description = 'Stores the amount of the payment voucher';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                /*IF xRec."Global Dimension 1 Code"<>'' THEN BEGIN
                  DisbLines.RESET;
                  DisbLines.SETRANGE(DisbLines.No,"No.");
                  IF DisbLines.FIND('-') THEN BEGIN
                    IF CONFIRM('There are lines already generated. The change will result in deletion of lines. Are you sure you want to delete?',FALSE)=TRUE THEN BEGIN
                     REPEAT
                      IF LoanApp.GET(DisbLines."Loan No.") THEN BEGIN
                        LoanApp."Already Suggested":=FALSE;
                        LoanApp.MODIFY;
                        DisbLines.DELETE;
                      END;
                    UNTIL DisbLines.NEXT=0;
                    END ELSE
                    EXIT;
                  END;
                END;
                */

            end;
        }
        field(11; Status; Option)
        {
            Description = 'Stores the status of the record in the database';
            Editable = true;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(12; "Payment Type"; Option)
        {
            OptionMembers = Normal,"Petty Cash";
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                /*IF xRec."Global Dimension 2 Code"<>'' THEN BEGIN
                  DisbLines.RESET;
                  DisbLines.SETRANGE(DisbLines.No,"No.");
                  IF DisbLines.FIND('-') THEN BEGIN
                    IF CONFIRM('There are lines already generated. The change will result in deletion of lines. Are you sure you want to delete?',FALSE)=TRUE THEN BEGIN
                     REPEAT
                      IF LoanApp.GET(DisbLines."Loan No.") THEN BEGIN
                        LoanApp."Already Suggested":=FALSE;
                        LoanApp.MODIFY;
                        DisbLines.DELETE;
                      END;
                    UNTIL DisbLines.NEXT=0;
                    END ELSE
                    EXIT;
                  END;
                END;
                */

            end;
        }
        field(14; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(15; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin
                /*
                TESTFIELD(Status,Status::Pending);
                IF NOT UserMgt.CheckRespCenter(1,"Responsibility Center") THEN
                  ERROR(
                    Text001,
                    RespCenter.TABLECAPTION,UserMgt.GetPurchasesFilter);
                 {
                "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
                IF "Location Code" = '' THEN BEGIN
                  IF InvtSetup.GET THEN
                    "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
                END ELSE BEGIN
                  IF Location.GET("Location Code") THEN;
                  "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
                END;
                
                UpdateShipToAddress;
                   }
                   {
                CreateDim(
                  DATABASE::"Responsibility Center","Responsibility Center",
                  DATABASE::Vendor,"Pay-to Vendor No.",
                  DATABASE::"Salesperson/Purchaser","Purchaser Code",
                  DATABASE::Campaign,"Campaign No.");
                
                IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
                  RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
                  "Assigned User ID" := '';
                END;
                  }
                   */

            end;
        }
        field(16; "No of Loans"; Integer)
        {
            CalcFormula = count("Loan Disbursement Lines" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Posting Remarks"; Text[50])
        {
        }
        field(18; "Loan Product Type"; Code[20])
        {
            TableRelation = "Product Setup"."Product ID" where("Product Class" = const(Credit));

            trigger OnValidate()
            begin
                /*IF xRec."Loan Product Type"<>'' THEN BEGIN
                  DisbLines.RESET;
                  DisbLines.SETRANGE(DisbLines.No,"No.");
                  IF DisbLines.FIND('-') THEN BEGIN
                    IF CONFIRM('There are lines already generated. The change will result in deletion of lines. Are you sure you want to delete?',FALSE)=TRUE THEN BEGIN
                     REPEAT
                      IF LoanApp.GET(DisbLines."Loan No.") THEN BEGIN
                        LoanApp."Already Suggested":=FALSE;
                        LoanApp.MODIFY;
                        DisbLines.DELETE;
                      END;
                    UNTIL DisbLines.NEXT=0;
                    END ELSE
                    EXIT;
                  END;
                END;
                */

            end;
        }
        field(19; "Issued Date From"; Date)
        {

            trigger OnValidate()
            begin
                /*IF xRec."Issued Date From"<>0D THEN BEGIN
                  DisbLines.RESET;
                  DisbLines.SETRANGE(DisbLines.No,"No.");
                  IF DisbLines.FIND('-') THEN BEGIN
                    IF CONFIRM('There are lines already generated. The change will result in deletion of lines. Are you sure you want to delete?',FALSE)=TRUE THEN BEGIN
                     REPEAT
                      IF LoanApp.GET(DisbLines."Loan No.") THEN BEGIN
                        LoanApp."Already Suggested":=FALSE;
                        LoanApp.MODIFY;
                        DisbLines.DELETE;
                      END;
                    UNTIL DisbLines.NEXT=0;
                    END ELSE
                    EXIT;
                  END;
                END;
                */

            end;
        }
        field(20; "Issued Date To"; Date)
        {

            trigger OnValidate()
            begin
                /*IF xRec."Issued Date To"<>0D THEN BEGIN
                  DisbLines.RESET;
                  DisbLines.SETRANGE(DisbLines.No,"No.");
                  IF DisbLines.FIND('-') THEN BEGIN
                    IF CONFIRM('There are lines already generated. The change will result in deletion of lines. Are you sure you want to delete?',FALSE)=TRUE THEN BEGIN
                     REPEAT
                      IF LoanApp.GET(DisbLines."Loan No.") THEN BEGIN
                        LoanApp."Already Suggested":=FALSE;
                        LoanApp.MODIFY;
                        DisbLines.DELETE;
                      END;
                    UNTIL DisbLines.NEXT=0;
                    END ELSE
                    EXIT;
                  END;
                END;
                */

            end;
        }
        field(21; "Subsequent Disbursements"; Option)
        {
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;

            trigger OnValidate()
            begin
                /*IF "Subsequent Disbursements"="Subsequent Disbursements"::Yes THEN
                  MESSAGE(Text0001);
                
                IF xRec."Subsequent Disbursements"<>"Subsequent Disbursements" THEN BEGIN
                  DisbLines.RESET;
                  DisbLines.SETRANGE(DisbLines.No,"No.");
                  IF DisbLines.FIND('-') THEN BEGIN
                    IF CONFIRM('There are lines already generated. The change will result in deletion of lines. Are you sure you want to delete?',FALSE)=TRUE THEN BEGIN
                     REPEAT
                      IF LoanApp.GET(DisbLines."Loan No.") THEN BEGIN
                        LoanApp."Already Suggested":=FALSE;
                        LoanApp.MODIFY;
                        DisbLines.DELETE;
                      END;
                    UNTIL DisbLines.NEXT=0;
                    END ELSE
                    EXIT;
                  END;
                END;
                */

            end;
        }
        field(22; "Date Created"; Date)
        {
            Editable = false;
        }
        field(23; "Posting Date"; Date)
        {
            Editable = false;
        }
        field(24; "Prepared By"; Code[50])
        {
            Editable = false;
        }
        field(25; "Disbursement Destination"; Option)
        {
            OptionCaption = 'Normal,Bank Account,Supplier';
            OptionMembers = Normal,"Bank Account",Supplier;
        }
        field(26; "Disburse Accounts"; Code[20])
        {
            TableRelation = if ("Disbursement Destination" = const(Supplier)) Vendor."No."
            else
            if ("Disbursement Destination" = const("Bank Account")) "Bank Account"."No.";

            trigger OnValidate()
            begin
                "Posting Date" := today;
                if "Disbursement Destination" = "disbursement destination"::"Bank Account" then begin
                    if BankAcc.Get("Disburse Accounts") then
                        Name := BankAcc.Name;
                end else
                    if "Disbursement Destination" = "disbursement destination"::Supplier then begin
                        if Vend.Get("Disburse Accounts") then
                            Name := Vend.Name;
                    end;
            end;
        }
        field(27; "Special Processing Commission"; Decimal)
        {
        }
        field(28; "Cheque No."; Code[20])
        {
        }
        field(29; Name; Text[50])
        {
            Editable = false;
        }
        field(30; "Description/Remarks"; Text[50])
        {
            Editable = false;
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

    trigger OnDelete()
    begin
        TestField(Status, Status::Approved);
    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            MembNoSeries.Get;
            MembNoSeries.TestField(MembNoSeries."Loan Batch Nos");
            "No." := NoSeries.GetNextNo(MembNoSeries."Loan Batch Nos", WorkDate(), true);
        end;

        if UserSetup.Get(UpperCase(UserId)) then begin
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";

        end;



    end;

    trigger OnModify()
    begin
        if Posted then
            Error(ErrMod);

        if (Status = Status::Approved) or (Status = Status::Pending) then
            Error('Batch already approved');
    end;

    trigger OnRename()
    begin
        TestField(Status, Status::Approved);
    end;

    var
        MembNoSeries: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        ErrMod: label 'Cannot modify a posted batch';
        DisbLines: Record "Loan Disbursement Lines";
        LoanApp: Record Loans;
        Text0001: label 'Please note that subsequent partial deductions due per today will be effected';
        UserSetup: Record "User Setup";
        BankAcc: Record "Bank Account";
        Vend: Record "Savings Accounts";
}

