
Table 50255 "RFQ Header"
{
    LookupPageId = "RFQ List";
    DrillDownPageId = "RFQ List";

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Quotation Request,Open Tender,Restricted Tender,Low Value Procurement,Direct Procurement';
            OptionMembers = "Quotation Request","Open Tender","Restricted Tender","Low Value Procurement","Direct Procurement";
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(11; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
            DataClassification = CustomerContent;
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            DataClassification = CustomerContent;
            TableRelation = Location.Code where("Use As In-Transit" = const(false));

            trigger OnValidate()
            begin
                if "Ship-to Code" <> '' then begin
                    location.Get("Ship-to Code");
                    "Location Code" := "Ship-to Code";
                    "Ship-to Name" := location.Name;
                    "Ship-to Name 2" := location."Name 2";
                    "Ship-to Address" := location.Address;
                    "Ship-to Address 2" := location."Address 2";
                    "Ship-to City" := location.City;
                    "Ship-to Contact" := location.Contact;
                end
            end;
        }
        field(13; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
            DataClassification = CustomerContent;
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
            DataClassification = CustomerContent;
        }
        field(15; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
            DataClassification = CustomerContent;
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
            DataClassification = CustomerContent;
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            DataClassification = CustomerContent;
        }
        field(18; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
            DataClassification = CustomerContent;
        }
        field(19; "Expected Opening Date"; DateTime)
        {
            Caption = 'Expected Opening Date';
            DataClassification = CustomerContent;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(21; "Expected Closing Date"; DateTime)
        {
            Caption = 'Expected Closing Date';
            DataClassification = CustomerContent;
        }
        field(22; "Posting Description"; Text[50])
        {
            Caption = 'Posting Description';
            DataClassification = CustomerContent;
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            DataClassification = CustomerContent;
            TableRelation = "Payment Terms";
        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
        }
        field(25; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(26; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
            DataClassification = CustomerContent;
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            DataClassification = CustomerContent;
            TableRelation = "Shipment Method";
        }
        field(28; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(31; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Vendor Posting Group";
        }
        field(32; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                PurchLine: Record "Purchase Line";
                Currency: Record Currency;
                RecalculatePrice: Boolean;
            begin
            end;
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
            DataClassification = CustomerContent;
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            DataClassification = CustomerContent;
            TableRelation = Language;
        }
        field(43; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
            end;
        }
        field(45; "Order Class"; Code[10])
        {
            Caption = 'Order Class';
            DataClassification = CustomerContent;
        }
        field(46; Comment; Boolean)
        {
            //CalcFormula = exist("Purch. Comment Line" where ("Document Type"=field("Document Type"),
            //                                               "No."=field("No."),
            //                                             "Document Line No."=const(0)));
            Caption = 'Comment';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(47; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(51; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
            DataClassification = CustomerContent;
        }
        field(52; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            DataClassification = CustomerContent;
        }
        field(55; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            DataClassification = CustomerContent;
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account";
        }
        field(57; Receive; Boolean)
        {
            Caption = 'Receive';
            DataClassification = CustomerContent;
        }
        field(58; Invoice; Boolean)
        {
            Caption = 'Invoice';
            DataClassification = CustomerContent;
        }
        field(60; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            //CalcFormula = sum("Purchase Line".Amount where("Document Type" = field("Document Type"),
            //                                              "Document No." = field("No.")));
            Caption = 'Amount';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            //CalcFormula = sum("Purchase Line"."Amount Including VAT" where("Document Type" = field("Document Type"),
            //                                                              "Document No." = field("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(62; "Receiving No."; Code[20])
        {
            Caption = 'Receiving No.';
            DataClassification = CustomerContent;
        }
        field(63; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
            DataClassification = CustomerContent;
        }
        field(64; "Last Receiving No."; Code[20])
        {
            Caption = 'Last Receiving No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Purch. Rcpt. Header";
        }
        field(65; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Purch. Inv. Header";
        }
        field(73; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
            TableRelation = "Reason Code";
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Business Posting Group";
        }
        field(76; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            DataClassification = CustomerContent;
            TableRelation = "Transaction Type";
        }
        field(77; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            DataClassification = CustomerContent;
            TableRelation = "Transport Method";
        }
        field(78; "VAT Country/Region Code"; Code[10])
        {
            Caption = 'VAT Country/Region Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(79; "RFQ No."; Code[20])
        {
            Caption = 'RFQ No.';
            DataClassification = CustomerContent;

        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            DataClassification = CustomerContent;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
            DataClassification = CustomerContent;
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(94; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            DataClassification = CustomerContent;
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(95; "Order Address Code"; Code[10])
        {
            Caption = 'Order Address Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                PayToVend: Record "Savings Accounts";
            begin
            end;
        }
        field(97; "Entry Point"; Code[10])
        {
            Caption = 'Entry Point';
            DataClassification = CustomerContent;
            TableRelation = "Entry/Exit Point";
        }
        field(98; Correction; Boolean)
        {
            Caption = 'Correction';
            DataClassification = CustomerContent;
        }
        field(99; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(101; "Area"; Code[10])
        {
            Caption = 'Area';
            DataClassification = CustomerContent;
            TableRelation = Area;
        }
        field(102; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            DataClassification = CustomerContent;
            TableRelation = "Transaction Specification";
        }
        field(104; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(109; "Receiving No. Series"; Code[10])
        {
            Caption = 'Receiving No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(114; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            DataClassification = CustomerContent;
            TableRelation = "Tax Area";
        }
        field(115; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            DataClassification = CustomerContent;
        }
        field(116; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "VAT Business Posting Group";
        }
        field(118; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                TempVendLedgEntry: Record "Savings Ledger Entry";
            begin
            end;
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            var
                ChangeLogMgt: Codeunit "Change Log Management";
                RecRef: RecordRef;
                xRecRef: RecordRef;
            begin
            end;
        }
        field(120; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Closed,Cancelled,Stopped,,"Under Evaluation","Awarded","Quotations Received";
        }
        field(121; "Invoice Discount Calculation"; Option)
        {
            Caption = 'Invoice Discount Calculation';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(123; "Send IC Document"; Boolean)
        {
            Caption = 'Send IC Document';
            DataClassification = CustomerContent;
        }
        field(124; "IC Status"; Option)
        {
            Caption = 'IC Status';
            DataClassification = CustomerContent;
            OptionCaption = 'New,Pending,Sent';
            OptionMembers = New,Pending,Sent;
        }
        field(125; "Buy-from IC Partner Code"; Code[20])
        {
            Caption = 'Buy-from IC Partner Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(126; "Pay-to IC Partner Code"; Code[20])
        {
            Caption = 'Pay-to IC Partner Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(129; "IC Direction"; Option)
        {
            Caption = 'IC Direction';
            DataClassification = CustomerContent;
            OptionCaption = 'Outgoing,Incoming';
            OptionMembers = Outgoing,Incoming;
        }
        field(130; "Awarded Vendor No."; Code[20])
        {
            Caption = 'Awarded Vendor No.';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
            Editable = false;
        }
        field(131; "Evaluation Report"; Text[250])
        {
            Caption = 'Evaluation Report';
            DataClassification = CustomerContent;
        }
        field(151; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(152; "External Requisition No."; Code[20])
        {
            Caption = 'External Requisition No.';
            DataClassification = CustomerContent;
            TableRelation = "External Requisition Header";
        }
        field(5043; "No. of Archived Versions"; Integer)
        {
            //CalcFormula = max("Purchase Header Archive"."Version No." where("Document Type" = field("Document Type"),
            //                                                               "No." = field("No."),
            //                                                             "Doc. No. Occurrence" = field("Doc. No. Occurrence")));
            Caption = 'No. of Archived Versions';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
            DataClassification = CustomerContent;
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            DataClassification = CustomerContent;
            TableRelation = Campaign;
        }
        field(5052; "Buy-from Contact No."; Code[20])
        {
            Caption = 'Buy-from Contact No.';
            DataClassification = CustomerContent;
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
            end;

            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
            end;
        }
        field(5053; "Pay-to Contact No."; Code[20])
        {
            Caption = 'Pay-to Contact No.';
            DataClassification = CustomerContent;
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
            end;

            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
            end;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
        }
        field(5752; "Completely Received"; Boolean)
        {
            //CalcFormula = min("Purchase Line"."Completely Received" where("Document Type" = field("Document Type"),
            //                                                             "Document No." = field("No."),
            //                                                           Type = filter(<> " "),
            //                                                         "Location Code" = field("Location Filter")));
            Caption = 'Completely Received';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(5753; "Posting from Whse. Ref."; Integer)
        {
            Caption = 'Posting from Whse. Ref.';
            DataClassification = CustomerContent;
        }
        field(5754; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(5790; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
            DataClassification = CustomerContent;
        }
        field(5791; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';
            DataClassification = CustomerContent;
        }
        field(5792; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
            DataClassification = CustomerContent;
        }
        field(5793; "Inbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';
            DataClassification = CustomerContent;
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5801; "Return Shipment No."; Code[20])
        {
            Caption = 'Return Shipment No.';
            DataClassification = CustomerContent;
        }
        field(5802; "Return Shipment No. Series"; Code[10])
        {
            Caption = 'Return Shipment No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(5803; Ship; Boolean)
        {
            Caption = 'Ship';
            DataClassification = CustomerContent;
        }
        field(5804; "Last Return Shipment No."; Code[20])
        {
            Caption = 'Last Return Shipment No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Return Shipment Header";
        }
        field(9000; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
        }
        field(50000; "Email Sent To Vendors"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "Email Sent To Vendors By"; Code[30])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50002; "Email Sent To Vendors On"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50003; Awarded; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50004; "Awarded By"; Code[30])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50005; "Awarded On"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50006; "Evaluation Matrix Type"; Option)
        {
            Caption = 'Evaluation Matrix Type';
            OptionMembers = RFQ,RFP;
            OptionCaption = 'RFQ,RFP';
            DataClassification = CustomerContent;
        }
        field(50007; "Budget/Base Amount"; Decimal)
        {
            Caption = 'Budget/Base Amount';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            DecimalPlaces = 0 : 5;
        }
        field(50008; "Scoring Document Type"; Option)
        {
            Caption = 'Scoring Document Type';
            OptionMembers = GoodsRFQ,ServicesRFP;
            OptionCaption = 'Goods (RFQ),Services (RFP)';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Scoring Document Type" = "Scoring Document Type"::GoodsRFQ then
                    "Evaluation Matrix Type" := "Evaluation Matrix Type"::RFQ
                else
                    "Evaluation Matrix Type" := "Evaluation Matrix Type"::RFP;
            end;
        }

        field(39004240; Copied; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(39004241; "Debit Note"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(39004243; "PRF No"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase requistion no';
            TableRelation = "Purchase Header"."No." where("Document Type" = const("Purchase Requisition"),
                                                           Status = filter(Released));


            trigger OnValidate()
            var
                PurchaseHeader: Record "Purchase Header";
            begin
                if "PRF No" <> xRec."PRF No" then
                    TestField("Email Sent To Vendors", false);
                TestField(Status, Status::Open
                );
                TestField(Awarded, false);
                if Confirm('By selecting the requisition number,you will delete and update the lines. Do you want to continue.') then
                    AutoPopPurchLine;
                PurchaseHeader.Reset();
                PurchaseHeader.SetRange("No.", "PRF No");
                if PurchaseHeader.FindFirst() then
                    "Posting Description" := PurchaseHeader."Posting Description";
            end;
        }
        field(39004244; "Released By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(39004245; "Release Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(39005536; Cancelled; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(39005537; "Cancelled By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(39005538; "Cancelled Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(39005539; DocApprovalType; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Purchase,Requisition,Quote;
        }
        field(39005556; "Internal Requisition No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header"."No." where(Status = filter(Released));

            trigger OnValidate()
            var
                PHeader: Record "Purchase Header";
            begin
                //CHECK WHETHER HAS LINES AND DELETE
                if not Confirm('If you change the Request for Quote No. the current lines will be deleted. Do you want to continue?', false)
                then
                    Error('You have selected to abort the process');

                RFQLine.Reset;
                RFQLine.SetRange(RFQLine."Document No.", "No.");
                RFQLine.DeleteAll;

                if PHeader.Get(Rec."Document Type", Rec."Internal Requisition No.") then;

                PurchaseLine.Reset;
                PurchaseLine.SetRange(PurchaseLine."Document No.", "Internal Requisition No.");
                if PurchaseLine.Find('-') then begin
                    repeat
                        RFQLine.Init;
                        RFQLine."Document Type" := "Document Type";
                        RFQLine."Document No." := "No.";
                        RFQLine."Line No." := PurchaseLine."Line No.";
                        RFQLine.Type := PurchaseLine.Type;
                        RFQLine."No." := PurchaseLine."No.";
                        RFQLine.Description := PurchaseLine.Description;
                        //RFQLine."Expense Code":=PurchaseLine."Expense Code";
                        RFQLine.Validate("No.");
                        RFQLine."Location Code" := PurchaseLine."Location Code";
                        RFQLine.Validate("Location Code");
                        RFQLine."Unit of Measure" := PurchaseLine."Unit of Measure";
                        RFQLine.Validate("Unit of Measure");
                        RFQLine.Validate(Quantity, PurchaseLine.Quantity);
                        RFQLine.Validate("Shortcut Dimension 1 Code", PHeader."Shortcut Dimension 1 Code");
                        RFQLine.Validate("Shortcut Dimension 2 Code", PHeader."Shortcut Dimension 2 Code");
                        RFQLine."Direct Unit Cost" := PurchaseLine."Direct Unit Cost";
                        RFQLine.Validate("Direct Unit Cost");
                        RFQLine.Amount := PurchaseLine.Amount;
                        RFQLine.Insert;
                    until PurchaseLine.Next = 0;
                end;
            end;
        }
        field(99008500; "Date Received"; Date)
        {
            Caption = 'Date Received';
            DataClassification = CustomerContent;
        }
        field(99008501; "Time Received"; Time)
        {
            Caption = 'Time Received';
            DataClassification = CustomerContent;
        }
        field(99008504; "BizTalk Purchase Quote"; Boolean)
        {
            Caption = 'BizTalk Purchase Quote';
            DataClassification = CustomerContent;
        }
        field(99008505; "BizTalk Purch. Order Cnfmn."; Boolean)
        {
            Caption = 'BizTalk Purch. Order Cnfmn.';
            DataClassification = CustomerContent;
        }
        field(99008506; "BizTalk Purchase Invoice"; Boolean)
        {
            Caption = 'BizTalk Purchase Invoice';
            DataClassification = CustomerContent;
        }
        field(99008507; "BizTalk Purchase Receipt"; Boolean)
        {
            Caption = 'BizTalk Purchase Receipt';
            DataClassification = CustomerContent;
        }
        field(99008508; "BizTalk Purchase Credit Memo"; Boolean)
        {
            Caption = 'BizTalk Purchase Credit Memo';
            DataClassification = CustomerContent;
        }
        field(99008509; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
            DataClassification = CustomerContent;
        }
        field(99008510; "Time Sent"; Time)
        {
            Caption = 'Time Sent';
            DataClassification = CustomerContent;
        }
        field(99008511; "BizTalk Request for Purch. Qte"; Boolean)
        {
            Caption = 'BizTalk Request for Purch. Qte';
            DataClassification = CustomerContent;
        }
        field(99008512; "BizTalk Purchase Order"; Boolean)
        {
            Caption = 'BizTalk Purchase Order';
            DataClassification = CustomerContent;
        }
        field(99008520; "Vendor Quote No."; Code[20])
        {
            Caption = 'Vendor Quote No.';
            DataClassification = CustomerContent;
        }
        field(99008521; "BizTalk Document Sent"; Boolean)
        {
            Caption = 'BizTalk Document Sent';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document Type", "No.", "Posting Description", "PRF No")
        {
        }
       

    }

    trigger OnInsert()
    var
        NSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";

    begin

        if "No." = '' then begin
            NSetup.Get;
            NSetup.TestField("RFQ Nos");
            "No." := NoSeries.GetNextNo(NSetup."RFQ Nos", WorkDate(), true);
        end;
    end;

    var
        PurchSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        location: Record Location;
        RFQLine: Record "RFQ Line";
        UserSetup: Record "User Setup";
        PurchaseLine: Record "Purchase Line";


    procedure AutoPopPurchLine()
    var
        RFQLine: Record "RFQ Line";
        LineNo: Integer;
        reqLine: Record "Purchase Line";
    begin
        RFQLine.Reset;
        RFQLine.SetRange("Document Type", "Document Type");
        RFQLine.SetRange("Document No.", "No.");
        RFQLine.DeleteAll;


        reqLine.Reset;
        reqLine.SetRange(reqLine."Document No.", "PRF No");
        if reqLine.Find('-') then begin
            RFQLine.Init;
            repeat
                if reqLine.Quantity <> 0 then begin
                    LineNo := LineNo + 1000;
                    RFQLine."Document Type" := "Document Type";
                    RFQLine.Validate("Document Type");
                    RFQLine."Document No." := "No.";
                    RFQLine.Validate("Document No.");
                    RFQLine."Line No." := LineNo;
                    RFQLine.Type := reqLine.Type;
                    //RFQLine."Expense Code":=reqLine."Expense Code";    //Denno added---
                    RFQLine."No." := reqLine."No.";
                    RFQLine."PRF No" := "PRF No";
                    RFQLine.Validate("No.");
                    RFQLine.Description := reqLine.Description;
                    RFQLine.Quantity := reqLine.Quantity;
                    RFQLine.Validate(Quantity);
                    RFQLine."Unit of Measure Code" := reqLine."Unit of Measure Code";
                    RFQLine.Validate("Unit of Measure Code");
                    RFQLine."Unit of Measure" := reqLine."Unit of Measure";
                    RFQLine."Direct Unit Cost" := reqLine."Direct Unit Cost";
                    RFQLine.Validate("Direct Unit Cost");
                    RFQLine."Location Code" := reqLine."Location Code";
                    RFQLine."Location Code" := "Location Code";
                    RFQLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                    RFQLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                    RFQLine.Insert(true);
                end
            until reqLine.Next = 0;
        end;
    end;
}

