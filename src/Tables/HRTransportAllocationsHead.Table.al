Table 51044 "HR Transport Allocations Head"
{
    LookupPageID = "HR Transport Allocation";

    fields
    {
        field(2; Commencement; Text[30])
        {
        }
        field(3; "Destination(s)"; Text[30])
        {
        }
        field(4; "Vehicle Reg Number"; Code[20])
        {
            TableRelation = "Company Vehicles";

            trigger OnValidate()
            begin
                Vehicle.Reset;
                Vehicle.SetRange(Vehicle."Registration No.", "Vehicle Reg Number");
                if Vehicle.Find('-') then begin
                    "Passenger Capacity" := Vehicle.Capacity;
                end;
            end;
        }
        field(5; "Assigned Driver"; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Assigned Driver");
                if HREmp.Find('-') then begin
                    "Driver Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + HREmp."Last Name";
                end
            end;
        }
        field(7; "Date of Allocation"; Date)
        {
        }
        field(8; "Vehicle Allocated by"; Code[20])
        {
        }
        field(9; "Opening Odometer Reading"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(10; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Released,Closed,Cancelled;
        }
        field(13; "Date of Trip"; Date)
        {
        }
        field(14; "Purpose of Trip"; Text[250])
        {
        }
        field(60; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(61; Comments; Text[250])
        {
        }
        field(63; "Driver Name"; Text[100])
        {
        }
        field(64; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            //TableRelation = Table5714.Field1;

            trigger OnValidate()
            begin

                /*TESTFIELD(Status,Status::Open);
                IF NOT UserMgt.CheckRespCenter(1,Department) THEN
                  ERROR(
                    Text001,
                    RespCenter.TABLECAPTION,UserMgt.GetPurchasesFilter);
                */

            end;
        }
        field(65; "Loaded to WorkTicket"; Boolean)
        {
        }
        field(66; "Time out"; Time)
        {
        }
        field(67; "Time In"; Time)
        {
        }
        field(68; "Journey Route"; Text[250])
        {
        }
        field(69; "Time of Trip"; Time)
        {
        }
        field(70; "Closing Odometer Reading"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(71; "Linked to Invoice No"; Code[20])
        {
            /*
            TableRelation = Table38.Field3 where(Field1 = const(2));

            trigger OnValidate()
            begin
                PurchHeader.Reset;
                PurchHeader.SetRange(PurchHeader."Document Type", PurchHeader."document type"::"2");
                PurchHeader.SetRange(PurchHeader."No.", "Linked to Invoice No");
                if PurchHeader.Find('-') then begin
                    "Invoice Description" := PurchHeader."Posting Description";
                end;
            end;
            */
        }
        field(72; "No of Days Requested"; Integer)
        {
        }
        field(73; "Authorized  By"; Code[20])
        {
        }
        field(75; "Transport Allocation No"; Code[20])
        {
            Editable = false;
        }
        field(76; "Passenger Capacity"; Integer)
        {
        }
        field(77; "Requisition Type"; Option)
        {
            OptionMembers = Internal,External;
        }
        field(78; "Invoice Description"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Transport Allocation No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Transport Allocation No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Transport Allocation Nos.");
            "Transport Allocation No" := NoSeries.GetNextNo(HRSetup."Transport Allocation Nos.", WorkDate(), true);
        end;

        "Authorized  By" := UserId;
        "Date of Allocation" := Today;
    end;

    trigger OnModify()
    begin
        /*   IF (Status=Status::Approved) OR (Status=Status::Approved) THEN
              ERROR(Text0001);
        */

    end;

    var
        Text0001: label 'You cannot modify an Approved or Closed Record';
        Text001: label 'Your identification is set up to process from %1 %2 only.';
        HRSetup: Record "HR Setup.";
        NoSeries: Codeunit "No. Series";
        PurchHeader: Record "Purchase Header";
        Vehicle: Record "Company Vehicles";
        HREmp: Record Employee;
}

