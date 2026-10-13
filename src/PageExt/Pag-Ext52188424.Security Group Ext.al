/* #pragma warning disable AL0432
pageextension 50013 "Security Group Ext" extends "Security Groups"
{

    layout
    {
        addafter(Name)
        {
            field(Type; Rec.Type)
            {
                ApplicationArea = Basic;
            }
            field(Supervisor; Rec.Supervisor)
            {
                ApplicationArea = Basic;
            }
        }

    }

}


 */