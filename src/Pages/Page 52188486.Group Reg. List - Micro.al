
Page 50149 "Micro Group Application"
{
    ApplicationArea = Basic;
    CardPageID = "Group Reg. Card - Micro";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Member Registration";
    SourceTableView = where(Type = filter(Group),
                            "Group Section" = const("Micro Group"));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    Editable = false;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application Date';
                    Editable = false;
                }
                field(OldMemberNo; Rec."Old Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(DateofBirth; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(MobilePhoneNo; Rec."Mobile Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the contact''s mobile telephone number.';
                }
                field(EMail; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    ExtendedDatatype = EMail;
                    Importance = Promoted;
                    ToolTip = 'Specifies the email address of the contact.';
                }
               
                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Group;
        Rec."Group Account" := true;
        Rec."Group Section" := Rec."group section"::"Micro Group";
        Rec."Account Category" := Rec."account category"::MicroGroup;
    end;
}

