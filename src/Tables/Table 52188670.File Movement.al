Table 50333 "File Movement"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(2; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;

            trigger OnValidate()
            begin
                "Member Name" := '';
                if Members.Get("Member No.") then
                    "Member Name" := Members.Name;


            end;
        }
        field(3; "Member Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Request Location"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Custom User Group" where(Type = const("File Movement"));
            Editable = false;

            trigger OnValidate()
            begin
            end;
        }
        field(5; "Request Location Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Requested By"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Request Location Name" := '';
                "Request Location" := '';

                UserGroupMember.Reset();
                UserGroupMember.SetRange("User Name", "Requested By");
                //UserGroupMember.SetRange(Type, UserGroupMember.Type::"File Movement");
                UserGroupMember.SetRange("Company Name", CompanyName);
                //UserGroupMember.Setrange( ,'FILEMOVEMENT')
                if UserGroupMember.FindFirst() then begin
                    "Request Location" := UserGroupMember."User Group Code";
                    if UserGroup.Get("Request Location") then
                        "Request Location Name" := UserGroup.Name;

                end;
            end;
        }
        field(7; "Current Location"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Custom User Group" where(Type = const("File Movement"));

            trigger OnValidate()
            begin
                "Current Name" := '';

                if UserGroup.Get("Current Location") then
                    "Current Name" := UserGroup.Name;

            end;
        }
        field(8; "Current Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Current User"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Custom User Group" where(Type = const("File Movement"));

            trigger OnValidate()
            begin
                "Current Name" := '';

                if UserGroup.Get(("Current Location")) then
                    "Current Name" := UserGroup.Name;
            end;
        }
        field(10; "Movement Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Overdue Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(12; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","File Request","File Issue";

            trigger OnValidate()
            begin
                if "Entry Type" = "entry type"::"File Request" then begin
                    UserGroupMember.Reset;
                    //UserGroupMember.SetRange(Type, UserGroupMember.Type::"File Movement");
                    UserGroupMember.SetRange("User Name", UserId);
                    UserGroupMember.SetRange("Company Name", CompanyName);
                    if UserGroupMember.FindFirst then begin
                        // UserGroupMember.calcfields("User Name");

                        UserGroupMember.calcfields("User Group Name");
                        "Request Location" := UserGroupMember."User Group Code";
                        "Request Location Name" := UserGroupMember."User Group Name";
                        "Requested By" := UserGroupMember."User Name";

                    end;
                end;
            end;
        }
        field(13; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","To Be Issued","To Be Received","File Received";
            Editable = false;
        }
        field(15; "Date Issued"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Date Received"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Reason For Delay"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Purpose"; Option)
        {
            //OptionMembers = Loaning,"Loan Defaulters","Loan Recovery",Withdrawal;
            OptionMembers = Loaning,"Loan Defaulters","Loan Recovery",Withdrawal,"Reconciliation Purpose","Auditing Purposes",Refunds,"Loan and Signatories","Risk Payment",Custody,"Document Filing",Passbook,"Complaint Letters",Dividends,Termination,"New Member Details","New Member Verification",Deceased;
        }
        field(19; "Remarks"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Selected By" := '';
                if Select then
                    "Selected By" := UserId;
            end;
        }
        field(21; "Selected By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Deceased"; Boolean)
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

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField("File Movement Nos");
            "No." := NoSeries.GetNextNo(SalesSetup."File Movement Nos", WorkDate(), true);
        end;
        "Movement Date" := today;
    end;

    trigger OnModify()
    begin

        if Status = Status::"File Received" then
            Error('File Already received');
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        UserGroup: Record "Custom User Group";
        Members: Record Members;
        Log: Record "File Movement Log";
        UserGroupMember: Record "User Group Members";
}

