namespace UnitedWomen.UnitedWomen;
using Microsoft.Foundation.Company;

report 50549 "Loan Application Register"
{
    ApplicationArea = All;
    Caption = 'Loan Application Register';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/LoanApplicationRegister.rdlc';
    dataset
    {
        dataitem(MemberSalaryAppraisal; "Member Salary Appraisal")
        {
            RequestFilterFields = Status, "Appraiser ID", "Member No.", "Appraisal No.";

            column(AppraisalNo; "Appraisal No.")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Name; Name)
            {
            }
            column(LoanProductType; MemberSalaryAppraisal."Product Description")
            {
            }
            column(RequestedAmount; "Requested Amount")
            {
            }
            column(Status; Status)
            {
            }
            column(AppraiserID; "Appraiser ID")
            {
            }
            column(LoanRejectionReason; "Loan Rejection Reason")
            {
            }
            column(picture; CompanyInfo.Picture)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(email; CompanyInfo."E-Mail")
            {
            }
            column(address; CompanyInfo.Address)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(Appraisal_Completed; "Appraisal Completed") { }
            column(StatusReceived; StatusReceived)
            { }
            column(StatusPending; StatusPending)
            { }
            column(StatusApproved; StatusApproved)
            { }
            column(StatusDeclined; StatusDeclined)
            { }
            column(StatusDeferred; StatusDeferred)
            { }

            trigger OnAfterGetRecord()
            begin
                StatusReceived := true;
                StatusApproved := "Status" = "Status"::Approved;
                StatusDeclined := "Status" = "Status"::Rejected;
                StatusDeferred := false;
                StatusPending := "Status" = "Status"::Pending;
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
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        StatusReceived: Boolean;
        StatusApproved: Boolean;
        StatusDeclined: Boolean;
        StatusDeferred: Boolean;
        StatusPending: Boolean;
}
