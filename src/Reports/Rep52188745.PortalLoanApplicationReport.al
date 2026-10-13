report 50509 "Portal Loan Application Report"
{
    ApplicationArea = All;
    Caption = 'Portal Loan Application Report';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Portal Loan Application Report.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(PortalLoans; "Portal Loans")
        {
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(AccountName; "Account Name")
            {
            }
            column(AccountNo; "Account No")
            {
            }
            column(Amount; Amount)
            {
            }
            column(ApplicationNo; "Application No.")
            {
            }
            column(ApprovedAmount; "Approved Amount")
            {
            }
            column(Blocked; Blocked)
            {
            }
            column(Branch; Branch)
            {
            }
            column(Category; Category)
            {
            }
            column(CommisionAmount; "Commision Amount")
            {
            }
            column(Date; "Date")
            {
            }
            column(DateDeactivated; "Date Deactivated")
            {
            }
            column(DateEntered; "Date Entered")
            {
            }
            column(DatePosted; "Date Posted")
            {
            }
            column(Deactivated; Deactivated)
            {
            }
            column(DeactivatedBy; "Deactivated By")
            {
            }
            column(DocumentNo; DocumentNo)
            {
            }
            column(EntryCode; "Entry Code")
            {
            }
            column(ExpectedGuarantors; "Expected Guarantors")
            {
            }
            column(FullyGuaranteed; 0)
            {
            }
            column(LatestSalaryAmount; "Latest Salary Amount")
            {
            }
            column(LoanName; "Loan Name")
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(LoanPeriod; "Loan Period")
            {
            }
            column(LoanProductType; "Loan Product Type")
            {
            }
            column(LoanPurpose; "Loan Purpose")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Message; Message)
            {
            }
            column(MicroLoan; "Micro Loan")
            {
            }
            column(MicroLoanCategory; "Micro Loan Category")
            {
            }
            column(NeedsGuarantors; "Needs Guarantors")
            {
            }
            column(NetSalary; "Net Salary")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(Password; Password)
            {
            }
            column(Posted; Posted)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(RequestedAmount; "Requested Amount")
            {
            }
            column(STOAmount; "STO Amount")
            {
            }
            column(SalaryLoan; "Salary Loan")
            {
            }
            column(SessionID; "Session ID")
            {
            }
            column(Source; Source)
            {
            }
            column(Status; Status)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(Company_Picture; CompanyInformation.Picture)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TelephoneNo; "Telephone No")
            {
            }
            column(TimeEntered; "Time Entered")
            {
            }
            column(Totalloans; "Total loans")
            {
            }

            dataitem("Portal Guarantors"; "Portal Guarantors")
            {
                DataItemTableView = where("Guarantor Accepted" = filter(Yes));

                DataItemLink = "Loan Entry No." = field("Application No.");
                column(Guarantor_Member_No_; "Guarantor Member No.")
                {

                }
                column(Guarantor_Name; "Guarantor Name")
                {

                }
                column(Guarantor_Mobile_No_; "Guarantor Mobile No.")
                {

                }
                column(Amount_Requested; 0)
                {

                }
                column(Amount_Guaranteed; "Amount Guaranteed")
                {

                }
            }

            trigger OnPreDataItem()
            begin
                if CompanyInformation.Get then
                    CompanyInformation.CalcFields(CompanyInformation.Picture);
                CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
                CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
                CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail";
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
        CompanyInformation.Get();
        CompanyInformation.CalcFields(CompanyInformation.Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;

}
