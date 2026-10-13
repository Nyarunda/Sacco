table 50431 "Support Personnel"
{
    Caption = 'Support Personnel';
    DataClassification = CustomerContent;
    LookupPageId = "Support Personnel List";
    DrillDownPageId = "Support Personnel List";

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "Name"; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(3; "Email"; Text[250])
        {
            Caption = 'Email';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;

            trigger OnValidate()
            begin
                if "Email" <> '' then
                    if not "Email".Contains('@') then
                        Error('Please enter a valid email address.');
            end;
        }
        field(4; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(5; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
            TableRelation = "CRM Department"."Code";
        }
        field(6; "Department Name"; Text[100])
        {
            Caption = 'Department Name';

            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("CRM Department"."Name" where("Code" = field("Department Code")));
        }
        field(7; "Job Title"; Text[50])
        {
            Caption = 'Job Title';
            DataClassification = CustomerContent;
        }
        field(8; "Skill Set"; Text[250])
        {
            Caption = 'Skill Set';
            DataClassification = CustomerContent;
        }
        field(9; "Experience Level"; Option)
        {
            Caption = 'Experience Level';
            DataClassification = CustomerContent;
            OptionMembers = "Junior","Intermediate","Senior","Expert";
            OptionCaption = 'Junior,Intermediate,Senior,Expert';
        }
        field(10; "Active"; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(11; "Max Concurrent Tickets"; Integer)
        {
            Caption = 'Max Concurrent Tickets';
            DataClassification = CustomerContent;
            InitValue = 1000;
            MinValue = 1;
        }
        field(12; "Current Tickets"; Integer)
        {
            Caption = 'Current Tickets';

            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Ticket Header" where("Assigned To" = field("User ID"), "Status" = filter(<> "Closed")));
        }
        field(13; "Hire Date"; Date)
        {
            Caption = 'Hire Date';
            DataClassification = CustomerContent;
        }
        field(14; "Manager Code"; Code[20])
        {
            Caption = 'Manager Code';
            DataClassification = CustomerContent;
            TableRelation = "Support Personnel"."User ID" where("Active" = const(true));
        }
        field(15; "Manager Name"; Text[100])
        {
            Caption = 'Manager Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Support Personnel"."Name" where("User ID" = field("Manager Code")));
        }
        field(16; "Shift Start Time"; Time)
        {
            Caption = 'Shift Start Time';
            DataClassification = CustomerContent;
        }
        field(17; "Shift End Time"; Time)
        {
            Caption = 'Shift End Time';
            DataClassification = CustomerContent;
        }
        field(18; "Time Zone"; Text[50])
        {
            Caption = 'Time Zone';
            DataClassification = CustomerContent;
        }
        field(19; "Total Tickets Resolved"; Integer)
        {
            Caption = 'Total Tickets Resolved';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Ticket Header" where("Assigned To" = field("User ID"), "Status" = const("Resolved")));
        }
        field(20; "Average Resolution Time"; Decimal)
        {
            Caption = 'Average Resolution Time (Hours)';
            DataClassification = CustomerContent;
            Editable = false;
            DecimalPlaces = 2 : 2;
        }
        field(21; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(22; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(23; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(24; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "User ID")
        {
            Clustered = true;
        }
        key(Name; "Name") { }
        key(Department; "Department Code", "Name") { }
        key(Active; "Active", "Name") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "User ID", "Name", "Department Code", "Job Title") { }
        fieldgroup(Brick; "User ID", "Name", "Department Name", "Current Tickets", "Experience Level") { }
    }



    trigger OnInsert()
    var
        CRMSetup: Record "CRM Setup";
        NoSeries: Codeunit "No. Series";
    begin




        "Created Date" := CurrentDateTime;
        "Created By" := UserId;
        "Last Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
    end;




    trigger OnModify()
    begin
        "Last Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
    end;

    trigger OnDelete()
    var
        TicketHeader: Record "Ticket Header";
    begin
        TicketHeader.SetRange("Assigned To", "User ID");
        //TicketHeader.SetFilter("Status", '<>%1', TicketHeader."Status"::"Closed");
        if not TicketHeader.IsEmpty then
            Error('Cannot delete support personnel %1 because they have active tickets assigned.', "User ID");
    end;

    procedure GetAvailability(): Text
    var
        AvailabilityText: Text;
    begin
        if not "Active" then
            exit('Inactive');

        CalcFields("Current Tickets");
        if "Current Tickets" >= "Max Concurrent Tickets" then
            exit('At Capacity');

        // Check if within shift hours (simplified - doesn't account for time zones)
        if ("Shift Start Time" <> 0T) and ("Shift End Time" <> 0T) then begin
            if (Time >= "Shift Start Time") and (Time <= "Shift End Time") then
                exit('Available')
            else
                exit('Off Shift');
        end;

        exit('Available');
    end;

    procedure CanAssignTicket(): Boolean
    begin
        if not "Active" then
            exit(false);

        CalcFields("Current Tickets");
        exit("Current Tickets" < "Max Concurrent Tickets");
    end;
}