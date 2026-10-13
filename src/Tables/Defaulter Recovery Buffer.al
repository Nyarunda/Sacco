Table 50353 "Defaulter Recovery Buffer"
{

    fields
    {
        field(1; "Header No."; Code[20])
        {
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Order Line No.';
            DataClassification = SystemMetadata;
        }
        field(50002; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
            DataClassification = ToBeClassified;
        }
        field(50003; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(50004; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(50005; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Sav: Record "Savings Accounts";
                CAcc: Record "Credit Accounts";
            begin
                if Sav.Get("Account No.") then
                    "Member No." := Sav."Member No."
                else
                    if CAcc.Get("Account No.") then
                        "Member No." := CAcc."Member No.";
            end;
        }
        field(50006; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(50007; "Member No."; Code[50])
        {
            Caption = 'Customer CID';
            DataClassification = ToBeClassified;
        }
        field(50008; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(50009; "Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
            DataClassification = ToBeClassified;
        }
        field(50010; "Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
            DataClassification = ToBeClassified;
        }
        field(50011; "Transaction Type"; Enum "Transaction Type Enum")
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF "Transaction Type"="Transaction Type"::"Registration Fee" THEN
                  Description:='Registration Fee';
                IF "Transaction Type"="Transaction Type"::Loan THEN
                  Description:='Loan';
                IF "Transaction Type"="Transaction Type"::Repayment THEN
                  Description:='Loan Repayment';
                IF "Transaction Type"="Transaction Type"::Withdrawal THEN
                  Description:='Withdrawal';
                IF "Transaction Type"="Transaction Type"::"Interest Due" THEN
                  Description:='Interest Due';
                IF "Transaction Type"="Transaction Type"::"Interest Paid" THEN
                  Description:='Interest Paid';
                IF "Transaction Type"="Transaction Type"::"Benevolent Fund" THEN
                  Description:='ABF Fund';
                IF "Transaction Type"="Transaction Type"::"Deposit Contribution" THEN
                  Description:='Shares Contribution';
                IF "Transaction Type"="Transaction Type"::"Appraisal Fee" THEN
                  Description:='Appraisal Fee';
                IF "Transaction Type"="Transaction Type"::"Application` Fee" THEN
                  Description:='Application Fee';
                IF "Transaction Type"="Transaction Type"::"Unallocated Funds" THEN
                  Description:='Unallocated Funds';
                         */


                //GenSet.GET;
                /*
                IF "Account Type"="Account Type"::Member THEN BEGIN
                CustMember.RESET;
                CustMember.SETRANGE(CustMember."No.","Account No.");
                IF CustMember.FIND('-') THEN BEGIN
                IF "Transaction Type"="Transaction Type"::Bills THEN
                "Bal. Account No.":=GenSet."Bill Account"
                ELSE
                "Bal. Account No.":='';
                END;
                END;
                
                
                
                PartOfAcc:='';
                
                PartOfAcc:=COPYSTR("Account No.",1,3);
                
                IF ((PartOfAcc='S01') OR (PartOfAcc='S02') OR (PartOfAcc='S06') OR (PartOfAcc='S09')  ) AND ("Transaction Type"<>"Transaction Type"::"Deposit Contribution") THEN
                ERROR('The chosen transaction type should be deposit contribution');
                
                IF ((PartOfAcc='S03') OR (PartOfAcc='S04')) AND ("Transaction Type"<>"Transaction Type"::"Share Capital") THEN
                ERROR('The chosen transaction type should be share Capital');
                
                IF ((PartOfAcc='L01') OR (PartOfAcc='L04') OR (PartOfAcc='L05')) AND ("Transaction Type"<>"Transaction Type"::" ") THEN
                ERROR('The transaction type should be blank');
                */

            end;
        }
        field(50012; "Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //PKK

                /*IF Loans.GET("Loan No") THEN BEGIN
                  Loans.CALCFIELDS(Loans."Outstanding Balance");
                  IF Loans."Outstanding Balance"+Amount<=0 THEN BEGIN
                     Loans."Last Advice Date":=TODAY;
                     Loans."Advice Type":=Loans."Advice Type"::Stoppage;
                     Loans.MODIFY;
                   END;
                 END;
                 */
                /*
                Loans.RESET;
                Loans.SETRANGE(Loans."Loan  No.","Loan No");
                IF Loans.FIND('-') THEN BEGIN
                IF LType.GET(Loans."Loan Product Type") THEN BEGIN
                //"Shortcut Dimension 1 Code":=LType."Source of Financing";
                //VALIDATE("Shortcut Dimension 1 Code");
                END;
                
                Loans.CALCFIELDS(Loans."Outstanding Balance");
                InterestRate:=Loans.Interest;
                RepayPeriod:=Loans.Installments;
                LBalance:=Loans."Outstanding Balance";
                LoanAmount:=Loans."Approved Amount";
                
                
                IF "Transaction Type" = "Transaction Type"::"Application Fee" THEN BEGIN
                PCharges.RESET;
                PCharges.SETRANGE(PCharges."Product Code",Loans."Loan Product Type");
                PCharges.SETRANGE(PCharges.Code,'APP');
                IF PCharges.FIND('-') THEN BEGIN
                IF PCharges."Use Perc" = TRUE THEN
                Amount:=-1*(Loans."Approved Amount"*(PCharges.Percentage/100))
                ELSE
                Amount:=-1*PCharges.Amount;
                END;
                
                VALIDATE(Amount);
                
                EXIT;
                END;
                
                
                IF "Transaction Type" = "Transaction Type"::"Appraisal Fee" THEN BEGIN
                PCharges.RESET;
                PCharges.SETRANGE(PCharges."Product Code",Loans."Loan Product Type");
                PCharges.SETRANGE(PCharges.Code,'APPR');
                IF PCharges.FIND('-') THEN BEGIN
                IF PCharges."Use Perc" = TRUE THEN
                Amount:=-1*(Loans."Approved Amount"*(PCharges.Percentage/100))
                ELSE
                Amount:=-1*PCharges.Amount;
                END;
                
                VALIDATE(Amount);
                
                EXIT;
                END;
                
                
                
                
                
                IF Loans."Repayment Method"=Loans."Repayment Method"::Amortised THEN BEGIN
                Loans.TESTFIELD(Loans.Interest);
                Loans.TESTFIELD(Loans.Installments);
                
                TotalMRepay:=ROUND((InterestRate/12/100) / (1 - POWER((1 + (InterestRate/12/100)),- RepayPeriod)) * LoanAmount,0.05,'>');
                LInterest:=ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                LPrincipal:=TotalMRepay-LInterest;
                END;
                
                IF Loans."Repayment Method"=Loans."Repayment Method"::"Straight Line" THEN BEGIN
                Loans.TESTFIELD(Interest);
                Loans.TESTFIELD(Installments);
                LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
                LInterest:=ROUND((InterestRate/12/100)*LoanAmount,0.05,'>');
                //Grace Period
                LInterest:=ROUND((LInterest*(Loans.Installments+Loans."Grace Period - Principle (M)"))
                                /((Loans.Installments+Loans."Grace Period - Principle (M)")-Loans."Grace Period - Interest (M)"),0.05,'>');
                
                END;
                
                IF Loans."Repayment Method"=Loans."Repayment Method"::"Reducing Balance" THEN BEGIN
                Loans.TESTFIELD(Interest);
                Loans.TESTFIELD(Installments);
                LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
                LInterest:=ROUND((InterestRate/12/100)*LBalance,0.05,'>');
                END;
                
                IF Loans."Repayment Method"=Loans."Repayment Method"::Constants THEN BEGIN
                Loans.TESTFIELD(Repayment);
                IF LBalance < Loans.Repayment THEN
                LPrincipal:=LBalance
                ELSE
                LPrincipal:=Loans.Repayment;
                LInterest:=Interest;
                END;
                
                
                END;
                
                IF "Transaction Type" = "Transaction Type"::Repayment THEN
                Amount:=-1*LPrincipal
                ELSE IF "Transaction Type" = "Transaction Type"::"Interest Paid" THEN
                Amount:=-1*LInterest;
                
                VALIDATE(Amount);
                */


                //PKK

            end;
        }
        field(50013; "Product Type Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50015; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50016; "External Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Product Type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Bal Account Type';
            DataClassification = ToBeClassified;
        }
        field(50019; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal Account No.';
            DataClassification = ToBeClassified;
        }
        field(50020; Blocked; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
        }
        field(50021; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Loan Product"; Code[20])
        {
            CalcFormula = lookup(Loans."Loan Product Type" where("Loan No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(50023; Transaction; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Gross,Tax,Processing Fee,Duty on Processing Fee,Loan,SMS,Capitalized';
            OptionMembers = " ",Gross,Tax,"Processing Fee","Duty on Processing Fee",Loan,SMS,Capitalized;
        }
        field(50024; "Buffer Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Defaulter,Guarantor;
        }
        field(50025; "Journal Template Name"; Code[20])
        {
        }
        field(50026; "Journal Batch Name"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Header No.", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

