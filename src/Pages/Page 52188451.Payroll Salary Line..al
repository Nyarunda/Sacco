
Page 50114 "Payroll Salary Line."
{
    PageType = ListPart;
    SourceTable = "Staff Payroll Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(BasicPay; Rec."Basic Pay")
                {
                    ApplicationArea = Basic;
                }
                field(PaymentMode; Rec."Payment Mode")
                {
                    ApplicationArea = Basic;
                }
                field(ProcessNITA; Rec."Process NITA")
                {
                    ApplicationArea = Basic;
                }
                field(PINNo; Rec."PIN No.")
                {
                    ApplicationArea = Basic;
                }
                field(PaysNSSF; Rec."Pays NSSF")
                {
                    ApplicationArea = Basic;
                }
                field(PaysNHIF; Rec."Pays NHIF")
                {
                    ApplicationArea = Basic;
                }
                field(PaysPAYE; Rec."Pays PAYE")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Certificate?"; Rec."Insurance Certificate?")
                {
                    ApplicationArea = Basic;
                }
                field("Stop Employer Pension"; Rec."Stop Employer Pension")
                {
                    ApplicationArea = Basic;
                }
                field("Pays Housing Levy"; Rec."Pays Housing Levy")
                {
                    ApplicationArea = Basic;
                }
                field("Defined Pension"; Rec."Defined Pension")
                {
                    Caption = 'Defined Pension Amount';
                    ApplicationArea = Basic;
                }
                field("Insurance Relief"; Rec."Insurance Relief")
                {
                    Caption = 'Insurance Relief';
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

