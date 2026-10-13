table 50597 "Customer Complaints"
{
    Caption = 'Customer Complaints';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20]) { }
        field(2; Title; Text[250]) { }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Member No';
            TableRelation = Members."No.";


            trigger OnValidate()
            var
                Member: Record Members;
                CRMCustomer: Record "CRM Customer";
            begin
                "Customer Name" := '';
                //"Customer Type" := "Customer Type"::"Non-Member";

                // First try to find in Members table
                if Member.Get("Customer No.") then begin
                    "Customer Name" := Member.Name;
                    "Customer Type" := "Customer Type"::Member;
                    "Member No." := "Customer No.";
                    "Member Name" := Member.Name;
                    "Contact Phone" := Member."Mobile Phone No.";
                    "Contact Email" := Member."E-Mail";
                end else begin
                    // Try to find in CRM Customer (Leads)
                    if CRMCustomer.Get("Customer No.") then begin
                        "Customer Name" := CRMCustomer.Name;
                        //"Customer Type" := "Customer Type"::Lead;
                        "Contact Phone" := CRMCustomer."Phone No.";
                        "Contact Email" := CRMCustomer.Email;
                        // Clear member fields
                        "Member No." := '';
                        "Member Name" := '';
                    end;
                end;
            end;
        }
        field(5; "Case Source"; Enum "Case Source") { }
        field(6; Priority; Enum "Case Priority") { }
        field(7; Status; Enum "Case Status")
        {
            ValuesAllowed = Open, Escalated, Closed;
        }
        field(8; "Assigned To"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                "Department Code" := '';
                if UserSetup.Get("Assigned To") then
                    "Department Code" := UserSetup."Responsibility Center";
            end;
        }
        field(9; "Department Code"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(10; "Created DateTime"; DateTime) { }
        field(11; "Created Date"; Date) { }
        field(12; "Created Time"; Time) { }
        field(13; Description; Text[2000])
        {
            Caption = 'Solution/Service Provided';
        }
        field(14; "SLA Breached"; boolean) { }
        field(15; "Customer Name"; Text[100]) { }
        field(16; "Due Date"; Date) { }
        field(17; "Due Time"; Time) { }
        field(18; "Resolved Date"; Date) { }
        field(19; "Resolved DateTime"; DateTime) { }
        field(20; "Resolution Hours"; Integer) { }

        // SACCO-specific fields
        field(21; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            TableRelation = Members."No.";
            trigger OnValidate()
            var
                Member: Record Members;
            begin
                "Member Name" := '';
                if "Member No." <> '' then begin
                    if Member.Get("Member No.") then begin
                        "Member Name" := Member.Name;
                        "Customer Name" := Member.Name;
                        "Customer No." := "Member No.";
                        "Customer Type" := "Customer Type"::Member;
                        "Contact Phone" := Member."Mobile Phone No.";
                        "Contact Email" := Member."E-Mail";
                    end;
                end;
            end;
        }
        field(22; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            Editable = false;
        }


        field(241; "Issue Category Description"; Text[100])
        {
            Caption = 'Issue Category Description';
            Editable = false;
        }
        field(242; "Sub Category Description"; Text[100])
        {
            Caption = 'Sub Category Description';
            Editable = false;
        }
        field(25; "Related Account No."; Code[20])
        {
            Caption = 'Related Account No.';
            // Can relate to savings account, loan account, etc.
        }
        field(26; "Related Loan No."; Code[20])
        {
            Caption = 'Related Loan No.';
            TableRelation = Loans."Loan No.";
        }
        field(27; "Follow-up Required"; Boolean)
        {
            Caption = 'Follow-up Required';
        }
        field(28; "Next Follow-up Date"; Date)
        {
            Caption = 'Next Follow-up Date';
        }
        field(29; "Satisfaction Rating"; Integer)
        {
            Caption = 'Satisfaction Rating';
            MinValue = 1;
            MaxValue = 5;
        }
        field(30; "Resolution Details"; Text[2000])
        {
            Caption = 'Resolution Details';
        }
        field(31; "Escalation Level"; Integer)
        {
            Caption = 'Escalation Level';
            InitValue = 0;
        }
        field(32; "Last Escalated Date"; Date)
        {
            Caption = 'Last Escalated Date';
        }
        field(33; "Contact Phone"; Text[30])
        {
            Caption = 'Contact Phone';
            ExtendedDatatype = PhoneNo;
        }
        field(34; "Contact Email"; Text[80])
        {
            Caption = 'Contact Email';
            ExtendedDatatype = EMail;
        }
        field(35; "Customer Type"; Option)
        {
            Caption = 'Customer Type';
            OptionMembers = Member,"Non-Member",Lead,Staff;
            ValuesAllowed = 0;
        }
        field(36; "Assigned To 2"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(37; "Assigned Date"; Date)
        {
            Caption = 'Assigned Date';
        }
        field(38; "Closed Date"; Date)
        {
            Caption = 'Closed Date';
        }
        field(39; "Escalate To"; Code[50])
        {
            Caption = 'Escalate To';
            TableRelation = "User Setup"."User ID";
        }
        field(40; "Service Type"; Option)
        {
            Caption = 'Service Type';
            OptionMembers = "Reception Service","Case Management";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Service Type" = "Service Type"::"Case Management" then begin
                    "Customer Type" := "Customer Type"::Member;
                    "Customer No." := '';
                    "Customer Name" := '';
                    "Contact Email" := '';
                    "Contact Phone" := '';
                end;

            end;
        }
        field(41; "Reponsibility Center"; Code[10])
        {
            Caption = 'Department';
            //TableRelation = "Responsibility Center";
        }
        field(42; "Approved By"; Code[50])
        {
            Editable = false;
            Caption = 'Approved By';
            TableRelation = "User Setup"."User ID";
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    trigger OnInsert()
    var
        CRMSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        Customer: Record "CRM Customer";
        Member: Record Members;
        SaccoSetup: Record "Sacco Setup";
        DFormula: DateFormula;
    begin
        if "No." = '' then begin
            CRMSetup.Get();
            CRMSetup.TestField("Case Nos.");
            // Get the next number
            "No." := NoSeries.GetNextNo(CRMSetup."Case Nos.", WorkDate(), true);
        end;

        // Set creation timestamps
        if "Created DateTime" = 0DT then
            "Created DateTime" := CurrentDateTime;
        if "Created Date" = 0D then
            "Created Date" := Today;
        if "Created Time" = 0T then
            "Created Time" := Time;
        // Set due date based on SACCO setup
        SaccoSetup.Get();



        // Auto-populate customer name from various sources
        if ("Member No." <> '') and ("Member Name" = '') then begin
            if Member.Get("Member No.") then begin
                "Member Name" := Member.Name;
                "Customer Name" := Member.Name;
                "Customer Type" := "Customer Type"::Member;
                "Contact Phone" := Member."Mobile Phone No.";
                "Contact Email" := Member."E-Mail";
                if "Customer No." = '' then
                    "Customer No." := "Member No.";
            end;
        end else if ("Customer No." <> '') and ("Customer Name" = '') then begin
            // Check if it's a member first
            if Member.Get("Customer No.") then begin
                "Customer Name" := Member.Name;
                "Customer Type" := "Customer Type"::Member;
                "Member No." := "Customer No.";
                "Member Name" := Member.Name;
                "Contact Phone" := Member."Mobile Phone No.";
                "Contact Email" := Member."E-Mail";
            end else if Customer.Get("Customer No.") then begin
                "Customer Name" := Customer.Name;
                //"Customer Type" := "Customer Type"::Lead;
                "Contact Phone" := Customer."Phone No.";
                "Contact Email" := Customer.Email;
            end;
        end;


    end;

    trigger OnModify()
    var
        Customer: Record "CRM Customer";
        Member: Record Members;
    begin
        // Update customer name if customer number changed
        if ("Customer No." <> xRec."Customer No.") and ("Customer No." <> '') then begin
            if Customer.Get("Customer No.") then
                "Customer Name" := Customer.Name
            else
                "Customer Name" := '';
        end;

        // Update member information if member number changed
        if ("Member No." <> xRec."Member No.") and ("Member No." <> '') then begin
            if Member.Get("Member No.") then begin
                "Member Name" := Member.Name;
                "Customer Name" := Member.Name;
                "Customer Type" := "Customer Type"::Member;
            end else begin
                "Member Name" := '';
            end;
        end;

        // Auto-set resolved date and time when status changes to resolved
        if (Status = Status::Resolved) and (xRec.Status <> Status::Resolved) then begin
            if "Resolved Date" = 0D then
                "Resolved Date" := Today;
            if "Resolved DateTime" = 0DT then
                "Resolved DateTime" := CurrentDateTime;

            // Calculate resolution hours
            if "Created DateTime" <> 0DT then begin
                "Resolution Hours" := Round(("Resolved DateTime" - "Created DateTime") / 3600000, 1); // Convert milliseconds to hours
            end;
        end;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}
