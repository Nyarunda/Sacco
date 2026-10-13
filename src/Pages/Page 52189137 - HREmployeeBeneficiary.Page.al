Page 50839 "HR Employee Beneficiary"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Employee Beneficiary";
    ApplicationArea = All;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LineNo; Rec."Line No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(EmployeeCode; Rec."Employee Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(SurName; Rec.SurName)
                {
                    ApplicationArea = Basic;
                }
                field(OtherNames; Rec."Other Names")
                {
                    ApplicationArea = Basic;
                }

                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic;
                }


                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        UpdateDateOfBirthRequirement();
                        CurrPage.Update(false);
                    end;
                }
                field(DateOfBirth; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = DateOfBirthRequired;
                    trigger OnValidate()
                    begin
                        NomineeAge := 0;
                        if Rec."Date of Birth" <> 0D then
                            NomineeAge := Date2DMY(Today, 3) - Date2DMY(Rec."Date of Birth", 3);
                        CurrPage.Update(false);
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
                field("Guardian ID No."; Rec."Guardian ID No.")
                {
                    ApplicationArea = Basic;
                    Enabled = NomineeAge < 18;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Caption = 'Physical Address';
                }
                field(MobilePhoneNo; Rec."Mobile Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(HomeTelNo; Rec."Home Tel No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Email; Rec."E-mail")
                {
                    ApplicationArea = Basic;
                }
                field(Allocation; Rec.Allocation)
                {
                    ApplicationArea = Basic;

                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        NomineeAge := 0;
        if Rec."Date Of Birth" <> 0D then
            NomineeAge := Date2DMY(Today, 3) - Date2DMY(Rec."Date Of Birth", 3);
        UpdateDateOfBirthRequirement();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        NomineeAge := 0;
        DateOfBirthRequired := true;
    end;

    local procedure UpdateDateOfBirthRequirement()
    begin
        DateOfBirthRequired := Rec."ID No." = '';
    end;

    var
        NomineeAge: Integer;
        DateOfBirthRequired: Boolean;
}
