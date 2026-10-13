
PageExtension 50118 pageextension50118 extends "Human Resources Setup"
{
    layout
    {
        addafter("Employee Nos.")
        {
            field("Intern Nos."; Rec."Intern Nos.")
            {
                ApplicationArea = Basic;
            }
            field("Contract Nos."; Rec."Contract Nos.")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

