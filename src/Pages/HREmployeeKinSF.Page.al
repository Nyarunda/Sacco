Page 50867 "HR Employee KinSF"
{
    Caption = 'Emergency Contact Details';

    PageType = ListPart;
    SourceTable = "HR Employee Kin";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic;
                }
                field(SurName; Rec.SurName)
                {
                    ApplicationArea = Basic;
                }
                field(OtherNames; Rec."Other Names")
                {
                    ApplicationArea = Basic;
                }
                field(IDNoPassportNo; Rec."ID No/Passport No")
                {
                    ApplicationArea = Basic;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Email; Rec."E-mail")
                {
                    ApplicationArea = Basic;
                    
                }
                field(OfficeTelNo; Rec."Office Tel No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(HomeTelNo; Rec."Home Tel No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Phone No.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }


    var
        D: Date;
}

