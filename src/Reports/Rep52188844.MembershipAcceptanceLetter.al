namespace UnitedWomen.UnitedWomen;

report 50546 MembershipAcceptanceLetter
{
    ApplicationArea = All;
    Caption = 'MembershipAcceptanceLetter';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './src/Layouts/MembershipAcceptanceLetter.docx';

    dataset
    {
        dataitem(Member; Members)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(MemberName; Member.Name) { }
            column(FirstName; FirstName) { }
            column(Email; Member."E-Mail") { }
            column(MembershipNo; Member."No.") { }
            column(RegistrationDate; Format(Today, 0, '<Day,2> <Month Text> <Year4>')) { }
            column(CEO_Name; CEONameLbl) { }
            column(CEO_Title; CEOTitleLbl) { }

            trigger OnAfterGetRecord()
            begin
                VerifyMemberData(Member);
                FirstName := MemberActivities.FirstName(Member.Name);
            end;
        }
    }

    var
        FirstName: Text[50];
        MemberActivities: Codeunit "Member Activities";
        CEONameLbl: Label 'Nancy N. Mutugu';
        CEOTitleLbl: Label 'Chief Executive Officer';
        ErrorContactSupportErr: Label 'Member %1 is missing vital contact information. Please update the member card.';

    local procedure VerifyMemberData(MemberRec: Record Members)
    begin
        if (MemberRec.Name = '') or (MemberRec."E-Mail" = '') then
            Error(ErrorContactSupportErr, MemberRec."No.");
    end;

}
