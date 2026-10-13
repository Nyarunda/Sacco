
PageExtension 50077 pageextension50077 extends "General Ledger Entries"
{

    layout
    {
        addafter("Source No.")
        {
            field(MemberName; MemberName)
            {
                ApplicationArea = Basic;
            }
            field(EmployerName; EmployerName)
            {
                ApplicationArea = Basic;
            }
            field("Member No."; Rec."Member No.")
            {
                ApplicationArea = Basic;
            }
            field("Loan No."; Rec."Loan No.")
            {
                ApplicationArea = Basic;
            }
            field("Recon. Loan No."; Rec."Recon. Loan No.")
            {
                ApplicationArea = Basic;
            }
            field("Recon. Member No."; Rec."Recon. Member No.")
            {
                ApplicationArea = Basic;
            }
            field("Bank Code"; Rec."Bank Code")
            {
                ApplicationArea = Basic;
            }
            field(Channel; Rec.Channel)
            {
                ApplicationArea = Basic;
            }
            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = Basic;
            }
        }
    }

    trigger OnAfterGetRecord()

    begin

        MemberName := '';
        EmployerName := '';



        IF Rec."Source Type" = Rec."Source Type"::Savings THEN BEGIN

            IF Accounts.GET(Rec."Source No.") THEN BEGIN
                MemberName := Accounts.Name;
                IF Employer.GET(Accounts."Employer Code") THEN
                    EmployerName := Employer.Name;
            END;
        END ELSE
            IF Rec."Source Type" = Rec."Source Type"::"Bank Account" THEN BEGIN
                IF BankAccount.GET(Rec."Source No.") THEN BEGIN
                    MemberName := BankAccount.Name
                END;
            END ELSE
                IF Rec."Source Type" = Rec."Source Type"::"Fixed Asset" THEN BEGIN
                    IF FixedAsset.GET(Rec."Source No.") THEN BEGIN
                        MemberName := FixedAsset.Description
                    END;
                END ELSE
                    IF Rec."Source Type" = Rec."Source Type"::Vendor THEN BEGIN
                        IF Vendor.GET(Rec."Source No.") THEN BEGIN
                            MemberName := Vendor.Name
                        END;
                    END ELSE
                        IF (Rec."Source Type" = Rec."Source Type"::Customer) or (Rec."Source Type" = Rec."Source Type"::Credit) THEN BEGIN
                            IF Customer.GET(Rec."Source No.") THEN BEGIN
                                MemberName := Customer.Name
                            END;
                        END;

    end;



    var
        myInt: Integer;
        MemberName: Text[100];
        EmployerName: Text[100];
        Members: Record Members;
        Employer: Record Customer;
        Customer: Record Customer;
        Accounts: Record "Savings Accounts";
        Vendor: Record "Savings Accounts";
        BankAccount: Record "Bank Account";
        FixedAsset: Record "Fixed Asset";
        Cledger: Record "Credit Ledger Entry";
        VLedger: Record "Savings Ledger Entry";


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetControlVisibility;

    IF GETFILTERS <> '' THEN
      IF FINDFIRST THEN;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    #1..4
    */
    //end;
}
