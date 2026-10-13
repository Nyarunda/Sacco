
Table 50180 "Collateral Collection"
{
    LookupPageID = "Collateral Return List";
    drilldownpageid = "Collateral Return List";

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeries.TestManual(SalesSetup."Loan Security Collection Nos.");
                    "No. Series" := '';
                end;
            end;
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
            OptionCaption = ' ,Real Estate,Plant and Equipment,Natural Reserves,Marketable Securities,Inventory,Motor Vehicle';
            OptionMembers = " ","Real Estate","Plant and Equipment","Natural Reserves","Marketable Securities",Inventory,"Motor Vehicle";
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
                "Collateral Limit" := "Collateral Value" * ("Collateral Multiplier" / 100)
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
            Var
                Sacco: Codeunit "Sacco Activities";
                FullString: Text[130];
                String: Text[50];
                Heading: Text[30];
                SalutationTxt: Text[50];
                Receiver: Text[45];
                RegardsTxt: Text[30];
                Msg: Text;
                Member: Record Members;
            begin
                if Status = Status::Approved then begin

                    "Inward/Outward" := "inward/outward"::Returned;
                    Status := Status::Returned;

                    CollSec.Get("Collateral No.");
                    CollSec.Status := CollSec.Status::Returned;
                    CollSec."Inward/Outward" := CollSec."inward/outward"::Returned;
                    CollSec.Modify;

                    String := '';
                    FullString := '';
                    SalutationTxt := '';
                    RegardsTxt := '';
                    Receiver := '';

                    Member.Get("Account No.");
                    Receiver := Member."E-Mail";
                    if Sacco.ValidEmailAddress(Receiver) then begin
                        String := SelectStr(1, Member.Name);

                        SalutationTxt := 'Dear' + ' ' + String + ',';

                        RegardsTxt := 'Kind Regards';

                        Msg := STRSUBSTNO('Your loan collateral has been discharged successfully. Thank you . %1', Format(Today));
                        Sacco.SendEmail(Receiver, '', '', 'Collateral Return', SalutationTxt, Msg);
                    end;
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

                if "Charged Value" > "Collateral Limit" then
                    Error('"Charged Value" cannot be greater than "Collateral Limit"');
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
        field(52; "Collateral No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Collateral Register" where("Inward/Outward" = const("In-Store"),
                                                              Status = const(Approved),
                                                              "Account No." = field("Account No."));

            trigger OnValidate()
            begin
                if CollSec.Get("Collateral No.") then begin
                    
                    // Only a commitment against a posted loan may prevent a collateral return.
                    // Loan-security entries created for completed appraisals remain in the
                    // register, but they are not active loan commitments.
                    LoanGua.Reset;
                    LoanGua.SetRange("Collateral Reg. No.", "Collateral No.");
                    LoanGua.SetRange(Substituted, false);
                    LoanGua.SetFilter("Current Committed", '>0');
                    if LoanGua.FindSet() then
                        repeat
                            if Loans.Get(LoanGua."Loan No.") and Loans.Posted then
                                Error('The collateral cannot be released because posted loan %1 has a current committed amount of %2.',
                                    LoanGua."Loan No.", LoanGua."Current Committed");
                        until LoanGua.Next() = 0;

                    /* LoanGua.Reset;
                    LoanGua.SetRange("Collateral Reg. No.", "Collateral No.");
                    LoanGua.SetRange(Substituted, false);
                    LoanGua.SetFilter("Outstanding Principal", '>0');
                    if LoanGua.Find('-') then begin
                        LoanGua.CalcFields("Outstanding Principal");
                        if LoanGua."Outstanding Principal" > 0 then
                            Error(Text006, LoanGua."Outstanding Principal");
                    end; */

                    /*
                    LoanGua.RESET;
                    LoanGua.SETRANGE("Member No",CollSec."Account No.");
                    LoanGua.SETFILTER("Outstanding Principal",'>0');
                    LoanGua.SETRANGE(Substituted,FALSE);
                    IF LoanGua.FIND('-') THEN BEGIN
                        REPEAT
                            IF Loans.GET(LoanGua."Loan No.") THEN BEGIN
                                IF Loans."Loans Category-SASRA"<>Loans."Loans Category-SASRA"::Perfoming THEN
                                    IF Loans."Loans Category-SASRA"<>Loans."Loans Category-SASRA"::Watch THEN
                                          ERROR('Member is guaranteeing Member No. %1 who is a defaulter',Loans."Member No.");
                            END;
                        UNTIL LoanGua.NEXT=0;
                    END;
                    */


                    "Account Name" := CollSec."Account Name";
                    "Account No." := CollSec."Account No.";
                    Collateral := CollSec.Collateral;
                    "Collateral Limit" := CollSec."Collateral Limit";
                    "Collateral Multiplier" := CollSec."Collateral Multiplier";
                    "Collateral Name" := CollSec."Collateral Name";
                    "Collateral Perfected" := CollSec."Collateral Perfected";
                    "Collateral Type" := CollSec."Collateral Type";
                    "Collateral Value" := CollSec."Collateral Value";
                    "Forced Sale Value" := CollSec."Forced Sale Value";
                    "Inward/Outward" := CollSec."Inward/Outward";
                    "Last Valuation Date" := CollSec."Last Valuation Date";
                    "Next Valuation Date" := CollSec."Next Valuation Date";
                    "Global Dimension 1 Code" := CollSec."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CollSec."Global Dimension 2 Code";
                    "Collateral Details" := CollSec."Collateral Details";
                    "Valuation Type" := CollSec."Valuation Type";
                    "Registered Owner" := CollSec."Registered Owner";
                    Remarks := CollSec.Remarks;
                    "Insurance Expiry Date" := CollSec."Insurance Expiry Date";
                    "Legally Cleared" := CollSec."Legally Cleared";

                end;

            end;
        }
        field(53; Reason; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Cleared By"; Code[70])
        {
            DataClassification = ToBeClassified;
        }
        field(55; Narration; text[200])
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
            SalesSetup.TestField(SalesSetup."Loan Security Collection Nos.");
            "No." := NoSeries.GetNextNo(SalesSetup."Loan Security Collection Nos.", WorkDate(), true);
        end;

        UserSetup.Get(UserId);
        if not UserSetup."Collateral Reg" then
            Error(Text009);
    end;

    trigger OnModify()
    begin
        if (Status = Status::Approved) or (Status = Status::Pending) then
            Error(Text002, Status);
        if (Status = Status::Approved) then begin
            "Cleared By" := UserId;
            if "Date Collected" = 0D then
                "Date Collected" := today;
            Modify;
        end;
    end;

    var
        UserSetup: Record "User Setup";
        Text009: Label 'You do not permission to create/view collateral. Please contact ICT';
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        CusMembr: Record Members;
        SecurityRegSetUp: Record "Loan Collateral Setup";
        GenSetup: Record "Sacco Setup";
        Text006: label 'The loan which was guaranteed using the collateral has a balance of %1';
        Text001: label 'This collateral is blocked thus not avaialable for use.';
        Text002: label 'This application is %1 thus cannot modify.';
        Text003: label 'The last valuation day is more than %1 hence is invalid';
        Text004: label 'Last valuation date cannot be greater than today';
        Text005: label 'The forced sale value cannot be greater than collateral maximum limit of %1';
        CollSec: Record "Loan Collateral Register";
        LoanGua: Record "Loan Security";
        Loans: Record Loans;
}

