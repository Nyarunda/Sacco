Table 50977 "HR Job Applications"
{
    Caption = 'HR Job Applications';
    DrillDownPageID = "HR Job Applications List";
    LookupPageID = "HR Job Applications List";

    fields
    {
        field(1; "Job Application No."; Code[50])
        {
            Editable = false;
        }
        field(2; "First Name"; Text[100])
        {

            trigger OnValidate()
            begin
                fn_FullName;
            end;
        }
        field(3; "Middle Name"; Text[50])
        {

            trigger OnValidate()
            begin
                fn_FullName;
            end;
        }
        field(4; "Last Name"; Text[50])
        {

            trigger OnValidate()
            var
                Reason: Text[30];
            begin
                fn_FullName
            end;
        }
        field(5; Initials; Text[15])
        {
        }
        field(7; "Search Name"; Code[50])
        {
        }
        field(8; "Postal Address"; Text[80])
        {
        }
        field(9; "Residential Address"; Text[80])
        {
        }
        field(10; City; Text[30])
        {
        }
        field(11; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(12; County; Text[30])
        {
        }
        field(13; "Home Phone Number"; Text[30])
        {
        }
        field(14; "Cell Phone Number"; Text[30])
        {
        }
        field(15; "Work Phone Number"; Text[30])
        {
        }
        field(16; "Ext."; Text[7])
        {
        }
        field(17; "E-Mail"; Text[80])
        {
            ExtendedDatatype = EMail;

            trigger OnValidate()
            begin
                //Smtp.CheckValidEmailAddresses("E-Mail");
            end;
        }
        field(19; Picture; Media)
        {
            //SubType = Bitmap;
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
        field(20; "ID Number"; Code[20])
        {
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;

            trigger OnValidate()
            begin
                HRJobApp.Reset;
                HRJobApp.SetRange(HRJobApp."ID Number", "ID Number");
                if HRJobApp.Find('-') then begin
                    Error('This ID Number has been used in a prior Job Application.');
                end;

                HRCodeunit.fn_CheckIDNumber("ID Number");
            end;
        }
        field(21; Gender; Enum "Employee Gender")
        {
            //OptionCaption = ' ,Male,Female';
            //OptionMembers = " ",Male,Female;
        }
        field(22; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(23; Status; Option)
        {
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;
        }
        field(24; Comment; Boolean)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(25; "Fax Number"; Text[30])
        {
        }
        field(26; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(27; Colour; Option)
        {
            OptionMembers = African,Indian,White,Coloured;
        }
        field(28; "First Language (R/W/S)"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Language));
        }
        field(29; "Driving Licence"; Code[10])
        {
        }
        field(30; Disabled; Option)
        {
            OptionMembers = No,Yes," ";
        }
        field(31; "Health Assesment?"; Boolean)
        {
        }
        field(32; "Health Assesment Date"; Date)
        {
        }
        field(33; "Date Of Birth"; Date)
        {

            trigger OnValidate()
            begin
                ag := (Today - "Date Of Birth");
                if "Date Of Birth" >= Today then begin
                    Error('Date of Birth cannot be after %1', Today);
                end;

                Age := HRCodeunit.DetermineAge("Date Of Birth", Today);
                if ag > 20075 then Error('Your Age is above 55 years')
            end;
        }
        field(34; Age; Text[80])
        {
        }
        field(35; "Second Language (R/W/S)"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Language));
        }
        field(36; "Additional Language"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Language));
        }
        field(37; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(38; Level; Option)
        {
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(39; "Termination Category"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
            end;
        }
        field(40; "Postal Address2"; Text[30])
        {
        }
        field(41; "Postal Address3"; Text[20])
        {
        }
        field(42; "Residential Address2"; Text[30])
        {
        }
        field(43; "Residential Address3"; Text[20])
        {
        }
        field(44; "Post Code2"; Code[20])
        {
            //TableRelation = Table225;
        }
        field(45; Citizenship; Code[10])
        {
            //TableRelation = Table9.Field1;

            trigger OnValidate()
            begin
                Country.Reset;
                Country.SetRange(Country.Code, Citizenship);
                if Country.Find('-') then begin
                    "Citizenship Details" := Country.Name;
                end;
            end;
        }
        field(46; "Disabling Details"; Text[50])
        {
        }
        field(47; "Disability Grade"; Text[30])
        {
        }
        field(48; "Passport Number"; Text[30])
        {
        }
        field(49; "2nd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50; "3rd Skills Category"; Option)
        {
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(51; Region; Code[10])
        {
            //TableRelation = Table349.Field2 where(Field9 = const(4));
        }
        field(52; "First Language Read"; Boolean)
        {
        }
        field(53; "First Language Write"; Boolean)
        {
        }
        field(54; "First Language Speak"; Boolean)
        {
        }
        field(55; "Second Language Read"; Boolean)
        {
        }
        field(56; "Second Language Write"; Boolean)
        {
        }
        field(57; "Second Language Speak"; Boolean)
        {
        }
        field(58; "PIN Number"; Code[20])
        {
        }
        field(59; "Job Applied For"; Text[30])
        {
            Editable = false;
        }
        field(60; "Employee Requisition No"; Code[20])
        {
            TableRelation = "HR Employee Requisitions"."Requisition No.";

            trigger OnValidate()
            begin
                "Job Applied For" := '';
                "Job Applied for Description" := '';

                HREmpReq.Reset;
                HREmpReq.SetRange(HREmpReq."Requisition No.", "Employee Requisition No");
                if HREmpReq.Find('-') then
                    "Job Applied For" := HREmpReq."Job ID";
                "Job Applied for Description" := HREmpReq."Job Description";
            end;
        }
        field(61; "Total Score"; Decimal)
        {
            FieldClass = Normal;
        }
        field(62; Shortlist; Boolean)
        {
        }
        field(63; Qualified; Boolean)
        {
            Editable = false;
        }
        field(64; Stage; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(65; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(66; "Employee No"; Code[20])
        {
            TableRelation = "HR Succession Job Rotation"."Line No.";
        }
        field(67; "Applicant Type"; Option)
        {
            OptionCaption = ' ,External,Internal';
            OptionMembers = " ",External,Internal;
        }
        field(68; "Interview Invitation Sent"; Boolean)
        {
            Editable = true;
        }
        field(69; "Date Applied"; Date)
        {
        }
        field(70; "Citizenship Details"; Text[60])
        {
        }
        field(71; Expatriate; Boolean)
        {
        }
        field(72; "Total Score After Interview"; Decimal)
        {
            CalcFormula = sum("HR Job Interview".Score where("Applicant No" = field("Job Application No.")));
            FieldClass = FlowField;
        }
        field(73; "Total Score After Shortlisting"; Decimal)
        {
        }
        field(74; "Date of Interview"; Date)
        {
        }
        field(75; "From Time"; Time)
        {
        }
        field(76; "To Time"; Time)
        {
        }
        field(77; Venue; Text[100])
        {
        }
        field(78; "Job Applied for Description"; Text[100])
        {
        }
        field(79; "Regret Notice Sent"; Boolean)
        {
        }
        field(80; "Interview Type"; Option)
        {
            OptionCaption = 'Writen,Practicals,Oral';
            OptionMembers = Writen,Practicals,Oral;
        }
        field(81; Uploaded; Boolean)
        {
        }
        field(82; "Full Name"; Text[100])
        {
        }
        field(83; "Responsibility Center"; Code[20])
        {
            //TableRelation = Table52018718.Field1;
        }
        field(84; "Approval Status"; Option)
        {
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(85; "Ethnic Origin"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter("Interview Areas"));
        }
        field(86; "Document Status"; Option)
        {
            OptionMembers = "Application Stage","Shortlisting Stage",Closed;
        }
        field(87; "Proposed Salary"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Job Application No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Job Application No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Job Application Nos");
            "Job Application No." := NoSeries.GetNextNo(HRSetup."Job Application Nos", WorkDate(), true);
        end;

        "Date Applied" := Today;

        //Applicant Type
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            "Applicant Type" := "applicant type"::Internal;
        end else begin
            "Applicant Type" := "applicant type"::External;
        end;
    end;

    var
        HREmpReq: Record "HR Employee Requisitions";
        HRSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
        HREmpQual: Record "HR Employee Qualifications";
        HRAppQual: Record "HR Applicant Qualifications";
        HRAppReff: Record "HR Applicant Referees";
        HRAppHobb: Record "HR Applicant Hobbies";
        HRJobApp: Record "HR Job Applications";
        Country: Record "Country/Region";
        HREmp: Record Employee;
        HRCodeunit: Codeunit "HR Codeunit.";
        ag: Integer;
    ////SMTP: Codeunit UnknownCodeunit400;


    procedure FullName(): Text[100]
    begin
        if "Middle Name" = '' then
            exit("First Name" + ' ' + "Last Name")
        else
            exit("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;

    local procedure fn_FullName()
    begin
        "Full Name" := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
    end;

    local procedure fn_PopulateStaffDetails()
    begin
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
        if HREmp.Find('-') then begin
            /*
            //Insert Bio Data
            "First Name" := HREmp."First Name";
            "Middle Name" := HREmp."Middle Name";
            "Last Name" := HREmp."Last Name";
            "Postal Address" := HREmp."Postal Address";
            "Residential Address" := HREmp."Residential Address";
            City := HREmp.City;
            "Post Code" := HREmp."Post Code";
            County := HREmp.County;
            // "Home Phone Number":=HREmp."Home Phone Number";
            // "Cell Phone Number":=HREmp."Cellular Phone Number";
            //    "Work Phone Number":=HREmp."Work Phone Number";
            "Ext." := HREmp."Ext.";
            "E-Mail" := HREmp."E-Mail";
            HREmp.CalcFields(HREmp.Picture);
            Picture := HREmp.Picture;
            "ID Number" := HREmp."ID Number";

            Gender := HREmp.Gender;
            "Country Code" := HREmp."Country Code";
            "Marital Status" := HREmp."Marital Status";
            "First Language (R/W/S)" := HREmp."First Language (R/W/S)";
            "First Language Read" := HREmp."First Language Read";
            "First Language Speak" := HREmp."First Language Speak";
            "First Language Write" := HREmp."First Language Write";
            "Second Language (R/W/S)" := HREmp."Second Language (R/W/S)";
            "Second Language Read" := HREmp."Second Language Read";
            "Second Language Speak" := HREmp."Second Language Speak";
            "Second Language Write" := HREmp."Second Language Write";
            "Date Of Birth" := HREmp."Date Of Birth";
            */
            Validate("Date Of Birth");

            //Insert Qualfications
            HRAppQual.Reset;
            HRAppQual.SetRange(HRAppQual."Application No", "Job Application No.");
            if HRAppQual.Find('-') then begin

            end else begin

            end;
        end;
    end;
}

