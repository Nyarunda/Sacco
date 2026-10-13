
Table 50125 "Loan Collateral Register"
{
    LookupPageID = "Collateral List";

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            /*  trigger OnValidate()
             begin
                 if "No." <> xRec."No." then begin
                     SalesSetup.Get;
                     NoSeries.TestManual(SalesSetup."Loan Security Nos.");
                     "No. Series" := '';
                 end;
             end; */
        }
        field(5; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(8; "Account No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
            TableRelation = Members;

            trigger OnValidate()
            begin
                if CusMembr.Get("Account No.") then
                    "Account Name" := CusMembr.Name;
            end;
        }
        field(9; "Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Collateral Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Title Deed,Motor Vehicle, NSE Shares,Money Market Fund,Insurance,Fixed Deposit External';
            OptionMembers = " ","Title Deed","Motor Vehicle","NSE Shares","Money Market Fund",Insurance,"Fixed Deposit External";
            ValuesAllowed = " ", "Title Deed", "Motor Vehicle", "NSE Shares", "Money Market Fund", Insurance, "Fixed Deposit External";
            trigger onvalidate()
            begin
                Collateral := '';
                "Collateral Name" := '';
                "Collateral Multiplier" := 0;
                "Collateral Limit" := 0;
                "Charged Value" := 0;
            end;
        }
        field(11; Collateral; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Collateral Setup".Code where(Type = field("Collateral Type"));

            trigger OnValidate()
            begin
                if SecurityRegSetUp.Get(Collateral) then begin
                    if SecurityRegSetUp.Blocked then
                        Error(Text001);

                    "Collateral Name" := SecurityRegSetUp.Description;
                    "Collateral Multiplier" := SecurityRegSetUp."Collateral Multiplier";
                    "Collateral Limit" := "Collateral Value" * ("Collateral Multiplier" / 100);
                    "Charged Value" := "Collateral Limit";
                    "Valuation Type" := SecurityRegSetUp."Valuation Type";
                    UpdateChargeExemptionRequirement();
                end;
            end;
        }
        field(12; "Collateral Name"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Collateral Multiplier"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Collateral Value"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Collateral Limit" := "Collateral Value" * ("Collateral Multiplier" / 100);
                UpdateChargeExemptionRequirement();
            end;
        }
        field(17; "Collateral Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Max. amount Collateral can cover against loan';
            Editable = false;
        }
        field(29; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected,Returned';
            OptionMembers = Open,Pending,Approved,Rejected,Returned;

            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    "Inward/Outward" := "inward/outward"::"In-Store";
                end;
            end;
        }
        field(30; "Inward/Outward"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,In-Store,Returned';
            OptionMembers = " ","In-Store",Returned;
        }
        field(31; "Last Valuation Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GenSetup.Get;
                if "Last Valuation Date" <> 0D then begin
                    if "Last Valuation Date" > Today then
                        Error(Text004);
                    GenSetup.TestField("Maximum Valuation Period");
                    if CalcDate(GenSetup."Maximum Valuation Period", "Last Valuation Date") < Today then
                        Error(Text003, GenSetup."Maximum Valuation Period");
                    SecurityRegSetUp.Reset;
                    SecurityRegSetUp.SetRange(SecurityRegSetUp.Type, "Collateral Type");
                    if SecurityRegSetUp.Find('-') then begin
                        if Format(SecurityRegSetUp."Revaluation Frequency") <> '' then
                            "Next Valuation Date" := CalcDate(SecurityRegSetUp."Revaluation Frequency", "Last Valuation Date");
                    end;
                end;
            end;
        }
        field(32; "Forced Sale Value"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Text001: label 'Forced sale value cannot be more than collateral limit';
            begin
                if "Forced Sale Value" > "Collateral Limit" then
                    Error(Text005, "Collateral Limit");
            end;
        }
        field(33; "Collateral Perfected"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Next Valuation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Collateral Details"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Registered Owner"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Re-Opened By"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(39; "Date Re-Opened"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Insurance Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Valuation Type"; Option)
        {
            Editable = false;
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Appreciating,Depreciating';
            OptionMembers = " ",Appreciating,Depreciating;
        }
        field(42; "Legally Cleared"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(44; "Charged Value"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                UpdateChargeExemptionRequirement();

                // if "Charged Value" > "Collateral Limit" then
                //     Error('"Charged Value" cannot be greater than "Collateral Limit"');
            end;
        }
        field(45; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(46; "Collection Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(47; "Collector ID No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Collector Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Collector Phone No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Date Collected"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Mark For Collection"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Power of Attorney"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(53; "Vehicle Class"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vehicle Class Category";
        }
        field(54; "Vehicle Reg. No."; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(55; "Plot Location"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(56; "Plot No."; Code[80])
        {
            DataClassification = ToBeClassified;

        }
        field(57; "Collateral Description"; Code[80])
        {
            DataClassification = ToBeClassified;

        }
        field(58; "Serial No."; code[50])
        {
        }
        field(59; "Year of Purchase"; code[10])
        {
            Caption = 'Year of Manufacture';

            trigger OnValidate()
            var
                YearOfManufacture: Integer;
                CurrentYear: Integer;
                YearDifference: Integer;
            begin
                if Rec."Year of Purchase" <> '' then begin
                    if not Evaluate(YearOfManufacture, Rec."Year of Purchase") then
                        Error('Please enter a valid year.');

                    CurrentYear := Date2DMY(Today, 3);
                    YearDifference := CurrentYear - YearOfManufacture;

                    // if YearDifference > 8 then
                    //     Error('Year of Manufacture cannot be more than 8 years old. Maximum allowed year is %1.', CurrentYear - 8);

                    if YearOfManufacture > CurrentYear then
                        Error('Year of Manufacture cannot be in the future.');
                end;
            end;
        }
        field(60; "Chasis No."; code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Loan No."; code[20])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Loan Security"."Loan No." where("Collateral Reg. No." = field("No.")));

        }
        field(62; Make; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Tracker ID"; Text[60])
        {
            DataClassification = ToBeClassified;
        }

        field(64; Insurance; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Title Name"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(66; Location; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(67; Company; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Face Value"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Bond Details"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70; Institution; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(71; Lawyer; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(72; "Cash Conversion Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Trucker Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(74; Valuer; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(75; "Valuer Code"; code[30])
        {
            TableRelation = vendor;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                Vend.get("Valuer Code");
                Valuer := Vend.Name;
            end;
        }
        field(77; "Lawyer Code"; code[30])
        {
            TableRelation = vendor;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                Vend.get("Lawyer Code");
                Lawyer := Vend.Name;
            end;
        }
        field(79; "Insurance Expiry Reminder"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Captured By"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(81; "Discharged By"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Collateral Collection"."Cleared By" where("Collateral No." = field("No."));
        }
        field(82; "Date Discharged"; Date)
        {
            FieldClass = FlowField;
            Caption = 'Date Collected/Discharged';
            Editable = false;
            CalcFormula = lookup("Collateral Collection"."Date Collected" where("Collateral No." = field("No.")));
        }
        field(83; "Date Captured"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(84; "Approved By"; Code[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = max("Approval Entry"."Approver ID" where("Document No." = field("No.")));
        }

        field(86; "Insurance Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            Var
                GenSetup: Record "Loan Collateral Setup";
            begin
                GenSetup.Reset();
                GenSetup.SetRange(GenSetup.Type, "Collateral Type");
                if GenSetup.FindFirst() then
                    "Insurance Expiry Date" := CalcDate(GenSetup."Revaluation Frequency", "Insurance Start Date");
            end;
        }
        field(87; "Insurance Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(88; "Tracking Installation Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Tracking Installation Date" = 0D then
                    Clear("Trucker Expiry Date")
                else
                    "Trucker Expiry Date" := CalcDate('<1Y>', "Tracking Installation Date");

            end;
        }
        field(89; "Third-party Collateral"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Mobile No."; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(91; Email; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(92; "Charge Exemption Required"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(93; "Charge Exemption Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(94; "Charge Exemption Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Rejected;
            Editable = false;
        }
        field(95; "Charge Exemption Requested By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup";
        }
        field(96; "Charge Exemption Requested On"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(97; "Charge Exemption Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup";
        }
        field(98; "Charge Exemption Approved On"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(99; "Insurance Details"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }



    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Loan Security Nos.");
            "No." := NoSeries.GetNextNo(SalesSetup."Loan Security Nos.", WorkDate(), true);
        end;

        "Captured By" := UserId;
        "Date Captured" := Today;
        "Legally Cleared" := true;
        "Charge Exemption Status" := "Charge Exemption Status"::Open;
        UpdateChargeExemptionRequirement();
    end;

    trigger OnModify()
    begin
        /*if (Status = Status::Approved) or (Status = Status::Pending) then
            Error(Text002, Status); */
    end;


    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        CusMembr: Record Members;
        SecurityRegSetUp: Record "Loan Collateral Setup";
        GenSetup: Record "Sacco Setup";
        Text001: label 'This collateral is blocked thus not avaialable for use.';
        Text002: label 'This application is %1 thus cannot modify.';
        Text003: label 'The last valuation day is more than %1 hence is invalid';
        Text004: label 'Last valuation date cannot be greater than today';
        Text005: label 'The forced sale value cannot be greater than collateral maximum limit of %1';

    local procedure IsChargeExemptionRequiredByPolicy(): Boolean
    var
        ChargedPercentage: Decimal;
    begin
        if ("Collateral Value" <= 0) or ("Charged Value" <= 0) then
            exit(false);

        ChargedPercentage := ("Charged Value" / "Collateral Value") * 100;
        exit(ChargedPercentage > "Collateral Multiplier");
    end;

    procedure UpdateChargeExemptionRequirement()
    var
        RequireExemption: Boolean;
    begin
        RequireExemption := IsChargeExemptionRequiredByPolicy();
        "Charge Exemption Required" := RequireExemption;

        if not RequireExemption then begin
            "Charge Exemption Status" := "Charge Exemption Status"::Open;
            Clear("Charge Exemption Comment");
            Clear("Charge Exemption Requested By");
            Clear("Charge Exemption Requested On");
            Clear("Charge Exemption Approved By");
            Clear("Charge Exemption Approved On");
            exit;
        end;

        if "Charge Exemption Status" = "Charge Exemption Status"::Approved then begin
            "Charge Exemption Status" := "Charge Exemption Status"::Open;
            Clear("Charge Exemption Approved By");
            Clear("Charge Exemption Approved On");
        end;
    end;

    procedure SendChargeExemptionForApproval()
    var
        UserSetup: Record "User Setup";
    begin
        if not "Charge Exemption Required" then
            Error('Charge exemption is not required for this collateral.');

        if "Charge Exemption Status" = "Charge Exemption Status"::Approved then
            Error('Charge exemption has already been approved.');

        UserSetup.Get(UserId);
        UserSetup.TestField("Collateral Exempt Approver");
        if UserSetup."Collateral Exempt Approver" = UserId then
            Error('Maker-checker violation: the exemption approver cannot be the same user sending the request.');

        TestField("Charge Exemption Comment");

        "Charge Exemption Status" := "Charge Exemption Status"::Pending;
        "Charge Exemption Requested By" := UserId;
        "Charge Exemption Requested On" := CurrentDateTime;
        Clear("Charge Exemption Approved By");
        Clear("Charge Exemption Approved On");
    end;

    procedure ApproveChargeExemption()
    var
        RequesterSetup: Record "User Setup";
    begin
        TestField("Charge Exemption Required", true);
        TestField("Charge Exemption Status", "Charge Exemption Status"::Pending);
        TestField("Charge Exemption Requested By");

        if "Charge Exemption Requested By" = UserId then
            Error('Maker-checker violation: requester cannot approve own exemption request.');

        RequesterSetup.Get("Charge Exemption Requested By");
        RequesterSetup.TestField("Collateral Exempt Approver");
        if RequesterSetup."Collateral Exempt Approver" <> UserId then
            Error('You are not configured as the collateral exemption approver for user %1.', "Charge Exemption Requested By");

        "Charge Exemption Status" := "Charge Exemption Status"::Approved;
        "Charge Exemption Approved By" := UserId;
        "Charge Exemption Approved On" := CurrentDateTime;
    end;

    procedure RejectChargeExemption()
    var
        RequesterSetup: Record "User Setup";
    begin
        TestField("Charge Exemption Required", true);
        TestField("Charge Exemption Status", "Charge Exemption Status"::Pending);
        TestField("Charge Exemption Requested By");

        if "Charge Exemption Requested By" = UserId then
            Error('Maker-checker violation: requester cannot reject own exemption request.');

        RequesterSetup.Get("Charge Exemption Requested By");
        RequesterSetup.TestField("Collateral Exempt Approver");
        if RequesterSetup."Collateral Exempt Approver" <> UserId then
            Error('You are not configured as the collateral exemption approver for user %1.', "Charge Exemption Requested By");

        "Charge Exemption Status" := "Charge Exemption Status"::Rejected;
        Clear("Charge Exemption Approved By");
        Clear("Charge Exemption Approved On");
    end;

    procedure ReOpenChargeExemption()
    var
        UserSetup: Record "User Setup";
    begin
        TestField("Charge Exemption Required", true);
        TestField("Charge Exemption Status", "Charge Exemption Status"::Approved);
        UserSetup.Get(UserId);
        UserSetup.TestField("Collateral Exempt Approver");
        if UserSetup."Collateral Exempt Approver" <> UserId then
            Error('You are not configured as the collateral exemption approver.');
    end;
}

