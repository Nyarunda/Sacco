namespace UnitedWomen.UnitedWomen;
using Microsoft.Foundation.Company;

report 50552 "Appraisal Report - Board"
{
    ApplicationArea = All;
    Caption = 'Appraisal Report - Board';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/AppraisalReportBoard.rdlc';

    dataset
    {
        dataitem(MemberSalaryAppraisal; "Member Salary Appraisal")
        {
            column(Picture; CI.picture)
            {
            }
            column(C_Name; CI.Name)
            {
            }
            column(DatePrepared; AppraisalDateForReport)
            {
            }
            column(IntroducedBy; IntroducedBy)
            {
            }
            column(Name; Name)
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(ShareDeposits; "Share Deposits")
            {
            }
            column(GetMemberAge; GetMemberAge())
            {
            }
            column(Qualification_As_Per_Deposits; "Qualification As Per Deposits")
            {
            }
            column(RequestedAmount; "Requested Amount")
            {
            }
            column(LoanPurpose; "Loan Purpose")
            {
            }
            column(BusinessDescription; "Business Description")
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
            dataitem("Loan Guarantors and Security"; "Loan Security")
            {

                DataItemLink = "Loan No." = field("Appraisal No.");
                column(ReportForNavId_60; 60)
                {
                }
                column(SavingsAccountNoMemberNo_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Member No")
                {
                }
                column(Name_LoanGuarantorsandSecurity; SecDetails)
                {
                }
                column(AmountGuaranteed_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Amount Guaranteed")
                {
                }
                column(AvailableGuarantorship_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Available Guarantorship")
                {
                }
                column(GuarDeposits; "Loan Guarantors and Security"."Guarantor Deposits")
                {
                }
                column(GuarantorType_LoanGuarantorsandSecurity; "Loan Guarantors and Security"."Guarantor Type")
                {
                }
                column(ActualDeposits; "Loan Guarantors and Security"."Guarantor Deposits")
                {
                }
                column(Member_Deposits; "Loan Guarantors and Security"."Member Deposits")
                {
                }
                trigger OnAfterGetRecord()
                var
                    SavAcc: Record "Savings Accounts";
                begin
                    case "Loan Guarantors and Security"."Guarantor Type" of
                        "Loan Guarantors and Security"."Guarantor Type"::Collateral:
                            SecDetails := Format("Loan Guarantors and Security"."Collateral Type");
                        "Loan Guarantors and Security"."Guarantor Type"::Guarantor:
                            SecDetails := "Loan Guarantors and Security".Name;
                        "Loan Guarantors and Security"."Guarantor Type"::Lien:
                            if "Loan Guarantors and Security"."Security Details" <> '' then
                                SecDetails := "Loan Guarantors and Security"."Security Details"
                            else
                                SecDetails := "Loan Guarantors and Security".Name;
                    end;

                    /*  if SavAcc.get("Loan Guarantors and Security"."Account No.") then
                         SecDetails := StrSubstNo("Loan Guarantors and Security".Name + ':' + SavAcc."Product Name"); */
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if MemberRec.get("Member No.") then
                    IntroducedBy := StrSubstNo(MemberRec."Recruited By Name" + ':' + MemberRec."Recruited By", 1, 100);

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
        SecDetails: Text[100];
        PreparedBy: Text[100];
        AppraisalDateForReport: Date;
}
