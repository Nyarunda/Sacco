

table 50692 "AML Suspicious Activity"
{
    Caption = 'AML Suspicious Activity';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(3; "Alert Type"; Enum "AML Alert Type")
        {
            Caption = 'Alert Type';
            DataClassification = CustomerContent;
        }
        field(4; "Status"; Enum "AML Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Status Date" := CurrentDateTime;
                "Status Updated By" := CopyStr(UserId, 1, MaxStrLen("Status Updated By"));

                if "Status" in ["Status"::ReportedToAuthorities, "Status"::Closed] then begin
                    "Closed Date" := Today;
                    "Closed By" := "Status Updated By";
                end;
            end;
        }
        field(5; "Priority"; Option)
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
            OptionMembers = Low,Medium,High,Critical;
            OptionCaption = 'Low,Medium,High,Critical';
        }
        field(10; "Alert Date"; Date)
        {
            Caption = 'Alert Date';
            DataClassification = CustomerContent;
        }
        field(11; "Alert Time"; Time)
        {
            Caption = 'Alert Time';
            DataClassification = CustomerContent;
        }
        field(12; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(13; "Detailed Description"; Text[1000])
        {
            Caption = 'Detailed Description';
            DataClassification = CustomerContent;
        }
        field(20; "Transaction Monitor Entry"; Integer)
        {
            Caption = 'Transaction Monitor Entry';
            DataClassification = CustomerContent;
            TableRelation = "AML Transaction Monitor"."Entry No.";
        }
        field(21; "Transaction Amount"; Decimal)
        {
            Caption = 'Transaction Amount';
            DataClassification = CustomerContent;
        }
        field(22; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
            DataClassification = CustomerContent;
        }
        field(23; "Transaction Type"; Enum "AML Transaction Type")
        {
            Caption = 'Transaction Type';
            DataClassification = CustomerContent;
        }
        field(30; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Members".Name where("No." = field("Member No.")));
            Editable = false;
        }
        field(31; "Customer Risk Level"; Enum "AML Risk Level")
        {
            Caption = 'Customer Risk Level';
            FieldClass = FlowField;
            CalcFormula = lookup("AML Customer Risk Profile"."Risk Level" where("Customer No." = field("Customer No.")));
            Editable = false;
        }
        field(40; "Risk Score"; Decimal)
        {
            Caption = 'Risk Score';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 2 : 2;
        }
        field(41; "Auto Generated"; Boolean)
        {
            Caption = 'Auto Generated';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50; "Assigned To"; Code[50])
        {
            Caption = 'Assigned To';
            DataClassification = CustomerContent;
        }
        field(51; "Investigation Notes"; Text[1000])
        {
            Caption = 'Investigation Notes';
            DataClassification = CustomerContent;
        }
        field(52; "Resolution"; Text[500])
        {
            Caption = 'Resolution';
            DataClassification = CustomerContent;
        }
        field(60; "Status Date"; DateTime)
        {
            Caption = 'Status Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(61; "Status Updated By"; Code[50])
        {
            Caption = 'Status Updated By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(62; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
        }
        field(70; "Closed Date"; Date)
        {
            Caption = 'Closed Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(71; "Closed By"; Code[50])
        {
            Caption = 'Closed By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(81; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(82; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(83; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(90; "External Reference"; Code[50])
        {
            Caption = 'External Reference';
            DataClassification = CustomerContent;
        }
        field(91; "Reported to FRC"; Boolean)
        {
            Caption = 'Reported to FRC';
            DataClassification = CustomerContent;
        }
        field(92; "FRC Reference"; Code[50])
        {
            Caption = 'FRC Reference';
            DataClassification = CustomerContent;
        }
        field(93; "Report Date"; Date)
        {
            Caption = 'Report Date';
            DataClassification = CustomerContent;
        }
        field(94; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = CustomerContent;
        }
        field(95; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Members".Name where("No." = field("Member No.")));
            Editable = false;
        }
        field(96; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Customer No.", "Alert Date")
        {
        }
        key(Key3; "Status", "Priority")
        {
        }
        key(Key4; "Alert Type", "Status")
        {
        }
        key(Key5; "Due Date", "Status")
        {
        }
        key(Key6; "Assigned To", "Status")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Customer No.", "Customer Name", "Alert Type", "Status", "Alert Date")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Created By" := CopyStr(UserId, 1, MaxStrLen("Created By"));
        "Last Modified Date" := "Created Date";
        "Last Modified By" := "Created By";

        if "Alert Date" = 0D then
            "Alert Date" := Today;
        if "Alert Time" = 0T then
            "Alert Time" := Time;
        if "Status" = "Status"::"Open" then
            "Status" := "Status"::Open;

        CalculateDueDate();
    end;

    trigger OnModify()
    begin
        "Last Modified Date" := CurrentDateTime;
        "Last Modified By" := CopyStr(UserId, 1, MaxStrLen("Last Modified By"));
    end;

    local procedure CalculateDueDate()
    begin
        case "Priority" of
            "Priority"::Critical:
                "Due Date" := CalcDate('<+1D>', "Alert Date");
            "Priority"::High:
                "Due Date" := CalcDate('<+3D>', "Alert Date");
            "Priority"::Medium:
                "Due Date" := CalcDate('<+7D>', "Alert Date");
            "Priority"::Low:
                "Due Date" := CalcDate('<+14D>', "Alert Date");
        end;
    end;

    procedure CreateFromTransactionMonitor(TransactionMonitor: Record "AML Transaction Monitor")
    begin
        Init();
        "Customer No." := TransactionMonitor."Customer No.";
        "Member No." := TransactionMonitor."Member No.";
        "Loan No." := TransactionMonitor."Loan No.";
        "Alert Type" := TransactionMonitor."Alert Type";
        "Description" := TransactionMonitor."Alert Description";
        "Transaction Monitor Entry" := TransactionMonitor."Entry No.";
        "Transaction Amount" := TransactionMonitor."Amount (LCY)";
        "Transaction Date" := TransactionMonitor."Transaction Date";
        "Transaction Type" := TransactionMonitor."Transaction Type";
        "Risk Score" := TransactionMonitor."Risk Score";
        "Auto Generated" := true;

        // Set priority based on alert type and risk score
        case "Alert Type" of
            "Alert Type"::HighValue,
            "Alert Type"::Structured,
            "Alert Type"::PEP:
                "Priority" := "Priority"::High;
            "Alert Type"::Velocity,
            "Alert Type"::Unusual:
                "Priority" := "Priority"::Medium;
            else
                "Priority" := "Priority"::Low;
        end;

        if "Risk Score" >= 75 then
            "Priority" := "Priority"::Critical;

        Insert(true);
    end;

    procedure AssignToUser(UserName: Code[50])
    begin
        "Assigned To" := UserName;
        if "Status" = "Status"::Open then
            "Status" := "Status"::InvestigationPending;
        Modify();
    end;

    procedure EscalateToManagement()
    begin
        "Status" := "Status"::EscalatedToManagement;
        "Priority" := "Priority"::High;
        Modify();
    end;

    procedure ReportToAuthorities(FRCReference: Code[50])
    begin
        "Status" := "Status"::ReportedToAuthorities;
        "Reported to FRC" := true;
        "FRC Reference" := FRCReference;
        "Report Date" := Today;
        Modify();
    end;

    procedure MarkAsFalsePositive(Resolution: Text[500])
    begin
        "Status" := "Status"::FalsePositive;
        "Resolution" := Resolution;
        Modify();
    end;

    procedure CloseCase(Resolution: Text[500])
    begin
        "Status" := "Status"::Closed;
        "Resolution" := Resolution;
        Modify();
    end;
}
