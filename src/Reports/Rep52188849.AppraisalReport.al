namespace UnitedWomen.UnitedWomen;
using Microsoft.Foundation.Company;
// using System.Security.User;

report 50551 "Appraisal Report"
{
    ApplicationArea = All;
    Caption = 'Appraisal Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/AppraisalReport.rdlc';
    dataset
    {
        dataitem(MemberSalaryAppraisal; "Member Salary Appraisal")
        {
            CalcFields = "CEO Comments", "Credit Committee Comments", "Appraiser Comments";
            column(Picture; CI.picture)
            {
            }
            column(C_Name; CI.Name)
            {
            }
            column(DatePrepared; AppraisalDateForReport)
            {
            }
            column(PreparedBy; PreparedBy)
            {
            }
            /* column(Name; Name)
            {
            } */
            column(Name; MemberRec.Name + ' (' + MemberRec."No." + ')')
            {
            }

            column(RequestedAmount; "Requested Amount")
            {
            }
            column(Occupation; Occupation)
            {
            }
            column(IntroducedBy; IntroducedBy)
            {
            }
            column(Loan_Purpose; "Loan Purpose")
            {
            }
            column(Business_Description; "Business Description")
            {
            }
            column(CEOComments; MemberSalaryAppraisal.GetCEOComment())
            {
            }
            column(CreditCommitteeComments; MemberSalaryAppraisal.GetCreditCommitteeComment())
            {
            }
            column(AppraiserComments; MemberSalaryAppraisal.GetAppraiserComment())
            {
            }
            column(BoardComments; MemberSalaryAppraisal.GetBoardComment())
            {
            }
            column(SecurityDetails; SecurityDetails)
            {
            }
            trigger OnAfterGetRecord()
            var
                Lsecurity: Record "Loan Security";
            begin
                if MemberRec.get("Member No.") then
                    IntroducedBy := StrSubstNo(MemberRec."Recruited By Name" + ':' + MemberRec."Recruited By", 1, 100);

                Lsecurity.Reset();
                Lsecurity.SetRange("Loan No.", MemberSalaryAppraisal."Appraisal No.");
                SecurityDetails := '';
                if Lsecurity.FindSet() then
                    repeat
                        if SecurityDetails <> '' then
                            SecurityDetails += ' | ';
                        SecurityDetails += Format(Lsecurity."Guarantor Type") + ' ' + Lsecurity."Security Details"; //+ Format(Lsecurity."Amount Guaranteed");
                    until Lsecurity.Next() = 0;

                if StrLen(SecurityDetails) > 2 then
                    SecurityDetails := CopyStr(SecurityDetails, 1, StrLen(SecurityDetails) - 2);

                PreparedBy := MemberSalaryAppraisal."Appraiser ID";
                AppraisalDateForReport := MemberSalaryAppraisal."Loan Appraisal Date";
                if AppraisalDateForReport = 0D then
                    AppraisalDateForReport := MemberSalaryAppraisal."Date";
                if AppraisalDateForReport = 0D then
                    AppraisalDateForReport := Today;
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
    trigger OnInitReport()
    begin
        CI.GET;
        CI.CALCFIELDS(CI.Picture);
    end;

    var
        MemberRec: Record Members;
        IntroducedBy: Text[100];
        CI: Record "Company Information";
        SecurityDetails: Text[1024];
        PreparedBy: Text[100];
        AppraisalDateForReport: Date;
}
