
Page 50174 "Member Listing"
{
    CardPageID = "Member Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Members;
    SourceTableView = where(Type = filter('Group|Member'));

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
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(OldMemberNo; Rec."Old Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Group No."; Rec."Group No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Group Account"; Rec."Group Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RegistrationDate; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
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
                field(Pensioner; Rec.Pensioner)
                {
                    ApplicationArea = Basic;
                }
                field(RelationshipOfficer; Rec."Relationship Officer")
                {
                    ApplicationArea = Basic;
                }
                field(RelationshipOfficerName; Rec."Relationship Officer Name")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

