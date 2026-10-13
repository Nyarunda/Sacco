page 50383 "Nominee Application"
{
    Caption = 'Nominee Application';

    PageType = List;
    SourceTable = Nominee;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(IDNo; Rec."ID No.")
                {
                    Caption = 'ID No./Birth Cert. No.';
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
                        CheckControls();
                        CurrPage.Update(false);
                    end;
                }
                field("Guardian Name"; Rec."Guardian Name")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Enabled = ShowMandatory;
                }
                Field("Guardian Phone No."; Rec."Guardian Phone No.")
                {
                    ApplicationArea = Basic;
                    Enabled = ShowMandatory;
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
                    Visible = false;
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
        ShowMandatory: Boolean;

    trigger OnOpenPage()
    begin
        CheckControls();
    end;

    trigger OnAfterGetRecord()
    begin
        CheckControls();
    end;

    local procedure CheckControls()
    begin
        ShowMandatory := (Rec."Date of Birth" <> 0D) and
          (Rec."Date of Birth" > CalcDate('<-18Y>', Today));
    end;
}

