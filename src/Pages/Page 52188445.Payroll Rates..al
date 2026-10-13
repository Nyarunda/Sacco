
Page 50092 "Payroll Rates."
{
    ApplicationArea = Basic;
    PageType = Card;
    SourceTable = "Payroll Rates";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(TaxRelief)
            {
                Caption = 'Tax Relief';
                field(Control33; Rec."Tax Relief")
                {
                    ApplicationArea = Basic;
                }
                field(InsuranceRelief; Rec."Insurance Relief")
                {
                    ApplicationArea = Basic;
                }
                field(MaxRelief; Rec."Max Relief")
                {
                    ApplicationArea = Basic;
                }
                field(DisbledTaxLimit; Rec."Disbled Tax Limit")
                {
                    ApplicationArea = Basic;
                }
                field("OOI Deduction"; Rec."OOI Deduction")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Fringe)
            {
                field("Loan Market Rate"; Rec."Loan Market Rate")
                {
                    ApplicationArea = basic;
                }
            }
            group(NHIF)
            {
                Caption = 'NHIF';
                field(NHIFBasedon; Rec."NHIF Based on")
                {
                    ApplicationArea = Basic;
                }
                field("NHIF Relief"; Rec."NHIF Relief")
                {
                    ApplicationArea = Basic;
                }
            }
            group(NITA)
            {
                Caption = 'NITA';
                field(NITAAmount; Rec."NITA Amount")
                {
                    ApplicationArea = Basic;
                }
                field(NITANumber; Rec."NITA Number")
                {
                    ApplicationArea = Basic;
                }
            }

            group(Housing)
            {
                field("Housing Levy Relief"; Rec."Housing Levy Relief")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Pension)
            {
                Caption = 'Pension';
                field(MaxPensionContribution; Rec."Max Pension Contribution")
                {
                    ApplicationArea = Basic;
                }
                field(TaxOnExcessPension; Rec."Tax On Excess Pension")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Mortgage)
            {
                Caption = 'Mortgage';
                field(MortgageReliefLessfromTaxablePay; Rec."Mortgage Relief")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mortgage Relief (Less from Taxable Pay)';
                }
                field(MortgageReliefPercentage; Rec."Mortgage Relief Percentage")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        RestrictAccess
    end;


    procedure RestrictAccess()
    var
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}
