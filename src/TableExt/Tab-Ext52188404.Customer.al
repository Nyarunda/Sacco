
TableExtension 50167 tableextension52188404 extends Customer
{

    fields
    {

        field(50088; "Employer Based Staff Nos"; Boolean)
        {
        }

        field(50007; "Dont Charge Transactions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Advice Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Changes,Everything';
            OptionMembers = " ",Changes,Everything;
        }
        field(50000; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Travel Advance",Partner,"Staff Advance",Members,"Training Advance",Employer,"Cashier Excess","Cashier Shortage","MPESA",Shop,Tenant,Imprest;

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                //TestNoEntriesExist(FIELDCAPTION("Account Type"));
            end;
        }

        field(50096; "Remove Loan Restriction"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()

            begin
                UserSetup.Reset();
                UserSetup.SetRange("User ID", UserId);
                UserSetup.SetRange("Credit Setups", true);
                if not UserSetup.findfirst then
                    error('You do not have the permission to update this setup');

            end;
        }

        field(50011; "Cannot Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "CRB Employer Industry Type"; Code[1])
        {
            DataClassification = ToBeClassified;
        }

        field(50015; Type; Enum "Employer Type")
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Checkoff Agreement Date"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Repayment Frequency"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Rent Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Service Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; Installments; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Repayment Startdate"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; Initials; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Company Profile"; Option)
        {
            OptionMembers = " ",Affliate,Main;
            DataClassification = ToBeClassified;
        }
        field(50024; "Industry Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Industry Type";
        }
        field(50025; "Skip Check CRB"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    fieldgroups
    {

    }
    var
        UserSetup: Record "User setup";

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Create Customer Account", true);
        if not UserSetup.findfirst then
            error('You do not have the permission to Create Customer Account [Create Customer Account]!');
    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Delete Customer", true);
        if not UserSetup.findfirst then
            error('You do not have the permission to delete Customer Account!');
    end;

}

