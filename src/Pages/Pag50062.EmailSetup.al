page 50062 "Email Setup"
{
    ApplicationArea = All;
    Caption = 'Email Setup';
    PageType = Card;
    SourceTable = "Email Setup";
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                }
                field("From Name"; Rec."From Name")
                {
                    ApplicationArea = All;
                }
                field("From Address"; Rec."From Address")
                {
                    ApplicationArea = All;
                }
                field("Max Bulk Size"; Rec."Max Bulk Size")
                {
                    ApplicationArea = All;
                }
            }

            group(SMTP)
            {
                Caption = 'SMTP';

                field("SMTP Host"; Rec."SMTP Host")
                {
                    ApplicationArea = All;
                }
                field("SMTP Port"; Rec."SMTP Port")
                {
                    ApplicationArea = All;
                }
                field("SMTP Username"; Rec."SMTP Username")
                {
                    ApplicationArea = All;
                }
                field("SMTP Password"; Rec."SMTP Password")
                {
                    ApplicationArea = All;
                }
                field("Use TLS"; Rec."Use TLS")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get('') then begin
            Rec.Init();
            Rec."Primary Key" := '';
            Rec."SMTP Port" := 587;
            Rec."Use TLS" := true;
            Rec."Max Bulk Size" := 50;
            Rec.Insert(true);
        end;
    end;
}
