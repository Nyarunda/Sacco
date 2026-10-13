
Table 50151 "Member Registration"
{
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Member Registration List";
    LookupPageID = "Member Registration List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin

                if "No." <> xRec."No." then begin

                    NSetup.Get;
                    NoSeries.TestManual(NSetup."Member Application Nos.");
                    "No. Series" := '';

                end;
            end;
        }
        field(2; Name; Text[200])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                if "Account Category" = "account category"::Individual then begin
                    NameBreakdown;
                    ProcessNameChange;
                end;
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
        field(5; Address; Text[50])
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
            TableRelation = if ("Country/Region Code" = const('')) "Post Code".City
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(9; "Alternative Phone No."; Text[30])
        {
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            begin
                if "Alternative Phone No." <> '' then begin
                    TestField("Country/Region Code");
                    CountryRegion.Get("Country/Region Code");
                    CountryRegion.TestField("Phone Code Format");
                    CodeLength := StrLen(CountryRegion."Phone Code Format");
                    CountryRegion.TestField("Phone No. Length");

                    /* if CopyStr("Alternative Phone No.", 1, CodeLength) <> CountryRegion."Phone Code Format" then
                        Error('Invalid Phone. No. Country Phone Code %1 Required', CountryRegion."Phone Code Format");

                    TestPhone := DelChr("Alternative Phone No.", '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|-|_');
                    if TestPhone <> "Alternative Phone No." then
                        Error('Invalid Phone No. Invalid Character detected');

                    if StrLen("Alternative Phone No.") <> CountryRegion."Phone No. Length" then
                        Error('Invalid Phone No. Length should be %1', CountryRegion."Phone No. Length"); */
                end;
            end;
        }
        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
        field(15; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(22; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(24; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(29; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                PostCode.ValidateCountryCode(City, "Post Code", County, "Country/Region Code");
                if "Country/Region Code" <> xRec."Country/Region Code" then
                    VATRegistrationValidation;


                if CountryRegion.Get("Country/Region Code") then begin

                    CountryRegion.TestField("Phone Code Format");
                    CountryRegion.TestField("Mobile Phone. No. Length");
                    "Phone Code" := CountryRegion."Phone Code Format";
                    "Mobile Phone No." := "Phone Code";
                end;
            end;
        }
        field(38; Comment; Boolean)
        {
            CalcFormula = exist("Rlshp. Mgt. Comment Line" where("Table Name" = const(Contact),
                                                                  "No." = field("No."),
                                                                  "Sub No." = const(0)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(84; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(85; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back';
        }
        field(86; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';

            trigger OnValidate()
            begin
                "VAT Registration No." := UpperCase("VAT Registration No.");
                if "VAT Registration No." <> xRec."VAT Registration No." then
                    VATRegistrationValidation;
            end;
        }
        field(89; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = if ("Country/Region Code" = const('')) "Post Code"
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
                Validate("Country/Region Code");
            end;
        }
        field(92; County; Text[30])
        {
            Caption = 'County';
            TableRelation = County;
        }
        field(101; "Work E-Mail"; Text[80])
        {
            Caption = 'Work Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if ("Search E-Mail" = UpperCase(xRec."E-Mail")) or ("Search E-Mail" = '') then
                    "Search E-Mail" := "E-Mail";
                MailManagement.ValidateEmailAddressField("E-Mail");

                Members.reset();
                Members.SetRange("Work E-Mail", "Work E-Mail");
                if Members.FindFirst() then
                    Error('E-mail linked to another account');
            end;
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'Personal Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if ("Search E-Mail" = UpperCase(xRec."E-Mail")) or ("Search E-Mail" = '') then
                    "Search E-Mail" := "E-Mail";
                MailManagement.ValidateEmailAddressField("E-Mail");

                Members.reset();
                Members.SetRange("E-Mail", "E-Mail");
                if Members.FindFirst() then
                    Error('E-mail linked to another account');
            end;
        }
        field(103; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(107; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(140; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
        field(5050; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Group,Member';
            OptionMembers = " ",Group,Member;
        }
        field(5051; "Company No."; Code[20])
        {
            Caption = 'Company No.';
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
        field(5052; "Company Name"; Text[50])
        {
            Caption = 'Company Name';
            TableRelation = Contact where(Type = const(Company));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Validate("Company No.", GetCompNo("Company Name"));
            end;
        }
        field(5053; "Lookup Contact No."; Code[20])
        {
            Caption = 'Lookup Contact No.';
            Editable = false;
            TableRelation = Contact;

            trigger OnValidate()
            begin
                if Type = Type::" " then
                    "Lookup Contact No." := ''
                else
                    "Lookup Contact No." := "No.";
            end;
        }
        field(5054; "First Name"; Text[30])
        {
            Caption = 'First Name';

            trigger OnValidate()
            begin
                Name := CalculatedName;
                ProcessNameChange;
            end;
        }
        field(5055; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';

            trigger OnValidate()
            begin
                Name := CalculatedName;
                ProcessNameChange;
            end;
        }
        field(5056; Surname; Text[30])
        {
            Caption = 'Surname';

            trigger OnValidate()
            begin
                Name := CalculatedName;
                ProcessNameChange;
            end;
        }
        field(5058; "Job Title"; Text[30])
        {
            Caption = 'Job Title';
        }
        field(5059; Initials; Text[30])
        {
            Caption = 'Initials';
        }
        field(5060; "Extension No."; Text[30])
        {
            Caption = 'Extension No.';
        }
        field(5061; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            begin
                if "Mobile Phone No." <> '' then begin
                    TestField("Country/Region Code");
                    CountryRegion.Get("Country/Region Code");
                    CountryRegion.TestField("Phone Code Format");
                    CodeLength := StrLen(CountryRegion."Phone Code Format");
                    CountryRegion.TestField("Mobile Phone. No. Length");

                    if CopyStr("Mobile Phone No.", 1, CodeLength) <> CountryRegion."Phone Code Format" then
                        Error('Invalid Phone. No. Country Phone Code %1 Required', CountryRegion."Phone Code Format");
                    if "Phone Code" = '+254' then
                        TestPhone := DelChr(UpperCase("Mobile Phone No."), '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|-|_')
                    else
                        TestPhone := DelChr(UpperCase("Mobile Phone No."), '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|_');

                    if TestPhone <> "Mobile Phone No." then
                        Error('Invalid Phone No. Invalid Character detected');

                    if StrLen("Mobile Phone No.") <> CountryRegion."Phone No. Length" then
                        Error('Invalid Phone No. Length should be %1', CountryRegion."Phone No. Length");


                    Members.Reset;
                    Members.SetRange("Mobile Phone No.", "Mobile Phone No.");
                    Members.SetRange("Account Category", "Account Category");
                    Members.SetRange("Group Account", "Group Account");
                    if Members.FindSet(false) then
                        repeat
                            if "Phone Code" = '+254' then begin

                                if SpotCash.ConvertPhoneNo(Members."Mobile Phone No.") = SpotCash.ConvertPhoneNo("Mobile Phone No.") then begin
                                    if Members."Account Category" = "Account Category" then
                                        Error('Mobile Phone No. Already linked to Member No. %1 - %2', Members."No.", Members.Name)
                                    else begin
                                        if confirm('Mobile Phone No. Already linked to Member No. ' + Members."No." + ':' + Members.Name + '. Do you want to proceed', false) then
                                            Error('Aborted');
                                    end;
                                end;
                            end
                            else begin

                                if Members."Account Category" = "Account Category" then begin

                                    Members.Reset();
                                    Members.SetRange("Mobile Phone No.", "Mobile Phone No.");
                                    if Members.FindFirst() then
                                        Error('Mobile Phone No. Already linked to Member No. %1 - %2', Members."No.", Members.Name)

                                end
                                else begin
                                    if confirm('Mobile Phone No. Already linked to Member No. ' + Members."No." + ':' + Members.Name + '. Do you want to proceed', false) then
                                        Error('Aborted');
                                end;
                            end
                        until Members.Next() = 0;
                end;
            end;
        }
        field(5062; Pager; Text[30])
        {
            Caption = 'Pager';
        }
        field(5063; "Organizational Level Code"; Code[10])
        {
            Caption = 'Organizational Level Code';
            TableRelation = "Organizational Level";
        }
        field(5064; "Exclude from Segment"; Boolean)
        {
            Caption = 'Exclude from Segment';
        }
        field(5065; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5066; "Next Task Date"; Date)
        {
            CalcFormula = min("To-do".Date where("Contact Company No." = field("Company No."),
                                                  "Contact No." = field(filter("Lookup Contact No.")),
                                                  Closed = const(false),
                                                  "System To-do Type" = const("Contact Attendee")));
            Caption = 'Next Task Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5067; "Last Date Attempted"; Date)
        {
            CalcFormula = max("Interaction Log Entry".Date where("Contact Company No." = field("Company No."),
                                                                  "Contact No." = field(filter("Lookup Contact No.")),
                                                                  "Initiated By" = const(Us),
                                                                  Postponed = const(false)));
            Caption = 'Last Date Attempted';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5068; "Date of Last Interaction"; Date)
        {
            CalcFormula = max("Interaction Log Entry".Date where("Contact Company No." = field("Company No."),
                                                                  "Contact No." = field(filter("Lookup Contact No.")),
                                                                  "Attempt Failed" = const(false),
                                                                  Postponed = const(false)));
            Caption = 'Date of Last Interaction';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5069; "No. of Job Responsibilities"; Integer)
        {
            CalcFormula = count("Contact Job Responsibility" where("Contact No." = field("No.")));
            Caption = 'No. of Job Responsibilities';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5070; "No. of Industry Groups"; Integer)
        {
            CalcFormula = count("Contact Industry Group" where("Contact No." = field("Company No.")));
            Caption = 'No. of Industry Groups';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5071; "No. of Business Relations"; Integer)
        {
            CalcFormula = count("Contact Business Relation" where("Contact No." = field("Company No.")));
            Caption = 'No. of Business Relations';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5072; "No. of Mailing Groups"; Integer)
        {
            CalcFormula = count("Contact Mailing Group" where("Contact No." = field("No.")));
            Caption = 'No. of Mailing Groups';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5073; "External ID"; Code[20])
        {
            Caption = 'External ID';
        }
        field(5074; "No. of Interactions"; Integer)
        {
            CalcFormula = count("Interaction Log Entry" where("Contact Company No." = field(filter("Company No.")),
                                                               Canceled = const(false),
                                                               "Contact No." = field(filter("Lookup Contact No.")),
                                                               Date = field("Date Filter"),
                                                               Postponed = const(false)));
            Caption = 'No. of Interactions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5076; "Cost (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Interaction Log Entry"."Cost (LCY)" where("Contact Company No." = field("Company No."),
                                                                          Canceled = const(false),
                                                                          "Contact No." = field(filter("Lookup Contact No.")),
                                                                          Date = field("Date Filter"),
                                                                          Postponed = const(false)));
            Caption = 'Cost (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5077; "Duration (Min.)"; Decimal)
        {
            CalcFormula = sum("Interaction Log Entry"."Duration (Min.)" where("Contact Company No." = field("Company No."),
                                                                               Canceled = const(false),
                                                                               "Contact No." = field(filter("Lookup Contact No.")),
                                                                               Date = field("Date Filter"),
                                                                               Postponed = const(false)));
            Caption = 'Duration (Min.)';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        /*       field(5078; "No. of Opportunities"; Integer)
              {
                  CalcFormula = count("Opportunity Entry" where(Active = const(true),
                                                                 "Contact Company No." = field("Company No."),
                                                                 "Estimated Close Date" = field("Date Filter"),
                                                                 "Contact No." = field(filter("Lookup Contact No.")),
                  // "Action Taken" = field("Action Taken Filter"/8)));
                  Caption = 'No. of Opportunities';
                  Editable = false;
                  FieldClass = FlowField;
              }
              field(5079; "Estimated Value (LCY)"; Decimal)
              {
                  AutoFormatType = 1;
                  CalcFormula = sum("Opportunity Entry"."Estimated Value (LCY)" where(Active = const(true),
                                                                                       "Contact Company No." = field("Company No."),
                                                                                       "Estimated Close Date" = field("Date Filter"),
                                                                                       "Contact No." = field(filter("Lookup Contact No.")),
                  // "Action Taken" = field("Action Taken Filter")));
                  Caption = 'Estimated Value (LCY)';
                  Editable = false;
                  FieldClass = FlowField;
              }
              field(5080; "Calcd. Current Value (LCY)"; Decimal)
              {
                  AutoFormatType = 1;
                  CalcFormula = sum("Opportunity Entry"."Calcd. Current Value (LCY)" where(Active = const(true),
                                                                                            "Contact Company No." = field("Company No."),
                                                                                            "Estimated Close Date" = field("Date Filter"),
                                                                                            "Contact No." = field(filter("Lookup Contact No.")),
                  //   "Action Taken" = field("Action Taken Filter")));
                  Caption = 'Calcd. Current Value (LCY)';
                  Editable = false;
                  FieldClass = FlowField;
              } */
        field(5082; "Opportunity Entry Exists"; Boolean)
        {
            CalcFormula = exist("Opportunity Entry" where(Active = const(true),
                                                           "Contact Company No." = field("Company No."),
                                                           "Contact No." = field(filter("Lookup Contact No.")),
                                                           "Sales Cycle Code" = field("Sales Cycle Filter"),
                                                           "Sales Cycle Stage" = field("Sales Cycle Stage Filter"),
                                                           "Salesperson Code" = field("Salesperson Filter"),
                                                           "Campaign No." = field("Campaign Filter"),
                                                           // "Action Taken" = field("Action Taken Filter"),
                                                           "Estimated Value (LCY)" = field("Estimated Value Filter"),
                                                           "Calcd. Current Value (LCY)" = field("Calcd. Current Value Filter"),
                                                           "Completed %" = field("Completed % Filter"),
                                                           "Chances of Success %" = field("Chances of Success % Filter"),
                                                           "Probability %" = field("Probability % Filter"),
                                                           "Estimated Close Date" = field("Date Filter"),
                                                           "Close Opportunity Code" = field("Close Opportunity Filter")));
            Caption = 'Opportunity Entry Exists';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5084; "Salesperson Filter"; Code[20])
        {
            Caption = 'Salesperson Filter';
            FieldClass = FlowFilter;
            TableRelation = "Salesperson/Purchaser";
        }
        field(5085; "Campaign Filter"; Code[20])
        {
            Caption = 'Campaign Filter';
            FieldClass = FlowFilter;
            TableRelation = Campaign;
        }
        /* field(5087; "Action Taken Filter"; Enum "Opportunity Action Taken")
        {
            Caption = 'Action Taken Filter';
            FieldClass = FlowFilter;
        } */
        field(5088; "Sales Cycle Filter"; Code[10])
        {
            Caption = 'Sales Cycle Filter';
            FieldClass = FlowFilter;
            TableRelation = "Sales Cycle";
        }
        field(5089; "Sales Cycle Stage Filter"; Integer)
        {
            Caption = 'Sales Cycle Stage Filter';
            FieldClass = FlowFilter;
            TableRelation = "Sales Cycle Stage".Stage where("Sales Cycle Code" = field("Sales Cycle Filter"));
        }
        field(5090; "Probability % Filter"; Decimal)
        {
            Caption = 'Probability % Filter';
            DecimalPlaces = 1 : 1;
            FieldClass = FlowFilter;
            MaxValue = 100;
            MinValue = 0;
        }
        field(5091; "Completed % Filter"; Decimal)
        {
            Caption = 'Completed % Filter';
            DecimalPlaces = 1 : 1;
            FieldClass = FlowFilter;
            MaxValue = 100;
            MinValue = 0;
        }
        field(5092; "Estimated Value Filter"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Estimated Value Filter';
            FieldClass = FlowFilter;
        }
        field(5093; "Calcd. Current Value Filter"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Calcd. Current Value Filter';
            FieldClass = FlowFilter;
        }
        field(5094; "Chances of Success % Filter"; Decimal)
        {
            Caption = 'Chances of Success % Filter';
            DecimalPlaces = 0 : 0;
            FieldClass = FlowFilter;
            MaxValue = 100;
            MinValue = 0;
        }
        field(5095; "Task Status Filter"; Option)
        {
            Caption = 'Task Status Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Not Started,In Progress,Completed,Waiting,Postponed';
            OptionMembers = "Not Started","In Progress",Completed,Waiting,Postponed;
        }
        field(5096; "Task Closed Filter"; Boolean)
        {
            Caption = 'Task Closed Filter';
            FieldClass = FlowFilter;
        }
        field(5097; "Priority Filter"; Option)
        {
            Caption = 'Priority Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Low,Normal,High';
            OptionMembers = Low,Normal,High;
        }
        field(5098; "Team Filter"; Code[10])
        {
            Caption = 'Team Filter';
            FieldClass = FlowFilter;
            TableRelation = Team;
        }
        field(5099; "Close Opportunity Filter"; Code[10])
        {
            Caption = 'Close Opportunity Filter';
            FieldClass = FlowFilter;
            TableRelation = "Close Opportunity Code";
        }
        field(5100; "Correspondence Type"; Option)
        {
            Caption = 'Correspondence Type';
            OptionCaption = ' ,Hard Copy,Email,Fax';
            OptionMembers = " ","Hard Copy",Email,Fax;
        }
        field(5101; "Salutation Code"; Code[10])
        {
            Caption = 'Salutation Code';
            TableRelation = Salutation;
        }
        field(5102; "Search E-Mail"; Code[80])
        {
            Caption = 'Search Email';
        }
        field(5104; "Last Time Modified"; Time)
        {
            Caption = 'Last Time Modified';
        }
        field(5105; "E-Mail 2"; Text[80])
        {
            Caption = 'Email 2';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail 2");
            end;
        }
        field(8050; "Xrm Id"; Guid)
        {
            Caption = 'Xrm Id';
            Editable = false;
        }
        field(50004; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected,Created';
            OptionMembers = Open,Pending,Approved,Rejected,Created;
            trigger OnValidate()
            var
                MemberActivities: Codeunit "Member Activities";
            begin
                if Status = Status::Created then begin
                    UserSetup.Reset;
                    UserSetup.SetRange(UserSetup."User ID", UserId);
                    UserSetup.SetRange("Create Member", false);
                    if UserSetup.Find('-') then
                        Error(Text004);
                end;

            end;
        }
        field(50005; "Employer Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employement Sectors" where(Type = const(Employed));

            trigger OnValidate()
            Var
                EmpSectors: Record "Employement Sectors";
            begin
                "Employer Name" := '';

                EmpSectors.Reset();
                EmpSectors.SetRange(code, "Employer Code");
                if EmpSectors.FindFirst() then
                    "Employer Name" := EmpSectors.Description;

            end;
        }
        field(50006; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                DateofBirthError: label 'This date cannot be greater than today.';
            begin
                if "Date of Birth" <> 0D then
                    if "Date of Birth" > Today then
                        Error('Invalid Date of Birth. Future Date Detected');

                GenSetup.Get;
                if GenSetup."Membership Age" = BlankDF then
                    Error('Membership Age MUST have a value in General Setup');

                if CalcDate(GenSetup."Membership Age", "Date of Birth") > Today then
                    Error('Minimum Membership Age is %1', GenSetup."Membership Age");
            end;
        }
        field(50007; "Terms of Employment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Permanent,Contract,Casual;
        }
        field(50008; "Payroll/Staff No."; Code[10])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Members.Reset;
                Members.SetRange("Payroll/Staff No.", Rec."Payroll/Staff No.");
                if Members.FindFirst then begin
                    Message('Payroll/Staff No Already linked to Member No. %1 - %2 Employer-%3', Members."No.", Members.Name, Members."Payroll/Staff No.");
                end;

            end;
        }
        field(50009; "ID No."; Code[10])
        {
            CharAllowed = '09';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                TestID: Code[20];
                MembReg: Record "Member Registration";
            begin
                if "ID No." <> '' then begin
                    if StrLen("ID No.") < 6 then
                        Error('Invalid ID No.');



                    TestID := DelChr("ID No.", '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|-|_');
                    if TestID <> "ID No." then
                        Error('Invalid ID No. Invalid Character detected');


                    Members.Reset;
                    if "ID Type" = "ID Type"::Passport then
                        Members.SetRange(Passport, Rec.Passport);
                    if "ID Type" = "ID Type"::"National ID" then
                        Members.SetRange("ID No.", Rec."ID No.");
                    //Members.SetRange("Account Category", "Account Category");
                    //Members.SetRange("Group Account", "Group Account");
                    if Members.FindFirst then begin
                        Error('ID Already linked to Member No. %1 - %2', Members."No.", Members.Name);
                    end;

                    MembReg.Reset;
                    if "ID Type" = "ID Type"::Passport then
                        MembReg.SetRange(Passport, Rec.Passport);
                    if "ID Type" = "ID Type"::"National ID" then
                        MembReg.SetRange("ID No.", Rec."ID No.");
                    if MembReg.FindFirst then begin
                        Error('ID Already captured record %1 by %2 on %3', MembReg."No.", MembReg."Captured By", MembReg."Application Date");
                    end;

                end;
            end;
        }
        field(50011; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Single,Married,Divorced,Widowed,Others,Seperated,Widower';
            OptionMembers = " ",Single,Married,Divorced,Widowed,Others,Seperated,Widower;
        }
        field(50012; "ID Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "National ID","Alien ID","Military ID",Passport;

        }
        field(50013; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,Male,Female,Other';
            OptionMembers = " ",Male,Female,Other;
        }
        field(50014; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "ID Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Member Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Member,Staff,Board Member';
            OptionMembers = Member,Staff,"Board Member";
        }
        field(50018; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Group Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Bank Code"; Code[2])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Codes";

            trigger OnValidate()
            begin
                "Bank Name" := '';
                if BankCodes.Get("Bank Code") then
                    "Bank Name" := BankCodes."Bank Name";
            end;
        }
        field(50021; "Bank Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50022; "Branch Code"; Code[3])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code" = field("Bank Code"));

            trigger OnValidate()
            begin
                "Branch Name" := '';

                if BankBranches.Get("Bank Code", "Branch Code") then
                    "Branch Name" := BankBranches."Branch Name";
            end;
        }
        field(50023; "Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50024; "Bank Account No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "KRA PIN"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            begin
                Members.Reset;
                Members.SetRange("KRA PIN", "KRA PIN");
                Members.SetRange("Account Category", "Account Category");
                //Members.SetRange("Group Account", "Group Account");
                if Members.FindFirst then begin
                    Error('KRA PIN Already linked to Member No. %1 - %2', Members."No.", Members.Name);
                end;
            end;
        }
        field(50026; "Recruited by Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Walk In",Marketer,Staff,"Board Member",Member,Website;
            OptionCaption = 'Self Recruiter,Marketer,Staff,Board Member,Member,Website';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Recruited By" := '';
                "Recruited By Name" := '';
            end;
        }
        field(50027; "Relationship Officer"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
            trigger OnValidate()
            var
                myInt: Integer;
            begin

                "Relationship Officer Name" := '';

                if UserSetup.Get("Relationship Officer") then begin

                    "Relationship Officer" := UserSetup."Staff No";

                    if HREmployees.Get("Relationship Officer") then
                        "Relationship Officer Name" := HREmployees."First Name" + ' ' + HREmployees."Last Name";
                end;
            end;
        }
        field(50028; "Employer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Old Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Restricted Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Recruited By"; Code[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Recruited by Type" = const(Marketer)) "Salesperson/Purchaser"
            else
            if ("Recruited by Type" = const(Staff)) Members where("Member Category" = const("Staff Members"))
            else
            if ("Recruited by Type" = const("Board Member")) Members where("Member Category" = const("Board Members"))
            else
            if ("Recruited by Type" = const(Member)) Members where("Member Category" = const(Member));

            trigger OnValidate()
            begin
                "Recruited By Name" := '';

                if "Recruited by Type" = "recruited by type"::Marketer then begin
                    SalespersonPurchaser.Reset;
                    SalespersonPurchaser.SetRange(Code, "Recruited By");
                    if SalespersonPurchaser.Find('-') then begin
                        "Recruited By Name" := SalespersonPurchaser.Name;
                    end;
                end
                else
                    if "Recruited by Type" = "recruited by type"::"Board Member" then begin
                        Members.Reset;
                        Members.SetRange("No.", "Recruited By");
                        if Members.Find('-') then begin
                            "Recruited By Name" := Members.Name;
                        end;
                    end
                    else
                        if ("Recruited by Type" = "recruited by type"::Staff) or ("Recruited by Type" = "recruited by type"::Member) then begin
                            Members.Reset;
                            Members.SetRange("No.", "Recruited By");
                            if Members.Find('-') then begin
                                "Recruited By Name" := Members.Name;
                            end;
                        end;
            end;
        }
        field(50032; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50034; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50035; "Recruited By Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50036; "Tracker ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Approval Tracker";
        }
        field(50037; Signature; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50038; "Special Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Group Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Incorporated,"Non-Incorporated";
        }
        field(50040; "Type of Business"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Limited Company","Investment Company","Sole Proprietor",Other;
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

            trigger OnValidate()
            var
                DateofBirthError: label 'This date cannot be greater than today.';
            begin
                if "Date of Bus. Incorporation" > Today then
                    Error(DateofBirthError);
            end;
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

            trigger OnValidate()
            var
                DateofBirthError: label 'This date cannot be greater than today.';
            begin
                if "Date of Bus. Incorporation" > Today then
                    Error(DateofBirthError);
            end;
        }
        field(50050; "Group No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members."No." where(Type = const(Group));
        }
        field(50056; "Account Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Individual,Joint,Chamaa,Business,MicroGroup,Welfare;
        }
        field(50057; "Relationship Officer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50058; "Branch Manager"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50059; "Branch Manager Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50060; "Group Section"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Micro Group","Other Groups";
        }
        field(50061; "Phone Code"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50062; "Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50063; "From Another Sacco"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50064; "Member Class"; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Class";

            trigger OnValidate()
            var
                Default: Record "Default Savings Products.";
            begin
                DefaultAccounts();
                Commit();

                Default.Reset();
                Default.SetRange(Code, Rec."No.");
                if Default.FindSet() then
                    repeat
                        Default.Validate(Product);
                        Default.Modify();
                    until Default.Next() = 0;
            end;
        }

        field(50065; "How Did You Know About Us"; Enum "How Did You Know About Us Enum")
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
        field(50068; "Self Employed"; Boolean)
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
        field(50072; "Signing Instruction Narration"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Mandate;
        }
        field(50073; "Previous Sacco No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50087; "Signing Instructions"; Option)
        {
            OptionMembers = Single,"All must Sign","Either Must Sign";
        }
        field(50088; "Virtual Member"; Boolean)
        {
        }
        field(50089; "Employement Sector"; Code[30])
        {
            TableRelation = "Employement Sectors".Code where(Type = const(Business));

            trigger OnValidate()
            var
                EmpSector: Record "Employement Sectors";
            begin
                if "Employement Sector" = '' then begin
                    "Business Name" := '';
                    "Business/Group Location" := '';
                    exit;
                end;

                EmpSector.SetRange(Code, "Employement Sector");
                EmpSector.SetRange(Type, EmpSector.Type::Business);
                if not EmpSector.FindFirst() then begin
                    "Business Name" := '';
                    "Business/Group Location" := '';
                    exit;
                end;

                "Business Name" := EmpSector.Description;
                "Business/Group Location" := EmpSector.Location;
            end;
        }
        field(50090; Residential; Code[50])
        {

        }
        field(50091; State; Code[50])
        {

        }
        field(50093; Country; Code[50])
        {

        }
        field(50094; "Level of Employement"; Option)
        {
            OptionMembers = " ",Management;
        }
        field(50095; "Power of attorney remark"; Text[100])
        {

        }
        field(50096; "Remit Checkoff"; Boolean)
        {

        }
        field(50097; "Checkoff Station Name"; Text[100])
        {
        }
        field(50098; "Checkoff Station"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Employer));

            trigger OnValidate()
            Var
                Cust: Record Customer;
            begin
                "Checkoff Station Name" := '';

                if Cust.Get("Checkoff Station") then
                    "Checkoff Station Name" := Cust.Name;
            end;
        }
        field(50099; Locality; Option)
        {
            OptionMembers = Local,Diaspora;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Locality = Locality::Local then begin
                    State := '';
                    Country := '';
                    "Power of attorney remark" := '';
                end;
            end;
        }
        field(500100; "Member Electoral Zone"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Electoral Zones".Code WHERE(Type = CONST("Electral Zone"));
        }
        field(500101; "Trading As"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(500102; "Bank Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Address Details"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(50168; "Registration Form"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(50169; "Terms Accepted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50170; "Portal Application"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50171; "Portal Application Stage"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Member Details","Next of Kin Details","Document Upload",Completed;
        }
        field(50172; "Terms Acceptance Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50173; "Mpesa Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50174; "Recruited By Phone"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50175; "Document Type"; enum "Attachment Document Type")
        {
            DataClassification = ToBeClassified;

        }
        field(50176; "Business Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50177; "Position Held"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50178; "Reference Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50179; "Approved By"; Code[50])
        {
        }
        field(50180; "Registration Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Registration Date" > Today then Error(DateError, FieldCaption("Application Date"));

            end;
        }
        field(50232; "Employment Info"; Option)
        {
            OptionMembers = Employed,UnEmployed,Contracting,Business,"Self-Employed",Pensioner,Permanent,Retired;
        }

        field(50233; "ID No. IDM Verified"; Boolean)
        {
            Caption = 'ID No. IDM Verified';
            DataClassification = CustomerContent;
        }
        field(50234; "KRA PIN IDM Verified"; Boolean)
        {
            Caption = 'KRA PIN IDM Verified';
            DataClassification = CustomerContent;
        }
        field(50235; "Phone IDM Verified"; Boolean)
        {
            Caption = 'Phone IDM Verified';
            DataClassification = CustomerContent;
        }
        field(50236; "ID Serial No."; Text[100])
        {
            Caption = 'ID Serial No.';
            DataClassification = CustomerContent;
        }

        field(50237; "CRB Status Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50238; "CRB Checked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50239; "CRB Status Code"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50240; "CRB Status Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50241; "Join Mobile Banking"; Boolean)
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
        key(Key2; "Search Name")
        {
        }
        key(Key3; "Company Name", "Company No.", Type, Name)
        {
        }
        key(Key4; "Company No.")
        {
        }
        key(Key5; "Territory Code")
        {
        }
        key(Key6; "Salesperson Code")
        {
        }
        key(Key7; "VAT Registration No.")
        {
        }
        key(Key8; "Search E-Mail")
        {
        }
        key(Key9; Name)
        {
        }
        key(Key10; City)
        {
        }
        key(Key11; "Post Code")
        {
        }
        key(Key12; "Alternative Phone No.")
        {
        }
        key(Key13; "Document Type")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, Type, City, "Post Code", "Alternative Phone No.")
        {
        }
        fieldgroup(Brick; "No.", Name, Type, City, "Alternative Phone No.", Image)
        {
        }
    }

    trigger OnDelete()
    var
        Task: Record "To-do";
        SegLine: Record "Segment Line";
        ContIndustGrp: Record "Contact Industry Group";
        ContactWebSource: Record "Contact Web Source";
        ContJobResp: Record "Contact Job Responsibility";
        ContMailingGrp: Record "Contact Mailing Group";
        ContProfileAnswer: Record "Contact Profile Answer";
        RMCommentLine: Record "Rlshp. Mgt. Comment Line";
        ContAltAddr: Record "Contact Alt. Address";
        ContAltAddrDateRange: Record "Contact Alt. Addr. Date Range";
        InteractLogEntry: Record "Interaction Log Entry";
        Opp: Record Opportunity;
        Cont: Record Contact;
        ContBusRel: Record "Contact Business Relation";
        CampaignTargetGrMgt: Codeunit "Campaign Target Group Mgt";
        VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
    begin
    end;

    trigger OnInsert()
    var
        MemberReg: Record "Member Registration";
    begin
        NSetup.Get;


        if "No." = '' then begin
            NSetup.TestField("Member Application Nos.");
            // Get the next number
            "No." := NoSeries.GetNextNo(NSetup."Member Application Nos.", WorkDate(), true);
            "No. Series" := NSetup."Member Application Nos.";
        end;

        "Application Date" := WorkDate;
        "Captured By" := UserId;
        "Document Type" := "Sales Document Type"::Member;

        UserSetup.Get("Captured By");
        UserSetup.TestField("Global Dimension 2 Code");

        //UserSetup.TestField("Staff No");
        "Relationship Officer" := UserSetup."Staff No";

        if HREmployees.Get("Relationship Officer") then
            "Relationship Officer Name" := HREmployees."First Name" + ' ' + HREmployees."Last Name";

        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        DefaultAccounts;



        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin

            if UserSetup."Max. Open Documents" > 0 then begin

                MemberReg.Reset();
                MemberReg.SetRange("Captured By", UserId);
                MemberReg.SetRange(Status, MemberReg.Status::Open);
                if MemberReg.FindFirst() then
                    if MemberReg.Count > UserSetup."Max. Open Documents" then
                        Error('You are not allowed to open multiple documents. Complete %1 first.', MemberReg."No.");

            end;

            if UserSetup."Create Member" = false then Error(Text004);
        end;




        UserSetup.Reset;
        UserSetup.SetRange("Global Dimension 2 Code", "Global Dimension 2 Code");
        UserSetup.SetRange("Branch Manager", true);
        if UserSetup.FindFirst then begin
            "Branch Manager" := UserSetup."Staff No";
            HREmployees.Get("Branch Manager");
            "Branch Manager Name" := HREmployees."First Name" + ' ' + HREmployees."Last Name";
        end;
    end;

    var
        DateError: label '%1 cannot be greater than today.';
        SpotCash: Codeunit "SpotCash Mbanking";
        CannotDeleteWithOpenTasksErr: label 'You cannot delete contact %1 because there are one or more tasks open.', Comment = '%1 = Contact No.';
        Text001: label 'You cannot delete the %2 record of the %1 because the contact is assigned one or more unlogged segments.';
        Text002: label 'You cannot delete the %2 record of the %1 because one or more opportunities are in not started or progress.';
        Text003: label '%1 cannot be changed because one or more interaction log entries are linked to the contact.';
        Text004: label 'You do not have permission to capture or create new member.';
        CannotChangeWithOpenTasksErr: label '%1 cannot be changed because one or more tasks are linked to the contact.', Comment = '%1 = Contact No.';
        Text006: label '%1 cannot be changed because one or more opportunities are linked to the contact.';
        Text007: label '%1 cannot be changed because there are one or more related people linked to the contact.';
        RelatedRecordIsCreatedMsg: label 'The %1 record has been created.', Comment = 'The Customer record has been created.';
        Text010: label 'The %2 record of the %1 is not linked with any other table.';
        Text011: label 'The ID %2 record of the %1 is not linked with any other table.';
        RMSetup: Record "Marketing Setup";
        DuplMgt: Codeunit DuplicateManagement;
        NoSeries: Codeunit "No. Series";
        UpdateCustVendBank: Codeunit "CustVendBank-Update";
        CampaignMgt: Codeunit "Campaign Target Group Mgt";
        ContChanged: Boolean;
        SkipDefaults: Boolean;
        Text012: label 'You cannot change %1 because one or more unlogged segments are assigned to the contact.';
        Text019: label 'The %2 record of the %1 already has the %3 with %4 %5.';
        CreateCustomerFromContactQst: label 'Do you want to create a contact as a customer using a customer template?';
        Text021: label 'You have to set up formal and informal salutation formulas in %1  language for the %2 contact.';
        Text022: label 'The creation of the customer has been aborted.';
        Text033: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        SelectContactErr: label 'You must select an existing contact.';
        AlreadyExistErr: label '%1 %2 already has a %3 with %4 %5.', Comment = '%1=Contact table caption;%2=Contact number;%3=Contact Business Relation table caption;%4=Contact Business Relation Link to Table value;%5=Contact Business Relation number';
        HideValidationDialog: Boolean;
        NSetup: Record "Sales & Receivables Setup";
        GenSetup: Record "Sacco Setup";
        BlankDF: DateFormula;
        CountryRegion: Record "Country/Region";
        CodeLength: Integer;
        TestPhone: Text;
        UserSetup: Record "User Setup";
        HREmployees: Record Employee;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Members: Record Members;
        Cust: Record Members;
        BankCodes: Record "Bank Codes";
        BankBranches: Record "Bank Branches";

    procedure On_Modify(xRec: Record Contact)
    var
        OldCont: Record Contact;
        Cont: Record Contact;
    begin
        SetLastDateTimeModified;

        if Type = Type::" " then begin
            RMSetup.Get;
            Cont.Reset;
            Cont.SetCurrentkey("Company No.");
            Cont.SetRange("Company No.", "No.");
            Cont.SetRange(Type, Type::Group);
            Cont.SetFilter("No.", '<>%1', "No.");
            if Cont.Find('-') then
                repeat
                    ContChanged := false;
                    OldCont := Cont;
                    if Name <> xRec.Name then begin
                        Cont."Company Name" := Name;
                        ContChanged := true;
                    end;
                    if RMSetup."Inherit Salesperson Code" and
                       (xRec."Salesperson Code" <> "Salesperson Code") and
                       (xRec."Salesperson Code" = Cont."Salesperson Code")
                    then begin
                        Cont."Salesperson Code" := "Salesperson Code";
                        ContChanged := true;
                    end;
                    if RMSetup."Inherit Territory Code" and
                       (xRec."Territory Code" <> "Territory Code") and
                       (xRec."Territory Code" = Cont."Territory Code")
                    then begin
                        Cont."Territory Code" := "Territory Code";
                        ContChanged := true;
                    end;
                    if RMSetup."Inherit Country/Region Code" and
                       (xRec."Country/Region Code" <> "Country/Region Code") and
                       (xRec."Country/Region Code" = Cont."Country/Region Code")
                    then begin
                        Cont."Country/Region Code" := "Country/Region Code";
                        ContChanged := true;
                    end;
                    if RMSetup."Inherit Language Code" and
                       (xRec."Language Code" <> "Language Code") and
                       (xRec."Language Code" = Cont."Language Code")
                    then begin
                        Cont."Language Code" := "Language Code";
                        ContChanged := true;
                    end;
                    if RMSetup."Inherit Address Details" then
                        if xRec.IdenticalAddress(Cont) then begin
                            if xRec.Address <> Address then begin
                                Cont.Address := Address;
                                ContChanged := true;
                            end;
                            if xRec."Address 2" <> "Address 2" then begin
                                Cont."Address 2" := "Address 2";
                                ContChanged := true;
                            end;
                            if xRec."Post Code" <> "Post Code" then begin
                                Cont."Post Code" := "Post Code";
                                ContChanged := true;
                            end;
                            if xRec.City <> City then begin
                                Cont.City := City;
                                ContChanged := true;
                            end;
                            if xRec.County <> County then begin
                                Cont.County := County;
                                ContChanged := true;
                            end;
                        end;
                    if RMSetup."Inherit Communication Details" then begin
                        if (xRec."Phone No." <> "Alternative Phone No.") and (xRec."Phone No." = Cont."Phone No.") then begin
                            Cont."Phone No." := "Alternative Phone No.";
                            ContChanged := true;
                        end;
                        if (xRec."Telex No." <> "Telex No.") and (xRec."Telex No." = Cont."Telex No.") then begin
                            Cont."Telex No." := "Telex No.";
                            ContChanged := true;
                        end;
                        if (xRec."Fax No." <> "Fax No.") and (xRec."Fax No." = Cont."Fax No.") then begin
                            Cont."Fax No." := "Fax No.";
                            ContChanged := true;
                        end;
                        if (xRec."Telex Answer Back" <> "Telex Answer Back") and (xRec."Telex Answer Back" = Cont."Telex Answer Back") then begin
                            Cont."Telex Answer Back" := "Telex Answer Back";
                            ContChanged := true;
                        end;
                        if (xRec."E-Mail" <> "E-Mail") and (xRec."E-Mail" = Cont."E-Mail") then begin
                            Cont.Validate("E-Mail", "E-Mail");
                            ContChanged := true;
                        end;
#pragma warning disable AL0432
                        if (xRec."Home Page" <> "Home Page") and (xRec."Home Page" = Cont."Home Page") then begin
                            Cont."Home Page" := "Home Page";
                            ContChanged := true;
#pragma warning restore AL0432
                        end;
                        if (xRec."Extension No." <> "Extension No.") and (xRec."Extension No." = Cont."Extension No.") then begin
                            Cont."Extension No." := "Extension No.";
                            ContChanged := true;
                        end;
                        if (xRec."Mobile Phone No." <> "Mobile Phone No.") and (xRec."Mobile Phone No." = Cont."Mobile Phone No.") then begin
                            Cont."Mobile Phone No." := "Mobile Phone No.";
                            ContChanged := true;
                        end;
                        if (xRec.Pager <> Pager) and (xRec.Pager = Cont.Pager) then begin
                            Cont.Pager := Pager;
                            ContChanged := true;
                        end;
                    end;
                    if ContChanged then begin
                        //Cont.OnModify(OldCont);
                        //Cont.Modify;
                    end;
                until Cont.Next = 0;

            if (Name <> xRec.Name) or
               ("Name 2" <> xRec."Name 2") or
               (Address <> xRec.Address) or
               ("Address 2" <> xRec."Address 2") or
               (City <> xRec.City) or
               ("Post Code" <> xRec."Post Code") or
               ("VAT Registration No." <> xRec."VAT Registration No.") or
               ("Alternative Phone No." <> xRec."Phone No.")
            then
                CheckDupl;
        end;
    end;

    procedure TypeChange()
    var
        InteractLogEntry: Record "Interaction Log Entry";
        Opp: Record Opportunity;
        Task: Record "To-do";
        Cont: Record Contact;
        CampaignTargetGrMgt: Codeunit "Campaign Target Group Mgt";
    begin
        RMSetup.Get;

        if Type <> xRec.Type then begin
            InteractLogEntry.LockTable;
            Cont.LockTable;
            InteractLogEntry.SetCurrentkey("Contact Company No.", "Contact No.");
            InteractLogEntry.SetRange("Contact Company No.", "Company No.");
            InteractLogEntry.SetRange("Contact No.", "No.");
            if InteractLogEntry.FindFirst then
                Error(Text003, FieldCaption(Type));
            Task.SetRange("Contact Company No.", "Company No.");
            Task.SetRange("Contact No.", "No.");
            if not Task.IsEmpty then
                Error(CannotChangeWithOpenTasksErr, FieldCaption(Type));
            Opp.SetRange("Contact Company No.", "Company No.");
            Opp.SetRange("Contact No.", "No.");
            if not Opp.IsEmpty then
                Error(Text006, FieldCaption(Type));
        end;

        case Type of
            Type::" ":
                begin
                    if Type <> xRec.Type then begin
                        TestField("Organizational Level Code", '');
                        TestField("No. of Job Responsibilities", 0);
                    end;
                    "First Name" := '';
                    "Middle Name" := '';
                    Surname := '';
                    "Job Title" := '';
                    "Company No." := "No.";
                    "Company Name" := Name;
                    "Salutation Code" := RMSetup."Def. Company Salutation Code";
                end;
            Type::Group:
                begin
                    CampaignTargetGrMgt.DeleteContfromTargetGr(InteractLogEntry);
                    Cont.Reset;
                    Cont.SetCurrentkey("Company No.");
                    Cont.SetRange("Company No.", "No.");
                    Cont.SetRange(Type, Type::Group);
                    if Cont.FindFirst then
                        Error(Text007, FieldCaption(Type));
                    if Type <> xRec.Type then begin
                        TestField("No. of Business Relations", 0);
                        TestField("No. of Industry Groups", 0);
                        TestField("Currency Code", '');
                        TestField("VAT Registration No.", '');
                    end;
                    if "Company No." = "No." then begin
                        "Company No." := '';
                        "Company Name" := '';
                        "Salutation Code" := RMSetup."Default Person Salutation Code";
                        NameBreakdown;
                    end;
                end;
        end;
        Validate("Lookup Contact No.");
    end;


    procedure GetAgeText(DateOfBirth: Date): Text[50]
    var
        Years: Integer;
        Months: Integer;
        TodayDay: Integer;
        TodayMonth: Integer;
        TodayYear: Integer;
        BirthDay: Integer;
        BirthMonth: Integer;
        BirthYear: Integer;
        AgeText: Text[50];
    begin
        if DateOfBirth = 0D then
            exit('');

        TodayDay := Date2DMY(Today, 1);
        TodayMonth := Date2DMY(Today, 2);
        TodayYear := Date2DMY(Today, 3);

        BirthDay := Date2DMY(DateOfBirth, 1);
        BirthMonth := Date2DMY(DateOfBirth, 2);
        BirthYear := Date2DMY(DateOfBirth, 3);

        Years := TodayYear - BirthYear;
        Months := TodayMonth - BirthMonth;

        if TodayDay < BirthDay then
            Months -= 1;

        if Months < 0 then begin
            Years -= 1;
            Months += 12;
        end;

        AgeText := Format(Years) + ' Yrs';

        if Months > 0 then
            AgeText += ' & ' + Format(Months) + ' Months';

        exit(AgeText);
    end;

    procedure AssistEdit(OldCont: Record Contact): Boolean
    var
        Cont: Record Contact;
    begin
    end;

    /*
    procedure GetDefaultPhoneNo(): Text[30]
    var
        ClientTypeManagement: Codeunit UnknownCodeunit4;
    begin
        if ClientTypeManagement.IsClientType(Clienttype::Phone) then begin
            if "Mobile Phone No." = '' then
                exit("Alternative Phone No.");
            exit("Mobile Phone No.");
        end;
        if "Alternative Phone No." = '' then
            exit("Mobile Phone No.");
        exit("Alternative Phone No.");
    end;
    */


    procedure ShowCustVendBank()
    var
        ContBusRel: Record "Contact Business Relation";
        Cust: Record Members;
        Vend: Record "Savings Accounts";
        BankAcc: Record "Bank Account";
        FormSelected: Boolean;
    begin
        FormSelected := true;

        ContBusRel.Reset;

        if "Company No." <> '' then
            ContBusRel.SetFilter("Contact No.", '%1|%2', "No.", "Company No.")
        else
            ContBusRel.SetRange("Contact No.", "No.");
        ContBusRel.SetFilter("No.", '<>''''');

        case ContBusRel.Count of
            0:
                Error(Text010, TableCaption, "No.");
            1:
                ContBusRel.FindFirst;
            else
                FormSelected := Page.RunModal(Page::"Contact Business Relations", ContBusRel) = Action::LookupOK;
        end;

        if FormSelected then
            case ContBusRel."Link to Table" of
                ContBusRel."link to table"::Customer:
                    begin
                        Cust.Get(ContBusRel."No.");
                        Page.Run(Page::"Customer Card", Cust);
                    end;
                ContBusRel."link to table"::Vendor:
                    begin
                        Vend.Get(ContBusRel."No.");
                        Page.Run(Page::"Vendor Card", Vend);
                    end;
                ContBusRel."link to table"::"Bank Account":
                    begin
                        BankAcc.Get(ContBusRel."No.");
                        Page.Run(Page::"Bank Account Card", BankAcc);
                    end;
            end;
    end;

    local procedure NameBreakdown()
    var
        NamePart: array[30] of Text[250];
        TempName: Text[250];
        FirstName250: Text[250];
        i: Integer;
        NoOfParts: Integer;
    begin
        if Type = Type::" " then
            exit;

        TempName := Name;
        while StrPos(TempName, ' ') > 0 do begin
            if StrPos(TempName, ' ') > 1 then begin
                i := i + 1;
                NamePart[i] := CopyStr(TempName, 1, StrPos(TempName, ' ') - 1);
            end;
            TempName := CopyStr(TempName, StrPos(TempName, ' ') + 1);
        end;
        i := i + 1;
        NamePart[i] := TempName;
        NoOfParts := i;

        "First Name" := '';
        "Middle Name" := '';
        Surname := '';
        for i := 1 to NoOfParts do
            if (i = NoOfParts) and (NoOfParts > 1) then
                Surname := CopyStr(NamePart[i], 1, MaxStrLen(Surname))
            else
                if (i = NoOfParts - 1) and (NoOfParts > 2) then
                    "Middle Name" := CopyStr(NamePart[i], 1, MaxStrLen("Middle Name"))
                else begin
                    FirstName250 := DelChr("First Name" + ' ' + NamePart[i], '<', ' ');
                    "First Name" := CopyStr(FirstName250, 1, MaxStrLen("First Name"));
                end;
    end;

    procedure SetSkipDefault()
    begin
        SkipDefaults := true;
    end;

    procedure IdenticalAddress(var Cont: Record Contact): Boolean
    begin
        exit(
          (Address = Cont.Address) and
          ("Address 2" = Cont."Address 2") and
          ("Post Code" = Cont."Post Code") and
          (City = Cont.City))
    end;

    procedure ActiveAltAddress(ActiveDate: Date): Code[10]
    var
        ContAltAddrDateRange: Record "Contact Alt. Addr. Date Range";
    begin
        ContAltAddrDateRange.SetCurrentkey("Contact No.", "Starting Date");
        ContAltAddrDateRange.SetRange("Contact No.", "No.");
        ContAltAddrDateRange.SetRange("Starting Date", 0D, ActiveDate);
        ContAltAddrDateRange.SetFilter("Ending Date", '>=%1|%2', ActiveDate, 0D);
        if ContAltAddrDateRange.FindLast then
            exit(ContAltAddrDateRange."Contact Alt. Address Code");

        exit('');
    end;

    local procedure CalculatedName() NewName: Text[50]
    var
        NewName92: Text[92];
    begin
        if "First Name" <> '' then
            NewName92 := "First Name";
        if "Middle Name" <> '' then
            NewName92 := NewName92 + ' ' + "Middle Name";
        if Surname <> '' then
            NewName92 := NewName92 + ' ' + Surname;

        NewName92 := DelChr(NewName92, '<', ' ');
        NewName := CopyStr(NewName92, 1, MaxStrLen(NewName));
    end;

    local procedure UpdateSearchName()
    begin
        if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
            "Search Name" := Name;
    end;

    local procedure CheckDupl()
    begin
    end;

    procedure GetSalutation(SalutationType: Option Formal,Informal; LanguageCode: Code[10]): Text[260]
    var
        SalutationFormula: Record "Salutation Formula";
        NamePart: array[5] of Text[50];
        SubStr: Text[30];
        i: Integer;
    begin
        if not SalutationFormula.Get("Salutation Code", LanguageCode, SalutationType) then
            Error(Text021, LanguageCode, "No.");
        SalutationFormula.TestField(Salutation);

        case SalutationFormula."Name 1" of
            SalutationFormula."name 1"::"Job Title":
                NamePart[1] := "Job Title";
            SalutationFormula."name 1"::"First Name":
                NamePart[1] := "First Name";
            SalutationFormula."name 1"::"Middle Name":
                NamePart[1] := "Middle Name";
            SalutationFormula."name 1"::Surname:
                NamePart[1] := Surname;
            SalutationFormula."name 1"::Initials:
                NamePart[1] := Initials;
            SalutationFormula."name 1"::"Company Name":
                NamePart[1] := "Company Name";
        end;

        case SalutationFormula."Name 2" of
            SalutationFormula."name 2"::"Job Title":
                NamePart[2] := "Job Title";
            SalutationFormula."name 2"::"First Name":
                NamePart[2] := "First Name";
            SalutationFormula."name 2"::"Middle Name":
                NamePart[2] := "Middle Name";
            SalutationFormula."name 2"::Surname:
                NamePart[2] := Surname;
            SalutationFormula."name 2"::Initials:
                NamePart[2] := Initials;
            SalutationFormula."name 2"::"Company Name":
                NamePart[2] := "Company Name";
        end;

        case SalutationFormula."Name 3" of
            SalutationFormula."name 3"::"Job Title":
                NamePart[3] := "Job Title";
            SalutationFormula."name 3"::"First Name":
                NamePart[3] := "First Name";
            SalutationFormula."name 3"::"Middle Name":
                NamePart[3] := "Middle Name";
            SalutationFormula."name 3"::Surname:
                NamePart[3] := Surname;
            SalutationFormula."name 3"::Initials:
                NamePart[3] := Initials;
            SalutationFormula."name 3"::"Company Name":
                NamePart[3] := "Company Name";
        end;

        case SalutationFormula."Name 4" of
            SalutationFormula."name 4"::"Job Title":
                NamePart[4] := "Job Title";
            SalutationFormula."name 4"::"First Name":
                NamePart[4] := "First Name";
            SalutationFormula."name 4"::"Middle Name":
                NamePart[4] := "Middle Name";
            SalutationFormula."name 4"::Surname:
                NamePart[4] := Surname;
            SalutationFormula."name 4"::Initials:
                NamePart[4] := Initials;
            SalutationFormula."name 4"::"Company Name":
                NamePart[4] := "Company Name";
        end;

        case SalutationFormula."Name 5" of
            SalutationFormula."name 5"::"Job Title":
                NamePart[5] := "Job Title";
            SalutationFormula."name 5"::"First Name":
                NamePart[5] := "First Name";
            SalutationFormula."name 5"::"Middle Name":
                NamePart[5] := "Middle Name";
            SalutationFormula."name 5"::Surname:
                NamePart[5] := Surname;
            SalutationFormula."name 5"::Initials:
                NamePart[5] := Initials;
            SalutationFormula."name 5"::"Company Name":
                NamePart[5] := "Company Name";
        end;

        for i := 1 to 5 do
            if NamePart[i] = '' then begin
                SubStr := '%' + Format(i) + ' ';
                if StrPos(SalutationFormula.Salutation, SubStr) > 0 then
                    SalutationFormula.Salutation :=
                      DelStr(SalutationFormula.Salutation, StrPos(SalutationFormula.Salutation, SubStr), 3);
            end;

        exit(StrSubstNo(SalutationFormula.Salutation, NamePart[1], NamePart[2], NamePart[3], NamePart[4], NamePart[5]))
    end;


    procedure InheritCompanyToPersonData(NewCompanyContact: Record Contact)
    begin
        "Company Name" := NewCompanyContact.Name;

        RMSetup.Get;
        if RMSetup."Inherit Salesperson Code" then
            "Salesperson Code" := NewCompanyContact."Salesperson Code";
        if RMSetup."Inherit Territory Code" then
            "Territory Code" := NewCompanyContact."Territory Code";
        if RMSetup."Inherit Country/Region Code" then
            "Country/Region Code" := NewCompanyContact."Country/Region Code";
        if RMSetup."Inherit Language Code" then
            "Language Code" := NewCompanyContact."Language Code";
        if RMSetup."Inherit Address Details" and StaleAddress then begin
            Address := NewCompanyContact.Address;
            "Address 2" := NewCompanyContact."Address 2";
            "Post Code" := NewCompanyContact."Post Code";
            City := NewCompanyContact.City;
            County := NewCompanyContact.County;
        end;
        if RMSetup."Inherit Communication Details" then begin
            UpdateFieldForNewCompany(FieldNo("Alternative Phone No."));
            UpdateFieldForNewCompany(FieldNo("Telex No."));
            UpdateFieldForNewCompany(FieldNo("Fax No."));
            UpdateFieldForNewCompany(FieldNo("Telex Answer Back"));
            UpdateFieldForNewCompany(FieldNo("E-Mail"));
            UpdateFieldForNewCompany(FieldNo("Home Page"));
            UpdateFieldForNewCompany(FieldNo("Extension No."));
            UpdateFieldForNewCompany(FieldNo("Mobile Phone No."));
            UpdateFieldForNewCompany(FieldNo(Pager));
            UpdateFieldForNewCompany(FieldNo("Correspondence Type"));
        end;
        CalcFields("No. of Industry Groups", "No. of Business Relations");
    end;

    local procedure StaleAddress() Stale: Boolean
    var
        OldCompanyContact: Record Contact;
        DummyContact: Record Contact;
    begin
        if OldCompanyContact.Get(xRec."Company No.") then
            Stale := IdenticalAddress(OldCompanyContact);
        Stale := Stale or IdenticalAddress(DummyContact);
    end;

    local procedure UpdateFieldForNewCompany(FieldNo: Integer)
    var
        OldCompanyContact: Record Contact;
        NewCompanyContact: Record Contact;
        OldCompanyRecRef: RecordRef;
        NewCompanyRecRef: RecordRef;
        ContactRecRef: RecordRef;
        ContactFieldRef: FieldRef;
        OldCompanyFieldValue: Text;
        ContactFieldValue: Text;
        Stale: Boolean;
    begin
        ContactRecRef.GetTable(Rec);
        ContactFieldRef := ContactRecRef.Field(FieldNo);
        ContactFieldValue := Format(ContactFieldRef.Value);

        if NewCompanyContact.Get("Company No.") then begin
            NewCompanyRecRef.GetTable(NewCompanyContact);
            if OldCompanyContact.Get(xRec."Company No.") then begin
                OldCompanyRecRef.GetTable(OldCompanyContact);
                OldCompanyFieldValue := Format(OldCompanyRecRef.Field(FieldNo).Value);
                Stale := ContactFieldValue = OldCompanyFieldValue;
            end;
            if Stale or (ContactFieldValue = '') then begin
                ContactFieldRef.Validate(NewCompanyRecRef.Field(FieldNo).Value);
                ContactRecRef.SetTable(Rec);
            end;
        end;
    end;

    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;


    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        if MapPoint.FindFirst then
            MapMgt.MakeSelection(Database::Contact, GetPosition)
        else
            Message(Text033);
    end;

    local procedure ProcessNameChange()
    var
        ContBusRel: Record "Contact Business Relation";
        Cust: Record Customer;
        Vend: Record Vendor;
    begin
        UpdateSearchName;

        if Type = Type::" " then
            "Company Name" := Name;

        if Type = Type::Group then begin
            ContBusRel.Reset;
            ContBusRel.SetCurrentkey("Link to Table", "Contact No.");
            ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Customer);
            ContBusRel.SetRange("Contact No.", "Company No.");
            if ContBusRel.FindFirst then
                if Cust.Get(ContBusRel."No.") then
                    if Cust."Primary Contact No." = "No." then begin
                        Cust.Contact := Name;
                        Cust.Modify;
                    end;

            ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Vendor);
            if ContBusRel.FindFirst then
                if Vend.Get(ContBusRel."No.") then
                    if Vend."Primary Contact No." = "No." then begin
                        Vend.Contact := Name;
                        Vend.Modify;
                    end;
        end;
    end;

    local procedure GetCompNo(ContactText: Text): Text
    var
        Contact: Record Contact;
        ContactWithoutQuote: Text;
        ContactFilterFromStart: Text;
        ContactFilterContains: Text;
        ContactNo: Code[20];
    begin
        if ContactText = '' then
            exit('');

        if StrLen(ContactText) <= MaxStrLen(Contact."Company No.") then
            if Contact.Get(CopyStr(ContactText, 1, MaxStrLen(Contact."Company No."))) then
                exit(Contact."No.");

        ContactWithoutQuote := ConvertStr(ContactText, '''', '?');

        Contact.SetRange(Type, Contact.Type::Company);

        Contact.SetFilter(Name, '''@' + ContactWithoutQuote + '''');
        if Contact.FindFirst then
            exit(Contact."No.");
        Contact.SetRange(Name);
        ContactFilterFromStart := '''@' + ContactWithoutQuote + '*''';
        Contact.FilterGroup := -1;
        Contact.SetFilter("No.", ContactFilterFromStart);
        Contact.SetFilter(Name, ContactFilterFromStart);
        if Contact.FindFirst then
            exit(Contact."No.");
        ContactFilterContains := '''@*' + ContactWithoutQuote + '*''';
        Contact.SetFilter("No.", ContactFilterContains);
        Contact.SetFilter(Name, ContactFilterContains);
        Contact.SetFilter(City, ContactFilterContains);
        Contact.SetFilter("Phone No.", ContactFilterContains);
        Contact.SetFilter("Post Code", ContactFilterContains);
        case Contact.Count of
            1:
                begin
                    Contact.FindFirst;
                    exit(Contact."No.");
                end;
            else begin
                if not GuiAllowed then
                    Error(SelectContactErr);
                ContactNo := SelectContact(Contact);
                if ContactNo <> '' then
                    exit(ContactNo);
            end;
        end;
        Error(SelectContactErr);
    end;

    local procedure SelectContact(var Contact: Record Contact): Code[20]
    var
        ContactList: Page "Contact List";
    begin
        if Contact.FindSet then
            repeat
                Contact.Mark(true);
            until Contact.Next = 0;
        if Contact.FindFirst then;
        Contact.MarkedOnly := true;

        ContactList.SetTableview(Contact);
        ContactList.SetRecord(Contact);
        ContactList.LookupMode := true;
        if ContactList.RunModal = Action::LookupOK then
            ContactList.GetRecord(Contact)
        else
            Clear(Contact);

        exit(Contact."No.");
    end;

    procedure LookupCompany()
    var
        Contact: Record Contact;
        CompanyDetails: Page "Company Details";
    begin
        Contact.SetRange("No.", "Company No.");
        CompanyDetails.SetTableview(Contact);
        CompanyDetails.SetRecord(Contact);
        if Type = Type::Group then
            CompanyDetails.Editable := false;
        CompanyDetails.RunModal;
    end;

    local procedure CheckForExistingRelationships(LinkToTable: Option " ",Customer,Vendor,"Bank Account")
    var
        Contact: Record Contact;
        ContBusRel: Record "Contact Business Relation";
    begin
    end;

    procedure SetLastDateTimeModified()
    var
        DateFilterCalc: Codeunit "DateFilter-Calc";
        UtcNow: DateTime;
    begin
        UtcNow := DateFilterCalc.ConvertToUtcDateTime(CurrentDatetime);
        "Last Date Modified" := Dt2Date(UtcNow);
        "Last Time Modified" := Dt2Time(UtcNow);
    end;

    procedure SetLastDateTimeFilter(DateFilter: DateTime)
    var
        DateFilterCalc: Codeunit "DateFilter-Calc";
        SyncDateTimeUtc: DateTime;
        CurrentFilterGroup: Integer;
    begin
        SyncDateTimeUtc := DateFilterCalc.ConvertToUtcDateTime(DateFilter);
        CurrentFilterGroup := FilterGroup;
        SetFilter("Last Date Modified", '>=%1', Dt2Date(SyncDateTimeUtc));
        FilterGroup(-1);
        SetFilter("Last Date Modified", '>%1', Dt2Date(SyncDateTimeUtc));
        SetFilter("Last Time Modified", '>%1', Dt2Time(SyncDateTimeUtc));
        FilterGroup(CurrentFilterGroup);
    end;


    procedure TouchContact(ContactNo: Code[20])
    var
        Cont: Record Contact;
    begin
        Cont.LockTable;
        if Cont.Get(ContactNo) then begin
            Cont.SetLastDateTimeModified;
            Cont.Modify;
        end;
    end;


    procedure CountNoOfBusinessRelations(): Integer
    var
        ContactBusinessRelation: Record "Contact Business Relation";
    begin
        if "Company No." <> '' then
            ContactBusinessRelation.SetFilter("Contact No.", '%1|%2', "No.", "Company No.")
        else
            ContactBusinessRelation.SetRange("Contact No.", "No.");
        exit(ContactBusinessRelation.Count);
    end;


    procedure CreateSalesQuoteFromContact()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Init;
        SalesHeader.Validate("Document Type", SalesHeader."document type"::Quote);
        SalesHeader.Insert(true);
        SalesHeader.Validate("Document Date", WorkDate);
        SalesHeader.Validate("Sell-to Contact No.", "No.");
        SalesHeader.Modify;
        Commit;
        Page.RunModal(Page::"Sales Quote", SalesHeader);
    end;


    procedure ContactToCustBusinessRelationExist(): Boolean
    var
        ContBusRel: Record "Contact Business Relation";
    begin
        ContBusRel.Reset;
        ContBusRel.SetRange("Contact No.", "No.");
        ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Customer);
        exit(ContBusRel.FindFirst);
    end;

    [IntegrationEvent(true, false)]
    procedure OnBeforeVendorInsert(var Vend: Record Vendor)
    begin
    end;

    [IntegrationEvent(true, false)]
    procedure OnBeforeCustomerInsert(var Cust: Record Customer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeIsUpdateNeeded(Contact: Record Contact; xContact: Record Contact; var UpdateNeeded: Boolean)
    begin
    end;

    local procedure SetDefaultSalesperson()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) and (UserSetup."Salespers./Purch. Code" <> '') then
            "Salesperson Code" := UserSetup."Salespers./Purch. Code";
    end;

    local procedure VATRegistrationValidation()
    var
        VATRegistrationNoFormat: Record "VAT Registration No. Format";
        VATRegistrationLog: Record "VAT Registration Log";
        VATRegNoSrvConfig: Record "VAT Reg. No. Srv Config";
        VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
        ResultRecordRef: RecordRef;
        ApplicableCountryCode: Code[10];
    begin
    end;

    procedure GetContNo(ContactText: Text): Code[20]
    var
        Contact: Record Contact;
        ContactWithoutQuote: Text;
        ContactFilterFromStart: Text;
        ContactFilterContains: Text;
    begin
    end;

    local procedure MarkContactsWithSimilarName(var Contact: Record Contact; ContactText: Text)
    var
        TypeHelper: Codeunit "Type Helper";
        ContactCount: Integer;
        ContactTextLength: Integer;
        Treshold: Integer;
    begin
    end;

    local procedure IsUpdateNeeded(): Boolean
    var
        UpdateNeeded: Boolean;
    begin
        UpdateNeeded :=
          (Name <> xRec.Name) or
          ("Search Name" <> xRec."Search Name") or
          ("Name 2" <> xRec."Name 2") or
          (Address <> xRec.Address) or
          ("Address 2" <> xRec."Address 2") or
          (City <> xRec.City) or
          ("Alternative Phone No." <> xRec."Alternative Phone No.") or
          ("Telex No." <> xRec."Telex No.") or
          ("Territory Code" <> xRec."Territory Code") or
          ("Currency Code" <> xRec."Currency Code") or
          ("Language Code" <> xRec."Language Code") or
          ("Salesperson Code" <> xRec."Salesperson Code") or
          ("Country/Region Code" <> xRec."Country/Region Code") or
          ("Fax No." <> xRec."Fax No.") or
          ("Telex Answer Back" <> xRec."Telex Answer Back") or
          ("VAT Registration No." <> xRec."VAT Registration No.") or
          ("Post Code" <> xRec."Post Code") or
          (County <> xRec.County) or
          ("E-Mail" <> xRec."E-Mail") or
          ("Home Page" <> xRec."Home Page") or
          (Type <> xRec.Type);
    end;


    procedure DefaultAccounts()
    var
        ProductSetup: Record "Product Setup";
        Default: Record "Default Savings Products.";
    begin

        ProductSetup.Reset;

        if "Group Section" = "group section"::"Other Groups" then
            ProductSetup.SetRange("Auto Open Group Account", true)
        else
            ProductSetup.SetRange("Auto Open Member Account", true);
        if ProductSetup.FindFirst then begin
            Default.Reset;
            Default.SetRange(Code, "No.");
            if Default.FindFirst then
                Default.DeleteAll;
            repeat
                Default.Init;
                Default.Code := "No.";
                Default.Validate(Product, ProductSetup."Product ID");
                Default.Insert;
            until ProductSetup.Next = 0;
        end;
    end;
}

