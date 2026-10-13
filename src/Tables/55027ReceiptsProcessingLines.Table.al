Table 55027 "Receipts Processing Lines"
{

    fields
    {
        field(1; "Check No/Staff No."; Code[20])
        {
        }
        field(2; "Savings Amount"; Decimal)
        {
        }
        field(3; "No Repayment"; Boolean)
        {
        }
        field(4; "Staff Not Found"; Boolean)
        {
        }
        field(5; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(6; "Transaction Date"; Date)
        {
        }
        field(8; Generated; Boolean)
        {
        }
        field(9; "Payment No"; Integer)
        {
        }
        field(10; Posted; Boolean)
        {
        }
        field(11; "Multiple Receipts"; Boolean)
        {
        }
        field(12; Name; Text[200])
        {
        }
        field(13; "Early Remitances"; Boolean)
        {
        }
        field(14; "Early Remitance Amount"; Decimal)
        {
        }
        field(15; "Trans Type"; Option)
        {
            OptionCaption = ' ,Registration fee,Loan,Deposits,Interest,Shares';
            OptionMembers = " ","Registration fee",Loan,Deposits,Interest,Shares;
        }
        field(16; Description; Text[60])
        {
        }
        field(17; "Member Not Found"; Boolean)
        {
        }
        field(18; "Search Index"; Code[20])
        {

            trigger OnValidate()
            begin

                if CopyStr("Search Index", 1, 2) = 'LN' then begin
                    "Import Loan No." := "Search Index";
                    "Search Index" := '';
                    //MODIFY;
                end;
            end;
        }
        field(19; "Loan Not Found"; Boolean)
        {
        }
        field(20; "Loan No"; Code[20])
        {

            trigger OnValidate()
            begin
                /*
                 memb.RESET;
                 memb.SETRANGE(memb."No.","Member No");
                 IF memb.FIND('-') THEN BEGIN
                  loans.RESET;
                  loans.SETRANGE(loans."Loan  No.","Loan No");
                  IF loans.FIND('-') THEN BEGIN
                   IF "Trans Type"="Trans Type"::Shares THEN BEGIN
                    Amount:=100;
                   END ELSE IF "Trans Type"="Trans Type"::Deposits THEN BEGIN
                   loans.CALCFIELDS(loans."Interest Due",loans."Outstanding Balance");
                  /// IF loans."Interest Due">0 THEN
                  // Amount:=loans."Interest Due";
                    Amount:=0.01*loans."Outstanding Balance";
                   END ELSE IF  "Trans Type"="Trans Type"::Loan THEN BEGIN
                   Amount:=loans.Repayment;
                  END;
                END;
                END;
                */

            end;
        }
        field(21; User; Code[20])
        {
        }
        field(22; "Member Moved"; Boolean)
        {
            Enabled = false;
        }
        field(23; "Employer Code"; Code[20])
        {

            trigger OnValidate()
            begin
                /*
               IF "Employer Code"<> ReceiptsHeader."Employer Code" THEN  BEGIN
               "Member PRD Mismatch":=TRUE;
               MODIFY;
               END;
                 */
                /*
               ReceiptsH.RESET;
               ReceiptsH.SETRANGE(ReceiptsH."Employer Code","Employer Code");
               IF ReceiptsH.FIND('-')=FALSE THEN BEGIN
               IF ReceiptsH."Employer Code"<> "Employer Code" THEN BEGIN
               ERROR('WRONG');
               END;
               END;
                  */

            end;
        }
        field(24; "Batch No."; Code[30])
        {
        }
        field(25; "Member No"; Code[20])
        {
        }
        field(26; "ID No."; Code[20])
        {
            Enabled = false;
        }
        field(27; "Receipt Header No"; Code[20])
        {
            TableRelation = "Receipts Processing Header".No;
        }
        field(28; "Receipt Line No"; Integer)
        {
        }
        field(29; "Account Type"; Option)
        {
            Enabled = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,None,Staff';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,"None",Staff;
        }
        field(30; "Entry No"; Integer)
        {
        }
        field(31; "Member PRD Mismatch"; Boolean)
        {
        }
        field(32; "Shares Amount"; Decimal)
        {
        }
        field(33; "Recovery Amount"; Decimal)
        {
        }
        field(34; Balance; Decimal)
        {
        }
        field(35; "Loan Account No."; Code[20])
        {
        }
        field(36; "Product Code"; Code[20])
        {
        }
        field(37; "Savings Acc No."; Code[20])
        {
        }
        field(38; "Import Loan No."; Code[20])
        {
        }
        field(39; "Excess Amount-No Loan"; Decimal)
        {
        }
        field(40; "Interest Paid"; Decimal)
        {
        }
        field(41; "Repayment Amount"; Decimal)
        {
        }
        field(42; "Excess Repayment- Loan"; Decimal)
        {
        }
        field(43; "Shares Account Not Found"; Boolean)
        {
        }
        field(44; "Invalid Refference Code"; Boolean)
        {
        }

        field(62012; "Posting Date"; Date)
        {

            CalcFormula = lookup("Receipts Processing Header"."Posting date" where("No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }

    }

    keys
    {
        key(Key1; "Receipt Line No", "Receipt Header No")
        {
            Clustered = true;
            SumIndexFields = "Savings Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Posted = true then
            Error('You cannot delete a Posted Check Off');
    end;

    trigger OnModify()
    begin
        if Posted = true then
            Error('You cannot modify a Posted Check Off');
    end;

    trigger OnRename()
    begin
        if Posted = true then
            Error('You cannot rename a Posted Check Off');
    end;

    var
        Memb: Record Members;
        loans: Record loans;
        ReceiptsHeader: Record "Receipts Processing Header";
        Cust: Record Members;
        ReceiptsH: Record "Receipts Processing Header";
}

