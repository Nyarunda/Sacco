table 50569 "Store Requisition Header"
{
    DrillDownPageID = "Store Requisitions List";
    LookupPageID = "Store Requisitions List";

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = false;
            Editable = false;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesReceivablesSetup.Get();
                    NoSeries.TestManual(SalesReceivablesSetup."Store Requisition Nos");
                    "No." := '';
                end;
            end;
        }
        field(2; "Request date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Request date" < Today then Error('Required date should be furturistic');
            end;
        }
        field(5; "Required Date"; Date)
        {
        }
        field(6; "Requester ID"; Code[50])
        {
            Caption = 'Requester ID';
            Editable = false;
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;

            trigger OnValidate()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;
        }
        field(7; "Request Description"; Text[150])
        {
        }
        field(9; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(10; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Cancelled,Posted;
        }
        field(11; Supplier; Code[20])
        {
            TableRelation = Vendor;
        }
        field(12; "Action Type"; Option)
        {
            OptionMembers = " ","Ask for Tender","Ask for Quote";

            trigger OnValidate()
            begin
                /*
                IF Type=Type::"G/L Account" THEN BEGIN
                   IF "Action Type"="Action Type"::Issue THEN
                            ERROR('You cannot Issue a G/L Account please order for it')
                END;


               //Compare Quantity in Store and Qty to Issue
                IF Type=Type::Item THEN BEGIN
                   IF "Action Type"="Action Type"::Issue THEN BEGIN
                    IF Quantity>"Qty in store" THEN
                      ERROR('You cannot Issue More than what is available in store')
                   END;
                END;
                */

            end;
        }
        field(29; Justification; Text[250])
        {
        }
        field(30; "User ID"; Code[50])
        {
            Editable = false;
        }

        field(31; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                Dimval.Reset;
                Dimval.SetRange(Dimval."Global Dimension No.", 1);
                Dimval.SetRange(Dimval.Code, "Global Dimension 1 Code");
                if Dimval.Find('-') then
                    "Function Name" := Dimval.Name;

                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(56; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                Dimval.Reset;
                Dimval.SetRange(Dimval."Global Dimension No.", 2);
                Dimval.SetRange(Dimval.Code, "Shortcut Dimension 2 Code");
                if Dimval.Find('-') then
                    "Budget Center Name" := Dimval.Name;

                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(57; "Function Name"; Text[100])
        {
            Description = 'Stores the name of the function in the database';
        }
        field(58; "Budget Center Name"; Text[100])
        {
            Description = 'Stores the name of the budget center in the database';
        }
        field(81; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(3, "Shortcut Dimension 3 Code");
                Validate("Shortcut Dimension 3 Code");
            end;

            trigger OnValidate()
            begin
                Dimval.Reset;
                //Dimval.SETRANGE(Dimval."Global Dimension No.",3);
                Dimval.SetRange(Dimval.Code, "Shortcut Dimension 3 Code");
                if Dimval.Find('-') then
                    Dim3 := Dimval.Name;

                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(82; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';

            trigger OnLookup()
            begin
                LookupShortcutDimCode(4, "Shortcut Dimension 4 Code");
                Validate("Shortcut Dimension 4 Code");
            end;

            trigger OnValidate()
            begin
                Dimval.Reset;
                //Dimval.SETRANGE(Dimval."Global Dimension No.",4);
                Dimval.SetRange(Dimval.Code, "Shortcut Dimension 4 Code");
                if Dimval.Find('-') then
                    Dim4 := Dimval.Name;

                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(83; Dim3; Text[250])
        {
        }
        field(84; Dim4; Text[250])
        {
        }
        field(85; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin

                TestField(Status, Status::Open);
                /*  if not UserMgt.CheckRespCenter(1, "Responsibility Center") then
                     Error(
                       Text001,
                       RespCenter.TableCaption, UserMgt.GetPurchasesFilter); */
                /*
               "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
               IF "Location Code" = '' THEN BEGIN
                 IF InvtSetup.GET THEN
                   "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
               END ELSE BEGIN
                 IF Location.GET("Location Code") THEN;
                 "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
               END;

               UpdateShipToAddress;
                  */
                /*
             CreateDim(
               DATABASE::"Responsibility Center","Responsibility Center",
               DATABASE::Vendor,"Pay-to Vendor No.",
               DATABASE::"Salesperson/Purchaser","Purchaser Code",
               DATABASE::Campaign,"Campaign No.");

             IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
               RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
               "Assigned User ID" := '';
             END;
               */

            end;
        }
        field(86; TotalAmount; Decimal)
        {
            CalcFormula = Sum("Store Requisition Lines"."Line Amount" WHERE("Requistion No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(87; "Issuing Store"; Code[10])
        {
            TableRelation = Location;

            trigger OnValidate()
            begin

                ReqLines.Reset;
                ReqLines.SetRange(ReqLines."Requistion No", "No.");
                if ReqLines.Find('-') then begin
                    repeat
                        ReqLines."Issuing Store" := "Issuing Store";
                    until ReqLines.Next = 0;
                end;
            end;
        }
        field(88; "Job No"; Code[20])
        {
            TableRelation = Job;
        }
        field(89; "Posting Date"; Date)
        {
        }
        field(90; "Document Type"; Option)
        {
            OptionCaption = ' ,Grant,PR';
            OptionMembers = " ",Grant,PR;
        }
        field(91; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(481; "Item Description"; Text[80])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR('Delete Not allowed');
        if Status <> Status::Open then
            Error('You Cannot DELETE an already released Requisition')
    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            "No." := NoSeries.GetNextNo(GetNoSeriesCode, WorkDate(), true);
        end;
        //EXIT(GetNoSeriesRelCode(NoSeriesCode));
        "Request date" := Today;
        "Posting Date" := Today;
        "User ID" := UserId;
        UserSetup.Get("User ID");
        "Responsibility Center" := UserSetup."Responsibility Center";
    end;

    trigger OnModify()
    begin
        //  IF Status=Status::Released THEN
        //     ERROR('You Cannot modify an already Approved Requisition');
        /*
        ReqLines.RESET;
        ReqLines.SETRANGE(ReqLines."Requistion No","No.");
        IF ReqLines.FIND('-') THEN BEGIN
        REPEAT
          ReqLines."Shortcut Dimension 1 Code":="Global Dimension 1 Code";
          ReqLines."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
        //  ReqLines."dimension set id" := "dimension set id";
        UNTIL ReqLines.NEXT=0;
        END;
        */

    end;

    var
        NoSeries: Codeunit "No. Series";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        // UserDept: Record "Imprest Surrender Details";
        RespCenter: Record "Responsibility Center";
        // UserMgt: Codeunit "User Setup Management BR";
        Text001: Label 'Your identification is set up to process from %1 %2 only.';
        Dimval: Record "Dimension Value";
        UserSetup: Record "User Setup";
        ReqLines: Record "Store Requisition Lines";
        DimMgt: Codeunit DimensionManagement;

    procedure GetNoSeriesRelCode(NoSeriesCode: Code[20]): Code[10]
    var
        GenLedgerSetup: Record "General Ledger Setup";
        RespCenter: Record "Responsibility Center";
        DimMgt: Codeunit DimensionManagement;
        NoSrsRel: Record "No. Series Relationship";
    begin
        exit(GetNoSeriesRelCode(NoSeriesCode));


    end;

    local procedure GetNoSeriesCode(): Code[10]
    var
        NoSeriesCode: Code[20];
    begin
        SalesReceivablesSetup.Get();
        SalesReceivablesSetup.TestField("Store Requisition Nos");
        exit(SalesReceivablesSetup."Store Requisition Nos");

    end;

    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Payments', "No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure LinesExists(): Boolean
    var
        PayLines: Record "Store Requisition Lines";
        HasLines: Boolean;
    begin
        HasLines := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines."Requistion No", "No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            if PayLines."Issuing Store" = '' then Error('Kindly insert the issuing store for item %1', PayLines."No.");
            exit(HasLines);
        end;
    end;

    procedure PostStoreRequisition()
    var
        ItemLedger: Record "Item Ledger Entry";
        ReqLine: Record "Store Requisition Lines";
        InventorySetup: Record "Inventory Setup";
        ItemJnlLn: Record "Item Journal Line";
        LineNo: Integer;
        Text046: Label 'The %1 does not match the quantity defined in item tracking.';
        ResEntry: Record "Reservation Entry";
        LastResNo: Integer;
    begin

        if not LinesExists then
            Error('There are no Lines created for this Document');

        if Status = Status::Posted then
            Error('The Document Has Already been Posted');

        if Status <> Status::Released then
            Error('The Document Has not yet been Approved');
        if InventorySetup.Get then begin
            InventorySetup.TESTFIELD(InventorySetup."Item Jnl Template");
            InventorySetup.TESTFIELD(InventorySetup."Item Jnl Batch");

            ItemJnlLn.Reset;
            ItemJnlLn.SETRANGE(ItemJnlLn."Journal Template Name", InventorySetup."Item Jnl Template");
            ItemJnlLn.SETRANGE(ItemJnlLn."Journal Batch Name", InventorySetup."Item Jnl Batch");
            if ItemJnlLn.Find('-') then
                ItemJnlLn.DeleteAll;


            ReqLine.Reset;
            ReqLine.SetRange(ReqLine."Requistion No", "No.");
            if ReqLine.Find('-') then begin
                repeat
                    //Issue

                    LineNo := LineNo + 1000;
                    ItemJnlLn.INIT;
                    ItemJnlLn."Journal Template Name" := InventorySetup."Item Jnl Template";
                    ItemJnlLn."Journal Batch Name" := InventorySetup."Item Jnl Batch";
                    ItemJnlLn."Line No." := LineNo;
                    ItemJnlLn."Entry Type" := ItemJnlLn."Entry Type"::"Negative Adjmt.";
                    ItemJnlLn."Document No." := "No.";
                    ItemJnlLn."Item No." := ReqLine."No.";
                    ItemJnlLn.VALIDATE("Item No.");
                    ReqLine.TESTFIELD("Issuing Store");
                    ItemJnlLn."Location Code" := ReqLine."Issuing Store";
                    ItemJnlLn."Bin Code" := ReqLine."Bin Code";
                    ItemJnlLn.VALIDATE("Location Code");
                    ItemJnlLn."Posting Date" := "Request date";
                    ItemJnlLn.Description := ReqLine.Description;

                    ItemLedger.RESET;
                    ItemLedger.SETRANGE(ItemLedger."Item No.", ReqLine."No.");
                    ItemLedger.SETRANGE(ItemLedger."Location Code", ReqLine."Issuing Store");
                    ItemLedger.CALCSUMS(Quantity);
                    IF ItemLedger.Quantity <= 0 THEN
                        ERROR('Item %1 is out of stock in store %2', ReqLine.Description, ReqLine."Issuing Store");

                    ItemJnlLn.Quantity := ReqLine.Quantity;
                    ItemJnlLn."Shortcut Dimension 1 Code" := ReqLine."Shortcut Dimension 1 Code";
                    ItemJnlLn.VALIDATE("Shortcut Dimension 1 Code");
                    ItemJnlLn."Shortcut Dimension 2 Code" := ReqLine."Shortcut Dimension 2 Code";
                    ItemJnlLn.VALIDATE("Shortcut Dimension 2 Code");
                    //ItemJnlLn."Lot No.":=ReqLine."Lot No.";
                    ItemJnlLn."Dimension Set ID" := ReqLine."Dimension Set ID";
                    ItemJnlLn.VALIDATE(Quantity);
                    ItemJnlLn.VALIDATE("Unit Amount");
                    ItemJnlLn."Reason Code" := '221';
                    //ItemJnlLn.VALIDATE("Reason Code");
                    ItemJnlLn."Gen. Prod. Posting Group" := ReqLine."Gen. Prod. Posting Group";
                    ItemJnlLn."Gen. Bus. Posting Group" := ReqLine."Gen. Bus. Posting Group";
                    ItemJnlLn.INSERT(TRUE);

                    //ReqLine."Request Status":=ReqLine."Request Status"::Closed;

                    //Added to take care of lot numbers-----------------
                    //If Lot No field  Exist then insert reservation line
                    ResEntry.Reset;
                    ResEntry.SetRange(ResEntry."Entry No.");
                    if ResEntry.Find('+') then LastResNo := ResEntry."Entry No.";

                    LastResNo := LastResNo + 1;

                    if ReqLine."Lot No." <> '' then begin
                        ResEntry.Init;
                        ResEntry."Entry No." := LastResNo;   //ResEntry."Entry No."
                        ResEntry."Item No." := ReqLine."No.";
                        ResEntry."Location Code" := ReqLine."Issuing Store";
                        ResEntry."Quantity (Base)" := -ReqLine.Quantity;
                        ResEntry.Validate("Quantity (Base)");
                        ResEntry.Quantity := -ReqLine.Quantity;
                        ResEntry."Qty. to Handle (Base)" := -ReqLine.Quantity;
                        ResEntry.Validate("Qty. to Handle (Base)");
                        ResEntry."Reservation Status" := ResEntry."Reservation Status"::Prospect;
                        ResEntry."Creation Date" := "Request date";
                        ResEntry."Source Type" := 83;
                        ResEntry."Source Subtype" := 3;
                        ResEntry."Source ID" := 'ITEM';
                        ResEntry."Source Batch Name" := 'DEFAULT';
                        ResEntry."Source Ref. No." := LineNo;
                        ResEntry."Lot No." := ReqLine."Lot No.";
                        ResEntry."Item Tracking" := ResEntry."Item Tracking"::"Lot No.";
                        ResEntry.Insert;

                    end;

                until ReqLine.Next = 0;
                //Post Entries
                ItemJnlLn.Reset;
                ItemJnlLn.SETRANGE(ItemJnlLn."Journal Template Name", InventorySetup."Item Jnl Template");
                ItemJnlLn.SETRANGE(ItemJnlLn."Journal Batch Name", InventorySetup."Item Jnl Batch");
                CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJnlLn);
                //End Post entries

                // Modify All
                // Post := false;
                // Post := JournlPosted.PostedSuccessfully();
                //if Post then begin
                //ReqLine.MODIFYALL(ReqLine."Request Status",ReqLine."Request Status"::Closed);
                Status := Status::Posted;
                Modify;
                //  end
            end;
        end;

        Status := Status::Posted;
        Modify;

    end;

}

