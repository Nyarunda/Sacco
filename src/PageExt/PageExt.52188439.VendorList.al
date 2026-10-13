// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50083 VendorListExt extends "Vendor List"
{
    layout
    {
        addafter(Blocked)
        {
            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the type of vendor, such as a private person, a company, or a legal entity.';
            }
            field("KRA Pin No."; Rec."KRA Pin No.")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the vendor KRA PIN number.';
            }
        }
    }


    trigger OnOpenPage();
    begin
        Rec.SetFilter("Creditor Type", '<>%1', Rec."Creditor Type"::FOSA);
        //Rec.SetFilter("Vendor Type", '%1', "Vendor Type"::" ");
    end;




}
