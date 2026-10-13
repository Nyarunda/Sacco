Page 50907 "HR OSInjured Person List"
{
    PageType = ListPart;
    SourceTable = "HR OSInjured Person";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if (Rec.Type = Rec.Type::"Non-Employee") then begin
                            NonEmployee := true;
                        end else
                            NonEmployee := false;
                    end;
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(InjuredPerson; Rec."Injured Person")
                {
                    ApplicationArea = Basic;
                    Editable = NonEmployee;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Editable = NonEmployee;
                }
                field(PhoneNo; Rec."Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = NonEmployee;
                }
                field(IDNo; Rec."ID No")
                {
                    ApplicationArea = Basic;
                    Editable = NonEmployee;
                }
                field(DateOfBirth; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = NonEmployee;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                    Editable = NonEmployee;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        NonEmployee := false;
    end;

    var
        NonEmployee: Boolean;
}

