/// <summary>
/// Table Members (ID 50445).
/// Old Registered members
/// </summary>
table 50445 Members
{
    Caption = 'Members';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Member Listing";
    LookupPageId = "Member Listing";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            trigger OnValidate()
            var
                Loans: Record Loans;
                Account: Record "Member Accounts";
            begin
                Loans.Reset();
                Loans.SetRange("Member No.", "No.");
                if Loans.FindFirst() then begin
                    Loans.ModifyAll("Member Name", Name);
                end;

                Account.Reset();
                Account.SetRange("Member No.", "No.");
                if Account.FindFirst() then begin
                    Account.ModifyAll("Name", Name);
                end;
            end;
        }


        field(4; Address; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; City; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = if ("Country/Region Code" = const('')) "Post Code".City
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity("Phone No.", "Post Code", County, "KRA PIN", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(7; "Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            ExtendedDatatype = PhoneNo;
        }
        field(8; "Country/Region Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                PostCode.ValidateCountryCode("Phone No.", "Post Code", County, "KRA PIN");
            end;
        }
        field(9; "Post Code"; Code[20])
        {
            Editable = false;
            TableRelation = if ("Country/Region Code" = const('')) "Post Code"
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Phone No.", "Post Code", County, "KRA PIN", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(10; County; Text[30])
        {
            Editable = false;
        }

        field(11; "E-Mail"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            ExtendedDatatype = EMail;
            OptimizeForTextSearch = true;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(12; "Work E-Mail"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("Work E-Mail");
            end;
        }
        field(13; "Address Details"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(107; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Member Tier"; Option)
        {
            Caption = 'Member Tier';
            OptionMembers = " ",Silver,Diamond,Gold,Platinum;
            Editable = false;
        }
        field(29; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(51; "Cannot Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
            end;
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
            end;
        }

        field(5061; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;

            /*
            trigger OnValidate()
            var
                Char: DotNet Char;
                i: Integer;
            begin
                for i := 1 to StrLen("Mobile Phone No.") do
                    if Char.IsLetter("Mobile Phone No."[i]) then
                        FieldError("Mobile Phone No.", PhoneNoCannotContainLettersErr);
            end;
            */
        }
        field(50100; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Group,Member';
            OptionMembers = " ",Group,Member;
        }
        field(50101; Nationality; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Member Status"; Enum "Member Status Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "Employer Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Employer));
        }
        field(50106; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                DateofBirthError: label 'This date cannot be greater than today.';
            begin
                if "Date of Birth" <> 0D then
                    if "Date of Birth" > Today then
                        Error('Invalid Date of Birth. Future Date Detected');
            end;
        }
        field(50107; "Terms of Employment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Permanent,Contract,Casual;
        }
        field(50108; "Payroll/Staff No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "ID No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }

        field(50111; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Single,Married,Divorced,Widowed,Others,Seperated';
            OptionMembers = " ",Single,Married,Divorced,Widowed,Others,Seperated;
        }
        field(50112; "ID Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "National ID","Alien ID","Military ID",Passport;
        }
        field(50113; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,Male,Female,Other';
            OptionMembers = "  ",Male,Female,Other;
        }
        field(50114; "First Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50115; "Middle Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50116; Surname; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50117; "Member Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Member,Staff Members,Board Members,Delegates,Non-Member';
            OptionMembers = Member,"Staff Members","Board Members",Delegates,"Non-Member";
        }
        field(50118; "Test No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50119; "Group Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50120; "Bank Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50121; "Bank Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50122; "Branch Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50123; "Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50124; "Bank Account No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50125; "KRA PIN"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50126; "Recruited by Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Walk In",Marketer,Staff,"Board Member",Member,Website;

            trigger OnValidate()
            begin
                "Recruited By" := '';
                "Recruited By Name" := '';
            end;
        }
        field(50127; "Relationship Officer"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                "Relationship Officer Name" := '';
                if Employee.Get("Relationship Officer") then begin
                    "Relationship Officer Name" := Employee."First Name" + ' ' + Employee."Last Name";
                end;
            end;
        }
        field(50128; "Employer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50129; "Old Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Restricted Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Recruited By"; Code[100])
        {
            Caption = 'Recruited By';
            DataClassification = ToBeClassified;
        }
        field(50033; "Company No."; Code[20])
        {
            Caption = 'Company No.';
            DataClassification = ToBeClassified;
            TableRelation = Contact where(Type = const(Company));

            trigger OnValidate()
            var
                Opp: Record Opportunity;
                OppEntry: Record "Opportunity Entry";
                Task: Record "To-do";
                InteractLogEntry: Record "Interaction Log Entry";
                SegLine: Record "Segment Line";
                SalesHeader: Record "Sales Header";
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
            end;
        }
        field(50034; "Company Name"; Text[50])
        {
            Caption = 'Company Name';
            DataClassification = ToBeClassified;
            TableRelation = Contact where(Type = const(Company));
            ValidateTableRelation = false;
        }
        field(50035; "Salutation Code"; Code[10])
        {
            Caption = 'Salutation Code';
            DataClassification = ToBeClassified;
            TableRelation = Salutation;
        }
        field(50036; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Recruited By Name"; Text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Special Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Other Type Of Business"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Business Reg. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Incorporation No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "Date of Bus. Incorporation"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Business/Group Location"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50046; "Plot/Bldg/Street/Road"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50047; "Group Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Single,Joint,Corporate,"Group",Parish,"Church & Church Development",Others,Welfare;
        }
        field(50048; "Other Group Type"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Date of Bus. Reg."; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Group Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Incorporated,"Non-Incorporated";
        }
        field(50051; "Type of Business"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Limited Company","Investment Company","Sole Proprietor",Other;
        }
        field(50052; "Group No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members."No." where(Type = const(Group),
                                                 "Group Section" = filter("Micro Group"));
        }
        field(50053; "Physically Challenged"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Gross Dividends"; Decimal)
        {
            CalcFormula = sum("Dividends Progression"."Gross Dividends" where("Member No" = field("No.")));
            FieldClass = FlowField;
        }
        field(50055; "Cheques Bounced"; Integer)
        {
            CalcFormula = count("Teller Transaction" where("Member No." = field("No."),
                                                            "Cheque Status" = const(Bounced),
                                                            Posted = const(true)));
            FieldClass = FlowField;
        }
        field(50056; "Account Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Individual,Joint,Chamaa,Business,MicroGroup,Welfare;
        }
        field(50057; "Relationship Officer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Branch Manager"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Branch Manager Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Group Section"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Micro Group","Other Groups";
        }
        field(50061; "Last Deposit Date BF"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Mobile Loan Defaulter"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50063; IsAgencyActivated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; AgencyPin; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(50002; "Document Limit"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Internal Staff Employer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }

        field(39; Blocked; Option)
        {
            OptionMembers = " ",Debit,Credit,All;
        }
        field(40; "Is Defaulter"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(50007; "Dont Charge Transactions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Loan Qualification"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Basic Pay,Gross Pay,Standing Order,Net Pay';
            OptionMembers = "Basic Pay","Gross Pay","Standing Order","Net Pay";
        }
        field(50010; "Self Employed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Stop Interest Due"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50015; "From Another Sacco"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Member Class"; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Class";
        }
        field(50017; "How Did You Know About Us"; Enum "How Did You Know About Us Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Exempt Send SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Exempt Send Email"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50066; "Employment Section"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employment Sections";
        }


        field(50067; Passport; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50069; "Cost Center"; Option)
        {
            OptionMembers = " ",Finance,Operations,Cargo,Commercial,"Corporate Quality Safety & Environment","Information Technology",Jambojet,"Managing Director's Office",People,"Sales - Passenger Services",Technical,Other,"Fahari Aviation","Strategy & Innovation";
        }

        field(50070; "Meeting Day"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50071; "Meeting Location"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(50072; "Signing Instruction narration"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Mandate;
        }

        field(50073; "Previous Sacco No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50074; "Pensioner"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50075; "Commission Paid"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Rejoined"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "Date Rejoined"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50078; "Rejoined By"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50087; "Signing Instructions"; Option)
        {
            OptionMembers = Single,"All must Sign","Either Must Sign";
        }
        field(50088; "Employer Based Staff Nos"; Boolean)
        {
        }
        field(50089; "EmailAddress 1"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(50090; "EmailAddress 2"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(50091; "Phone Number"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50093; "Phone Number 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50094; "Contact Name 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50095; EmailAddress; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(50097; "Block Mobile Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50098; "Block Guarantorship"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50099; "Rewarded"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50200; "Lease Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50201; "Lease End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50202; "Annual Lease Increment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50203; "Mobile Blacklisted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50205; Residential; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(50207; "Employement Sector"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employement Sectors".Description;

            trigger OnValidate()
            var
                EmpSector: Record "Employement Sectors";
            begin
                if "Employement Sector" = '' then
                    exit;

                EmpSector.SetRange(Description, "Employement Sector");
                if not EmpSector.FindFirst() then
                    exit;

                if "Employment Info" in ["Employment Info"::Business,
                                          "Employment Info"::Contracting,
                                          "Employment Info"::"Self-Employed"] then begin
                    "Business Name" := EmpSector.Description;
                    "Business/Group Location" := EmpSector.Location;
                end;
            end;
        }
        field(50208; State; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50209; Country; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50210; "Level of Employement"; Option)
        {
            OptionMembers = " ",Management;
        }
        field(50211; "Remit Checkoff"; Boolean)
        {
        }
        field(50212; "Checkoff Station"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Employer));

            trigger OnValidate()
            Var
                Cust: Record Customer;
            begin

            end;
        }
        field(50213; "Rejoined No."; Integer)
        {
            CalcFormula = count("Member Changes" where("Member No." = field("No."), "Change Type" = filter(Rejoining)));
            FieldClass = FlowField;
        }
        field(50215; Locality; Option)
        {
            OptionMembers = Local,Diaspora;
        }
        field(50216; "Checkoff Station Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50217; "GFE Members No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50218; "Passport Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50219; "Member Electoral Zone"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Electoral Zones".Code WHERE(Type = CONST("Electral Zone"));
        }
        field(50220; "Trading As"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50221; Remarks; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(50222; "Self Guaranteed Amount"; Decimal)
        {
            CalcFormula = sum("Loan Security"."Current Committed" where("Member No" = field("No."), "Self Guarantee" = const(true), Substituted = const(false),
                                                                         "Guarantor Type" = const(Guarantor)));
            FieldClass = FlowField;
        }
        field(50223; "Old Payroll No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50224; "CRB Company Type"; text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50225; "CRB Industry Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50226; Religion; Option)
        {
            OptionMembers = " ",Christian,Muslim;
        }

        field(50227; "Recruited By Phone"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50228; "Document Type"; enum "Sales Document Type")
        {
            DataClassification = ToBeClassified;

        }
        field(50229; "Business Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50230; "Position Held"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50231; "Reference Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50180; "Member Registration Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Registration Date" > Today then Error(DateError, FieldCaption("Member Registration Date"));

            end;
        }
        field(50232; "Employment Info"; Option)
        {
            OptionMembers = Employed,UnEmployed,Contracting,Business,"Self-Employed",Pensioner,Permanent;
        }
        field(50233; "ID Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50234; "Account Manager"; code[80])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Loan Officer" where(
            "Member No." = field("No."),
            Posted = const(true), "Outstanding Principal" = filter(> 0)));
        }



    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(KeyMemberStatus; "Member Status")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "ID No.", "Mobile Phone No.", Name, "Member Status", "Old Member No.")
        {

        }

    }


    var
        DateError: label '%1 cannot be greater than today.';
        SalesSetup: Record "Sales & Receivables Setup";
        CommentLine: Record "Comment Line";
        MemberAccounts: Record "Savings Accounts";
        SalesOrderLine: Record "Sales Line";
        CustBankAcc: Record "Customer Bank Account";
        ShipToAddr: Record "Ship-to Address";
        PostCode: Record "Post Code";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        ShippingAgentService: Record "Shipping Agent Services";
        //ItemCrossReference: Record "Item Cross Reference";
        RMSetup: Record "Marketing Setup";
        //SalesPrice: Record "Sales Price";
        //SalesLineDisc: Record "Sales Line Discount";
        SalesPrepmtPct: Record "Sales Prepayment %";
        ServContract: Record "Service Contract Header";
        ServiceItem: Record "Service Item";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromCust: Codeunit "CustCont-Update";
        DimMgt: Codeunit DimensionManagement;
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
        InsertFromContact: Boolean;
        InsertFromTemplate: Boolean;
        LookupRequested: Boolean;
        Members: Record Members;
        AppAccountSignatories: Record "Account Signatories.";
        AccountSignatories: Record "Account Signatories.";

    procedure CheckBlockedCust(Cust2: Record Members)
    var
        Source: Option Journal,Document;
    begin

        if (Cust2.Blocked = Cust2.Blocked::All) then
            Error('Member %1, is Blocked with Type All', Cust2."No." + '-' + Cust2.Name);
    end;

}
