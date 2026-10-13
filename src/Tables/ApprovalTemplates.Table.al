Table 50366 "Approval Templates"
{
    Caption = 'Approval Templates';

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            Editable = false;
        }
        field(2; "Approval Code"; Code[20])
        {
            Caption = 'Approval Code';
            //TableRelation = "Approval Code".Code;

            trigger OnValidate()
            begin
                TestField(Enabled, false);
                //ApprCode.Get("Approval Code");
                //ApprCode.TestField("Linked To Table No.");
                "Table ID" := Database::"Approval Tracker";// ApprCode."Linked To Table No.";
            end;
        }
        field(3; "Approval Type"; Enum "Workflow Approval Type")
        {
            Caption = 'Approval Type';

            trigger OnValidate()
            begin
                TestField(Enabled, false);
            end;
        }
        field(4; "Document Type"; Enum "Approval Document Type")
        {
            Caption = 'Document Type';
            trigger OnValidate()
            begin
                TestField(Enabled, false);
            end;
        }
        field(5; "Limit Type"; Enum "Workflow Approval Limit Type")
        {
            Caption = 'Limit Type';

            trigger OnValidate()
            begin
                TestField(Enabled, false);
            end;
        }
        field(6; "Additional Approvers"; Boolean)
        {
            CalcFormula = exist("Additional Approvers" where("Approval Code" = field("Approval Code"),
                                                              "Approval Type" = field("Approval Type"),
                                                              "Document Type" = field("Document Type"),
                                                              "Limit Type" = field("Limit Type"),
                                                              "Approver ID" = filter(<> '')));
            Caption = 'Additional Approvers';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Enabled; Boolean)
        {
            Caption = 'Enabled';

            trigger OnValidate()
            var
                Salesheader: Record "Sales Header";
                PurchaseHeader: Record "Purchase Header";
                ApprovalEntry: Record "Approval Entry";
                TempApprovalTemplate: Record "Approval Templates";
            begin
                if (Enabled = false) and (xRec.Enabled = true) then begin
                    TempApprovalTemplate.SetRange("Approval Code", "Approval Code");
                    TempApprovalTemplate.SetRange("Document Type", "Document Type");
                    if not TempApprovalTemplate.FindFirst then
                        case "Table ID" of
                            Database::"Sales Header":
                                begin
                                    Salesheader.SetCurrentkey("Document Type", Status);
                                    Salesheader.SetRange("Document Type", "Document Type");
                                    Salesheader.SetRange(Status, Salesheader.Status::"Pending Approval");
                                    if Salesheader.FindFirst then begin
                                        if Confirm(Text006) then begin
                                            ApprovalEntry.SetRange("Table ID", Database::"Sales Header");
                                            ApprovalEntry.SetRange("Document Type", "Document Type");
                                            ApprovalEntry.SetFilter(
                                              Status, '%1|%2|%3', ApprovalEntry.Status::Created, ApprovalEntry.Status::Open, ApprovalEntry.Status::Approved);
                                            if ApprovalEntry.FindFirst then
                                                ApprovalEntry.ModifyAll(Status, ApprovalEntry.Status::Canceled);
                                        end;
                                        Salesheader.ModifyAll(Status, Salesheader.Status::Open);
                                    end;
                                end;
                            Database::"Purchase Header":
                                begin
                                    PurchaseHeader.SetCurrentkey("Document Type", Status);
                                    PurchaseHeader.SetRange("Document Type", "Document Type");
                                    PurchaseHeader.SetRange(Status, PurchaseHeader.Status::"Pending Approval");
                                    if PurchaseHeader.FindFirst then begin
                                        if Confirm(Text006) then begin
                                            ApprovalEntry.SetRange("Table ID", Database::"Purchase Header");
                                            ApprovalEntry.SetRange("Document Type", "Document Type");
                                            ApprovalEntry.SetFilter(
                                              Status, '%1|%2|%3', ApprovalEntry.Status::Created, ApprovalEntry.Status::Open, ApprovalEntry.Status::Approved);
                                            if ApprovalEntry.FindFirst then
                                                ApprovalEntry.ModifyAll(Status, ApprovalEntry.Status::Canceled);
                                        end;
                                        PurchaseHeader.ModifyAll(Status, Salesheader.Status::Open);
                                    end;
                                end;
                        end;
                end;

            end;
        }
        field(50000; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }

        field(50003; "Description"; TExt[200])
        {
        }


        field(50004; "Custom Document Type"; Enum "Custom Document Type")
        {
            Caption = 'Additional Document Type';
            trigger OnValidate()
            begin
                TestField(Enabled, false);
                "Document Type" := "Document Type"::" ";
            end;
        }
        field(50005; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                TestField(Enabled, false);
            end;
        }
    }

    keys
    {
        key(Key1; "Approval Code", "Approval Type", "Document Type", "Custom Document Type", "Limit Type")
        {
            Clustered = true;
        }
        key(Key2; "Table ID", "Approval Type", Enabled)
        {
        }
        key(Key3; "Approval Code", "Approval Type", Enabled)
        {
        }
        key(Key4; Enabled)
        {
        }
        key(Key5; "Limit Type", "Document Type", "Approval Type", Enabled)
        {
        }
        key(Key6; "Table ID", "Document Type", Enabled)
        {
        }
        key(Key7; "Table ID", "Custom Document Type", "Responsibility Center", "User ID", Enabled)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        AdditionalApprovers.SetRange("Approval Code", "Approval Code");
        AdditionalApprovers.SetRange("Approval Type", "Approval Type");
        AdditionalApprovers.SetRange("Document Type", "Document Type");
        AdditionalApprovers.SetRange("Limit Type", "Limit Type");
        AdditionalApprovers.DeleteAll;
    end;

    trigger OnInsert()
    begin
        TestValidation;
    end;

    trigger OnRename()
    begin
        TestValidation;
        RenameAddApprovers(Rec, xRec);
    end;

    var
        ApprCode: Record "Approval Code";
        AdditionalApprovers: Record "Additional Approvers";
        Text001: label '%1 is not a valid limit type for table %2.';
        Text002: label '%1 is only valid for table %2.';
        Text004: label '%1 is only valid when document type is Quote and Table ID is %2.';
        Text005: label 'Additional Approvers must be inserted if %1 is blank.';
        Text006: label 'Do you want to cancel all outstanding approvals? ';
        Text007: label 'Additional Approvers must be inserted if %1 is %2 and %3 is Credit Limit.';


    procedure TestValidation()
    var
        AppSetup: Record "Approval Setup";
    begin
        AppSetup.Get;
        if ("Table ID" = Database::"Purchase Header") and
           ("Limit Type" = "limit type"::"Credit Limits")
        then
            Error(StrSubstNo(Text001, Format("Limit Type"), Database::"Purchase Header"));

        if ("Table ID" <> Database::"Purchase Header") and
           ("Limit Type" = "limit type"::"Request Limits")
        then
            Error(StrSubstNo(Text002, Format("Limit Type"), Database::"Purchase Header"));

        if ("Table ID" = Database::"Purchase Header") and
           ("Limit Type" = "limit type"::"Request Limits") and
           ("Document Type" <> "document type"::Quote)
        then
            Error(StrSubstNo(Text004, Format("Limit Type"), "Table ID"));
    end;


    procedure RenameAddApprovers(Template: Record "Approval Templates"; xTemplate: Record "Approval Templates")
    var
        AddApprovers: Record "Additional Approvers";
        RenamedAddApprovers: Record "Additional Approvers";
    begin
        AddApprovers.SetRange("Approval Code", xTemplate."Approval Code");
        AddApprovers.SetRange("Approval Type", xTemplate."Approval Type");
        AddApprovers.SetRange("Document Type", xTemplate."Document Type");
        AddApprovers.SetRange("Limit Type", xTemplate."Limit Type");
        if AddApprovers.Find('-') then
            repeat
                RenamedAddApprovers := AddApprovers;
                RenamedAddApprovers."Approval Code" := Template."Approval Code";
                RenamedAddApprovers."Approval Type" := Template."Approval Type";
                RenamedAddApprovers."Document Type" := Template."Document Type";
                RenamedAddApprovers."Limit Type" := Template."Limit Type";
                AddApprovers.Delete;
                RenamedAddApprovers.Insert;
            until AddApprovers.Next = 0;
    end;
}
