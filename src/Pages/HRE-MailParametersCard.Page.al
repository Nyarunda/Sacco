Page 50920 "HR E-Mail Parameters Card"
{
    PageType = Card;
    SourceTable = "HR E-Mail Parameters";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(AssociateWith; Rec."Associate With")
                {
                    ApplicationArea = Basic;
                }
                field(SenderName; Rec."Sender Name")
                {
                    ApplicationArea = Basic;
                }
                field(SenderAddress; Rec."Sender Address")
                {
                    ApplicationArea = Basic;
                }
                field(Recipients; Rec.Recipients)
                {
                    ApplicationArea = Basic;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = Basic;
                }
                field(Body; Rec.Body)
                {
                    ApplicationArea = Basic;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = Basic;
                }
                field(TemplatePath; Rec."Template Path")
                {
                    ApplicationArea = Basic;
                }
                field(PayslipMessage; Rec."Payslip Message")
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

