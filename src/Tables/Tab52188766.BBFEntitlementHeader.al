table 50448 "BBF Entitlement Header"
{

    DrillDownPageId = "BBF Entitlements List";
    LookupPageId = "BBF Entitlements List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; Date; Date)
        {
            Editable = false;
        }
        field(3; "Captured By"; Code[30])
        {
            Editable = false;
        }
        field(4; Amount; Decimal)
        {
            CalcFormula = sum("BBF Entitlement Lines"."BBF Entitlement Claimed" where("Header No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Member No"; Code[20])
        {
            TableRelation = Members."No.";

            trigger OnValidate()
            var
                BBFLines: Record "BBF Entitlement Lines";
                Kin: Record "Next of Kin.";
                i: Integer;
            begin
                if Members.Get("Member No") then begin
                    "Account Name" := Members.Name;
                end else begin
                    "Account Name" := '';
                end;

                BBFLines.Reset;
                BBFLines.SetRange("Header No", "No.");
                if BBFLines.Find('-') then
                    BBFLines.DeleteAll;

                KIN.Reset();
                KIN.SetRange("No.", "Member No");
                KIN.SetRange(Beneficiary, true);
                if KIN.FindFirst() then begin
                    repeat
                        BBFLines.Reset();
                        if BBFLines.FindLast() then;

                        BBFRequisationLines.Init;
                        BBFRequisationLines."Header No" := "No.";
                        BBFRequisationLines.Name := KIN.Name;
                        BBFRequisationLines."Entry No." := BBFLines."Entry No." + 1;
                        BBFRequisationLines."Date of Birth" := KIN."Date of Birth";
                        BBFRequisationLines."%Allocation" := KIN."%Allocation";
                        BBFRequisationLines."Requisation No." := "No.";
                        BBFRequisationLines."ID No." := KIN."ID No.";
                        BBFRequisationLines."Account No." := SavingsAccounts."No.";
                        BBFRequisationLines."Next of Kin" := KIN.Relationship;
                        BBFRequisationLines.Validate("Next of Kin");
                        BBFRequisationLines.Type := BBFRequisationLines.Type::"Benevolent Beneficiary";
                        BBFRequisationLines."Claim Type" := BBFRequisationLines."Claim Type"::Death;

                        BBFEntitlement.Reset;
                        BBFEntitlement.SetRange(Entitlement, KIN.Relationship);
                        if BBFEntitlement.Find('-') then begin
                            BBFRequisationLines."BBF Entitlement Code" := BBFEntitlement.Code;
                            BBFRequisationLines."BBF Entitlement Claimed" := BBFEntitlement.Amount;
                            BBFRequisationLines.Relationship := BBFEntitlement.Description;
                        end;

                        BBFRequisationLines.Insert(true);
                    until KIN.Next() = 0;
                end;
            end;
        }
        field(6; "Account Name"; Text[50])
        {
        }
        field(7; "Responsibility Center"; Code[30])
        {
            TableRelation = "Responsibility Center";
        }
        field(9; "No. Series"; Code[20])
        {
        }
        field(10; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(11; Payed; Boolean)
        {
        }
        field(12; Posted; Boolean)
        {
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(15; "Payment Release Date"; Date)
        {
        }
        field(16; "Bank Account No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAcc: Record "Bank Account";
            begin
                BankAcc.Reset;
                BankAcc.SetRange("No.", "Bank Account No.");
                if BankAcc.FindFirst then "Bank Account Name" := BankAcc.Name;
            end;
        }
        field(17; "Bank Account Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }


        field(19; "Collector Name"; Text[100])
        {
        }
        field(20; "Collector ID"; Code[20])
        {
        }
        field(21; "Collector Mobile No."; Code[13])
        {
        }
        field(22; "Collector Relationship"; Text[30])
        {
            Description = 'LookUp to Relationships Table';
            TableRelation = Relationship;
        }
        field(23; "Last Contribution Date"; Date)
        {
        }
        field(24; "Date of Demise"; Date)
        {
        }

        field(26; "Pay Mode"; Option)
        {
            OptionCaption = ' ,Cash,Cheque,EFT,Letter of Credit,Mpesa,FOSA';
            OptionMembers = " ",Cash,Cheque,EFT,"Letter of Credit",Mpesa,FOSA;
        }
        field(27; "Paying Bank"; code[20])
        {
            Caption = 'Paying Account';
            TableRelation = if ("Pay Mode" = const(FOSA)) "Savings Accounts" where("Product Category" = const("Ordinary Savings"))
            else
            "Bank Account";
        }

        field(28; "Cheque No."; Code[20])
        {
            Caption = 'Cheque/EFT No';

            trigger OnValidate()
            begin
                if "Pay Mode" = "Pay Mode"::Cash then begin
                    Error('You CANNOT insert cheque No. If the Pay Mode is Cash');
                end;
            end;
        }

        field(51200; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = true;
            TableRelation = "Dimension Set Entry";
            trigger OnLookup()
            var
                OldDimSetID: Integer;
                IsHandled: Boolean;
                DimMgt: Codeunit DimensionManagement;
            begin

                OldDimSetID := "Dimension Set ID";
                "Dimension Set ID" :=
                  DimMgt.EditDimensionSet(
                    Rec, "Dimension Set ID", "No.", "Global Dimension 1 Code", "Global Dimension 2 Code");

                //IsChanged := OldDimSetID <> "Dimension Set ID";
            end;

            trigger OnValidate()
            var
                DimMgt: Codeunit DimensionManagement;
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
            end;
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
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."BBF Claims");
            "No." := NoSeries.GetNextNo(SeriesSetup."BBF Claims", WorkDate(), true);
        end;

        UserSetup.Get(UserId);
        // "Responsibily Center" := UserSetup."Responsibility Centre";
        "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        "Captured By" := UserId;
        Date := Today;

        "Payment Release Date" := Today;

        if UserSetup."BBF Claim" = false then
            Error(Text001)
    end;

    var
        Err001: label 'Claim has already been raised';
        Text001: Label 'You do not have the permission to capture & process GFE Claim.';
        SeriesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        Members: Record Members;
        Loans: Record Loans;
        BBFRequisationLines: Record "BBF Entitlement Lines";
        EntryNo: Integer;
        SavingsAccounts: Record "Savings Accounts";
        BBFEntitlement: Record "BBF Entitlement";
        DimVal: Record "Dimension Value";
        ProductFactory: Record "Product Setup";
        BBFRequisationHeader: Record "BBF Entitlement Header";
}
