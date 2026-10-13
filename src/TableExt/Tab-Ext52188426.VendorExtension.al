tableextension 50019 "Vendor Extension" extends Vendor
{
    fields
    {

        field(90000; "Prequalification Status"; Option)
        {
            Caption = 'Prequalification Status';
            OptionMembers = "Not Prequalified","Prequalified","Expired","Under Review";
            OptionCaption = 'Not Prequalified,Prequalified,Expired,Under Review';
            DataClassification = CustomerContent;
        }
        field(90001; "Prequalification Date"; Date)
        {
            Caption = 'Prequalification Date';
            DataClassification = CustomerContent;
        }
        field(90002; "Prequalification Expiry Date"; Date)
        {
            Caption = 'Prequalification Expiry Date';
            DataClassification = CustomerContent;
        }
        field(90003; "Vendor Category"; Code[20])
        {
            Caption = 'Vendor Category';
            DataClassification = CustomerContent;
        }
        field(50050; "Creditor Type"; Enum "Creditor Type Enum")
        {
            Caption = 'Creditor Type';
            DataClassification = ToBeClassified;
        }


        field(50051; "Authorised Over Draft"; Decimal)
        {
            CalcFormula = sum("Overdraft Header"."Approved Amount" where("Account No." = field("No."),
                                                                          Posted = const(true),
                                                                          Expired = const(false)));
            Description = 'Sum("Overdraft Header"."Approved Amount" WHERE (Account No.=FIELD(No.),Posted=CONST(Yes),Expired=CONST(No)))';
            FieldClass = FlowField;
        }
        field(50052; "Uncleared Cheques"; Decimal)
        {
            CalcFormula = sum("Teller Transaction".Amount where("Account No." = field("No."),
                                                                 Posted = const(true),
                                                                 Type = filter("Cheque Deposit" | "Credit Cheque"),
                                                                 "Cheque Status" = filter(Pending | Matured)));
            FieldClass = FlowField;
        }
        field(50053; "Lien Placed"; Decimal)
        {
            CalcFormula = sum("Teller Transaction".Amount where("Account No." = field("No."),
                                                                 Posted = const(true),
                                                                 Type = filter(Lien),
                                                                 "Cheque Status" = filter(Pending)));
            FieldClass = FlowField;
        }

        field(50001; "Product Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Registration Fee","Share Capital","Deposit Contribution","Benevolent Fund","Unallocated Fund","Dividend Account","Micro Member Deposit","Micro Group Deposit","Ordinary Savings","Holiday Savings","School Fee","Fixed Deposit","Junior Savings",Welfare,Housing,"Virtual Account","FOSA Shares",Business,Jipange,"Agent Float","Agent Commission";
        }
        field(50002; "Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup";
        }
        field(50003; "Product Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;
        }
        field(50005; "Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Monthly Contribution Date" := Today;
                "Contribution Updated By" := UserId;
            end;
        }
        field(50007; "ID No."; Code[50])
        {
            CalcFormula = lookup(Members."ID No." where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }

        field(50009; "Payroll/Staff No."; Code[50])
        {
            CalcFormula = lookup(Members."Payroll/Staff No." where("No." = field("Member No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; Status; Enum "Account Status Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Group No."; Code[20])
        {
            CalcFormula = lookup(Members."Group No." where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(50013; "Child Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Child Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Child Birth Cet. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Test Blocked"; Enum "Vendor Blocked")
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Signing Instructions Narration"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Mandate;
        }
        field(50018; "Transactional Mobile No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Monthly Contribution Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Contribution Updated By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Cheque Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Old Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Old Member No."; Code[20])
        {
            CalcFormula = lookup(Members."Old Member No." where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(50024; "Next MLoan Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Member Category"; Option)
        {
            CalcFormula = lookup(Members."Member Category" where("No." = field("Member No.")));
            FieldClass = FlowField;
            OptionCaption = 'Member,Staff Members,Board Members,Delegates,Non-Member';
            OptionMembers = Member,"Staff Members","Board Members",Delegates,"Non-Member";
        }
        field(50058; "Last Transaction Date"; Date)
        {
            CalcFormula = max("Savings Ledger Entry"."Posting Date" where("Amount (LCY)" = filter(<> 0),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Account No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50059; "Mobile Withdrawals"; Decimal)
        {
            CalcFormula = sum("Mobile Withdrawal Buffer".Amount where("Account No" = field("No."),
                                                                        Posted = const(false)));
            FieldClass = FlowField;
        }
        field(50060; "Cheque Book Mandate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Child Account Status"; Option)
        {
            OptionMembers = Child,"Pending Conversion",Converted;
        }

        field(50063; "Dormancy Period"; DateFormula)
        {
            CalcFormula = lookup("Product Setup"."Dormancy Period" where("Product ID" = field("Product Type")));
            FieldClass = FlowField;
        }

        field(50064; "Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loan Security" where("Account No." = field("No."),
                                                       Substituted = const(false),
                                                       "Outstanding Principal" = filter(> 0)));
            Editable = false;
            FieldClass = FlowField;
        }


        field(50065; "ATM No."; Code[20])
        {
            Editable = false;
        }
        field(50066; "ATM Balance"; Decimal)
        {
            CalcFormula = sum("Coop ATM Transaction"."Total Account Debit" where("Member Account" = field("No."),
                                                                 Posted = const(false),
                                                                 "Transaction Type" = filter(<> 1420)));
            FieldClass = FlowField;
        }


        field(50067; "Piggy Bank Issued"; Boolean)
        {
            Editable = false;
        }


        field(50074; "Allow Bank Transfer"; Boolean)
        {
            Editable = false;
        }
        field(50068; "Mbanking Registered"; Boolean)
        {
            Editable = false;
        }
        field(50069; "Bank Transfer Trans. Limit"; Decimal)
        {
            Editable = false;
        }
        field(50070; "Bank Transfer Daily Limit"; Decimal)
        {
            Editable = false;
        }

        field(50071; "Allow Withdrawal To Others"; Boolean)
        {
            Editable = false;
        }
        field(50072; "Salary Processing"; Boolean)
        {
            Editable = false;
        }



        field(50073; "Old ATM No"; Code[20])
        {
            Editable = false;
        }



        field(50080; "Repay Mode"; Enum "Repay Mode Enum")
        {
            //ValuesAllowed = " ", Salary, Milk, Tea,"Staff Salary","Business","Check Off","Dividends","Internal Standing Order","External Standing Order","Pension","Bonus","Mini-Bonus",Allowance,Cash;
            ValuesAllowed = " ", Salary, "Check Off", "Internal Standing Order", "External Standing Order", "Pension", Allowance, Cash;

        }


        field(50081; "Active Fixed Deposit"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Fixed Deposit Accounts"."FD Amount" where("Fixed Account No." = field("No."),
                                                                          Posted = const(true),
                                                                          "FD Status" = const(Active),
                                                                          "No." = field("FD Filter"),
                                                                          "Approval Status" = const(Approved)));
        }


        field(50082; "FD Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }

        field(50083; "Block Instant Loans"; Boolean)
        {
        }

        field(50087; "Signing Instructions"; Option)
        {
            OptionMembers = Single,"All must Sign","Either Must Sign";
        }
        field(50088; "Old Amount"; Decimal)
        {
            //OptionMembers = Single,"All must Sign","Either Must Sign";
        }


        field(50089; "OLD ATM Balance"; Decimal)
        {
            CalcFormula = sum("ATM Transactions".Amount where("Account No" = field("No."),
                                                                 Posted = const(false),
                                                                 Transfered = const(false)));
            FieldClass = FlowField;
        }

        field(50090; "Old Uncleared Cheques"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Transactions- CBS".Amount WHERE("Account No" = FIELD("No."), Posted = CONST(true), "Cheque Processed" = CONST(False), Type = CONST('Cheque Deposit')));
        }

        field(50091; "Employer Code"; Code[20])
        {
            CalcFormula = lookup(Members."Employer Code" where("No." = field("Member No.")));
            FieldClass = FlowField;
            TableRelation = Customer where("Account Type" = const(Employer));
        }
        field(50092; "Membership Date"; Date)
        {
            CalcFormula = lookup(Members."Registration Date" where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(50093; "Member ID"; Code[50])
        {
        }
        field(50094; "Member Staff No."; Code[50])
        {
        }
        field(50095; "Old Net Change"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Member Ledger Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                           "Posting Date" = FIELD("Date Filter")));
            Caption = 'Old Net Change';
            Editable = false;
            FieldClass = FlowField;
        }


        field(50096; "Cummulative Contribution"; Decimal)
        {
            //OptionMembers = Single,"All must Sign","Either Must Sign";
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Monthly Contribution Date" := Today;
                "Contribution Updated By" := UserId;
            end;
        }

        field(50097; "Current Balance"; Decimal)
        {
            //OptionMembers = Single,"All must Sign","Either Must Sign";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Monthly Contribution Date" := Today;
                "Contribution Updated By" := UserId;
                "Cummulative Contribution" := "Monthly Contribution" + "Change Balance" + "Current Balance";
            end;
        }

        field(50098; "Change Balance"; Decimal)
        {
            //OptionMembers = Single,"All must Sign","Either Must Sign";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Monthly Contribution Date" := Today;
                "Contribution Updated By" := UserId;
                "Cummulative Contribution" := "Monthly Contribution" + "Change Balance" + "Current Balance";

            end;
        }


        field(50099; "Total Loan Arrears"; Decimal)
        {
            CalcFormula = Sum("SACCO Categorization"."Total Arrears" where("Member No." = field("Member No.")));
            FieldClass = FlowField;
        }


        field(50100; "Duplicates"; Integer)
        {
            CalcFormula = count(Vendor where("Product Category" = field("Product Category"), "Member No." = field("Member No.")));
            FieldClass = FlowField;
        }

        field(50101; "ATM Delinked By"; Code[50])
        {
            Editable = false;
        }
        field(50102; "Date Delinked"; Date)
        {
            Editable = false;
        }


        field(50103; "Old Balance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Member Ledger Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                   "Posting Date" = FIELD("Date Filter")));

            Editable = false;
            FieldClass = FlowField;
        }


        field(50104; "Salaried"; Boolean)
        {
            CalcFormula = lookup(Vendor."Salary Processing" where("Member No." = field("Member No."), "Product Category" = const("Ordinary Savings")));
            FieldClass = FlowField;
        }


        field(50105; "Loan Lien"; Decimal)
        {
            CalcFormula = sum("Loan Security"."Current Committed" where("Account No." = field("No."),
                                                                 "Guarantor Type" = filter(Lien)));
            FieldClass = FlowField;
        }

        field(50106; "KRA Pin No."; code[11])
        {
            DataClassification = CustomerContent;

        }
        field(50107; "Next Capitalization Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "New Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Savings Ledger Entry"."Amount (LCY)" WHERE("Account No." = FIELD("No."),
                                                                                   "Currency Code" = FIELD("Currency Filter"), "Posting Date" = FIELD("Date Filter")));
            Caption = 'New Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;

        }


        field(50151; "Approved Fuuza"; Decimal)
        {
            CalcFormula = sum("Fuliza"."Approved Amount" where("Account No." = field("No."),
                                                                          Posted = const(true),
                                                                          Expired = const(false)));
            FieldClass = FlowField;
        }


        field(90004; "Allow Fuuza"; Boolean)
        {
            CalcFormula = lookup("Product Setup"."Allow Fuuza" where("Product ID" = field("Product Type")));
            FieldClass = FlowField;
        }
        field(90005; "Virtual Account No."; Code[20])
        {
            TableRelation = Vendor where("Product Category" = const("Virtual Account"), "Member No." = field("Member No."));
        }

        field(90006; "Virtual Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Savings Ledger Entry"."Amount (LCY)" WHERE("Account No." = FIELD("Virtual Account No."),
                                                                                   "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Virtual Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }


        field(90007; "Fuuza Interest"; Decimal)
        {


            CalcFormula = lookup("Fuuza Interest Buffer"."Interest Amount" where("Account No" = field("No.")));
            FieldClass = FlowField;
        }
        field(90008; "Virtual Account Interest"; Decimal)
        {
            CalcFormula = lookup("Fuuza Interest Buffer"."Interest Amount" where("Account No" = field("Virtual Account No.")));
            FieldClass = FlowField;
        }

        field(50157; "Virtual Approved Fuuza"; Decimal)
        {
            CalcFormula = sum("Fuliza"."Approved Amount" where("Account No." = field("Virtual Account No."),
                                                                          Posted = const(true),
                                                                          Expired = const(false)));
            FieldClass = FlowField;
        }
        field(50158; "Is Lawyer"; Boolean)
        {
        }
        field(50159; "Vendor Type"; Enum "Vendor Type")
        {
        }
    }

    fieldgroups
    {
        addlast(DropDown; "Product Name", "Product Category", "ID No.", "Mobile Phone No.") { }

    }

    trigger OnDelete()
    var
        Usersetup: Record "User Setup";
    begin
        Usersetup.Get(UserId);
        if not Usersetup."Delete Vendor" then
            Error('You do not have permission to delete. "Delete Vendor"');
    end;

}
