// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50082 CustomerCardExt extends "Customer Card"
{

    layout
    {

        addafter(Name)
        {
            field("Account Type"; Rec."Account Type")
            {
                ApplicationArea = Basic;
                trigger OnValidate()
                begin
                    UpdateControls();
                end;
            }
            field(Initials; Rec.Initials)
            {
                ApplicationArea = Basic;
            }
            field("Advice Method"; Rec."Advice Method")
            {
                ApplicationArea = Basic;
            }
            field(Type; Rec.Type)
            {
                ApplicationArea = Basic;
            }
            field("Employer Based Staff Nos"; Rec."Employer Based Staff Nos")
            {
                ApplicationArea = Basic;
            }
            field("Remove Loan Restriction"; Rec."Remove Loan Restriction")
            {
                ApplicationArea = Basic;
            }
            field("Company Profile"; Rec."Company Profile")
            {
                ApplicationArea = Basic;
            }
            field("Industry Type";Rec."Industry Type")
            {
                ApplicationArea = Basic;
            }


        }
        addafter(ContactName)
        {
        }

        addafter(Invoicing) // Existing control on the page
        {
            group("Lease Agreement")
            {
                Visible = LeaseDetVisible;

                field("Rent Amount"; Rec."Rent Amount")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Service Charge"; Rec."Service Charge")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Repayment Startdate"; Rec."Repayment Startdate")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
            }
        }
    }
    actions
    {
        addafter("&Customer")
        {
            action("Generate Schedule")
            {
                ApplicationArea = All;
                Image = Action;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                begin

                    SaccoActivities.GenerateRentRepaymentSchedule(Rec);
                    Commit;

                    Cust.SetFilter("No.", Rec."No.");
                    Report.Run(Report::"Rent Repayment Schedule", true, true, Cust);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls;
    end;

    var

        LeaseDetVisible: Boolean;
        Cust: Record Customer;
        SaccoActivities: Codeunit "Sacco Activities";



    procedure UpdateControls()
    begin

        if Rec."Account Type" = Rec."Account Type"::Tenant then
            LeaseDetVisible := true
        else
            LeaseDetVisible := false;
    end;
}
