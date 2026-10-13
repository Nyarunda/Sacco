table 50449 "BBF Entitlement Lines"
{
    // LookupPageID = "DCS Validation Matrix";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Member No"; Code[20])
        {
            Description = 'LookUp to Member Application Table';
            TableRelation = Members where("No." = field("Member No"));

            trigger OnValidate()
            begin
                if AccountM.Get("Member No") then
                    Name := AccountM.Name;
                AccountF.Reset;
                AccountF.SetRange("Member No.", "Member No");
                if AccountF.Find('-') then
                    "Account No." := AccountF."No.";
            end;
        }
        field(3; Name; Text[50])
        {
            Editable = false;
            NotBlank = true;
        }
        field(4; Relationship; Text[30])
        {
            Description = 'LookUp to Relationships Table';
            Editable = false;
            TableRelation = Relationship;
        }
        field(5; Beneficiary; Boolean)
        {
            Editable = false;
        }
        field(6; "Date of Birth"; Date)
        {
            Editable = false;

            trigger OnValidate()
            var
                DateofBirthError: label 'This date cannot be greater than today.';
            begin
                if "Date of Birth" > Today then
                    Error(DateofBirthError);
            end;
        }
        field(7; Address; Text[30])
        {
            Editable = false;
        }
        field(8; Telephone; Code[20])
        {
            CharAllowed = '0123456789';
            Editable = false;
        }
        field(9; Fax; Code[10])
        {
        }
        field(10; Email; Text[30])
        {
        }
        field(11; "ID No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                "ID No." := DelChr("ID No.", '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|+|-|_');
                FieldLength("ID No.", 10);
            end;
        }
        field(12; "%Allocation"; Decimal)
        {
            Editable = false;
            MinValue = 0;
        }
        field(13; Type; Option)
        {
            Editable = false;
            OptionCaption = 'Next of Kin,Spouse,Benevolent Beneficiary,Family Member';
            OptionMembers = "Next of Kin",Spouse,"Benevolent Beneficiary","Family Member";
        }
        field(14; Deceased; Boolean)
        {
            Editable = false;
        }
        field(15; "BBF Entitlement Code"; Code[10])
        {
            Editable = true;
            TableRelation = "BBF Entitlement".Code;

            trigger OnValidate()
            begin
                Rec.TestField("Claim Type");
                Rec.TestField("Relationship Type");
                BBFEntitlement.GET("BBF Entitlement Code");
                "BBF Entitlement Claimed" := BBFEntitlement.Amount;
                "BBF Entitlement Paid" := BBFEntitlement.Amount;
            end;
        }
        field(16; "BBF Entitlement Claimed"; Decimal)
        {
        }
        field(17; "Line No."; Code[50])
        {
            Editable = false;

        }
        field(18; "Account No."; Code[80])
        {
            Editable = false;
        }
        field(19; "Next of Kin"; Text[150])
        {

            trigger OnValidate()
            var
                Entitlement: Record "BBF Entitlement";
                MaxKinNo: Integer;
                ErrorOnMaxEntitlement: label 'Member has exhausted the Max. No. of -%1- entitlement under this category.Category is %2.';
                RunPeriodicTrans: Codeunit "Sacco Activities";
                SavingsAccounts: Record "Savings Accounts";
            begin
                KinDetails.Reset;
                KinDetails.SetRange(Name, "Next of Kin");
                if KinDetails.Find('-') then
                    // KinDetails.TestField("BBF Entitlement");
                    // KinDetails.TestField("BBF Entitlement Code");
                    Relationship := KinDetails.Relationship;
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Member No.", "Member No");
                SavingsAccounts.SetRange("Loan Disbursement Account", true);
                if SavingsAccounts.Find('-') then
                    "Account No." := SavingsAccounts."No.";
                // "BBF Entitlement Claimed" := KinDetails."BBF Entitlement";
                // "BBF Entitlement Code" := KinDetails."BBF Entitlement Code";
                Beneficiary := KinDetails.Beneficiary;
                "ID No." := KinDetails."ID No.";
                Deceased := KinDetails.Deceased;
                Type := KinDetails.Type;
                "Date of Birth" := KinDetails."Date of Birth";
                // Address := KinDetails.Address;

                if Entitlement.Get("BBF Entitlement Code") then begin

                    KinDetails.Reset;
                    KinDetails.SetRange(Relationship, Relationship);
                    KinDetails.SetRange(Deceased, true);
                    if KinDetails.Find('-') then
                        repeat
                            MaxKinNo := KinDetails.Count;
                        until KinDetails.Next = 0;

                    if MaxKinNo > Entitlement."Max No." then Error(ErrorOnMaxEntitlement, MaxKinNo, Relationship);
                end;
            end;
        }
        field(20; Posted; Boolean)
        {
        }
        field(21; "Header No"; Code[20])
        {
        }
        field(22; "Loan No."; Code[20])
        {
            TableRelation = Loans where("Loan Account" = field("Account No."));
        }
        field(23; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Loan,Repayment,Interest Due,Interest Paid,Bills,Appraisal';
            OptionMembers = " ",Loan,Repayment,"Interest Due","Interest Paid",Bills,Appraisal;
        }
        field(24; "Requisation No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "BBF Entitlement Paid"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "BBF Entitlement Paid" > "BBF Entitlement Claimed" then Error(Err0001);
                Difference := "BBF Entitlement Claimed" - "BBF Entitlement Paid";
            end;
        }
        field(26; Difference; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(27; "Relationship Type"; Option)
        {
            OptionCaption = '  ,Principal Member, Beneficiary';
            OptionMembers = "  ","Principal Member",Beneficiary;

            trigger OnValidate()
            var
                BBFRequisationLines: Record "BBF Entitlement Lines";
                BBFLines: Record "BBF Entitlement Lines";
                BBFRequisationHeader: Record "BBF Entitlement Header";
                NOK: Record "Next of Kin.";
            begin
                /*BBFRequisationLines.Reset;
                BBFRequisationLines.SetRange("Header No", "No.");
                if BBFRequisationLines.Find('-') then
                    BBFRequisationLines.DeleteAll;

                if "Relationship Type" = "Relationship Type"::"Principal Member" then begin
                    BBFRequisationHeader.Reset;
                    BBFRequisationHeader.SetRange("Member No", "Member No");
                    BBFRequisationHeader.SetRange(Type, BBFRequisationHeader.Type::"Principal Member");
                    if BBFRequisationHeader.Find('-') then error(Err001);

                    begin
                        BBFRequisationLines.Init;
                        BBFRequisationLines."Header No" := "No.";
                        BBFRequisationLines."Member No" := "Member No";
                        BBFRequisationLines.Validate("Member No");
                        BBFRequisationLines."Account No." := "Account Name";
                        BBFRequisationLines."Transaction Type" := BBFRequisationLines."transaction type"::" ";
                        BBFEntitlement.Reset;
                        BBFEntitlement.SetRange(code, 'SELF');
                        if BBFEntitlement.Find('-') then begin
                            BBFRequisationLines."BBF Entitlement Code" := BBFEntitlement.Code;
                            BBFRequisationLines."BBF Entitlement Claimed" := BBFEntitlement.Amount;
                            BBFRequisationLines.Relationship := BBFEntitlement.Description;
                        end;
                        BBFRequisationLines.Insert();

                    end
                end else */
                if "Relationship Type" = "Relationship Type"::Beneficiary then begin

                    /*BBFRequisationLines.Reset;
                    BBFRequisationLines.SetRange("Header No", "No.");
                    if BBFRequisationLines.Find('-') then BBFRequisationLines.DeleteAll;

                    NOK.Reset();
                    NOK.SetRange("No.", "Member No");
                    NOK.SetRange(Beneficiary, true);
                    if NOK.FindFirst() then begin
                        repeat
                            BBFLines.Reset();
                            if BBFLines.FindLast() then;

                            BBFRequisationLines.Init;
                            BBFRequisationLines."Header No" := "No.";
                            BBFRequisationLines.Name := NOK.Name;
                            BBFRequisationLines."Entry No." := BBFLines."Entry No." + 1;
                            BBFRequisationLines."Date of Birth" := NOK."Date of Birth";
                            BBFRequisationLines."%Allocation" := NOK."%Allocation";
                            BBFRequisationLines."Requisation No." := "No.";
                            BBFRequisationLines."ID No." := NOK."ID No.";
                            BBFRequisationLines."Account No." := SavingsAccounts."No.";
                            BBFRequisationLines."Next of Kin" := NOK.Relationship;
                            BBFRequisationLines.Validate("Next of Kin");
                            BBFRequisationLines.Type := BBFRequisationLines.Type::"Benevolent Beneficiary";
                            BBFEntitlement.Reset;
                            BBFEntitlement.SetRange(Entitlement, NOK.Relationship);
                            if BBFEntitlement.Find('-') then begin
                                BBFRequisationLines."BBF Entitlement Code" := BBFEntitlement.Code;
                                BBFRequisationLines."BBF Entitlement Claimed" := BBFEntitlement.Amount;
                                BBFRequisationLines.Relationship := BBFEntitlement.Description;
                            end;
                            BBFRequisationLines.Insert(true);
                        until NOK.Next() = 0;
                    end;*/

                end;
            end;
        }

        field(29; "Claim Type"; Enum "BBF Claim Type")
        {

        }
        field(30; "Death Certificate No."; code[50])
        {
            Caption = 'Death Certificate/ Burial Permit No.';
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Header No")
        {
            Clustered = true;
            SumIndexFields = "%Allocation";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        // BHeader.Reset;
        // BHeader.SetRange("No.", "Line No.");
        // BHeader.SetFilter(Status, '<>%1', BHeader.Status::Pending);
        // if BHeader.Find('-') then begin
        //     Error(ErrorOnDelMod, BHeader.Status);
        // end;
    end;

    trigger OnModify()
    begin
        // BHeader.Reset;
        // BHeader.SetRange("No.", "Line No.");
        // BHeader.SetFilter(Status, '<>%1', BHeader.Status::Pending);
        // if BHeader.Find('-') then begin
        //     Error(ErrorOnDelMod, BHeader.Status);
        // end;
    end;

    trigger OnRename()
    begin
        // BHeader.Reset;
        // BHeader.SetRange("No.", "Line No.");
        // BHeader.SetFilter(Status, '<>%1', BHeader.Status::Pending);
        // if BHeader.Find('-') then begin
        //     Error(ErrorOnDelMod, BHeader.Status);
        // end;
    end;

    var
        NOK: Record "Next of KIN.";
        TotalA: Decimal;
        NOK1: Record "Next of KIN.";
        AccountM: Record Members;
        KinDetails: Record "Next of KIN.";
        AccountF: Record "Savings Accounts";
        // BHeader: Record "Payments Header";
        ErrorOnDelMod: label 'You cannot DELETE or MODIFY a Document whose status is %1';
        BBFEntitlement: Record "BBF Entitlement";
        Err0001: label 'Amount Paid cannot be more than claimed';


    procedure FieldLength(VarVariant: Text; FldLength: Integer): Text
    var
        FieldLengthError: label 'Field cannot be more than %1 Characters.';
    begin
        if StrLen(VarVariant) > FldLength then
            Error(FieldLengthError, FldLength);
    end;
}
