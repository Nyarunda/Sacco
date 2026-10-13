pageextension 50682 "Employee Card Ext" extends "Employee Card"
{
    layout
    {
        addlast(content)
        {
            group("Work Experience")
            {
                Caption = 'Work Experience';

                part(WorkExperience; "Employee Work Experience")
                {
                    ApplicationArea = All;
                    SubPageLink = "Employee No." = field("No.");
                }
            }
        }
    }
}
