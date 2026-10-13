
Page 50549 "Nominee Changes"
{
    PageType = ListPart;
    SourceTable = Nominee;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(DateofBirth; Rec."Date of Birth")
                {
                    Caption = 'Year of Birth';
                    ApplicationArea = Basic;
                    ShowMandatory = ShowMandatory;
                    trigger OnValidate()
                    begin
                        NomineeAge := 0;
                        if Rec."Date of Birth" <> 0D then
                            NomineeAge := Date2DMY(Today, 3) - Date2DMY(Rec."Date of Birth", 3);
                    end;
                }
                field("Guardian Name"; Rec."Guardian Name")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Enabled = NomineeAge < 18;
                }
                Field("Guardian Phone No."; Rec."Guardian Phone No.")
                {
                    ApplicationArea = Basic;
                    Enabled = NomineeAge < 18;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                }
                field(MobilePhoneNo; Rec."Mobile Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic;
                }
                field(Spouse; Rec.Spouse)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Beneficiary; Rec.Beneficiary)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Allocation; Rec."%Allocation")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
    var
        NomineeAge: Integer;
        ShowMandatory: Boolean;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CheckControls();
    end;

    trigger OnAfterGetRecord()
    begin
        CheckControls();
    end;

    local procedure CheckControls()
    var
        myInt: Integer;
    begin
        NomineeAge := 0;
        if Rec."Date of Birth" <> 0D then
            NomineeAge := Date2DMY(Today, 3) - Date2DMY(Rec."Date of Birth", 3);

        if NomineeAge < 18 then
            ShowMandatory := true
        else
            ShowMandatory := false;
    end;

}

