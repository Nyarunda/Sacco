namespace UnitedWomen.UnitedWomen;
using Microsoft.Foundation.Company;

report 50579 "Guarantor Substitution Report"
{
    ApplicationArea = All;
    Caption = 'Guarantor Substitution Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/GuarantorSubstitution.rdlc';
    dataset
    {
        dataitem(LoanSecurity; "Loan Security")
        {
            DataItemTableView = where(Substituted = const(false));
            column(MemberNo; SubstitutedMemberNo)
            {
            }
            column(LoaneeName; "Loanee Name")
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(Name; SubstitutedSecurityName)
            {
            }
            column(MemberGuaranteed; "Member Guaranteed")
            {
            }
            column(SubstitutedMember; IncomingMemberNo)
            {
            }
            column(AmountGuaranteed; IncomingAmountGuaranteed)
            {
            }
            column(SubMemberName; IncomingSecurityName)
            { }
            column(SubstitutedGuarantorNo; SubstitutedMemberNo)
            { }
            column(SubstitutedGuarantorName; SubstitutedSecurityName)
            { }
            column(IncomingGuarantorNo; IncomingMemberNo)
            { }
            column(IncomingGuarantorName; IncomingSecurityName)
            { }
            column(IncomingAmountGuaranteed; IncomingAmountGuaranteed)
            { }
            column(CompanyPicture; CompanyInfo.Picture) { }

            trigger OnPreDataItem()
            begin
                SetFilter("Substituted Member", '<>%1', '');
            end;

            trigger OnAfterGetRecord()
            var
                SubstitutedSecurity: record "Loan Security";
            begin
                Clear(SubstitutedMemberNo);
                Clear(SubstitutedSecurityName);
                Clear(IncomingMemberNo);
                Clear(IncomingSecurityName);
                Clear(IncomingAmountGuaranteed);

                SubstitutedMemberNo := LoanSecurity."Substituted Member";
                IncomingMemberNo := LoanSecurity."Member No";
                IncomingSecurityName := GetSecurityDisplayName(LoanSecurity);
                IncomingAmountGuaranteed := GetIncomingGuaranteedAmount(LoanSecurity, SubstitutedMemberNo);

                SubstitutedSecurity.Reset();
                SubstitutedSecurity.SetRange("Loan No.", LoanSecurity."Loan No.");
                SubstitutedSecurity.SetRange("Member No", SubstitutedMemberNo);
                SubstitutedSecurity.SetRange(Substituted, true);
                if SubstitutedSecurity.FindFirst() then
                    SubstitutedSecurityName := GetSecurityDisplayName(SubstitutedSecurity)
                else
                    SubstitutedSecurityName := GetMemberName(SubstitutedMemberNo);

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        SubstitutedMemberNo: Code[20];
        SubstitutedSecurityName: Text[250];
        IncomingMemberNo: Code[20];
        IncomingSecurityName: Text[250];
        IncomingAmountGuaranteed: Decimal;
        CompanyInfo: Record "Company Information";

    local procedure GetSecurityDisplayName(Security: Record "Loan Security"): Text[250]
    begin
        if Security."Guarantor Type" = Security."Guarantor Type"::Collateral then
            if Security."Collateral Reg. No." <> '' then
                if Security.Name <> '' then
                    exit(CopyStr(StrSubstNo('%1 - %2', Security.Name, Security."Collateral Reg. No."), 1, 250))
                else
                    exit(Security."Collateral Reg. No.");

        exit(CopyStr(Security.Name, 1, 250));
    end;

    local procedure GetMemberName(MemberNo: Code[20]): Text[250]
    var
        Member: Record Members;
    begin
        if MemberNo = '' then
            exit('');

        if Member.Get(MemberNo) then
            exit(CopyStr(Member.Name, 1, 250));

        exit(MemberNo);
    end;

    local procedure GetIncomingGuaranteedAmount(IncomingSecurity: Record "Loan Security"; OutgoingMemberNo: Code[20]): Decimal
    var
        Replacement: Record "Security Sub. Replacement";
        ReplacementAmount: Decimal;
    begin
        Replacement.Reset();
        Replacement.SetRange("Loan No.", IncomingSecurity."Loan No.");
        Replacement.SetRange("Substituted Member", OutgoingMemberNo);
        Replacement.SetRange("Account No.", IncomingSecurity."Account No.");
        Replacement.SetRange("Collateral Reg. No.", IncomingSecurity."Collateral Reg. No.");

        if Replacement.FindSet() then
            repeat
                ReplacementAmount += Replacement."Replacement Amount";
            until Replacement.Next() = 0;

        if ReplacementAmount <> 0 then
            exit(ReplacementAmount);

        if IncomingSecurity."Current Committed" <> 0 then
            exit(IncomingSecurity."Current Committed");

        exit(IncomingSecurity."Amount Guaranteed");
    end;
}
