pageextension 50135 "Vendor card" extends "vendor card"
{
    layout
    {
        addafter(MobilePhoneNo)
        {
            field("KRA Pin No."; Rec."KRA Pin No.")
            {
                ShowMandatory = true;
                ApplicationArea = all;
            }
            field("Is Lawyer"; Rec."Is Lawyer")
            {
                ApplicationArea = All;
                //ShowMandatory = true;
            }
            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = All;

            }
        }
        addafter("Vendor Posting Group")
        {
            group(Prequalification)
            {
                Caption = 'Prequalification';
                field("Prequalification Status"; Rec."Prequalification Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the prequalification status of the vendor.';
                }
                field("Prequalification Date"; Rec."Prequalification Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the prequalification date.';
                }
                field("Prequalification Expiry Date"; Rec."Prequalification Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the prequalification expires.';
                }
                field("Vendor Category"; Rec."Vendor Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor category.';
                }
            }
        }


    }

    actions
    {
        addlast(Navigation)
        {
            action("Prequalification Details")
            {
                ApplicationArea = All;
                Caption = 'Prequalification Details';
                Image = Document;
                RunObject = page "Prequlified Supplier List";
                RunPageLink = "Vendor No." = field("No.");
                ToolTip = 'View prequalification details for this vendor.';
            }
            action("Vendor Account Statement")
            {
                ApplicationArea = All;
                Caption = 'Vendor Account Statement';
                Image = Report;
                ToolTip = 'Print the account statement for this vendor.';

                trigger OnAction()
                var
                    Vendor: Record Vendor;
                begin
                    Rec.TestField("No.");
                    Vendor.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Vendor Account Statement", true, false, Vendor);
                end;
            }
        }
    }
}
