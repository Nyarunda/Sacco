Table 55014 "SACCO Account"
{
    Caption = 'SACCO Account';
    DataCaptionFields = "No.", Name;
    Permissions = TableData "Credit Ledger Entry" = r;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            SQLDataType = Varchar;

        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
                /*
                StatusPermissions.RESET;
                StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::Edit);
                IF StatusPermissions.FIND('-') = FALSE THEN
                ERROR('You do not have permissions to edit the name.');
                */

            end;
        }
        field(3; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(4; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(5; "Current Address"; Text[50])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(8; Contact; Text[50])
        {
            Caption = 'Contact';

            trigger OnValidate()
            begin
                //IF RMSetup.GET THEN
                //  IF RMSetup."Bus. Rel. Code for Customers" <> '' THEN
                //    IF (xRec.Contact = '') AND (xRec."Primary Contact No." = '') THEN BEGIN
                //      MODIFY;
                //      UpdateContFromCust.OnModify(Rec);
                //      UpdateContFromCust.InsertNewContactPerson(Rec,FALSE);
                //      MODIFY(TRUE);
                //    END
            end;
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
            Enabled = false;
        }
        field(14; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';
            Enabled = false;
        }
        field(15; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            Enabled = false;
            //TableRelation = Territory;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            //TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            //TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

        }
        field(18; "Chain Name"; Code[10])
        {
            Caption = 'Chain Name';
            Enabled = false;
        }
        field(19; "Budgeted Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Budgeted Amount';
            Enabled = false;
        }
        field(20; "Credit Limit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Credit Limit (LCY)';
            Enabled = false;
        }
        field(21; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            //TableRelation = "Receivables Posting Group";

            trigger OnValidate()
            begin
            end;
        }
        field(22; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            //TableRelation = Currency;
        }
        field(23; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            Enabled = false;
            //TableRelation = "Customer Price Group";
        }
        field(24; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            Enabled = false;
            //TableRelation = Language;
        }
        field(26; "Statistics Group"; Integer)
        {
            Caption = 'Statistics Group';
            Enabled = false;
        }
        field(27; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            Enabled = false;
            //TableRelation = "Payment Terms";
        }
        field(28; "Fin. Charge Terms Code"; Code[10])
        {
            Caption = 'Fin. Charge Terms Code';
            Enabled = false;
            //TableRelation = "Finance Charge Terms";
        }
        field(29; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            //TableRelation = "Salesperson/Purchaser";
        }
        field(30; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            Enabled = false;
            //TableRelation = "Shipment Method";
        }
        field(31; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            Enabled = false;
            //TableRelation = "Shipping Agent";
        }
        field(32; "Place of Export"; Code[20])
        {
            Caption = 'Place of Export';
            Enabled = false;
        }
        field(33; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
            Enabled = false;
            //TableRelation = Customer;
            //This property is currently not supported
            //Test//TableRelation = false;
            //Validate//TableRelation = false;
        }
        field(34; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            Enabled = false;
            //TableRelation = "Customer Discount Group";
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            //TableRelation = "Country/Region";
        }
        field(36; "Collection Method"; Code[20])
        {
            Caption = 'Collection Method';
            Enabled = false;
        }
        field(37; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            Enabled = false;
        }
        field(38; Comment; Boolean)
        {
            CalcFormula = exist("Comment Line" where("Table Name" = const(Customer),
                                                      "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
        }
        field(40; "Invoice Copies"; Integer)
        {
            Caption = 'Invoice Copies';
            Enabled = false;
        }
        field(41; "Last Statement No."; Integer)
        {
            Caption = 'Last Statement No.';
            Enabled = false;
        }
        field(42; "Print Statements"; Boolean)
        {
            Caption = 'Print Statements';
            Enabled = false;
        }
        field(45; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            Enabled = false;
            //TableRelation = Customer;
        }
        field(46; Priority; Integer)
        {
            Caption = 'Priority';
            Enabled = false;
        }
        field(47; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            //TableRelation = "Payment Method";
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(55; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(56; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            //TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(57; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            //TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(80; "Application Method"; Option)
        {
            Caption = 'Application Method';
            Enabled = false;
            OptionCaption = 'Manual,Apply to Oldest';
            OptionMembers = Manual,"Apply to Oldest";
        }
        field(82; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';
            Enabled = false;
        }
        field(83; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Enabled = false;
            //TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(84; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(85; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back';
            Enabled = false;
        }
        field(86; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            Enabled = false;

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
                VATRegNoFormat.Test("VAT Registration No.", "Country/Region Code", "No.", Database::Customer);
            end;
        }
        field(87; "Combine Shipments"; Boolean)
        {
            Caption = 'Combine Shipments';
            Enabled = false;
        }
        field(88; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            //TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                //if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
                //  if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") then
                //    Validate("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
            end;
        }
        field(89; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(91; "Post Code"; Code[20])
        {

        }
        field(92; County; Text[30])
        {
            Caption = 'County';
        }

        field(99; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Credit Ledger Entry"."Debit Amount (LCY)" where("Account No." = field("No."),
                                                                                       "Posting Date" = field("Date Filter"),
                                                                                       "Currency Code" = field("Currency Filter")));
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Credit Ledger Entry"."Credit Amount (LCY)" where("Account No." = field("No."),
                                                                                        "Posting Date" = field("Date Filter"),
                                                                                        "Currency Code" = field("Currency Filter")));
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(103; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            Enabled = false;
            ExtendedDatatype = URL;
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            //TableRelation = "No. Series";
        }
        field(108; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            Enabled = false;
            //TableRelation = "Tax Area";
        }
        field(109; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            Enabled = false;
        }
        field(110; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            //TableRelation = "VAT Business Posting Group";
        }
        field(111; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            //TableRelation = Currency;
        }
        field(5049; "Primary Contact No."; Code[20])
        {
            Caption = 'Primary Contact No.';
            Enabled = false;
            //TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
                ContBusRel.SetCurrentkey("Link to Table", "No.");
                ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Customer);
                ContBusRel.SetRange("No.", "No.");
                if ContBusRel.FindFirst then
                    Cont.SetRange("Company No.", ContBusRel."Contact No.")
                else
                    Cont.SetRange("No.", '');

                if "Primary Contact No." <> '' then
                    if Cont.Get("Primary Contact No.") then;
                if Page.RunModal(0, Cont) = Action::LookupOK then
                    Validate("Primary Contact No.", Cont."No.");
            end;

            trigger OnValidate()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
                Contact := '';
                if "Primary Contact No." <> '' then begin
                    Cont.Get("Primary Contact No.");

                    ContBusRel.SetCurrentkey("Link to Table", "No.");
                    ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Customer);
                    ContBusRel.SetRange("No.", "No.");
                    ContBusRel.Find('-');

                    //if Cont."Company No." <> ContBusRel."Contact No." then
                    //  Error(Text003, Cont."No.", Cont.Name, "No.", Name);

                    if Cont.Type = Cont.Type::Person then
                        Contact := Cont.Name
                end;
            end;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            //TableRelation = "Responsibility Center";
        }
        field(5750; "Shipping Advice"; Option)
        {
            Caption = 'Shipping Advice';
            Enabled = false;
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
        }
        field(7600; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            //TableRelation = "Base Calendar";
        }
        field(7601; "Copy Sell-to Addr. to Qte From"; Option)
        {
            Caption = 'Copy Sell-to Addr. to Qte From';
            Enabled = false;
            OptionCaption = 'Company,Person';
            OptionMembers = Company,Person;
        }
        field(68000; "Customer Type"; Option)
        {
            OptionCaption = ' ,Welfare,Micro finance, Partnership';
            OptionMembers = " ",Welfare,"Micro finance"," Partnership";
        }
        field(68001; "Registration Date"; Date)
        {
        }
        field(68004; "Total Repayments"; Decimal)
        {
            Editable = false;
        }
        field(68005; "Principal Balance"; Decimal)
        {
        }
        field(68006; "Principal Repayment"; Decimal)
        {
        }
        field(68008; "Debtors Type"; Option)
        {
            OptionCaption = ' ,Staff,Client,Others';
            OptionMembers = " ",Staff,Client,Others;
        }
        field(68012; Status; Option)
        {
            OptionCaption = 'New,Active,Frozen,Closed,Dormant,Deceased';
            OptionMembers = New,Active,Frozen,Closed,Dormant,Deceased;

            trigger OnValidate()
            begin
                if (Status <> Status::Frozen) or (Status <> Status::Closed) then
                    Blocked := Blocked::All;
            end;
        }
        field(68013; "Savings Account"; Code[20])
        {
            //TableRelation = "SACCO Account" where("Member No." = field("Member No."),
            // "Product Type" = filter('0101' | '0102' | '0103' | '0104' | '0105' | '0106' | '0107'));
        }
        field(68015; "Old Account No."; Code[20])
        {
        }
        field(68016; "Loan Product Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //TableRelation = "Loan Product Types".Code;
        }
        field(68017; "Employer Code"; Code[50])
        {
            //TableRelation = Employer;

            trigger OnValidate()
            begin
                /*Vend2.RESET;
                Vend2.SETRANGE(Vend2."Staff No","Payroll/Staff No");
                IF Vend2.FIND('-') THEN BEGIN
                REPEAT
                Vend2."Company Code":="Employer Code";
                Vend2.MODIFY;
                UNTIL Vend2.NEXT = 0;
                END;*/

            end;
        }
        field(68018; "Date of Birth"; Date)
        {

        }
        field(68019; "E-Mail (Personal)"; Text[50])
        {
        }
        field(68020; "Station/Department"; Code[20])
        {
            //TableRelation = Stations.Code where("Employer Code" = field("Employer Code"));
        }
        field(68021; "Home Address"; Text[50])
        {
        }
        field(68022; Location; Text[50])
        {
        }
        field(68023; "Sub-Location"; Text[50])
        {
        }
        field(68024; "District/County"; Text[50])
        {
        }
        field(68025; "Resons for Status Change"; Text[80])
        {
        }
        field(68026; "Payroll/Staff No"; Code[20])
        {

            trigger OnValidate()
            begin
                /*IF "Customer Type" = "Customer Type"::" " THEN
                EXIT;
                
                IF "Customer Type" = "Customer Type"::FOSA THEN
                EXIT;
                IF "Payroll/Staff No"<>'' THEN BEGIN
                Cust.RESET;
                Cust.SETRANGE(Cust."Payroll/Staff No","Payroll/Staff No");
                Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                IF Cust.FIND('-') THEN BEGIN
                //IF Cust."No." <> "No." THEN
                   //ERROR('Staff/Payroll No. already exists');
                END;
                END;
                
                IF xRec."Payroll/Staff No"<>'' THEN BEGIN
                IF "Payroll/Staff No"<>xRec."Payroll/Staff No" THEN BEGIN
                IF CONFIRM('Are you sure you want to change the staff number?',TRUE)=TRUE THEN BEGIN
                CustFosa:='5-02-'+"No."+'-00';
                
                //MESSAGE('%1',CustFosa);
                
                
                
                Cust.RESET;
                Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::FOSA);
                Cust.SETRANGE("No.",CustFosa);
                IF Cust.FIND('-') THEN BEGIN
                Cust."Payroll/Staff No":="Payroll/Staff No";
                END;
                
                
                
                
                Vend.RESET;
                Vend.SETRANGE(Vend."No.","FOSA Account");
                IF Vend.FIND('-') THEN BEGIN
                IF Vend."Staff No" <> '' THEN BEGIN
                Vend2.RESET;
                Vend2.SETRANGE(Vend2."Staff No",Vend."Staff No");
                IF Vend2.FIND('-') THEN BEGIN
                REPEAT
                Vend2."Staff No":="Payroll/Staff No";
                Vend2.MODIFY;
                UNTIL Vend2.NEXT = 0;
                END;
                END;
                END;
                Vend.RESET;
                Vend2.RESET;
                
                Loans.RESET;
                Loans.SETRANGE(Loans."Client Code","No.");
                Loans.SETFILTER(Loans.Source,'BOSA');
                IF Loans.FIND('-') THEN BEGIN
                REPEAT
                //MESSAGE('NIMEGET %1%2',"Staff No",Loans."Staff No");
                Loans."Staff No":="Payroll/Staff No";
                Loans.MODIFY;
                UNTIL Loans.NEXT=0;
                END;
                
                Loans.RESET;
                Loans.SETRANGE(Loans."Client Code","FOSA Account");
                Loans.SETFILTER(Loans.Source,'FOSA');
                IF Loans.FIND('-') THEN BEGIN
                REPEAT
                //MESSAGE('NIMEGET %1%2',"Staff No",Loans."Staff No");
                Loans."Staff No":="Payroll/Staff No";
                Loans.MODIFY;
                UNTIL Loans.NEXT=0;
                END;
                
                
                
                END
                ELSE
                "Payroll/Staff No":=xRec."Payroll/Staff No"
                END;
                END;     */

            end;
        }
        field(68027; "ID No."; Code[20])
        {

            trigger OnValidate()
            begin
                /*IF "ID No."<>'' THEN BEGIN
                Cust.RESET;
                Cust.SETRANGE(Cust."ID No.","ID No.");
                Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                IF Cust.FIND('-') THEN BEGIN
                IF Cust."No." <> "No." THEN
                   ERROR('ID No. already exists');
                END;
                END;
                
                
                
                Vend2.RESET;
                Vend2.SETRANGE(Vend2."Creditor Type",Vend2."Creditor Type"::Account);
                Vend2.SETRANGE(Vend2."Staff No","Payroll/Staff No");
                IF Vend2.FIND('-') THEN BEGIN
                REPEAT
                Vend2."ID No.":="ID No.";
                Vend2.MODIFY;
                UNTIL Vend2.NEXT = 0;
                END;
                    */

            end;
        }
        field(68028; "Mobile Phone No"; Code[50])
        {

            trigger OnValidate()
            begin
                /*
                Vend.RESET;
                Vend.SETRANGE(Vend."Staff No","Payroll/Staff No");
                IF Vend.FIND('-') THEN
                Vend.MODIFYALL(Vend."Mobile Phone No","Mobile Phone No");
                
                Cust.RESET;
                Cust.SETRANGE(Cust."Payroll/Staff No","Payroll/Staff No");
                IF Cust.FIND('-') THEN
                Cust.MODIFYALL(Cust."Mobile Phone No","Mobile Phone No");*/



                Cust.Reset;
                Cust.SetRange(Cust."Member No.", Cust."Member No.");
                if Cust.Find('-') then begin
                    repeat
                        if Cust."No." <> "No." then begin
                            Cust."Mobile Phone No" := "Mobile Phone No";
                            Cust.Modify;

                        end;

                    until Cust.Next = 0;
                end;

            end;
        }
        field(68029; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Divorced,Widower,Widow;
        }
        field(68030; Signature; Blob)
        {
            Caption = 'Signature';
            SubType = Bitmap;
        }
        field(68031; "Passport No."; Code[50])
        {
        }
        field(68032; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;


        }
        field(68033; "Withdrawal Date"; Date)
        {
        }
        field(68034; "Withdrawal Fee"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(68040; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }


        field(68044; "Registration Fee"; Decimal)
        {
        }
        field(68045; "Society Code"; Code[20])
        {
        }

        field(68047; "Monthly Contribution"; Decimal)
        {

        }
        field(68048; "Investment B/F"; Decimal)
        {
        }
        field(68049; "Dividend Amount"; Decimal)
        {
            CalcFormula = sum("Dividends Progression"."Gross Dividends" where("Account No" = field("No.")));
            FieldClass = FlowField;
        }
        field(68050; "First Name"; Text[50])
        {

            trigger OnValidate()
            begin
                Name := "First Name" + ' ' + "Second Name" + ' ' + "Last Name";
                Modify;
            end;
        }
        field(68051; "Office Telephone No."; Code[50])
        {
        }
        field(68052; "Extension No."; Code[30])
        {
        }
        field(68053; "Insurance Contribution"; Decimal)
        {

            trigger OnValidate()
            begin
                //Advice:=TRUE;
            end;
        }
        field(68054; Advice; Boolean)
        {
        }
        field(68055; Province; Code[50])
        {
            //TableRelation = "Appraisal Salary Set-up".Code;
        }
        field(68056; "Previous Share Contribution"; Decimal)
        {
        }

        field(68059; "Refund Issued"; Boolean)
        {
            Editable = false;
        }
        field(68060; "Batch No."; Code[20])
        {

            trigger OnValidate()
            begin
                /*IF "Refund Issued"=TRUE THEN BEGIN
                RefundsR.RESET;
                RefundsR.SETRANGE(RefundsR."Member No.","No.");
                IF RefundsR.FIND('-') THEN
                RefundsR.DELETEALL;
                
                "Refund Issued":=FALSE;
                END;
                
                IF "Batch No." <> '' THEN BEGIN
                MovementTracker.RESET;
                MovementTracker.SETRANGE(MovementTracker."Document No.","Batch No.");
                MovementTracker.SETRANGE(MovementTracker."Current Location",TRUE);
                IF MovementTracker.FIND('-') THEN BEGIN
                ApprovalsUsers.RESET;
                ApprovalsUsers.SETRANGE(ApprovalsUsers."Approval Type",MovementTracker."Approval Type");
                ApprovalsUsers.SETRANGE(ApprovalsUsers.Stage,MovementTracker.Stage);
                ApprovalsUsers.SETRANGE(ApprovalsUsers."User ID",USERID);
                IF ApprovalsUsers.FIND('-') = FALSE THEN
                ERROR('You cannot assign a batch which is in %1.',MovementTracker.Station);
                
                END;
                END; */

            end;
        }
        field(68061; "Current Status"; Option)
        {
            OptionMembers = Approved,Rejected;
        }
        field(68062; "Cheque No."; Code[20])
        {
        }
        field(68063; "Cheque Date"; Date)
        {
        }

        field(68065; "Defaulted Loans Recovered"; Boolean)
        {
        }
        field(68066; "Withdrawal Posted"; Boolean)
        {
        }
        field(68069; "Loan No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //TableRelation = Loans."Loan  No." where("Member No." = field("No."));
        }

        field(68071; "Move To1"; Code[30])
        {
            //TableRelation = "Office/Group"."Office/Unit ID";
        }
        field(68073; "File Movement Remarks"; Text[50])
        {
        }
        field(68076; "Status Change Date"; Date)
        {
        }
        field(68077; "Last Payment Date"; Date)
        {
            CalcFormula = max("Credit Ledger Entry"."Posting Date" where("Account No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68078; "Discounted Amount"; Decimal)
        {
        }
        field(68080; "Payroll Updated"; Boolean)
        {
        }
        field(68081; "Last Marking Date"; Date)
        {
        }
        field(68082; "Dividends Capitalised %"; Decimal)
        {

            trigger OnValidate()
            begin
                /*IF ("Dividends Capitalised %" < 0) OR ("Dividends Capitalised %" > 100) THEN
                ERROR('Invalied Entry.');*/

            end;
        }
        field(68085; "Formation/Province"; Code[20])
        {
            //TableRelation = "Member Province"."No.";

            trigger OnValidate()
            begin
                /*Vend.RESET;
                Vend.SETRANGE(Vend."Staff No","Payroll/Staff No");
                IF Vend.FIND('-') THEN BEGIN
                REPEAT
                Vend."Formation/Province":="Formation/Province";
                Vend.MODIFY;
                UNTIL Vend.NEXT=0;
                END;*/

            end;
        }
        field(68086; "Division/Department"; Code[20])
        {
            //TableRelation = "Member Departments"."No.";
        }
        field(68087; "Station/Section"; Code[20])
        {
            //TableRelation = "Member Section"."No.";
        }
        field(68088; "Closing Deposit Balance"; Decimal)
        {
        }
        field(68089; "Closing Loan Balance"; Decimal)
        {
        }
        field(68090; "Closing Insurance Balance"; Decimal)
        {
        }
        field(68091; "Dividend Progression"; Decimal)
        {
        }
        field(68092; "Closing Date"; Date)
        {
            CalcFormula = max("Credit Ledger Entry"."Posting Date" where("Account No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68093; "Welfare Fund"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(68094; "Discounted Dividends"; Decimal)
        {
        }
        field(68095; "Mode of Dividend Payment"; Option)
        {
            OptionCaption = ' ,FOSA,EFT,Cheque,Defaulted Loan (Capitalised)';
            OptionMembers = " ",FOSA,EFT,Cheque,"Defaulted Loan";
        }
        field(68096; "Qualifying Shares"; Decimal)
        {
        }
        field(68097; "Defaulter Overide Reasons"; Text[60])
        {
        }
        field(68098; "Defaulter Overide"; Boolean)
        {

            trigger OnValidate()
            begin
                /*TESTFIELD("Defaulter Overide Reasons");
                
                StatusPermissions.RESET;
                StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"Loan External EFT");
                IF StatusPermissions.FIND('-') = FALSE THEN
                ERROR('You do not have permissions to overide defaulters.'); */

            end;
        }
        field(68099; "Closure Remarks"; Text[40])
        {
        }
        field(68100; "Bank Account Num"; Code[50])
        {
        }
        field(68101; "Bank Code"; Code[20])
        {
            //TableRelation = Banks."Bank Code";
            //  Validate//TableRelation = false;
        }
        field(68102; "Dividend Processed"; Boolean)
        {
        }
        field(68103; "Dividend Error"; Boolean)
        {
        }
        field(68104; "Dividend Capitalized"; Decimal)
        {
        }
        field(68105; "Dividend Paid FOSA"; Decimal)
        {
        }
        field(68106; "Dividend Paid EFT"; Decimal)
        {
        }
        field(68107; "Dividend Withholding Tax"; Decimal)
        {
            CalcFormula = sum("Dividends Progression"."Witholding Tax" where("Account No" = field("No.")));
            FieldClass = FlowField;
        }
        field(68109; "Loan Last Payment Date"; Date)
        {
            FieldClass = Normal;
        }

        field(68112; "Account Category"; Option)
        {
            OptionCaption = 'Member, Staff Account,Board Members,Delegates';
            OptionMembers = Member," Staff Account","Board Members",Delegates;
        }
        field(68113; "Type Of Organisation"; Option)
        {
            OptionCaption = ' ,Club,Association,Partnership,Investment,Merry go round,Other,Group';
            OptionMembers = " ",Club,Association,Partnership,Investment,"Merry go round",Other,Group;
        }
        field(68114; "Source Of Funds"; Option)
        {
            OptionCaption = ' ,Business Receipts,Income from Investment,Salary,Other';
            OptionMembers = " ","Business Receipts","Income from Investment",Salary,Other;
        }
        field(68115; "MPESA Mobile No"; Code[20])
        {
        }
        field(68120; "Group Account No"; Code[20])
        {
            //TableRelation = "SACCO Account"."No." where("Group Account" = const(true));
        }
        field(68121; "Last Advice Date"; Date)
        {
        }
        field(68122; "Advice Type"; Option)
        {
            OptionMembers = " ","New Member","Shares Adjustment","ABF Adjustment","Registration Fees",Withdrawal,Reintroduction,"Reintroduction With Reg Fees";
        }
        field(68140; "Share Balance BF"; Decimal)
        {
            Enabled = false;
        }
        field(68143; "Move to"; Integer)
        {
            //TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));

        }
        field(68144; "File Movement Remarks1"; Option)
        {
            OptionCaption = ' ,Reconciliation purposes,Auditing purposes,Refunds,Loan & Signatories,Withdrawal,Risks payment,Cheque Payment,Custody,Document Filing,Passbook,Complaint Letters,Defaulters,Dividends,Termination,New Members Details,New Members Verification';
            OptionMembers = " ","Reconciliation purposes","Auditing purposes",Refunds,"Loan & Signatories",Withdrawal,"Risks payment","Cheque Payment",Custody,"Document Filing",Passbook,"Complaint Letters",Defaulters,Dividends,Termination,"New Members Details","New Members Verification";
        }
        field(68145; "File MVT User ID"; Code[20])
        {
        }
        field(68146; "File MVT Time"; Time)
        {
        }
        field(68147; "File Previous Location"; Code[20])
        {
        }
        field(68148; "File MVT Date"; Date)
        {
        }
        field(68149; "file received date"; Date)
        {
        }
        field(68150; "File received Time"; Time)
        {
        }
        field(68151; "File Received by"; Code[10])
        {
        }
        field(68152; "file Received"; Boolean)
        {
        }
        field(68153; User; Code[10])
        {
            Enabled = false;
        }
        field(68154; "Change Log"; Integer)
        {
            CalcFormula = count("Change Log Entry" where("Primary Key Field 1 Value" = field("No.")));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(68155; Section; Code[10])
        {
            //TableRelation = if (Section = const('')) testfsdg."Reoayment Method";
        }
        field(68156; Rejoined; Boolean)
        {
        }
        field(68157; "Job title"; Code[50])
        {
        }
        field(68158; Pin; Code[20])
        {
        }
        field(68160; "Remitance mode"; Option)
        {
            OptionCaption = ',Check off,Cash,Standing Order';
            OptionMembers = ,"Check off",Cash,"Standing Order";
        }
        field(68161; "Terms of Service"; Option)
        {
            OptionCaption = ',Permanent,Temporary,Contract';
            OptionMembers = ,Permanent,"Temporary",Contract;
        }

        field(68165; "Work Province"; Code[10])
        {
        }
        field(68166; "Work District"; Code[10])
        {
        }
        field(68167; "Sacco Branch"; Code[10])
        {
        }
        field(68168; "Bank Branch Code"; Code[20])
        {
        }
        field(68169; "Customer Paypoint"; Code[10])
        {
        }
        field(68170; "Date File Opened"; Date)
        {
        }
        field(68171; "File Status"; Code[10])
        {
        }
        field(68172; "Customer Title"; Code[10])
        {
        }
        field(68173; "Folio Number"; Code[20])
        {
        }
        field(68174; "Move to description"; Text[30])
        {
        }
        field(68175; Filelocc; Integer)
        {
            Enabled = false;
        }
        field(68176; "S Card No."; Code[10])
        {
        }
        field(68177; "Reason for file overstay"; Text[50])
        {
            Enabled = false;
        }
        field(68180; "Current Balance"; Decimal)
        {
            Enabled = false;
        }
        field(68181; "Member Transfer Date"; Date)
        {
        }
        field(68182; "Contact Person"; Code[20])
        {
        }
        field(68184; "Current Location"; Text[60])
        {
        }
        field(68185; "Micro Group Code"; Code[30])
        {
        }
        field(68188; "Office Branch"; Code[20])
        {
            //TableRelation = "Member Province"."No.";
        }
        field(68189; Department; Code[20])
        {
            //TableRelation = "Member Departments"."No.";
        }
        field(68190; Occupation; Text[30])
        {
        }
        field(68191; Designation; Text[30])
        {
        }
        field(68192; "Village/Residence"; Text[50])
        {
            //TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));
        }
        field(68193; "Staff Account"; Boolean)
        {
        }
        field(68194; "Contact Person Phone"; Code[30])
        {
            Enabled = false;
        }
        field(68197; "Old Fosa Account"; Code[50])
        {
            Enabled = false;
        }
        field(68198; "Recruited By"; Code[50])
        {
            //TableRelation = Member.Name;
        }
        field(68200; "Contact Person Relation"; Code[20])
        {
            //TableRelation = Member.Name;
        }
        field(68201; "Contact Person Occupation"; Code[20])
        {
        }
        field(68202; "Shares Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loan Guarantors"."Amount Guaranteed" where("SACCO Account No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68204; "File Type"; Option)
        {
            Enabled = false;
            OptionCaption = ' ,Loans,Refunds,Withdrawals - Resignation,Dividends,Examination';
            OptionMembers = " ",Loans,Refunds,"Withdrawals - Resignation",Dividends,Examination;
        }
        field(69048; "Rejoining Date"; Date)
        {
        }
        field(69051; "Member Deposit *3"; Decimal)
        {
        }
        field(69052; "New Loan Eligibility"; Decimal)
        {
            Enabled = false;
        }
        field(69053; "Bank Name"; Text[50])
        {
        }
        field(69054; "Bank Account No"; Code[30])
        {
        }
        field(69055; Membership; Option)
        {
            OptionCaption = ' ,Ordinary,Preferential';
            OptionMembers = " ",Ordinary,Preferential;
        }
        field(69056; "Benevolent Fund No."; Code[10])
        {
        }
        field(69057; "Group Account"; Boolean)
        {
        }
        field(69058; "Sent To"; Code[50])
        {
            Caption = 'Sent To';
            NotBlank = true;
            //TableRelation = User."User Name";
            //This property is currently not supported
            //Test//TableRelation = false;
            // Validate//TableRelation = false;


            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin


            end;
        }
        field(69059; "Received By"; Code[50])
        {
            Caption = 'Received By';
            NotBlank = true;
            //TableRelation = User."User Name";
            //This property is currently not supported
            //Test//TableRelation = false;
            //Validate//TableRelation = false;

        }
        field(69060; "Second Name"; Text[50])
        {
            Description = '// Bandari sacco- Maintain names separately';

            trigger OnValidate()
            begin
                Name := "First Name" + ' ' + "Second Name" + ' ' + "Last Name";
                Modify;
            end;
        }
        field(69061; "Last Name"; Text[50])
        {
            Description = '// Bandari Maintain Names separately';

            trigger OnValidate()
            begin
                Name := "First Name" + ' ' + "Second Name" + ' ' + "Last Name";
                Modify;
            end;
        }
        field(69065; "Product Type"; Code[20])
        {
            //TableRelation = "Product Factory"."Product ID";
        }
        field(69066; "Signing Instructions"; Option)
        {
            OptionCaption = 'Single,All must Sign,Either Must Sign';
            OptionMembers = Single,"All must Sign","Either Must Sign";
        }
        field(69067; "Fixed Deposit Type"; Code[20])
        {
            //TableRelation = "Fixed Deposit Type".Code;

        }
        field(69068; "FD Maturity Date"; Date)
        {
        }
        field(69069; "Fixed Deposit"; Boolean)
        {
        }
        field(69070; "Member No."; Code[20])
        {
            //TableRelation = Member."No.";
        }
        field(69071; "Neg. Interest Rate"; Decimal)
        {
        }
        field(69072; "Account Product Category"; Option)
        {
            OptionCaption = ' ,Loan,Savings';
            OptionMembers = " ",Loan,Savings;
        }
        field(69073; "Product Name"; Text[50])
        {
        }
        field(69074; "Account Type"; Option)
        {
            OptionCaption = ' ,Savings Account,Personal Savings,Microfinance Savings,Salary Account,Share Deposit Account,Fixed Deposit Account,Others(Specify)';
            OptionMembers = " ","Savings Account","Personal Savings","Microfinance Savings","Salary Account","Share Deposit Account","Fixed Deposit Account","Others(Specify)";
        }
        field(69075; "Can Guarantee Loan"; Boolean)
        {
        }
        field(69076; "Loan Disbursement Account"; Boolean)
        {
        }
        field(69077; "Loan Security Inclination"; Option)
        {
            OptionCaption = ' ,Short Loan Security,Long Term Loan Security,Share Capital';
            OptionMembers = " ","Short Term Loan Security","Long Term Loan Security","Share Capital";
        }
        field(69080; "Last Withdrawal Date"; Date)
        {
        }
        field(69081; "Expected Maturity Date"; Date)
        {
        }
        field(69083; "Staff User Id"; Code[30])
        {
        }
        field(69084; "Salary Processing"; Boolean)
        {
        }
        field(69085; "Net Salary"; Decimal)
        {
        }
        field(69086; "Standing Order Account"; Boolean)
        {
        }
        field(69087; "FD Duration"; DateFormula)
        {
        }
        field(69088; "FD Maturity Instructions"; Option)
        {
            OptionCaption = ' ,Capitalize,Transfer to Saving';
            OptionMembers = " ",Capitalize,"Transfer to Saving";
        }
        field(69089; "Interest Earned"; Decimal)
        {
            CalcFormula = sum("Interest Buffer"."Interest Amount" where("Account No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69090; "Untranfered Interest"; Decimal)
        {
            CalcFormula = sum("Interest Buffer"."Interest Amount" where("Account No" = field("No."),
                                                                         Transferred = filter(false)));
            FieldClass = FlowField;
        }
        field(69091; "Not Qualify for Interest"; Boolean)
        {
        }
        field(69092; "Fixed Deposit Status"; Option)
        {
            OptionCaption = ' ,Active,Matured,Closed,Not Matured';
            OptionMembers = " ",Active,Matured,Closed,"Not Matured";
        }
        field(69093; "Closure Transfer Acc"; Boolean)
        {
        }
        field(69096; "Relates to Business/Group"; Boolean)
        {
        }
        field(69097; "Type of Business"; Option)
        {
            OptionCaption = ' ,Sole Proprietor,Paerneship,Limited Liability Company,Informal Body,Registered Group,Other(Specify)';
            OptionMembers = " ","Sole Proprietor",Paerneship,"Limited Liability Company","Informal Body","Registered Group","Other(Specify)";
        }
        field(69098; "Other Business Type"; Text[15])
        {
        }
        field(69099; "Ownership Type"; Option)
        {
            OptionCaption = ' ,Personal Account,Joint Account,Group/Business,FOSA Shares';
            OptionMembers = " ","Personal Account","Joint Account","Group/Business","FOSA Shares";
        }
        field(69100; "Other Account Type"; Text[15])
        {
        }
        field(69101; "Nature of Business"; Text[30])
        {
        }
        field(69102; "Company Registration No."; Code[20])
        {
        }
        field(69103; "Date of Business Reg."; Date)
        {
        }
        field(69104; "Business/Group Location"; Text[50])
        {
        }
        field(69105; "Business P.I.N"; Code[20])
        {
        }
        field(69106; "Plot/Bldg/Street/Road"; Text[50])
        {
        }
        field(69107; "Group Type"; Option)
        {
            OptionCaption = ' ,Welfare,Microfinance';
            OptionMembers = " ",Welfare,Microfinance;
        }
        field(69108; "Single Party/Multiple"; Option)
        {
            OptionCaption = 'Single,Multiple';
            OptionMembers = Single,Multiple;
        }
        field(69109; "Pay Sheet No."; Code[20])
        {
        }
        field(69110; "Birth Certificate No."; Code[20])
        {
        }
        field(69111; "FD Start Date"; Date)
        {

            trigger OnValidate()
            begin
                "FD Maturity Date" := CalcDate("FD Duration", "FD Start Date");
                //VALIDATE
            end;
        }
        field(69112; "ATM No."; Code[20])
        {
        }
        field(69113; "Withdrawals Times"; Integer)
        {
        }
        field(69114; "Interest on Deposits"; Decimal)
        {
        }
        field(69115; "Amount to Transfer"; Decimal)
        {

            trigger OnValidate()
            begin
                Validate("FD Reference No");
            end;
        }
        field(69116; "FD Reference No"; Code[20])
        {
        }
        field(69117; "Protected Account"; Boolean)
        {
        }
        field(69118; "Created By"; Code[50])
        {
        }
        field(69119; "User Id"; Code[50])
        {
        }
        field(69120; "Loan Recovery-Jnl"; Decimal)
        {
            CalcFormula = sum("Gen. Journal Line".Amount where("Account No." = field("No."),
                                                                "Journal Batch Name" = const('LOANREC')));
            FieldClass = FlowField;
        }
        field(69121; "Member Segment"; Code[20])
        {
            //TableRelation = "Member Segment"."Segement code";
        }
        field(69122; "Signing Instructions Narration"; Text[100])
        {
        }
        field(69123; "Net Dividend"; Decimal)
        {
            CalcFormula = sum("Dividends Progression"."Net Dividends" where("Account No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69126; "Block Instant Loans"; Boolean)
        {
        }
        field(69127; "Dormant SMS Date"; Date)
        {
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; "Customer Posting Group")
        {
        }
        key(Key4; "Currency Code")
        {
        }
        key(Key5; "Country/Region Code")
        {
        }
        key(Key6; "Gen. Bus. Posting Group")
        {
        }
        key(Key7; Name, "Current Address", City)
        {
        }
        key(Key8; Name)
        {
        }
        key(Key9; City)
        {
        }
        key(Key10; "Post Code")
        {
        }
        key(Key11; "Phone No.")
        {
        }
        key(Key12; Contact)
        {
        }
        key(Key13; "Employer Code")
        {
        }
        key(Key14; "Member No.")
        {
        }
    }

    fieldgroups
    {
    }





    var
        Text000: label 'You cannot delete %1 %2 because there is at least one outstanding Sales %3 for this customer.';
        Text002: label 'Do you wish to create a contact for %1 %2?';
        CommentLine: Record "Comment Line";
        SalesOrderLine: Record "Sales Line";
        CustBankAcc: Record "Customer Bank Account";
        ShipToAddr: Record "Ship-to Address";
        PostCode: Record "Post Code";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        ShippingAgentService: Record "Shipping Agent Services";
        SalesPrepmtPct: Record "Sales Prepayment %";
        ServContract: Record "Service Contract Header";
        ServHeader: Record "Service Header";
        ServiceItem: Record "Service Item";
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromCust: Codeunit "CustCont-Update";
        DimMgt: Codeunit DimensionManagement;
        InsertFromContact: Boolean;
        Text003: label 'Contact %1 %2 is not related to customer %3 %4.';
        Text004: label 'post';
        Text005: label 'create';
        Text006: label 'You cannot %1 this type of document when Customer %2 is blocked with type %3';
        Text007: label 'You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.';
        Text008: label 'Deleting the %1 %2 will cause the %3 to be deleted for the associated Service Items. Do you want to continue?';
        Text009: label 'Cannot delete customer.';
        Text010: label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3. Enter another code.';
        Text011: label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text012: label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text013: label 'You cannot delete %1 %2 because there is at least one outstanding Service %3 for this customer.';
        Text014: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text015: label 'You cannot delete %1 %2 because there is at least one %3 associated to this customer.';
        Loans: Record Loans;
        //GenSetUp: Record UnknownRecord39004243;
        MinShares: Decimal;
        //MovementTracker: Record UnknownRecord39004256;
        Cust: Record "SACCO Account";
        Vend: Record "Savings Accounts";
        CustFosa: Code[20];
        Vend2: Record "Savings Accounts";
        FOSAAccount: Record "Savings Accounts";
        Text001: label 'You cannot delete %1 %2 because there is at least one transaction %3 for this customer.';
        InterestBuffer: Record "Interest Buffer";
        IntRate: Decimal;
        DocNo: Code[10];
        PDate: Date;
        IntBufferNo: Integer;
        MidMonthFactor: Decimal;
        DaysInMonth: Integer;
        StartDate: Date;
        IntDays: Integer;
        AsAt: Date;
        MinBal: Boolean;
        AccruedInt: Decimal;
        RIntDays: Integer;
        Bal: Decimal;
        DFilter: Text[50];
        DURATION1: Integer;
        FXDCODE: Code[20];
        Rate: Decimal;
        FXDINterest: Decimal;
        "Sacco Account": Record "SACCO Account";
        Account: Record "SACCO Account";
        Text016: label 'You cannot Modify %1 %2 because there is at least one transaction %3 for this Member.';



}

