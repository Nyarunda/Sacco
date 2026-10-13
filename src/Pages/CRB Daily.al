page 50109 "CRB Daily Payments"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    SourceTable = "CRB Main Data";
    SourceTableView = WHERE("Client Type" = CONST(Loanee));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date of Latest Payment"; Rec."Date of Latest Payment")
                {
                    Caption = 'Snapshot Date';
                }
                field("Client Type"; Rec."Client Type")
                {
                }
                field(Surname; Rec.Surname)
                {
                }
                field("Foreign Name 1"; Rec."Name 2")
                {
                    Caption = 'Forename 1';
                }
                field("Foreign Name 2"; Rec."Name 3")
                {
                    Caption = 'Forename 2';
                }
                field("Foreign Name 3"; Rec."Name 4")
                {
                    Caption = 'Forename 3';
                }
                field("Company Name"; CompanyInformation.Name)
                {
                }
                field("Primary Identification Code"; Rec."Primary Identification Code")
                {
                    Caption = 'Primary Identification Document Type';
                }
                field("Primary Identification 1"; Rec."Primary Identification 1")
                {
                    Caption = 'PrimaPrimary Identification Doc Number';
                }
                field("Account No."; Rec."Account No.")
                {
                    Caption='Account Number';
                }
                field("Currency of Facilty"; Rec."Currency of Facilty")
                {
                }
                field("Original Amount"; Rec."Original Amount")
                {
                }
                field("Payment Amount"; Rec."Last Payment Amount")
                {
                }
                field("Payment Date"; Rec."Date of Latest Payment")
                {
                }
                field("Current Balance"; Rec."Current Balance")
                {
                }
                field("Installments In Arrears"; Rec."No. of Installments in Arrears")
                {
                }
                field("Days In Arrears"; Rec."No. of Days in Arrears")
                {
                }
                field("Account Status"; Rec."Account Status")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Generate CRB")
            {
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Generate CRB Main";
            }
            action("View Guarantor File")
            {
                Image = ViewDocumentLine;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = Page "CRB Guarantor File";
            }
            action("View Loanee Update File")
            {
                Image = ViewDocumentLine;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = Page "CRB Update";
            }
        }
    }

    trigger OnInit()
    begin
        StatusPermission.RESET;
        StatusPermission.SETRANGE(StatusPermission."User ID", USERID);
        StatusPermission.SETRANGE(StatusPermission."SASRA Report", TRUE);
        IF NOT StatusPermission.FIND('-') THEN BEGIN
            ERROR('You Do Not have Permission to perform this action [SASRA Report]');
        END;
    end;

    var
        StatusPermission: Record "User Setup";
        CompanyInformation: Record "Company Information";
}

