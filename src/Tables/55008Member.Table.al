Table 55008 "OLD Member"
{
    Caption = 'Member';
    DataCaptionFields = "No.", Name;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            //SQLDataType = Varchar;

            trigger OnValidate()
            begin
                //IF "Customer Type"="Customer Type"::Member THEN BEGIN

                //END;



                //Prevent Changing once entries exist
            end;
        }
        field(2; Name; Text[80])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
                /*
                StatusPermissions.RESET;
                StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::NameEdit);
                IF StatusPermissions.FIND('-') = FALSE THEN
                ERROR('You do not have permissions to edit the name.');
                    */

            end;
        }
        field(3; "Search Name"; Code[80])
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
        field(9; "Phone No."; Text[80])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
        field(11; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';
        }
        field(12; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            //TableRelation = Territory;
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(15; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            //TableRelation = Currency;
        }
        field(16; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            //TableRelation = User."User Name";
        }
        field(17; Nationality; Code[10])
        {
            Caption = 'Nationality';
            //TableRelation = "Country/Region";
        }
        field(19; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
        }
        field(20; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(21; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(22; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(23; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(24; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(25; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
                //VATRegNoFormat.Test("VAT Registration No.",Nationality,"No.",DATABASE::Customer);
            end;
        }
        field(26; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(27; "Post Code"; Code[20])
        {
            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(28; County; Text[30])
        {
            Caption = 'County';
        }
        field(29; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(30; "Current Location"; Text[80])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(31; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            //TableRelation = "No. Series";
        }
        field(32; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            //TableRelation = Currency;
        }
        field(33; "Primary Contact No."; Code[20])
        {
            Caption = 'Primary Contact No.';
            //TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
                /*ContBusRel.SETCURRENTKEY("Link to Table","No.");
                ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
                ContBusRel.SETRANGE("No.","No.");
                IF ContBusRel.FINDFIRST THEN
                  Cont.SETRANGE("Company No.",ContBusRel."Contact No.")
                ELSE
                  Cont.SETRANGE("No.",'');
                
                IF "Primary Contact No." <> '' THEN
                  IF Cont.GET("Primary Contact No.") THEN ;
                IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN
                  VALIDATE("Primary Contact No.",Cont."No.");
                  */

            end;

            trigger OnValidate()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
                /*Contact := '';
                IF "Primary Contact No." <> '' THEN BEGIN
                  Cont.GET("Primary Contact No.");
                
                  ContBusRel.SETCURRENTKEY("Link to Table","No.");
                  ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
                  ContBusRel.SETRANGE("No.","No.");
                  ContBusRel.FIND('-');
                
                  IF Cont."Company No." <> ContBusRel."Contact No." THEN
                    ERROR(Text003,Cont."No.",Cont.Name,"No.",Name);
                
                  IF Cont.Type = Cont.Type::Person THEN
                    Contact := Cont.Name
                END;
                */

            end;
        }
        field(34; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            //TableRelation = "Responsibility Center";
        }
        field(35; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            //TableRelation = "Base Calendar";
        }
        field(36; "Customer Type"; Option)
        {
            OptionCaption = ' ,Welfare,Micro finance, Partnership';
            OptionMembers = " ",Welfare,"Micro finance"," Partnership";
        }
        field(37; "Registration Date"; Date)
        {
        }
        field(38; Status; Option)
        {
            OptionCaption = 'New,Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter';
            OptionMembers = New,Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter;
        }
        field(39; "Loan Product Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //TableRelation = "Loan Product Types".Code;
        }
        field(40; "Employer Code"; Code[100])
        {
            //TableRelation = Employer.Code;

        }
        field(41; "Date of Birth"; Date)
        {

            trigger OnValidate()
            begin
                /*IF "Date of Birth" <> 0D THEN BEGIN
                IF GenSetUp.GET(0) THEN BEGIN
                IF CALCDATE(GenSetUp."Min. Member Age","Date of Birth") > TODAY THEN
                ERROR('Applicant bellow the mininmum membership age of %1',GenSetUp."Min. Member Age");
                END;
                END;*/
                /*
                 IF "Date of Birth" > TODAY THEN
                 ERROR('Date of birth cannot be greater than today');
                   */

            end;
        }
        field(42; "E-Mail (Personal)"; Text[50])
        {
        }
        field(43; "Station/Department"; Code[20])
        {
            //TableRelation = Stations.Code where ("Employer Code"=field("Employer Code"));
        }
        field(44; "Home Address"; Text[50])
        {
        }
        field(45; Location; Text[50])
        {
        }
        field(46; "Sub-Location"; Text[50])
        {
        }
        field(47; "District/County"; Text[50])
        {
        }
        field(48; "Resons for Status Change"; Text[80])
        {
        }
        field(49; "Payroll No./Check No."; Code[20])
        {

            trigger OnValidate()
            begin

                //Update Staff no in all accounts
                SaccoAccount.Reset;
                SaccoAccount.SetRange(SaccoAccount."Member No.", "No.");
                if SaccoAccount.Find('-') then begin
                    repeat
                        if "Single Party/Multiple" = "single party/multiple"::Multiple then begin
                            SaccoAccount.Name := Name;
                        end else begin
                            SaccoAccount."First Name" := "First Name";
                            SaccoAccount.Validate(SaccoAccount."First Name");
                            SaccoAccount."Second Name" := "Second Name";
                            SaccoAccount.Validate(SaccoAccount."Second Name");
                            SaccoAccount."Last Name" := "Last Name";
                            SaccoAccount.Validate(SaccoAccount."Last Name");
                        end;
                        SaccoAccount."Payroll/Staff No" := "Payroll No./Check No.";
                        SaccoAccount."ID No." := "ID No.";
                        SaccoAccount."Mobile Phone No" := "Mobile Phone No";
                        SaccoAccount.Modify;
                    until SaccoAccount.Next = 0;
                end;



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
        field(50; "ID No."; Code[50])
        {

            trigger OnValidate()
            begin

                //Update all member sacco accounts
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
        field(51; "Mobile Phone No"; Code[50])
        {

            trigger OnValidate()
            begin


                //Choose a way of updating all accounts under sacco account where the member belongs
                /*Vend.RESET;
                Vend.SETRANGE(Vend."Staff No","Payroll/Staff No");
                IF Vend.FIND('-') THEN
                Vend.MODIFYALL(Vend."Mobile Phone No","Mobile Phone No");
                
                Cust.RESET;
                Cust.SETRANGE(Cust."Payroll/Staff No","Payroll/Staff No");
                IF Cust.FIND('-') THEN
                Cust.MODIFYALL(Cust."Mobile Phone No","Mobile Phone No");
                
                
                Vend.RESET;
                Vend.SETRANGE(Vend."Staff No","Payroll/Staff No");
                IF Vend.FIND('-') THEN BEGIN
                REPEAT
                Vend."Mobile Phone No":="Mobile Phone No";
                Vend.MODIFY;
                UNTIL Vend.NEXT=0;
                END;
                
                Cust.RESET;
                Cust.SETRANGE(Cust."Payroll/Staff No","Payroll/Staff No");
                IF Cust.FIND('-') THEN BEGIN
                REPEAT
                IF Cust."No." <> "No." THEN BEGIN
                Cust."Mobile Phone No":="Mobile Phone No";
                Cust.MODIFY;
                
                END;
                
                UNTIL Cust.NEXT = 0;
                END;
                */

            end;
        }
        field(52; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Divorced,Widower,Widow;
        }
        field(53; Signature; Blob)
        {
            Caption = 'Signature';
            SubType = Bitmap;
        }
        field(54; "Passport No."; Code[50])
        {
        }
        field(55; Gender; Option)
        {
            OptionCaption = '  ,Male,Female';
            OptionMembers = "  ",Male,Female;

            trigger OnValidate()
            begin
                //Update all related accounts with gender
            end;
        }
        field(56; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(57; "Society Code"; Code[20])
        {
        }
        field(58; "First Name"; Text[50])
        {

            trigger OnValidate()
            begin
                Name := "First Name" + ' ' + "Second Name" + ' ' + "Last Name";
                //MODIFY;
            end;
        }
        field(59; "Office Telephone No."; Code[50])
        {
        }
        field(60; Province; Code[50])
        {
            //TableRelation = "Appraisal Salary Set-up".Code;
        }
        field(61; "Loan No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //TableRelation = Loans."Loan  No." where ("Member No."=field("No."));
        }
        field(62; "Account Category"; Option)
        {
            OptionCaption = 'Member,Staff Members,Board Members,Delegates';
            OptionMembers = Member,"Staff Members","Board Members",Delegates;
        }
        field(63; "Type Of Organisation"; Option)
        {
            OptionCaption = ' ,Club,Association,Partnership,Investment,Merry go round,Other,Group';
            OptionMembers = " ",Club,Association,Partnership,Investment,"Merry go round",Other,Group;
        }
        field(64; "MPESA Mobile No"; Code[20])
        {
        }
        field(65; "Group Account No"; Code[20])
        {
            //TableRelation = Member."No." where ("Group Account"=const(true));
        }
        field(66; "Customer Paypoint"; Code[10])
        {
        }
        field(67; "Contact Person"; Code[50])
        {
            //TableRelation = Member."No.";
        }
        field(68; "Contact Person Phone"; Code[30])
        {
            Enabled = false;
        }
        field(69; "Recruited By"; Code[50])
        {
            //TableRelation = Member."No.";
        }
        field(70; "ContactPerson Relation"; Code[20])
        {
            //TableRelation = Member.Name;
        }
        field(71; "ContactPerson Occupation"; Code[20])
        {
            Enabled = false;
        }
        field(72; "Benevolent Fund No."; Code[30])
        {
            Enabled = false;
        }
        field(73; "Group Account"; Boolean)
        {
        }
        field(74; "Second Name"; Text[50])
        {
            Description = '// Bandari sacco- Maintain names separately';

            trigger OnValidate()
            begin
                Name := "First Name" + ' ' + "Second Name" + ' ' + "Last Name";
                //MODIFY;
            end;
        }
        field(75; "Last Name"; Text[50])
        {
            Description = '// Bandari Maintain Names separately';

            trigger OnValidate()
            begin
                Name := "First Name" + ' ' + "Second Name" + ' ' + "Last Name";
                //MODIFY;
            end;
        }
        field(76; Division; Text[50])
        {
        }
        field(77; "Employment / Occupation Detail"; Text[50])
        {
        }
        field(78; "Employer's Postal Address"; Text[150])
        {
        }
        field(79; "Member Segment"; Code[20])
        {
            //TableRelation = "Member Segment"."Segement code";
        }
        field(80; "Membership Type"; Option)
        {
            OptionCaption = ' ,Ordinary,Preferential';
            OptionMembers = " ",Ordinary,Preferential;
        }
        field(81; "Pay Sheet No."; Code[20])
        {
        }
        field(82; "Transacting Mandate"; Text[150])
        {
        }
        field(83; "Transaction Alert"; Text[150])
        {
        }
        field(84; "Sector Code"; Text[150])
        {
        }
        field(85; "Status - Withdrawal App."; Option)
        {
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
        }
        field(86; "Withdrawal Posted"; Boolean)
        {
        }
        field(87; "Account Type"; Option)
        {
            OptionCaption = ' ,Savings Account,Personal Savings,Microfinance Savings,Salary Account,Share Deposit Account,Fixed Deposit Account,Others(Specify)';
            OptionMembers = " ","Savings Account","Personal Savings","Microfinance Savings","Salary Account","Share Deposit Account","Fixed Deposit Account","Others(Specify)";
        }
        field(88; "Relates to Business/Group"; Boolean)
        {
        }
        field(89; "Type of Business"; Option)
        {
            OptionCaption = ' ,Sole Proprietor,Paerneship,Limited Liability Company,Informal Body,Registered Group,Other(Specify)';
            OptionMembers = " ","Sole Proprietor",Paerneship,"Limited Liability Company","Informal Body","Registered Group","Other(Specify)";
        }
        field(90; "Other Business Type"; Text[15])
        {
        }
        field(91; "Ownership Type"; Option)
        {
            OptionCaption = ' ,Personal Account,Joint Account,Group/Business,FOSA Shares';
            OptionMembers = " ","Personal Account","Joint Account","Group/Business","FOSA Shares";
        }
        field(92; "Other Account Type"; Text[15])
        {
        }
        field(93; "Nature of Business"; Text[30])
        {
        }
        field(94; "Company Registration No."; Code[20])
        {
        }
        field(95; "Date of Business Reg."; Date)
        {
        }
        field(96; "Business/Group Location"; Text[50])
        {
        }
        field(97; "Business P.I.N"; Code[20])
        {
        }
        field(98; "Plot/Bldg/Street/Road"; Text[50])
        {
        }
        field(99; "Group Type"; Option)
        {
            OptionCaption = ' ,Welfare,Microfinance';
            OptionMembers = " ",Welfare,Microfinance;
        }
        field(100; "Single Party/Multiple"; Option)
        {
            OptionCaption = 'Single,Multiple';
            OptionMembers = Single,Multiple;
        }
        field(101; "Birth Certificate No."; Code[20])
        {
        }
        field(102; "Current Residence"; Text[30])
        {
        }
        field(103; "Withdrawal Notice Date"; Date)
        {

            trigger OnValidate()
            begin

                "Withdrawal Maturity Date" := 0D;

                if "Withdrawal Notice Date" < WorkDate then
                    Error('Cannot back date a withrwal');

                "Withdrawal Maturity Date" := CalcDate('60D', "Withdrawal Notice Date");
            end;
        }
        field(104; "Withdrawal Maturity period"; DateFormula)
        {
        }
        field(105; "Withdrawal Maturity Date"; Date)
        {
        }
        field(106; "Employer Name"; Text[200])
        {
        }
        field(107; Savings; Decimal)
        {
            FieldClass = Normal;
        }
        field(108; "Total Loan Balance"; Decimal)
        {
            FieldClass = Normal;
        }
        field(109; Tag; Text[250])
        {

            trigger OnValidate()
            begin
                "Tag Captured By" := UserId;
                Modify;
            end;
        }
        field(110; "Tag Expiry Date"; Date)
        {
        }
        field(111; "Tag Captured By"; Code[30])
        {
        }
        field(112; "Signing Instructions"; Text[100])
        {
        }
        field(113; "Protected Account"; Boolean)
        {
        }
        field(114; "User Id"; Code[50])
        {
            //TableRelation = User."User Name";
            //This property is currently not supported
            //Test//TableRelation = false;
            //Validate//TableRelation = false;
        }
        field(115; "Created By"; Code[50])
        {
        }
        field(116; "Old Account No"; Code[20])
        {
        }
        field(117; "File Movement Remarks"; Text[20])
        {
        }
        field(118; "Move to"; Integer)
        {
            //TableRelation = "Approvals Set Up".Stage where ("Approval Type"=const("File Movement"));
        }
        field(120; "Virtual Member"; Boolean)
        {
        }
        field(121; "File sent to"; Code[50])
        {
            //TableRelation = User."User Name";
            //This property is currently not supported
            //Test//TableRelation = false;
            //Validate//TableRelation = false;
        }
        field(122; "Current Shares"; Decimal)
        {
        }
        field(123; "Member Category"; Option)
        {
            OptionCaption = ' ,Member,Non-Member,Account Holder';
            OptionMembers = " ",Member,"Non-Member","Account Holder";
        }
        field(124; "Pic Found"; Boolean)
        {
        }
        field(125; "Signature Found"; Boolean)
        {
        }
        field(126; "Enable SMS?"; Boolean)
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
        key(Key3; "Base Calendar Code")
        {
        }
        key(Key4; Name, "Current Address", City)
        {
        }
        key(Key5; Name)
        {
        }
        key(Key6; City)
        {
        }
        key(Key7; "Phone No.")
        {
        }
        key(Key8; Contact)
        {
        }
        key(Key9; "User Id")
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
        RMSetup: Record "Marketing Setup";
        SalesPrepmtPct: Record "Sales Prepayment %";
        ServContract: Record "Service Contract Header";
        ServHeader: Record "Service Header";
        ServiceItem: Record "Service Item";
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
        MinShares: Decimal;
        Cust: Record "OLD Member";
        Vend: Record "Savings Accounts";
        CustFosa: Code[20];
        Vend2: Record "Savings Accounts";
        FOSAAccount: Record "Savings Accounts";
        Text001: label 'You cannot delete %1 %2 because there is at least one transaction %3 for this customer.';
        SaccoAccount: Record "SACCO Account";

}

