table 50131 "File Management Lines"
{
    Caption = 'File Management Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header No."; Code[20])
        {
            Caption = 'Header No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Current Location"; Code[20])
        {
            Caption = 'Current Location';
            DataClassification = ToBeClassified;
        }
        field(3; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
            TableRelation = Members Where(Type = filter(<> " "));
            trigger OnValidate()
            var
                myInt: Integer;
                Cust: Record Members;
                Logs: Record "File Movement Log";
                UserSetup: Record "User Setup";
            begin
                Issued := false;
                "Member Name" := '';
                if "Member No." <> '' then begin
                    Issued := true;
                    Cust.get("Member No.");
                    "Member Name" := Cust.Name;
                    UserSetup.get(UserId);



                    Logs.Reset();
                    Logs.SetFilter("Member No.", "Member No.");
                    if Logs.findlast() then begin

                        if not UserSetup."File Movement Admin" then
                            if Logs."Current Location" <> "Current Location" then
                                Error('You are not in possession of this file. File is Currently at %1', Logs."Current Location");
                    end;


                end;
            end;

        }
        field(4; Issued; Boolean)
        {
            Caption = 'Issued';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FileMove.Get("Header No.");
                FileMove.TestField("Current User", UserId);

            end;
        }
        field(5; Received; Boolean)
        {
            Caption = 'Received';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FileMove.Get("Header No.");
                FileMove.TestField("Requested By", UserId);

            end;
        }
        field(6; "Member Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Member Status"; Enum "Member Status Enum")
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Member Status" where("No." = field("Member No.")));
            Editable = false;
        }

    }
    keys
    {
        key(PK; "Header No.", "Current Location", "Member No.")
        {
            Clustered = true;
        }
    }

    var
        FileMove: Record "File Movement";


}
