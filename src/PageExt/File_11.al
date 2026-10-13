
PageExtension 50065 pageextension50065 extends "Company Information"
{
    layout
    {
        addafter(Picture)
        {
            field("Letter Head"; Rec."Letter Head")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the picture that has been set up for the company, such as a company logo.';

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord;
                end;
            }
            field("Sacco Society No"; Rec."Sacco Society No")
            {
                ApplicationArea = Basic;
            }
            group("Current Year")
            {
                field("Year Start"; Rec."Year Start")
                {
                    ApplicationArea = Basic;
                }
                field("Year End"; Rec."Year End")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Payroll")
            {
                field("KRA PIN"; Rec."KRA PIN")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Teller")
            {
                field("Teller Slip Msg"; Rec."Teller Slip Msg")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Credit)
            {
                field("Credit Message"; Rec."Credit Message")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Details Image"; Rec."Bank Details Image")
                {
                    ApplicationArea = Basic;
                }
                field("Fosa Signature"; Rec."Fosa Signature")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("CEO Signature"; Rec."CEO Signature")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}

