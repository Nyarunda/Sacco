Table 51105 "HR Induction Schedule"
{

    fields
    {
        field(1; "Induction Code"; Code[10])
        {

            trigger OnValidate()
            begin
                if "Induction Code" <> xRec."Induction Code" then begin
                    HRSetup.Get;
                    NoSeries.TestManual(HRSetup."Induction Nos");
                    "No series" := '';
                end;
            end;
        }
        field(2; "Staff Code"; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(3; "Staff Names"; Text[100])
        {
            Editable = false;
        }
        field(4; "Staff Department"; Text[100])
        {
        }
        field(5; "Date of Join"; Date)
        {
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                "Global Dimension 1 Name" := '';
                DimValue.Reset;
                DimValue.SetRange(DimValue.Code, "Global Dimension 1 Code");
                if DimValue.Find('-') then begin
                    "Global Dimension 1 Name" := DimValue.Name;
                end;
            end;
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                "Global Dimension 2 Name" := '';
                DimValue.Reset;
                DimValue.SetRange(DimValue.Code, "Global Dimension 2 Code");
                if DimValue.Find('-') then begin
                    "Global Dimension 2 Name" := DimValue.Name;
                end;
            end;
        }
        field(8; "Induction Duration"; DateFormula)
        {

            trigger OnValidate()
            begin
                "Induction End Date" := 0D;
                "Induction End Date" := CalcDate("Induction Duration", "Induction Start Date");
            end;
        }
        field(9; "Induction Start Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Induction Start Date" < Today then
                    Error('You cannot Backdate');
                Validate("Induction Duration");
            end;
        }
        field(10; "Induction End Date"; Date)
        {
            Editable = false;
        }
        field(11; Comments; Text[100])
        {
        }
        field(12; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(13; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Petty Cash,Imprest,Requisition,ImprestSurrender,Interbank,Receipt,Staff Claim,Staff Advance,AdvanceSurrender,Budget Transfer,Employee Requisition,Leave Application,Transport Requisition,Training Requisition,Job Approval,Induction Approval';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Budget Transfer","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval";
        }
        field(14; "Global Dimension 1 Name"; Text[100])
        {
            Editable = false;
        }
        field(15; "Global Dimension 2 Name"; Text[100])
        {
            Editable = false;
        }
        field(40; "Created By"; Code[50])
        {
        }
        field(41; Selected; Boolean)
        {
        }
        field(42; "No series"; Code[10])
        {
        }
        field(44; "Date Created"; Date)
        {
            Editable = false;
        }
        field(46; "HOD Notified?"; Option)
        {
            Description = 'HOD Notified for Induction';
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;
        }
        field(47; "No. of Participants"; Integer)
        {
            CalcFormula = count("HR Staff  Induction" where("Participant Code" = filter(<> '')));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Induction Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Induction Code" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Induction Nos");
            "Induction Code" := NoSeries.GetNextNo(HRSetup."Induction Nos", WorkDate(), true);
        end;

        "Created By" := UserId;
        "Date Created" := Today;
    end;

    var
        Induction: Record "HR Staff  Induction";
        HRSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
        HREmp: Record Employee;
        Txt001: label 'The User ID %1 is not assigned to any employee';
        DimValue: Record "Dimension Value";
        HRCodeunit: Codeunit "HR Codeunit.";
}

