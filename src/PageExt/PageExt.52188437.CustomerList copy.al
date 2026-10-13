// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50081 CustomerListExt extends "Customer List"
{

    layout
    {

        addafter(Name)
        {
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = Basic;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        //Rec.SetFilter(Rec.Type, '<>%1&<>%2&<>%3&<>%4', Rec.Type::Checkoff, Rec.Type::Imprest, Rec.Type::Salary, Rec.Type::"Staff Advance");
    end;

}