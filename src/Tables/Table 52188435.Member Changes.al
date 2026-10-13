
Table 50078 "Member Changes"
{
    DrillDownPageID = "Member Changes List";
    LookupPageID = "Member Changes List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;

            trigger OnValidate()
            begin

                SetMemberDetails("Member No.");
                GetNextofkin;
                GetNominee();
                GetSignatory;
                GetAuthorized;
                GetPictures;
            end;
        }
        field(3; Name; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
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

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                //MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(12; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = Member,Account;
        }
        field(13; Nationality; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Status"; Enum "Member Status Enum")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Customer where("Account Type" = const(Employer));

            trigger OnValidate()
            var
                Emp: Record Customer;
            begin
                Emp.Get("Employer Code");
                "Employer Name" := Emp.Name;
            end;
        }
        field(16; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                DateofBirthError: label 'This date cannot be greater than today.';
            begin
                if "Date of Birth" <> 0D then
                    if "Date of Birth" > Today then
                        Error('Invalid Date of Birth. Future Date Detected');
            end;
        }
        field(17; "Terms of Employment"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = " ",Permanent,Contract,Casual;
        }
        field(18; "Payroll/Staff No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "ID No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Mobile Phone No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Single,Married,Divorced,Widowed,Others';
            OptionMembers = " ",Single,Married,Divorced,Widowed,Others;
        }
        field(22; "ID Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = "National ID","Alien ID","Military ID",Passport;
        }
        field(23; Gender; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = '  ,Male,Female,Other';
            OptionMembers = "  ",Male,Female,Other;
        }
        field(24; "First Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Middle Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; Surname; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Member Category"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Member,Staff Members,Board Members,Delegates,Non-Member,Housing';
            OptionMembers = Member,"Staff Members","Board Members",Delegates,"Non-Member",Housing;
        }
        field(28; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Group Account"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Bank Codes";
        }
        field(31; "Bank Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Bank Branches" where("Bank Code" = field("Bank Code"));
        }
        field(33; "Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Bank Account No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "KRA PIN"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "Recruited by Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Walk In,Marketer,Staff,Board Member,Member';
            OptionMembers = "Walk In",Marketer,Staff,"Board Member",Member;
        }
        field(37; "Relationship Manager"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(38; "Employer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39; "Old Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(40; "Restricted Member"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(41; "Recruited By"; Code[20])
        {
            Caption = 'Recruited By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(42; Type; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = Customer,Member,Employer;
        }
        field(43; "Company No."; Code[20])
        {
            Caption = 'Company No.';
            DataClassification = ToBeClassified;
            Editable = false;
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
        field(44; "Company Name"; Text[50])
        {
            Caption = 'Company Name';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Contact where(Type = const(Company));
            ValidateTableRelation = false;
        }
        field(45; "Salutation Code"; Code[20])
        {
            Caption = 'Salutation Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Salutation;
        }
        field(47; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(48; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(49; "Recruited By Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50; "Special Account"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; "Cannot Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52; "Other Type Of Business"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(53; "Business Reg. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(54; "Incorporation No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(55; "Date of Bus. Incorporation"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56; "Business/Group Location"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(57; "Plot/Bldg/Street/Road"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(58; "Other Group Type"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(59; "Date of Bus. Reg."; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60; "Group Category"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = " ",Incorporated,"Non-Incorporated";
        }
        field(61; "Type of Business"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = "Limited Company","Investment Company",Other;
        }
        field(62; "Group No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Members."No." where(Type = const(Group), "Group Section" = const("Micro Group"));
        }
        field(63; "Physically Challenged"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(64; "Group Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = " ",Single,Joint,Corporate,"Group",Parish,"Church & Church Development",Others;

        }
        field(65; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(66; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(67; "Account Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Individual,Joint,"Group(Non-Group)";
        }
        field(68; "Group Section"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Micro Group","Other Groups";
        }

        field(69; "Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(70; "Member Class"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Class";
            Editable = false;
        }
        field(71; "Exempt Send SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "New Exempt Send SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(73; "Exempt Send Email"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(74; "New Exempt Send Email"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Business Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(76; "New Business Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(77; "Position Held"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(78; "New Position Held"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Reference Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "New Reference Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(81; "ID Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(82; "New ID Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50000; "Type of Change"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Bio Data","Communication Details","Banking Details","System Details";
        }
        field(50003; "New Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "New Address"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "New Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "New City"; Text[30])
        {
            DataClassification = ToBeClassified;
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
        field(50007; "New Phone No."; Text[30])
        {
            Caption = 'Alternate Phone No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(50008; "New Country/Region Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                PostCode.ValidateCountryCode("Phone No.", "Post Code", County, "KRA PIN");
            end;
        }
        field(50009; "New Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
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
        field(50010; "New County"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "New E-Mail"; Text[80])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("New E-Mail");
            end;
        }
        field(50012; "New Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Member,Account;
        }
        field(50013; "New Nationality"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "New Status"; Enum "Member Status Enum")
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()

            begin
                if "Change Type" <> "Change Type"::Rejoining then begin
                    if (Status = Status::Withdrawn) or (Status = Status::Dormant) then begin

                        if "New Status" = "New Status"::Active then Error('Cannot change status to Active. Member is either Dormant or Withdrawn,use the correct change type');
                    end;
                end;
            end;
        }
        // field(50015; "New Employer Code"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = Customer where("Account Type" = const(Employer));
        //     trigger OnValidate()
        //     var
        //         Cust: Record Customer;
        //     begin
        //         "New Employer Name" := '';
        //         if Cust.get("New Employer Code") then
        //             "New Employer Name" := Cust.Name;
        //     end;
        // }

        field(50015; "New Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation =
                if ("New Employment Info" = const(Employed)) "Employement Sectors".Code where(Type = const(Employed))
            else
            if ("New Employment Info" = const(Permanent)) "Employement Sectors".Code where(Type = const(Employed));

            trigger OnValidate()
            var
                EmpSectors: Record "Employement Sectors";
            begin
                "New Employer Name" := '';

                EmpSectors.Reset();
                EmpSectors.SetRange(Code, "New Employer Code");
                EmpSectors.SetRange(Type, EmpSectors.Type::Employed);
                if EmpSectors.FindFirst() then
                    "New Employer Name" := EmpSectors.Description;
            end;
        }

        field(50016; "New Date of Birth"; Date)
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
        field(50017; "New Terms of Employment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Permanent,Contract,Casual;
        }
        field(50018; "New Payroll/Staff No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "New ID No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }

        field(50020; "New Mobile Phone No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "New Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Single,Married,Divorced,Widowed,Others';
            OptionMembers = " ",Single,Married,Divorced,Widowed,Others;
        }
        field(50022; "New ID Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "National ID","Alien ID","Military ID",Passport;
        }
        field(50023; "New Gender"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,Male,Female,Other';
            OptionMembers = "  ",Male,Female,Other;
        }
        field(50024; "New First Name"; Text[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                "New Name" := CalculatedName;
            end;
        }
        field(50025; "New Middle Name"; Text[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                "New Name" := CalculatedName;
            end;
        }
        field(50026; "New Surname"; Text[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                "New Name" := CalculatedName;
            end;
        }
        field(50027; "New Member Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Member,Staff Members,Board Members,Delegates,Non-Member,Housing';
            OptionMembers = Member,"Staff Members","Board Members",Delegates,"Non-Member",Housing;
        }
        field(50028; "New Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "New Group Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "New Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Codes";

            trigger OnValidate()
            var
                BankCodes: Record "Bank Codes";
            begin
                "New Bank Name" := '';
                "New Branch Code" := '';
                "New Branch Name" := '';

                if BankCodes.Get("New Bank Code") then
                    "New Bank Name" := BankCodes."Bank Name";
            end;
        }
        field(50031; "New Bank Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "New Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code" = field("New Bank Code"));

            trigger OnValidate()
            var
                BankBranches: Record "Bank Branches";
            begin
                "New Branch Name" := '';

                if BankBranches.Get("New Bank Code", "New Branch Code") then
                    "New Branch Name" := BankBranches."Branch Name";
            end;
        }
        field(50033; "New Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "New Bank Account No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "New KRA PIN"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "New Recruited by Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Walk In,Marketer,Staff,Board Member,Member';
            OptionMembers = "Walk In",Marketer,Staff,"Board Member",Member;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "New Recruited By" := '';
            end;
        }
        field(50037; "New Relationship Manager"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "New Employer Name"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "New Old Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "New Restricted Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "New Recruited By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Recruited by Type" = const(Marketer)) "Salesperson/Purchaser"
            else
            if ("New Recruited by Type" = const(Staff)) Employee
            else
            if ("New Recruited by Type" = const("Board Member")) Members where("Member Category" = const("Board Members"))
            else
            if ("New Recruited by Type" = const(Member)) Members;

            trigger OnValidate()
            begin
                "New Recruited By Name" := '';

                if "New Recruited by Type" = "New recruited by type"::Marketer then begin
                    SalespersonPurchaser.Reset;
                    SalespersonPurchaser.SetRange(Code, "New Recruited By");
                    if SalespersonPurchaser.Find('-') then begin
                        "New Recruited By Name" := SalespersonPurchaser.Name;
                    end;
                end
                else
                    if "New Recruited by Type" = "New Recruited by type"::"Board Member" then begin
                        Members.Reset;
                        Members.SetRange("No.", "New Recruited By");
                        if Members.Find('-') then begin
                            "New Recruited By Name" := Members.Name;
                        end;
                    end
                    else
                        if "New Recruited by Type" = "New Recruited by type"::Staff then begin
                            HREmployees.Reset;
                            HREmployees.SetRange("No.", "New Recruited By");
                            if HREmployees.Find('-') then begin
                                "New Recruited By Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                            end;
                        end
                        else
                            if "New Recruited by Type" = "New Recruited by type"::Member then begin
                                Members.Reset;
                                Members.SetRange("No.", "New Recruited By");
                                if Members.Find('-') then begin
                                    "New Recruited By Name" := Members.Name;
                                end;
                            end;
            end;
        }

        field(50042; "New Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Customer,Member,Employer;
        }
        field(50043; "New Company No."; Code[20])
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
        field(50044; "New Company Name"; Text[50])
        {
            Caption = 'Company Name';
            DataClassification = ToBeClassified;
            TableRelation = Contact where(Type = const(Company));
            ValidateTableRelation = false;
        }
        field(50045; "New Salutation Code"; Code[20])
        {
            Caption = 'Salutation Code';
            DataClassification = ToBeClassified;
            TableRelation = Salutation;
        }
        field(50047; "New Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "New Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "New Recruited By Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "New Special Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "New Cannot Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "New Other Type Of Business"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "New Business Reg. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "New Incorporation No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "New Date of Bus. Incorporation"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "New Business/Group Location"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "New Plot/Bldg/Street/Road"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "New Other Group Type"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "New Date of Bus. Reg."; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "New Group Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Incorporated,"Non-Incorporated";
        }
        field(50061; "New Type of Business"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Limited Company","Investment Company",Other;
        }
        field(50062; "New Group No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members."No." where(Type = const(Group), "Group Section" = const("Micro Group"));
        }
        field(50063; "New Physically Challenged"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "New Group Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Single,Joint,Corporate,"Group",Parish,"Church & Church Development",Others;
        }
        field(50065; "New Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50066; "New Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50067; "Change Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",General,"Employment Details",Communication,"Bank Details","Other Information","Next of Kin","Authorized Persons","Pic & Signature",Rejoining,"Unblock All Accounts","Block All Accounts",Nominee,"Block Mobile Loan","Block Guarantorship","Unblock Mobile Loan","Unblock Guarantorship","Child Details","Account Details","Account Closure","Mark As Fraud","UnMark As Fraud",Activation,"UnBlock Account";

            trigger OnValidate()
            begin
                if "Change Type" = "change type"::"Next of Kin" then
                    Validate("Member No.");
                if "Change Type" = "change type"::Nominee then
                    Validate("Member No.");

                if "Change Type" = "Change Type"::Rejoining then
                    Validate("Member No.");

            end;
        }
        field(50068; Picture; Blob)
        {
            Caption = 'Picture';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50069; Signature; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50070; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Rejected,Cancelled;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Approval Status" = "Approval Status"::Approved then
                    "Approved By" := userid;
            end;
        }
        field(50071; "Reason For Change"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50072; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50074; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50075; "New Account Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Individual,Joint,"Group(Non-Group)";
        }
        field(50076; "User Branch"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "New Group Section"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Micro Group","Other Groups";
        }

        field(50078; "New Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50079; "New Member Class"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Class";
        }
        field(50080; "Entered By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50081; "Created Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50082; "Signing Instructions"; Option)
        {
            OptionMembers = Single,"All must Sign","Either Must Sign";
        }
        field(50083; "Signing Instructions Narration"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Mandate;
        }
        field(50084; "New Signing Instructions"; Option)
        {
            OptionMembers = Single,"All must Sign","Either Must Sign";
        }
        field(50085; "New Signing Instr. Narration"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Mandate;
        }
        field(50086; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50087; "Child Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50088; "Child Date of Birth"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(50089; "Child Birth Cert No."; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50090; "Piggy Bank Issued"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50091; "New Child Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50092; "New Child Date of Birth"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(50093; "New Child Birth Cert No."; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50094; "New Piggy Bank Issued"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50095; "Account No."; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Accounts" where("Member No." = field("Member No."));

            trigger OnValidate()
            begin
                //child details
                if "Change Type" = "Change Type"::"Child Details" then begin
                    MemberAccounts.reset;
                    MemberAccounts.setrange("No.", "Account No.");
                    if MemberAccounts.FindFirst() then begin

                        "Child Name" := MemberAccounts."Child Name";
                        "Child Date of Birth" := MemberAccounts."Child Date Of Birth";
                        "Child Birth Cert No." := MemberAccounts."Child Birth Cet. No.";
                        "Piggy Bank Issued" := MemberAccounts."Piggy Bank Issued";

                    end;
                end;
                //Account Details
                if "Change Type" = "Change Type"::"UnBlock Account" then begin
                    MemberAccounts.reset;
                    MemberAccounts.setrange("No.", "Account No.");
                    if MemberAccounts.FindFirst() then begin
                        Blocked := MemberAccounts.BLocked;
                    end;
                end;

                if ("Change Type" = "Change Type"::"Account Details") or ("Change Type" = "Change Type"::Activation) then begin

                    MemberAccounts.reset;
                    MemberAccounts.setrange("No.", "Account No.");
                    if MemberAccounts.FindFirst() then begin
                        "Monthly Contribution" := MemberAccounts."Monthly Contribution";
                        "Salary Processing" := MemberAccounts."Salary Processing";
                        "Transactional Mobile No" := MemberAccounts."Transactional Mobile No";
                        "Account Status" := MemberAccounts.Status;
                        "Repay Mode" := MemberAccounts."Repay Mode";
                        Blocked := MemberAccounts.BLocked;

                    end;
                end;
            end;
        }
        field(50096; "Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50097; "New Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50098; "Account Status"; Enum "Account Status Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50099; "New Account Status"; Enum "Account Status Enum")
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                SaccoSetup: Record "Sacco Setup";
            begin

            end;
        }
        field(50100; "Salary Processing"; boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "New Salary Processing"; boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Transactional Mobile No"; code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "New Transactional Mobile No"; code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(501034; "Checkoff Station"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Customer where("Account Type" = const(Employer));
            trigger OnValidate()
            var
                Cust: Record Members;
            begin
                "Checkoff Station Name" := '';
                if Cust.get("New Checkoff Station") then
                    "Checkoff Station Name" := Cust.Name;

            end;
        }
        field(501035; "Checkoff Station Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(501036; "New Checkoff Station"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Employer));
            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                "New Checkoff Station Name" := '';
                if Cust.get("New Checkoff Station") then
                    "New Checkoff Station Name" := Cust.Name;

            end;
        }
        field(501037; "New Checkoff Station Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(501038; "Self Employed"; boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(501039; "New Self Employed"; boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(501040; "Employement Sector"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employement Sectors".Description;
        }
        field(501041; "New Employement Sector"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation =
                if ("New Employment Info" = const(Employed)) "Employement Sectors".code where(Type = const(Employed))
            else
            if ("New Employment Info" = const(Business)) "Employement Sectors".code where(Type = const(Business))
            else
            if ("New Employment Info" = const(Contracting)) "Employement Sectors".code where(Type = const(Business))
            else
            if ("New Employment Info" = const("Self-Employed")) "Employement Sectors".code where(Type = const(Business))
            else
            "Employement Sectors".code;
        }
        field(501056; "Employment Info"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = Employed,UnEmployed,Contracting,Business,"Self-Employed",Pensioner,Permanent;
        }
        field(501057; "New Employment Info"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Employed,UnEmployed,Contracting,Business,"Self-Employed",Pensioner,Permanent;

            trigger OnValidate()
            begin
                if "New Employment Info" in ["New Employment Info"::"Self-Employed",
                                             "New Employment Info"::Business,
                                             "New Employment Info"::Contracting] then begin
                    "New Terms of Employment" := "New Terms of Employment"::" ";
                    "New Employer Code" := '';
                    "New Employer Name" := '';
                    "New Checkoff Station" := '';
                    "New Checkoff Station Name" := '';
                    "New Payroll/Staff No." := '';
                    "New Self Employed" := true;
                end else begin
                    "New Employement Sector" := '';
                    "New Business Name" := '';
                    "New Business/Group Location" := '';
                    "New Self Employed" := false;
                end;
            end;
        }
        field(501042; "Passport"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(501043; "New Passport"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(501044; "Passport Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(501045; "New Passport Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(501046; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(501047; Charges; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(501048; "Excise Duty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(501049; "Repay Mode"; Enum "Repay Mode Enum")
        {
            DataClassification = ToBeClassified;
            Editable = false;
            ValuesAllowed = " ", Salary, "Check Off";
        }
        field(501050; "New Repay Mode"; Enum "Repay Mode Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(501051; Blocked; enum "Vendor Blocked")
        {
            Caption = 'Blocked';
            Editable = false;
        }
        field(501052; "New Blocked"; enum "Vendor Blocked")
        {
            Caption = 'New Blocked';
        }
        field(501053; "Deposit Changed By"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members where("Member Category" = filter("Staff Members"));
        }
        field(501054; "Work E-Mail"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                //MailManagement.ValidateEmailAddressField("Work E-Mail");
            end;
        }
        field(501055; "New Work E-Mail"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("New Work E-Mail");
            end;
        }
        field(501058; "Request ID"; Text[50])
        {
            Caption = 'Request ID';
        }
        field(501059; "Application Time"; Time)
        {
            Caption = 'Application Time';
        }
        field(501060; "Cancelled Date"; Date)
        {
            Caption = 'Cancelled Date';
            DataClassification = CustomerContent;
        }
        field(501061; "Cancelled Time"; Time)
        {
            Caption = 'Cancelled Time';
            DataClassification = CustomerContent;
        }
        field(501062; "Cancelled By"; Code[20])
        {
            Caption = 'Cancelled By';
            DataClassification = CustomerContent;
        }
        field(501063; "Cancellation Reason"; Text[100])
        {
            Caption = 'Cancellation Reason';
            DataClassification = CustomerContent;
        }
        field(501064; "New ID No. IDM Verified"; Boolean)
        {
            Caption = 'New ID Verified';
            DataClassification = CustomerContent;
        }
        field(501065; "New Phone IDM Verified"; Boolean)
        {
            Caption = 'New Mobile Verified';
            DataClassification = CustomerContent;
        }
        field(501066; "New KRA PIN IDM Verified"; Boolean)
        {
            Caption = 'New KRA PIN Verified';
            DataClassification = CustomerContent;
        }


    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if Code = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField("Member Changes Nos");
            Code := NoSeries.GetNextNo(SalesSetup."Member Changes Nos", WorkDate(), true);
        end;

        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin

            if UserSetup."Max. Open Documents" > 0 then begin
                MemberReg.Reset();
                MemberReg.SetRange("Captured By", UserId);
                MemberReg.SetRange(Status, MemberReg.Status::" ");
                if MemberReg.FindFirst() then
                    if MemberReg.Count > UserSetup."Max. Open Documents" then
                        Error('You are not allowed to open multiple documents. Complete %1 first.', MemberReg.code);
            end;

            if not UserSetup."Member Changes" then
                error('You are not allowed to capture member changes. Please concact ICT')
        end;

        Date := Today;
        "Entered By" := UserId;
        "Created Date Time" := CurrentDateTime;
    end;

    var
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
        NoSeries: Codeunit "No. Series";
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
        HREmployees: Record Employee;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        MemberReg: Record "Member Changes";
        UserSetup: Record "User Setup";
        TChannel: Enum "Transaction Channel";



    procedure InitFields()
    begin


        Type := Type::Member;
        "First Name" := '';
        Surname := '';
        "Middle Name" := '';
        Name := '';
        "Registration Date" := 0D;
        "ID No." := '';
        Passport := '';
        "Passport Expiry Date" := 0D;
        "Date of Birth" := 0D;
        "ID Expiry Date" := 0D;
        "KRA PIN" := '';
        "Signing Instructions Narration" := '';
        Gender := Gender::"  ";
        "Marital Status" := "marital status"::" ";
        "Employer Code" := '';
        "Employer Name" := '';
        "Checkoff Station" := '';
        "Checkoff Station Name" := '';
        "Terms of Employment" := "terms of employment"::" ";
        "Payroll/Staff No." := '';
        "Member Category" := 0;
        Address := '';
        "Address 2" := '';
        City := '';
        Nationality := '';
        Blocked := Blocked::" ";
        "Country/Region Code" := '';
        "Phone No." := '';
        "Mobile Phone No." := '';
        "E-Mail" := '';
        "Group Section" := "group section"::" ";

        "Global Dimension 2 Code" := '';
        "Recruited by Type" := 0;
        "Recruited By" := '';
        "Recruited By Name" := '';
        "Status" := "Status"::" ";
        "Bank Code" := '';
        "Bank Name" := '';
        "Branch Code" := '';
        "Branch Name" := '';
        "Bank Account No." := '';
        "Swift Code" := '';
        "Salutation Code" := '';
        "Group No." := '';
        "Physically Challenged" := false;
        "Special Account" := false;
        "Cannot Guarantee" := false;
        "Member Class" := '';
        "Employement Sector" := '';
        "Position Held" := '';
        "Business/Group Location" := '';

        //Group
        "Group Account" := false;
        "Other Type Of Business" := '';
        "Business Reg. No." := '';
        "Incorporation No." := '';
        "Date of Bus. Incorporation" := 0D;
        "Business/Group Location" := '';
        "Group Type" := 0;
        "Other Group Type" := '';
        "Date of Bus. Reg." := 0D;
        "Group Category" := 0;
        "Type of Business" := 0;
        "Account Category" := "account category"::Individual;

        //


        //NEW

        "New Type" := "new type"::Member;
        "New Passport" := '';
        "New First Name" := '';
        "New Surname" := '';
        "New Middle Name" := '';
        "New Name" := '';
        "New Registration Date" := 0D;
        "New ID No." := '';
        "New ID Expiry Date" := 0D;
        "New Date of Birth" := 0D;
        "New KRA PIN" := '';
        "New Gender" := "new gender"::"  ";
        "New Marital Status" := "new marital status"::" ";
        "New Employer Code" := '';
        "New Employer Name" := '';
        "New Checkoff Station" := '';
        "New Checkoff Station Name" := '';
        "New Terms of Employment" := 0;
        "New Payroll/Staff No." := '';
        "New Member Category" := 0;
        "New Address" := '';
        "New Address 2" := '';
        "New City" := '';
        "New Nationality" := '';
        "New Country/Region Code" := '';
        "New Phone No." := '';
        "New Mobile Phone No." := '';
        "New E-Mail" := '';
        "New Work E-Mail" := '';
        "New Signing Instr. Narration" := '';
        "New Registration Date" := 0D;


        "New Global Dimension 2 Code" := '';
        "New Recruited by Type" := 0;
        "New Recruited By" := '';
        "New Recruited By Name" := '';
        "New Status" := "new status"::" ";
        "New Bank Code" := '';
        "New Bank Name" := '';
        "New Branch Code" := '';
        "New Swift Code" := '';
        "New Branch Name" := '';
        "New Bank Account No." := '';
        "New Salutation Code" := '';
        "New Group No." := '';
        "New Physically Challenged" := false;
        "New Special Account" := false;
        "New Cannot Guarantee" := false;
        "New Member Class" := '';

        //Group
        "New Group Account" := false;
        "New Other Type Of Business" := '';
        "New Business Reg. No." := '';
        "New Incorporation No." := '';
        "New Date of Bus. Incorporation" := 0D;
        "New Business/Group Location" := '';
        "New Group Type" := 0;
        "New Other Group Type" := '';
        "New Date of Bus. Reg." := 0D;
        "New Group Category" := 0;
        "New Type of Business" := 0;
        "New Employement Sector" := '';
        "New Business Name" := '';
        "New Position Held" := '';

    end;

    procedure SetMemberDetails(MNo: Code[20])
    begin

        InitFields;
        if Members.Get(MNo) then begin

            Type := Members.Type;
            "First Name" := UpperCase(Members."First Name");
            Surname := UpperCase(Members.Surname);
            "Middle Name" := UpperCase(Members."Middle Name");
            Name := UpperCase(Members.Name);
            "Registration Date" := Members."Registration Date";
            "ID No." := Members."ID No.";
            "ID Type" := Members."ID Type";
            "New ID Type" := Members."ID Type";
            "ID Expiry Date" := Members."ID Expiry Date";
            Passport := Members.Passport;
            "Date of Birth" := Members."Date of Birth";
            "KRA PIN" := Members."KRA PIN";
            Gender := Members.Gender;
            "Exempt Send SMS" := Members."Exempt Send SMS";
            "Exempt Send Email" := Members."Exempt Send Email";
            "Marital Status" := Members."Marital Status";
            "Employer Code" := Members."Employer Code";
            "Employer Name" := Members."Employer Name";
            "Checkoff Station" := Members."Checkoff Station";
            "Checkoff Station Name" := Members."Checkoff Station Name";
            "Terms of Employment" := Members."Terms of Employment";
            "Payroll/Staff No." := Members."Payroll/Staff No.";
            "Member Category" := Members."Member Category";
            "Captured By" := Members."Captured By";
            Address := Members.Address;
            "Address 2" := Members."Address 2";
            City := Members.City;
            Nationality := Members.Nationality;
            "Country/Region Code" := Members."Country/Region Code";
            "Phone No." := Members."Phone No.";
            "Mobile Phone No." := Members."Mobile Phone No.";
            "E-Mail" := Members."E-Mail";
            "Global Dimension 2 Code" := Members."Global Dimension 2 Code";
            "Recruited by Type" := Members."Recruited by Type";
            "Recruited By" := Members."Recruited By";
            "Recruited By Name" := Members."Recruited By Name";
            "Status" := Members."Member Status";
            "Employement Sector" := Members."Employement Sector";
            "Self Employed" := Members."Self Employed";
            "New Self Employed" := Members."Self Employed";
            "Employment Info" := Members."Employment Info";
            "New Employment Info" := Members."Employment Info";
            "Passport Expiry Date" := Members."Passport Expiry Date";
            "ID Expiry Date" := Members."ID Expiry Date";
            "Reference Code" := Members."Reference Code";
            "Old Member No." := Members."Old Member No.";


            if "Change Type" = "Change Type"::Rejoining then begin

                if Members."Member Status" <> Members."Member Status"::Withdrawn then
                    Error('Member is not withdrawan');
            end;


            "Bank Code" := Members."Bank Code";
            "Swift Code" := Members."Swift Code";
            "Bank Name" := Members."Bank Name";
            "Branch Code" := Members."Branch Code";
            "Branch Name" := Members."Branch Name";
            "Bank Account No." := Members."Bank Account No.";
            "Salutation Code" := Members."Salutation Code";
            "Group No." := Members."Group No.";
            "Group Section" := Members."Group Section";

            "Physically Challenged" := Members."Physically Challenged";
            "Special Account" := Members."Special Account";
            "Cannot Guarantee" := Members."Cannot Guarantee";
            "Member Class" := Members."Member Class";


            //Group
            "Group Account" := Members."Group Account";
            "Other Type Of Business" := Members."Other Type Of Business";
            "Business Reg. No." := Members."Business Reg. No.";
            "Incorporation No." := Members."Incorporation No.";
            "Date of Bus. Incorporation" := Members."Date of Bus. Incorporation";
            "Business/Group Location" := Members."Business/Group Location";
            "Group Type" := Members."Group Type";
            "Other Group Type" := Members."Other Group Type";
            "Date of Bus. Reg." := Members."Date of Bus. Reg.";
            "Group Category" := Members."Group Category";
            "Type of Business" := Members."Type of Business";
            "Account Category" := Members."Account Category";

            MemberAccounts.Reset();
            MemberAccounts.SetRange("Member No.", MNo);
            MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
            if MemberAccounts.FindFirst() then begin
                "Signing Instructions" := MemberAccounts."Signing Instructions";
                "Signing Instructions Narration" := MemberAccounts."Signing Instructions Narration";
            end;

        end;
    end;

    procedure UpdateMember(MNo: Code[20])
    var
        NomineeApp: Record Nominee;
        Nominee: Record Nominee;
        NextOfKinApp: Record "Next of Kin.";
        NextOfKin: Record "Next of Kin.";
        MemberImages: Record "Member Images";
        ProductSetup: Record "Product Setup";
        PGroup: Record "Customer Posting Group";
        MemberAccounts: Record "Savings Accounts";
        MemberActivities: Codeunit "Member Activities";
        SActivities: Codeunit "Sacco Activities";
        JTemplate: Code[20];
        JBatch: Code[20];
        AcctType: Enum "Gen. Journal Account Type";
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        PreviousMember: Record Members;
        PreviousAcc: Record "Savings Accounts";
        Loans: Record Loans;
        i: Integer;

        MemberExit: Record "Member Exit";
        Saccosetup: Record "Sacco Setup";
        ChargeAmt: Decimal;
        ChargeDuty: Decimal;
        ChargeAcctType: Enum "Gen. Journal Account Type";
        ChargeAcct: Code[20];
        Desc: Text[100];
        Sky: Codeunit "Sky MBanking";
        SkyMobile: Codeunit "Sky Mobile Banking Integration";
    begin

        if PreviousMember.Get(MNo) then;
        if PreviousAcc.Get(Rec."Account No.") then;
        Saccosetup.Get();
        if Members.Get(MNo) then begin

            //if "Change Type" = "change type"::"Bank Details" then begin
            if "New Swift Code" <> '' then
                Members."Swift Code" := "New Swift Code";
            if "New Bank Code" <> '' then
                Members."Bank Code" := "New Bank Code";
            if "New Bank Name" <> '' then
                Members."Bank Name" := "New Bank Name";
            if "New Branch Code" <> '' then
                Members."Branch Code" := "New Branch Code";
            if "New Branch Name" <> '' then
                Members."Branch Name" := "New Branch Name";
            if "New Bank Account No." <> '' then
                Members."Bank Account No." := "New Bank Account No.";

            /* Members.Modify;
         end; 
         if "Change Type" = "change type"::Communication then begin*/
            if "New Address" <> '' then
                Members.Address := "New Address";
            if "New Address 2" <> '' then
                Members."Address 2" := "New Address 2";
            if "New Nationality" <> '' then
                Members.Nationality := "New Nationality";
            if "New Exempt Send SMS" then
                Members."Exempt Send SMS" := "New Exempt Send SMS";
            if "New Exempt Send Email" then
                Members."Exempt Send Email" := "New Exempt Send Email";
            if "New City" <> '' then
                Members.City := "New City";
            if "New Country/Region Code" <> '' then
                Members."Country/Region Code" := "New Country/Region Code";
            if "New Phone No." <> '' then
                Members."Phone No." := "New Phone No.";
            if "New Mobile Phone No." <> '' then begin

                Members."Mobile Phone No." := "New Mobile Phone No.";

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Members."No.");
                if MemberAccounts.FindFirst then begin
                    MemberAccounts.ModifyAll("Mobile Phone No.", "New Mobile Phone No.");
                end;
            end;
            if "New E-Mail" <> '' then
                Members."E-Mail" := "New E-Mail";

            if "New Work E-Mail" <> '' then
                Members."Work E-Mail" := "New Work E-Mail";

            /*   Members.Modify;
           end; */
            if "Change Type" = "change type"::"Block Guarantorship" then begin
                Members.TestField("Block Guarantorship", false);
                Members."Block Guarantorship" := true;
                Members.Modify();
            end;
            if "Change Type" = "change type"::"Block Mobile Loan" then begin
                Members.TestField("Block Mobile Loan", false);
                Members."Block Mobile Loan" := true;
                Members.Modify();
            end;

            if "Change Type" = "change type"::"unBlock Guarantorship" then begin
                Members.TestField("Block Guarantorship", true);
                Members."Block Guarantorship" := false;
                Members.Modify();
            end;
            if "Change Type" = "change type"::"unBlock Mobile Loan" then begin
                Members.TestField("Block Mobile Loan", true);
                Members."Block Mobile Loan" := false;
                Members.Modify();
            end;

            if "Change Type" = "change type"::"UnBlock Account" then begin


                MemberAccounts.Reset;
                MemberAccounts.SetRange("No.", "Account No.");
                if MemberAccounts.FindFirst then begin
                    MemberAccounts.Blocked := Rec."New Blocked";
                    MemberAccounts.Modify();
                    TrackTheSavingsChangesDone(Rec, PreviousAcc, MemberAccounts);
                end;
            end;

            if "Change Type" = "change type"::"Block All Accounts" then begin


                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Members."No.");
                if MemberAccounts.FindFirst then begin
                    repeat
                        MemberAccounts.Blocked := MemberAccounts.Blocked::All;
                        MemberAccounts.Modify();
                        TrackTheSavingsChangesDone(Rec, PreviousAcc, MemberAccounts);
                    until MemberAccounts.next = 0;
                end;
            end;

            if "Change Type" = "change type"::"Unblock All Accounts" then begin

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Members."No.");
                if MemberAccounts.FindFirst then begin
                    repeat
                        MemberAccounts.Blocked := MemberAccounts.Blocked::" ";
                        MemberAccounts.Status := MemberAccounts.Status::Active;
                        MemberAccounts.Modify();
                        TrackTheSavingsChangesDone(Rec, PreviousAcc, MemberAccounts);
                    until MemberAccounts.next = 0;
                end;
                Members."Member Status" := Members."Member Status"::Active;
                Members.Blocked := Members.Blocked::" ";
                Members.Modify();
            end;
            if "Change Type" = "change type"::"Mark As Fraud" then begin

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Members."No.");
                if MemberAccounts.FindFirst then begin
                    repeat
                        MemberAccounts.Blocked := MemberAccounts.Blocked::All;
                        MemberAccounts.Status := MemberAccounts.Status::Fraud;
                        MemberAccounts.Modify();
                        TrackTheSavingsChangesDone(Rec, PreviousAcc, MemberAccounts);
                    until MemberAccounts.next = 0;
                end;

                Members."Member Status" := Members."Member Status"::Fraud;
                Members.Blocked := Members.Blocked::All;
                Members.Modify();
            end;
            if "Change Type" = "change type"::"UnMark As Fraud" then begin

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Members."No.");
                if MemberAccounts.FindFirst then begin
                    repeat
                        MemberAccounts.Blocked := MemberAccounts.Blocked::" ";
                        MemberAccounts.Status := MemberAccounts.Status::Active;
                        MemberAccounts.Modify();
                        TrackTheSavingsChangesDone(Rec, PreviousAcc, MemberAccounts);
                    until MemberAccounts.next = 0;
                end;

                Members."Member Status" := Members."Member Status"::Active;
                Members.Blocked := Members.Blocked::" ";
                Members.Modify();
            end;

            //if "Change Type" = "change type"::"Employment Details" then begin
            if "New Position Held" <> '' then
                Members."Position Held" := "New Position Held";
            if "New Employer Code" <> '' then
                Members."Employer Code" := "New Employer Code";
            if "New Employer Name" <> '' then
                Members."Employer Name" := "New Employer Name";
            if "New Terms of Employment" <> "new terms of employment"::" " then
                Members."Terms of Employment" := "New Terms of Employment";
            if "New Employment Info" <> "Employment Info" then
                Members."Employment Info" := "New Employment Info";
            if "New Payroll/Staff No." <> '' then begin
                Members."Old Payroll No." := Members."Payroll/Staff No.";
                Members."Payroll/Staff No." := "New Payroll/Staff No.";

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Members."No.");
                if MemberAccounts.FindFirst then begin
                    MemberAccounts.ModifyAll("Member Staff No.", "New Payroll/Staff No.");
                    TrackTheSavingsChangesDone(Rec, PreviousAcc, MemberAccounts);
                end;
            end;

            /*   Members.Modify;
           end; */

            // if "Change Type" = "change type"::General then begin

            if "New First Name" <> '' then
                Members."First Name" := UpperCase("New First Name");
            if "New Surname" <> '' then
                Members.Surname := UpperCase("New Surname");
            if "New Middle Name" <> '' then
                Members."Middle Name" := UpperCase("New Middle Name");

            if "Change Type" = "Change Type"::General then
                if "New Member Category" <> "Member Category" then
                    Members."Member Category" := "New Member Category";

            if "New Name" <> '' then begin
                Members.Name := UpperCase("New Name");
                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Members."No.");
                if MemberAccounts.FindFirst then begin
                    MemberAccounts.ModifyAll(Name, "New Name");
                    TrackTheSavingsChangesDone(Rec, PreviousAcc, MemberAccounts);
                end;

                Loans.Reset;
                Loans.SetRange("Member No.", Members."No.");
                if Loans.FindFirst then begin
                    Loans.ModifyAll("Member Name", "New Name");
                end;
            end;
            if "New ID No." <> '' then begin

                Members."ID No." := "New ID No.";

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Members."No.");
                if MemberAccounts.FindFirst then begin
                    MemberAccounts.ModifyAll("Member ID", "New ID No.");
                end;
            end;
            if "New ID Type" <> Members."ID Type" then
                Members."ID Type" := "New ID Type";

            if "New ID Expiry Date" <> 0D then
                Members."ID Expiry Date" := "New ID Expiry Date";

            if "New Passport" <> Passport then
                Members.Passport := "New passport";
            if "New Passport Expiry Date" <> xrec."Passport Expiry Date" then
                Members."Passport Expiry Date" := "New Passport Expiry Date";
            if "New Date of Birth" <> 0D then
                Members."Date of Birth" := "New Date of Birth";
            if "New KRA PIN" <> '' then
                Members."KRA PIN" := "New KRA PIN";
            if "New Gender" <> "new gender"::"  " then
                Members.Gender := "New Gender";
            if "New Marital Status" <> "new marital status"::" " then
                Members."Marital Status" := "New Marital Status";

            if "New Reference Code" <> '' then
                "New Reference Code" := "New Reference Code";


            if "New Name" <> '' then begin
                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Members."No.");
                if MemberAccounts.FindFirst then begin
                    MemberAccounts.ModifyAll(Name, UpperCase("New Name"));
                end;
            end;
            if "New Member Class" <> '' then
                Members."Member Class" := "New Member Class";


            if "New Salutation Code" <> '' then
                Members."Salutation Code" := "New Salutation Code";
            if "New Status" <> "new status"::" " then
                Members."Member Status" := "New Status";
            if "New Physically Challenged" <> xRec."New Physically Challenged" then
                Members."Physically Challenged" := "New Physically Challenged";


            //Members.Modify;

            if "New Group No." <> '' then begin
                ProductSetup.Reset;
                ProductSetup.SetRange("Product Category", ProductSetup."product category"::"Micro Member Deposit");
                if ProductSetup.FindFirst then begin
                    MemberAccounts.Reset;
                    MemberAccounts.SetRange("Member No.", Members."No.");
                    MemberAccounts.SetRange("Product Type", ProductSetup."Product ID");
                    if not MemberAccounts.FindFirst then
                        MemberActivities.CreateSavingsAccount(ProductSetup, Members, 0, false, ProductSetup."Repay Mode");
                end;
            end;

            //end;

            if "Change Type" = "change type"::Rejoining then begin

                if "New Registration Date" = 0D then
                    "New Registration Date" := Today;

                Members."Member Status" := Members."Member Status"::Active;
                Members."Registration Date" := "New Registration Date";
                Members."Date Rejoined" := "New Registration Date";
                Members.Rejoined := true;
                Members.Blocked := Members.Blocked::" ";
                Members."Date Rejoined" := Today;
                Members."Rejoined By" := UserId;

                Members.Modify();

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Members."No.");
                if MemberAccounts.FindFirst then begin
                    repeat
                        MemberAccounts.Status := MemberAccounts.Status::Active;
                        MemberAccounts.Blocked := MemberAccounts.Blocked::" ";
                        MemberAccounts.Modify;
                        TrackTheSavingsChangesDone(Rec, PreviousAcc, MemberAccounts);
                    until MemberAccounts.Next() = 0;
                end;

                MemberExit.Reset();
                MemberExit.SetRange("Member No.", Members."No.");
                MemberExit.SetFilter(date, '>=%1', Saccosetup."Go Live Date");
                MemberExit.SetRange(Posted, true);
                if not MemberExit.FindFirst then begin

                    MemberAccounts.Reset;
                    MemberAccounts.SetRange("Member No.", Members."No.");
                    MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Registration Fee");
                    MemberAccounts.SetFilter("Balance (LCY)", '<>%1', 0);
                    if MemberAccounts.FindFirst then begin

                        SActivities.GetGeneralJournalTemplate(JTemplate, JBatch);
                        MemberAccounts.CalcFields("Balance (LCY)");
                        SActivities.JournalInit(JTemplate, JBatch);

                        PGroup.Get(MemberAccounts."Customer Posting Group");

                        SActivities.JournalInsert(
                            JTemplate,
                            JBatch,
                            Code,
                            Today,
                            Accttype::Savings,
                            MemberAccounts."No.",
                            CopyStr('REJOINING ZEROLIZATION', 1, 50),
                            Balaccttype::"G/L Account",
                            PGroup."Payables Account",
                            MemberAccounts."Balance (LCY)",
                            Code,
                            '',
                            Transtype::" ",
                            "Global Dimension 1 Code",
                            "Global Dimension 2 Code",
                            true,
                            TChannel::" ",
                            0
                            );

                        SActivities.JournalPost(JTemplate, JBatch);
                    end;
                end;
            end;

            if ("Change Type" = "Change Type"::Activation) then begin
                if SaccoSetup."Charge Activation Fee" then begin
                    MemberActivities.GetGeneralCumulativeChargeAmount(Saccosetup."Activation Fee Charge", 0, Charges, "Excise Duty", ChargeAcctType, ChargeAcct);


                    MemberAccounts.Reset;
                    MemberAccounts.SetRange("Member No.", Members."No.");
                    MemberAccounts.SetRange("No.", Rec."Account No.");
                    MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
                    if (MemberAccounts.FindFirst()) and (Rec."New Account Status" = Rec."New Account Status"::Active) and (Rec."Account Status" = Rec."Account Status"::Dormant) then begin

                        SActivities.GetGeneralJournalTemplate(JTemplate, JBatch);
                        MemberAccounts.CalcFields("Balance (LCY)");
                        SActivities.JournalInit(JTemplate, JBatch);
                        if Charges + "Excise Duty" > MemberAccounts."Balance (LCY)" then
                            Error('The account balance is less than %1', Charges + "Excise Duty");

                        SActivities.JournalInsert(
                            JTemplate,
                            JBatch,
                            Code,
                            Today,
                            Accttype::Savings,
                            MemberAccounts."No.",
                            CopyStr('Activation Fee ' + MemberAccounts."No.", 1, 50),
                            ChargeAcctType,
                            ChargeAcct,
                            Charges,
                            cODE,
                            '',
                            Transtype::" ",
                            "Global Dimension 1 Code",
                            "Global Dimension 2 Code",
                            true,
                            TChannel::" ",
                            0
                            );

                        SActivities.JournalInsert(
                            JTemplate,
                            JBatch,
                            Code,
                            Today,
                            Accttype::Savings,
                            MemberAccounts."No.",
                            CopyStr('Excise duty on Activation Fee ' + MemberAccounts."No.", 1, 50),
                            ChargeAcctType,
                            Saccosetup."Excise Duty GL",
                            "Excise Duty",
                            cODE,
                            '',
                            Transtype::" ",
                            "Global Dimension 1 Code",
                            "Global Dimension 2 Code",
                            true,
                            TChannel::" ",
                            0
                            );

                        SActivities.JournalPost(JTemplate, JBatch);
                    end;

                end;
            end;

            if "Change Type" = "Change Type"::"Account Closure" then begin

                MemberActivities.GetGeneralCumulativeChargeAmount('CLOSURE', 0, Charges, "Excise Duty", ChargeAcctType, ChargeAcct);

                MemberAccounts.Reset;
                MemberAccounts.SetRange("Member No.", Members."No.");
                MemberAccounts.SetRange("No.", Rec."Account No.");
                if MemberAccounts.FindFirst then begin

                    SActivities.GetGeneralJournalTemplate(JTemplate, JBatch);
                    MemberAccounts.CalcFields("Balance (LCY)");
                    SActivities.JournalInit(JTemplate, JBatch);

                    if Charges + "Excise Duty" > MemberAccounts."Balance (LCY)" then
                        Error('The account balance is less than %1', Charges + "Excise Duty");

                    SActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        Code,
                        Today,
                        Accttype::Savings,
                        MemberAccounts."No.",
                        CopyStr('ACCOUNT CLOSURE FEE', 1, 50),
                        ChargeAcctType,
                        ChargeAcct,
                        Charges,
                        cODE,
                        '',
                        Transtype::" ",
                        "Global Dimension 1 Code",
                        "Global Dimension 2 Code",
                        true,
                        TChannel::" ",
                        0
                        );

                    SActivities.JournalInsert(
                        JTemplate,
                        JBatch,
                        Code,
                        Today,
                        Accttype::Savings,
                        MemberAccounts."No.",
                        CopyStr('ACCOUNT CLOSURE FEE', 1, 50),
                        ChargeAcctType,
                        Saccosetup."Excise Duty GL",
                        "Excise Duty",
                        cODE,
                        '',
                        Transtype::" ",
                        "Global Dimension 1 Code",
                        "Global Dimension 2 Code",
                        true,
                        TChannel::" ",
                        0
                        );

                    SActivities.JournalPost(JTemplate, JBatch);
                end;

            end;

            //if "Change Type" = "change type"::"Other Information" then begin

            if "New Recruited by Type" <> xRec."New Recruited by Type" then
                Members."Recruited by Type" := "New Recruited by Type";
            if "New Recruited By" <> '' then
                Members."Recruited By" := "New Recruited By";
            if "New Recruited By Name" <> '' then
                Members."Recruited By Name" := "New Recruited By Name";
            if "Change Type" = "Change Type"::General then
                if "New Member Category" <> "Member Category" then
                    Members."Member Category" := "New Member Category";
            if "New Global Dimension 2 Code" <> '' then
                Members."Global Dimension 2 Code" := "New Global Dimension 2 Code";
            if "New Special Account" <> xRec."New Special Account" then
                Members."Special Account" := "New Special Account";
            if "New Cannot Guarantee" <> xRec."New Cannot Guarantee" then
                Members."Cannot Guarantee" := "New Cannot Guarantee";
            if "New Account Category" <> xRec."New Account Category" then
                Members."Account Category" := "New Account Category";

            /*    Members.Modify;
            end; */
            //if "Change Type" = "Change Type"::"Child Details" then begin
            MemberAccounts.Reset();
            MemberAccounts.SetRange("No.", Rec."Account No.");
            MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Junior Savings");
            if MemberAccounts.FindFirst() then begin
                if "New Child Name" <> '' then
                    MemberAccounts.Name := "New Child Name";
                if "New Child Date of Birth" <> 0D then
                    MemberAccounts."Child Date Of Birth" := "New Child Date of Birth";
                if "New Child Birth Cert No." <> '' then
                    MemberAccounts."Child Birth Cet. No." := "New Child Birth Cert No.";
                if "New Piggy Bank Issued" <> xRec."New Piggy Bank Issued" then
                    MemberAccounts."Piggy Bank Issued" := "New Piggy Bank Issued";
                MemberAccounts.Modify();
                TrackTheSavingsChangesDone(Rec, PreviousAcc, MemberAccounts);
            end;

            //end;

            // if "Change Type" = "Change Type"::"Account Details" then begin
            MemberAccounts.Reset();
            MemberAccounts.SetRange("No.", Rec."Account No.");
            if MemberAccounts.FindFirst() then begin
                if "New Account Status" <> MemberAccounts.Status then
                    MemberAccounts.Status := "New Account Status";
                if "New Monthly Contribution" <> Rec."Monthly Contribution" then
                    MemberAccounts."Monthly Contribution" := "New Monthly Contribution";
                if "New Account Status" <> xRec."New Account Status" then
                    MemberAccounts.Status := "New Account Status";
                if "New Salary Processing" <> xRec."New Salary Processing" then
                    MemberAccounts."Salary Processing" := false;
                if "New Repay Mode" <> XRec."New Repay Mode" then
                    MemberAccounts."Repay Mode" := "New Repay Mode";
                if "New Transactional Mobile No" <> xRec."New Transactional Mobile No" then
                    MemberAccounts."Transactional Mobile No" := "New Transactional Mobile No"; //SkyMobile.RemoveConvertPhoneNo("New Transactional Mobile No");
                if "Deposit Changed By" <> '' then begin
                    MemberAccounts."Deposit Changed By" := "Deposit Changed By";
                    MemberAccounts."Contribution Updated By" := "Deposit Changed By";
                end;
                if "New Blocked" <> xRec."New Blocked" then
                    Blocked := "New Blocked";
                MemberAccounts.Modify();

                TrackTheSavingsChangesDone(Rec, PreviousAcc, MemberAccounts);
            end;



            if "New Other Type Of Business" <> '' then
                Members."Other Type Of Business" := "New Other Type Of Business";
            if "New Business Name" <> '' then
                Members."Business Name" := "New Business Name";
            if "New Business Reg. No." <> '' then
                Members."Business Reg. No." := "New Business Reg. No.";
            if "New Incorporation No." <> '' then
                Members."Incorporation No." := "New Incorporation No.";
            if "New Date of Bus. Incorporation" <> 0D then
                Members."Date of Bus. Incorporation" := "New Date of Bus. Incorporation";
            if "New Business/Group Location" <> '' then
                Members."Business/Group Location" := "New Business/Group Location";
            if "New Group Type" <> xRec."New Group Type" then
                Members."Group Type" := "New Group Type";
            if "New Other Group Type" <> '' then
                Members."Other Group Type" := "New Other Group Type";
            if "New Date of Bus. Reg." <> 0D then
                Members."Date of Bus. Reg." := "New Date of Bus. Reg.";
            if "New Group Category" <> xRec."New Group Category" then
                Members."Group Category" := "New Group Category";
            if "New Type of Business" <> xRec."New Type of Business" then
                Members."Type of Business" := "New Type of Business";
            if "New Group Section" <> xRec."New Group Section" then
                Members."Group Section" := "New Group Section";
            Members."Self Employed" := "Self Employed";
            if "Self Employed" then begin
                Members."Employer Code" := '';
                Members."Employer Name" := '';
                //TestField("New Employement Sector");
            end;
            if "New Employement Sector" <> xRec."New Employement Sector" then
                Members."Employement Sector" := "New Employement Sector";

            if "Change Type" = "Change Type"::"Employment Details" then
                case "New Employment Info" of
                    "New Employment Info"::"Self-Employed",
                    "New Employment Info"::Business,
                    "New Employment Info"::Contracting:
                        begin
                            Members."Self Employed" := true;
                            Members."Terms of Employment" := Members."Terms of Employment"::" ";
                            Members."Employer Code" := '';
                            Members."Employer Name" := '';
                            Members."Checkoff Station" := '';
                            Members."Checkoff Station Name" := '';
                            Members."Payroll/Staff No." := '';
                        end;

                    "New Employment Info"::Employed,
                    "New Employment Info"::Permanent:
                        begin
                            Members."Self Employed" := false;
                            Members."Employement Sector" := '';
                            Members."Business Name" := '';
                            Members."Business/Group Location" := '';
                        end;

                    "New Employment Info"::UnEmployed,
                    "New Employment Info"::Pensioner:
                        begin
                            Members."Self Employed" := false;
                            Members."Terms of Employment" := Members."Terms of Employment"::" ";
                            Members."Employer Code" := '';
                            Members."Employer Name" := '';
                            Members."Checkoff Station" := '';
                            Members."Checkoff Station Name" := '';
                            Members."Payroll/Staff No." := '';
                            Members."Employement Sector" := '';
                            Members."Business Name" := '';
                            Members."Business/Group Location" := '';
                        end;
                end;

            /*   Members.Modify;
           end; */
            if "Change Type" = "change type"::"Next of Kin" then begin

                NextOfKinApp.Reset;
                NextOfKinApp.SetRange("No.", Code);
                if NextOfKinApp.Find('-') then begin

                    NextOfKin.Reset;
                    NextOfKin.SetRange("No.", Members."No.");
                    TrackNextOfKinChangesDone(Rec, Members."No.", Code);
                    if NextOfKin.Find('-') then
                        NextOfKin.DeleteAll;

                    repeat
                        NextOfKin.Init;
                        NextOfKin."No." := Members."No.";
                        NextOfKin."ID No." := NextOfKinApp."ID No.";
                        NextOfKin.Name := UpperCase(NextOfKinApp.Name);
                        NextOfKin.Relationship := NextOfKinApp.Relationship;
                        NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
                        NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                        NextOfKin."Mobile Phone No." := NextOfKinApp."Mobile Phone No.";
                        NextOfKin.Email := NextOfKinApp.Email;
                        NextOfKin."%Allocation" := NextOfKinApp."%Allocation";
                        NextOfKin.Spouse := NextOfKinApp.Spouse;
                        NextOfKin.Insert;
                    until NextOfKinApp.Next = 0;
                end;

            end;

            if "Change Type" = "change type"::Nominee then begin
                Nominee.Reset();
                if Nominee.FindLast() then
                    i := Nominee."Line No." + 1
                else
                    i := 1;

                NomineeApp.Reset;
                NomineeApp.SetRange("No.", Code);
                if NomineeApp.Find('-') then begin

                    Nominee.Reset;
                    Nominee.SetRange("No.", Members."No.");
                    TrackNomineeChangesDone(Rec, Members."No.", Code);
                    if Nominee.Find('-') then
                        Nominee.DeleteAll;

                    repeat

                        Nominee.Init;
                        Nominee."Line No." := i;
                        Nominee."No." := Members."No.";
                        Nominee."ID No." := NomineeApp."ID No.";
                        Nominee.Name := UpperCase(NomineeApp.Name);
                        Nominee.Relationship := NomineeApp.Relationship;
                        Nominee.Beneficiary := NomineeApp.Beneficiary;
                        Nominee."Date of Birth" := NomineeApp."Date of Birth";
                        Nominee."Mobile Phone No." := NomineeApp."Mobile Phone No.";
                        Nominee.Email := NomineeApp.Email;
                        Nominee."%Allocation" := NomineeApp."%Allocation";
                        Nominee.Spouse := NomineeApp.Spouse;
                        Nominee.Insert;
                        i += 1;

                    until NomineeApp.Next = 0;
                end;

            end;





            MemberAccounts.Reset();
            MemberAccounts.SetRange("Member No.", Members."No.");
            MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Ordinary Savings");
            if MemberAccounts.FindFirst() then begin
                if "New Signing Instructions" <> "Signing Instructions" then
                    MemberAccounts."Signing Instructions" := "New Signing Instructions";
                if "New Signing Instr. Narration" <> '' then
                    MemberAccounts."Signing Instructions Narration" := "New Signing Instr. Narration";

                MemberAccounts.Modify();
            end;


            AppAccountSignatories.Reset;
            AppAccountSignatories.SetRange(AppAccountSignatories.Code, Code);
            AppAccountSignatories.SetFilter(Name, '<>%1', '');
            if AppAccountSignatories.Find('-') then begin

                AccountSignatories.Reset;
                AccountSignatories.SetRange(Code, Members."No.");
                if AccountSignatories.Find('-') then
                    AccountSignatories.DeleteAll;


                repeat
                    AccountSignatories.Init;
                    AccountSignatories.Code := Members."No.";
                    AccountSignatories."Member No." := AppAccountSignatories."Member No.";
                    AccountSignatories."ID No." := AppAccountSignatories."ID No.";
                    AccountSignatories.Name := UpperCase(AppAccountSignatories.Name);
                    AccountSignatories."Date Of Birth" := AppAccountSignatories."Date Of Birth";
                    AccountSignatories."Staff/Payroll" := AppAccountSignatories."Staff/Payroll";
                    //AccountSignatories."Salesperson Code":=AppAccountSignatories."Salesperson Code";
                    AccountSignatories."Phone No." := AppAccountSignatories."Phone No.";
                    AccountSignatories.Signatory := AppAccountSignatories.Signatory;
                    AccountSignatories."Must Sign" := AppAccountSignatories."Must Sign";
                    AccountSignatories."Must be Present" := AppAccountSignatories."Must be Present";
                    AppAccountSignatories.CalcFields(AppAccountSignatories.Signature, AppAccountSignatories.Picture);
                    AccountSignatories.Picture := AppAccountSignatories.Picture;
                    AccountSignatories.Signature := AppAccountSignatories.Signature;
                    AccountSignatories."Expiry Date" := AppAccountSignatories."Expiry Date";
                    //AccountSignatories."Mobile No.":=AppAccountSignatories."Mobile No.";
                    AccountSignatories.Insert;

                    if AppAccountSignatories.Picture.Hasvalue then begin
                        Clear(AppAccountSignatories.Picture);
                        AppAccountSignatories.Modify;
                    end;

                    if AppAccountSignatories.Signature.Hasvalue then begin
                        Clear(AppAccountSignatories.Signature);
                        AppAccountSignatories.Modify;
                    end;

                until AppAccountSignatories.Next = 0;
            end;

            // end;

            if "Change Type" = "change type"::"Pic & Signature" then begin

                MemberImages.Reset;
                MemberImages.SetRange("Member No.", Members."No.");
                if MemberImages.Find('-') then
                    MemberImages.DeleteAll;

                CalcFields(Picture, Signature);

                MemberImages.Init;
                MemberImages."Member No." := Members."No.";
                MemberImages.Picture := Picture;
                MemberImages.Signature := Signature;
                MemberImages.Insert(true);
            end;

            Members.Modify();
            TrackTheChangesDone(Rec, PreviousMember, Members);

            SActivities.SendMemberChangesSms(Rec, Members);

        end;

    end;

    // ...existing code...
    procedure TrackTheChangesDone(Memberchanges: Record "Member Changes"; PrevMember: Record Members; UpdatedMember: Record Members)
    var
        PrevRecRef: RecordRef;
        UpdatedRecRef: RecordRef;
        Field: Record Field;
        MemberChgLog: Record "Member Change Log";
        PFRef: FieldRef;
        UpdatedFRef: FieldRef;
        UpdatedSavings: Record "Savings Accounts";
    begin

        if Memberchanges."Change Type" in [Memberchanges."Change Type"::"Authorized Persons",
            Memberchanges."Change Type"::"Next of Kin", Memberchanges."Change Type"::"Pic & Signature"] then
            exit;

        Field.Reset();
        Field.SetFilter(TableNo, '%1', Database::Members);
        Field.SetRange(ObsoleteState, Field.ObsoleteState::No);
        Field.SetFilter(Type, '<>%1&<>%2&<>%3', Field.Type::BLOB, Field.Type::Media, Field.Type::MediaSet);
        Field.SetFilter(FieldName, '<>%1&<>%2&<>%3&<>%4&<>%5',
            Field.FieldName(SystemModifiedAt),
            Field.FieldName(SystemModifiedBy),
            Field.FieldName(SystemCreatedAt),
            Field.FieldName(SystemCreatedBy),
            Field.FieldName(SystemId));
        IF Field.FindSet() THEN
            Repeat
                // Bind the RecordRef to the correct table for this field
                PrevRecRef.GetTable(PrevMember);
                UpdatedRecRef.GetTable(UpdatedMember);


                PFRef := PrevRecRef.Field(Field."No.");
                UpdatedFRef := UpdatedRecRef.Field(Field."No.");

                if (PFRef.Value <> UpdatedFRef.Value) then begin
                    MemberChgLog.Init();
                    MemberChgLog."Log No." := 0;
                    // When comparing savings-account fields, make sure member no is from UpdatedSavings
                    if Field.TableNo = Database::Members then
                        MemberChgLog."Member No." := UpdatedMember."No."
                    else
                        MemberChgLog."Member No." := UpdatedSavings."Member No.";

                    if "Change Type" in ["Change Type"::Nominee, "Change Type"::"Next of Kin"] then
                        MemberChgLog."Field Name" := Format("Change Type")
                    else
                        MemberChgLog."Field Name" := Field.FieldName;
                    MemberChgLog."Date Changed" := Today;
                    MemberChgLog."Time Changed" := Time;
                    MemberChgLog."User ID" := UserId;
                    MemberChgLog."Captured By" := GetMemberChangeCapturedBy(Memberchanges);
                    MemberChgLog."Previous Value" := CopyStr(Format(PFRef.Value), 1, 250);
                    MemberChgLog."New Value" := CopyStr(Format(UpdatedFRef.Value), 1, 250);
                    MemberChgLog."Reason For Change" := Memberchanges."Reason For Change";
                    MemberChgLog."Member Change No" := Memberchanges.Code;
                    MemberChgLog.Insert();
                end;
            until Field.Next() = 0;
    end;


    procedure TrackTheSavingsChangesDone(Memberchanges: Record "Member Changes"; PrevMember: Record "Savings Accounts"; UpdatedMember: Record "Savings Accounts")
    var
        PrevRecRef: RecordRef;
        UpdatedRecRef: RecordRef;
        Field: Record Field;
        MemberChgLog: Record "Member Change Log";
        PFRef: FieldRef;
        UpdatedFRef: FieldRef;
    begin

        if Memberchanges."Change Type" in [Memberchanges."Change Type"::"Authorized Persons",
            Memberchanges."Change Type"::"Next of Kin", Memberchanges."Change Type"::"Pic & Signature"] then
            exit;

        Field.Reset();
        Field.SetFilter(TableNo, '%1', Database::"Savings Accounts");
        Field.SetRange(ObsoleteState, Field.ObsoleteState::No);
        Field.SetFilter(Type, '<>%1&<>%2&<>%3', Field.Type::BLOB, Field.Type::Media, Field.Type::MediaSet);
        Field.SetFilter(FieldName, '<>%1&<>%2&<>%3&<>%4&<>%5',
            Field.FieldName(SystemModifiedAt),
            Field.FieldName(SystemModifiedBy),
            Field.FieldName(SystemCreatedAt),
            Field.FieldName(SystemCreatedBy),
            Field.FieldName(SystemId));
        IF Field.FindSet() THEN
            Repeat
                // Bind the RecordRef to the correct table for this field

                PrevRecRef.GetTable(PrevMember);
                UpdatedRecRef.GetTable(UpdatedMember);

                PFRef := PrevRecRef.Field(Field."No.");
                UpdatedFRef := UpdatedRecRef.Field(Field."No.");

                if (PFRef.Value <> UpdatedFRef.Value) then begin
                    MemberChgLog.Init();
                    MemberChgLog."Log No." := 0;
                    // When comparing savings-account fields, make sure member no is from UpdatedSavings

                    MemberChgLog."Member No." := UpdatedMember."Member No.";

                    if UpdatedMember."No." <> '' then
                        MemberChgLog."Field Name" := CopyStr(UpdatedMember."No." + ' - ' + Field.FieldName, 1, MaxStrLen(MemberChgLog."Field Name"))
                    else
                        MemberChgLog."Field Name" := Field.FieldName;
                    MemberChgLog."Date Changed" := Today;
                    MemberChgLog."Time Changed" := Time;
                    MemberChgLog."User ID" := UserId;
                    MemberChgLog."Captured By" := GetMemberChangeCapturedBy(Memberchanges);
                    MemberChgLog."Previous Value" := CopyStr(Format(PFRef.Value), 1, 250);
                    MemberChgLog."New Value" := CopyStr(Format(UpdatedFRef.Value), 1, 250);
                    MemberChgLog."Reason For Change" := Memberchanges."Reason For Change";
                    MemberChgLog."Member Change No" := Memberchanges.Code;
                    MemberChgLog.Insert();
                end;
            until Field.Next() = 0;
    end;

    procedure TrackNextOfKinChangesDone(Memberchanges: Record "Member Changes"; MemberNo: Code[20]; ChangeNo: Code[20])
    var
        ExistingNextOfKin: Record "Next of Kin.";
        AppNextOfKin: Record "Next of Kin.";
        MatchedExistingNextOfKin: Record "Next of Kin.";
        MatchedAppNextOfKin: Record "Next of Kin.";
    begin
        AppNextOfKin.Reset();
        AppNextOfKin.SetRange("No.", ChangeNo);
        if AppNextOfKin.FindSet() then
            repeat
                if FindMatchingExistingNextOfKin(AppNextOfKin, MemberNo, MatchedExistingNextOfKin) then
                    TrackRecordFieldChanges(Memberchanges, MatchedExistingNextOfKin, AppNextOfKin, Database::"Next of Kin.", MemberNo, CopyStr('Next of Kin ' + GetNextOfKinLogIdentifier(AppNextOfKin), 1, 70))
                else
                    InsertMemberChangeLog(
                        Memberchanges,
                        MemberNo,
                        CopyStr('Next of Kin Added', 1, 100),
                        '',
                        GetNextOfKinLogIdentifier(AppNextOfKin));
            until AppNextOfKin.Next() = 0;

        ExistingNextOfKin.Reset();
        ExistingNextOfKin.SetRange("No.", MemberNo);
        if ExistingNextOfKin.FindSet() then
            repeat
                if not FindMatchingAppNextOfKin(ExistingNextOfKin, ChangeNo, MatchedAppNextOfKin) then
                    InsertMemberChangeLog(
                        Memberchanges,
                        MemberNo,
                        CopyStr('Next of Kin Removed', 1, 100),
                        GetNextOfKinLogIdentifier(ExistingNextOfKin),
                        '');
            until ExistingNextOfKin.Next() = 0;
    end;

    procedure TrackNomineeChangesDone(Memberchanges: Record "Member Changes"; MemberNo: Code[20]; ChangeNo: Code[20])
    var
        ExistingNominee: Record Nominee;
        AppNominee: Record Nominee;
        MatchedExistingNominee: Record Nominee;
        MatchedAppNominee: Record Nominee;
    begin
        AppNominee.Reset();
        AppNominee.SetRange("No.", ChangeNo);
        if AppNominee.FindSet() then
            repeat
                if FindMatchingExistingNominee(AppNominee, MemberNo, MatchedExistingNominee) then
                    TrackRecordFieldChanges(Memberchanges, MatchedExistingNominee, AppNominee, Database::Nominee, MemberNo, CopyStr('Nominee ' + GetNomineeLogIdentifier(AppNominee), 1, 70))
                else
                    InsertMemberChangeLog(
                        Memberchanges,
                        MemberNo,
                        CopyStr('Nominee Added', 1, 100),
                        '',
                        GetNomineeLogIdentifier(AppNominee));
            until AppNominee.Next() = 0;

        ExistingNominee.Reset();
        ExistingNominee.SetRange("No.", MemberNo);
        if ExistingNominee.FindSet() then
            repeat
                if not FindMatchingAppNominee(ExistingNominee, ChangeNo, MatchedAppNominee) then
                    InsertMemberChangeLog(
                        Memberchanges,
                        MemberNo,
                        CopyStr('Nominee Removed', 1, 100),
                        GetNomineeLogIdentifier(ExistingNominee),
                        '');
            until ExistingNominee.Next() = 0;
    end;

    local procedure TrackRecordFieldChanges(Memberchanges: Record "Member Changes"; PrevRecVariant: Variant; UpdatedRecVariant: Variant; TableNo: Integer; MemberNo: Code[20]; SourceLabel: Text[100])
    var
        PrevRecRef: RecordRef;
        UpdatedRecRef: RecordRef;
        Field: Record Field;
        PFRef: FieldRef;
        UpdatedFRef: FieldRef;
    begin
        PrevRecRef.GetTable(PrevRecVariant);
        UpdatedRecRef.GetTable(UpdatedRecVariant);

        Field.Reset();
        Field.SetRange(TableNo, TableNo);
        Field.SetRange(ObsoleteState, Field.ObsoleteState::No);
        Field.SetFilter(Type, '<>%1&<>%2&<>%3', Field.Type::BLOB, Field.Type::Media, Field.Type::MediaSet);
        Field.SetFilter(FieldName, '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7',
            Field.FieldName(SystemModifiedAt),
            Field.FieldName(SystemModifiedBy),
            Field.FieldName(SystemCreatedAt),
            Field.FieldName(SystemCreatedBy),
            Field.FieldName(SystemId),
            'No.',
            'Line No.');
        if Field.FindSet() then
            repeat
                PFRef := PrevRecRef.Field(Field."No.");
                UpdatedFRef := UpdatedRecRef.Field(Field."No.");

                if PFRef.Value <> UpdatedFRef.Value then
                    InsertMemberChangeLog(
                        Memberchanges,
                        MemberNo,
                        CopyStr(SourceLabel + ' - ' + Field.FieldName, 1, 100),
                        CopyStr(Format(PFRef.Value), 1, 250),
                        CopyStr(Format(UpdatedFRef.Value), 1, 250));
            until Field.Next() = 0;
    end;

    local procedure InsertMemberChangeLog(Memberchanges: Record "Member Changes"; MemberNo: Code[20]; FieldName: Text[100]; PreviousValue: Text[250]; NewValue: Text[250])
    var
        MemberChgLog: Record "Member Change Log";
    begin
        MemberChgLog.Init();
        MemberChgLog."Log No." := 0;
        MemberChgLog."Member No." := MemberNo;
        MemberChgLog."Field Name" := CopyStr(FieldName, 1, MaxStrLen(MemberChgLog."Field Name"));
        MemberChgLog."Date Changed" := Today;
        MemberChgLog."Time Changed" := Time;
        MemberChgLog."User ID" := UserId;
        MemberChgLog."Captured By" := GetMemberChangeCapturedBy(Memberchanges);
        MemberChgLog."Previous Value" := CopyStr(PreviousValue, 1, MaxStrLen(MemberChgLog."Previous Value"));
        MemberChgLog."New Value" := CopyStr(NewValue, 1, MaxStrLen(MemberChgLog."New Value"));
        MemberChgLog."Reason For Change" := Memberchanges."Reason For Change";
        MemberChgLog."Member Change No" := Memberchanges.Code;
        MemberChgLog.Insert();
    end;

    local procedure GetMemberChangeCapturedBy(Memberchanges: Record "Member Changes"): Code[30]
    var
        CapturedBy: Code[50];
    begin
        CapturedBy := Memberchanges."Captured By";
        if CapturedBy = '' then
            CapturedBy := Memberchanges."Entered By";
        if CapturedBy = '' then
            CapturedBy := UserId;

        exit(CopyStr(CapturedBy, 1, 30));
    end;

    local procedure FindMatchingExistingNextOfKin(AppNextOfKin: Record "Next of Kin."; MemberNo: Code[20]; var ExistingNextOfKin: Record "Next of Kin."): Boolean
    begin
        ExistingNextOfKin.Reset();
        ExistingNextOfKin.SetRange("No.", MemberNo);
        if AppNextOfKin."ID No." <> '' then
            ExistingNextOfKin.SetRange("ID No.", AppNextOfKin."ID No.")
        else
            ExistingNextOfKin.SetRange(Name, AppNextOfKin.Name);
        exit(ExistingNextOfKin.FindFirst());
    end;

    local procedure FindMatchingAppNextOfKin(ExistingNextOfKin: Record "Next of Kin."; ChangeNo: Code[20]; var AppNextOfKin: Record "Next of Kin."): Boolean
    begin
        AppNextOfKin.Reset();
        AppNextOfKin.SetRange("No.", ChangeNo);
        if ExistingNextOfKin."ID No." <> '' then
            AppNextOfKin.SetRange("ID No.", ExistingNextOfKin."ID No.")
        else
            AppNextOfKin.SetRange(Name, ExistingNextOfKin.Name);
        exit(AppNextOfKin.FindFirst());
    end;

    local procedure FindMatchingExistingNominee(AppNominee: Record Nominee; MemberNo: Code[20]; var ExistingNominee: Record Nominee): Boolean
    begin
        ExistingNominee.Reset();
        ExistingNominee.SetRange("No.", MemberNo);
        if AppNominee."ID No." <> '' then
            ExistingNominee.SetRange("ID No.", AppNominee."ID No.")
        else
            ExistingNominee.SetRange(Name, AppNominee.Name);
        exit(ExistingNominee.FindFirst());
    end;

    local procedure FindMatchingAppNominee(ExistingNominee: Record Nominee; ChangeNo: Code[20]; var AppNominee: Record Nominee): Boolean
    begin
        AppNominee.Reset();
        AppNominee.SetRange("No.", ChangeNo);
        if ExistingNominee."ID No." <> '' then
            AppNominee.SetRange("ID No.", ExistingNominee."ID No.")
        else
            AppNominee.SetRange(Name, ExistingNominee.Name);
        exit(AppNominee.FindFirst());
    end;

    local procedure GetNextOfKinLogIdentifier(NextOfKin: Record "Next of Kin."): Text[250]
    begin
        exit(CopyStr(NextOfKin."ID No." + ' ' + NextOfKin.Name, 1, 250));
    end;

    local procedure GetNomineeLogIdentifier(NomineeRec: Record Nominee): Text[250]
    begin
        exit(CopyStr(NomineeRec."ID No." + ' ' + NomineeRec.Name, 1, 250));
    end;


    // ...existing code...

    procedure GetNextofkin()
    var
        NextOfKinApp: Record "Next of Kin.";
        NextOfKin: Record "Next of Kin.";
    begin
        NextOfKinApp.Reset;
        NextOfKinApp.SetRange("No.", Code);
        if NextOfKinApp.Find('-') then
            NextOfKinApp.DeleteAll;

        NextOfKin.Reset;
        NextOfKin.SetRange("No.", "Member No.");
        if NextOfKin.Find('-') then begin
            repeat

                NextOfKinApp.Init;
                NextOfKinApp."No." := Code;
                NextOfKinApp."ID No." := NextOfKin."ID No.";
                NextOfKinApp.Name := UpperCase(NextOfKin.Name);
                NextOfKinApp.Relationship := NextOfKin.Relationship;
                NextOfKinApp.Beneficiary := NextOfKin.Beneficiary;
                NextOfKinApp."Date of Birth" := NextOfKin."Date of Birth";
                NextOfKinApp."Mobile Phone No." := NextOfKin."Mobile Phone No.";
                NextOfKinApp.Email := NextOfKin.Email;
                NextOfKinApp."%Allocation" := NextOfKin."%Allocation";
                NextOfKinApp.Spouse := NextOfKin.Spouse;
                NextOfKinApp.Insert;

            until NextOfKin.Next = 0;
        end;
    end;

    procedure GetNominee()
    var
        NextOfKinApp: Record Nominee;
        NextOfKin: Record Nominee;
        i: Integer;
    begin
        NextOfKinApp.Reset;
        NextOfKinApp.SetRange("No.", Code);
        if NextOfKinApp.Find('-') then
            NextOfKinApp.DeleteAll;


        NextOfKinApp.Reset();
        if NextOfKinApp.FindLast() then
            i := NextOfKinApp."Line No." + 1
        else
            i := 1;

        NextOfKin.Reset;
        NextOfKin.SetRange("No.", Rec."Member No.");
        if NextOfKin.Find('-') then begin
            repeat

                NextOfKinApp.Init;
                NextOfKinApp."No." := Code;
                NextOfKinApp."Line No." := i;
                NextOfKinApp."ID No." := NextOfKin."ID No.";
                NextOfKinApp.Name := UpperCase(NextOfKin.Name);
                NextOfKinApp.Relationship := NextOfKin.Relationship;
                NextOfKinApp.Beneficiary := NextOfKin.Beneficiary;
                NextOfKinApp."Date of Birth" := NextOfKin."Date of Birth";
                NextOfKinApp."Mobile Phone No." := NextOfKin."Mobile Phone No.";
                NextOfKinApp.Email := NextOfKin.Email;
                NextOfKinApp."%Allocation" := NextOfKin."%Allocation";
                NextOfKinApp.Spouse := NextOfKin.Spouse;
                if NextOfKinApp.Insert then;

                i += 1;

            until NextOfKin.Next = 0;
        end;
    end;

    local procedure GetPictures()
    var
        MemberImages: Record "Member Images";
    begin

        MemberImages.Reset;
        MemberImages.SetRange("Member No.", "Member No.");
        if MemberImages.Find('-') then begin
            MemberImages.CalcFields(Picture, Signature);
            Picture := MemberImages.Picture;
            Signature := MemberImages.Signature;
        end;
    end;

    procedure GetSignatory()
    var
        NextOfKinApp: Record "Next of Kin.";
        NextOfKin: Record "Next of Kin.";
    begin

        AppAccountSignatories.Reset;
        AppAccountSignatories.SetRange(Code, Code);
        AppAccountSignatories.SetFilter(Type, '<>%1', AppAccountSignatories.Type::Authorized);
        if AppAccountSignatories.Find('-') then
            AppAccountSignatories.DeleteAll;



        AccountSignatories.Reset;
        AccountSignatories.SetRange(Code, "Member No.");
        AccountSignatories.SetFilter(Type, '<>%1', AccountSignatories.Type::Authorized);
        if AccountSignatories.Find('-') then begin
            repeat

                AppAccountSignatories.Init;
                AppAccountSignatories.Code := Code;
                AppAccountSignatories."Member No." := AccountSignatories."Member No.";
                AppAccountSignatories."ID No." := AccountSignatories."ID No.";
                AppAccountSignatories.Name := UpperCase(AccountSignatories.Name);
                AppAccountSignatories."Date Of Birth" := AccountSignatories."Date Of Birth";
                AppAccountSignatories."Staff/Payroll" := AccountSignatories."Staff/Payroll";
                //AppAccountSignatories."Salesperson Code":=AccountSignatories."Salesperson Code";
                AppAccountSignatories."Phone No." := AccountSignatories."Phone No.";
                AppAccountSignatories.Signatory := AccountSignatories.Signatory;
                AppAccountSignatories."Must Sign" := AccountSignatories."Must Sign";
                AppAccountSignatories."Must be Present" := AccountSignatories."Must be Present";
                AccountSignatories.CalcFields(AccountSignatories.Signature, AccountSignatories.Picture);
                AppAccountSignatories.Picture := AccountSignatories.Picture;
                AppAccountSignatories.Signature := AccountSignatories.Signature;
                AppAccountSignatories."Expiry Date" := AccountSignatories."Expiry Date";
                //AppAccountSignatories."Mobile No.":=AccountSignatories."Mobile No.";
                AppAccountSignatories.Insert;

            until AccountSignatories.Next = 0;
        end;
    end;


    procedure GetAuthorized()
    var
        NextOfKinApp: Record "Next of Kin.";
        NextOfKin: Record "Next of Kin.";
    begin

        AppAccountSignatories.Reset;
        AppAccountSignatories.SetRange(Code, Code);
        AppAccountSignatories.SetRange(Type, AppAccountSignatories.Type::Authorized);
        if AppAccountSignatories.Find('-') then
            AppAccountSignatories.DeleteAll;



        AccountSignatories.Reset;
        AccountSignatories.SetRange(Code, "Member No.");
        AccountSignatories.SetRange(Type, AccountSignatories.Type::Authorized);
        if AccountSignatories.Find('-') then begin
            repeat

                AppAccountSignatories.Init;
                AppAccountSignatories.Code := Code;
                AppAccountSignatories."Member No." := AccountSignatories."Member No.";
                AppAccountSignatories."ID No." := AccountSignatories."ID No.";
                AppAccountSignatories.Name := UpperCase(AccountSignatories.Name);
                AppAccountSignatories."Date Of Birth" := AccountSignatories."Date Of Birth";
                AppAccountSignatories."Staff/Payroll" := AccountSignatories."Staff/Payroll";
                //AppAccountSignatories."Salesperson Code":=AccountSignatories."Salesperson Code";
                AppAccountSignatories."Phone No." := AccountSignatories."Phone No.";
                AppAccountSignatories.Signatory := AccountSignatories.Signatory;
                AppAccountSignatories."Must Sign" := AccountSignatories."Must Sign";
                AppAccountSignatories."Must be Present" := AccountSignatories."Must be Present";
                AccountSignatories.CalcFields(AccountSignatories.Signature, AccountSignatories.Picture);
                AppAccountSignatories.Picture := AccountSignatories.Picture;
                AppAccountSignatories.Signature := AccountSignatories.Signature;
                AppAccountSignatories."Expiry Date" := AccountSignatories."Expiry Date";
                //AppAccountSignatories."Mobile No.":=AccountSignatories."Mobile No.";
                AppAccountSignatories.Insert;

            until AccountSignatories.Next = 0;
        end;
    end;

    local procedure CalculatedName() NewName: Text[50]
    var
        NewName92: Text[92];
    begin
        if "New First Name" <> '' then
            NewName92 := "New First Name"
        else
            NewName92 := "First Name";
        if "New Middle Name" <> '' then
            NewName92 := NewName92 + ' ' + "New Middle Name"
        else
            NewName92 := NewName92 + ' ' + "Middle Name";
        if "New Surname" <> '' then
            NewName92 := NewName92 + ' ' + "New Surname"
        else
            NewName92 := NewName92 + ' ' + Surname;

        NewName92 := DelChr(NewName92, '<', ' ');
        NewName := CopyStr(NewName92, 1, MaxStrLen(NewName));
    end;
}

