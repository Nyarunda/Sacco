Page 50362 "dashboard Lines"
{
    PageType = ListPart;
    SourceTable = "Dashboard Lines";
    SourceTableView = sorting(Type)
                      order(ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    StyleExpr = MemberStatusStyle;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = Basic;
                    StyleExpr = MemberStatusStyle;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        MemberStatusStyle := '';
        if Rec.Type = Rec.Type::"Loans Category" then
            MemberStatusStyle := 'StrongAccent';
        if Rec.Type = Rec.Type::"Treasury Balances" then
            MemberStatusStyle := 'Attention';//'StrongAccent'

        if CopyStr(Rec.Description, 1, 1) = '-' then
            MemberStatusStyle := 'Strong';

        /*
      END ELSE IF Status =Status::Blocked THEN BEGIN
      MemberStatusStyle := 'Attention';
      END ELSE if Rec.Status = Rec.Status::Deceased THEN BEGIN
      MemberStatusStyle := 'Strong';
        */

    end;

    var
        MemberStatusStyle: Text;
}

