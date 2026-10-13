namespace UnitedWomen.UnitedWomen;

report 50550 JuniorAcceptanceLetter
{
    ApplicationArea = All;
    Caption = 'JuniorAcceptanceLetter';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './src/Layouts/JuniorAcceptanceLetter.docx';
    dataset
    {
        dataitem(Member; "Savings Accounts")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(MemberName; Member.Name) { }
            column(FirstName; FirstName) { }
            column(Email; ParentMember."E-Mail") { }
            column(MembershipNo; Member."No.") { }
            column(ChildName; Member."Child Name") { }
            column(RegistrationDate; Format(Today, 0, '<Day,2> <Month Text> <Year4>')) { }
            column(CEO_Name; CEONameLbl) { }
            column(CEO_Title; CEOTitleLbl) { }

            trigger OnAfterGetRecord()
            begin
                Member.TestField("Product Category", Member."Product Category"::"Junior Savings");
                Member.TestField("Member No.");
                Member.TestField("Child Name");

                ParentMember.Get(Member."Member No.");
                VerifyMemberData(ParentMember);

                FirstName := MemberActivites.FirstName(ParentMember.Name);
            end;
        }
    }

    var
        FirstName: Text[50];
        ParentMember: Record Members;
        CEONameLbl: Label 'Nancy N. Mutugu';
        CEOTitleLbl: Label 'Chief Executive Officer';
        ErrorContactSupportErr: Label 'Member %1 is missing vital contact information. Please update the member card.';
        MemberActivites: codeunit "Member Activities";

    local procedure VerifyMemberData(MemberRec: Record Members)
    begin
        if (MemberRec.Name = '') or (MemberRec."E-Mail" = '') then
            Error(ErrorContactSupportErr, MemberRec."No.");
    end;
}
