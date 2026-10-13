namespace CentralDB.CentralDB;
using Microsoft.Foundation.Company;

report 50454 "Member Loans Eligibility"
{
    Caption = 'Member Loans Eligibility';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Member Loans Eligibility.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Member Category", "Member Status";
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
            column(Web; Web)
            {
            }
            column(No; "No.")
            {
            }
            column(Status_Members; Members."Member Status")
            {
            }
            column(IDNo; "ID No.")
            {
            }
            column(Name; Name)
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(EmployerName; "Employer Name")
            {
            }

            dataitem("Product Setup"; "Product Setup")
            {
                DataItemTableView = where("Product Class" = filter(Credit), "Dont Show on Member Register" = filter(false));
                RequestFilterFields = "Product ID";
                column(ProductID; "Product ID")
                {
                }
                column(ProductCategory; "Product Category")
                {
                }
                column(LoanBalance; LoanBalance)
                {
                }
                column(MaxQualAmount; MaxQualAmount)
                {
                }
                column(Description; Description)
                {
                }
                column(DepBalance; DepBalance)
                {
                }
                column(Mulitplier; "Product Setup"."Deposit Multiplier")
                {
                }
                trigger OnAfterGetRecord()
                var
                    Account: Record "Savings Accounts";
                begin
                    LoanBalance := 0;
                    MaxQualAmount := 0;
                    ProductID := '';
                    Maxqua := 0;
                    ResCode := '';
                    MultiDepAmt := 0;
                    GuaranteedInApplication := 0;
                    Committed := 0;
                    Available := 0;

                    PSetup.Get();

                    ProductID := "Product Setup"."Product ID";

                    Account.Reset();
                    Account.SetRange("Member No.", MembNo);
                    Account.SetRange("Product Category", Account."Product Category"::"Deposit Contribution");
                    Account.SetAutoCalcFields("Balance (LCY)");
                    Account.LoadFields("Balance (LCY)", "Member No.", "No.", "Product Category");
                    if Account.FindFirst() then begin
                        DepBalance := Account."Balance (LCY)";
                    end else
                        Error(ErrorInfo.Create('Account Not Found'));

                  //  LSecurity.CalculateMobileLoansAvailableShares(Account, MultiDepAmt, GuaranteedInApplication, Committed, Available, false, ProductID);

                    MaxQualAmount := Available;

                    ProductID := "Product Setup"."Product ID";
                    if "Product Setup"."Is Mobile" = true then begin
                        MaxQualAmount := 0;
                        if ProductID = 'L43' then
                            sky.GetDividendLoanQualifiedAmount(Account."No.", ProductID, MaxQualAmount, Remark)
                        else
                            Sky.GetLoanQualifiedAmount(Account."No.", ProductID, MaxQualAmount, Remark, ResCode);

                        MemberActiviies.GetMemberQualificationLoanAmount(Account."Member No.", ProductID, Maxqua, LoanBalance);
                    end else begin
                        MemberActiviies.GetMemberQualificationLoanAmount(Account."Member No.", ProductID, MaxQualAmount, LoanBalance);
                        MaxQualAmount := MaxQualAmount * "Product Setup"."Deposit Multiplier";
                    end;

                    if MaxQualAmount < 0 then MaxQualAmount := 0

                end;

            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                MembNo := Members."No.";
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        IF CompanyInformation.GET THEN
            CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' - ' + CompanyInformation."Post Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No.";//+' ; '+CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail";
#pragma warning disable AL0432
        Web := 'Member Portal: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432

    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Web: Text;
        MemberActiviies: Codeunit "Member Activities";
        Account: Record "Savings Accounts";
        LoanBalance: Decimal;
        DepBalance: Decimal;
        MaxQualAmount: Decimal;
        LProduct: Record "Product Setup";
        ProductID: Code[20];
        MembNo: Code[20];
        PSetup: Record "Sacco Setup";
        Sky: Codeunit "Sky MBanking";
        LocalStringWriter: Text;
        LocalJsonText: Text;
        LocalMsgCode: Text;
        CDate: Date;
        CTime: Time;
        Remark: text[100];
        ResCode: text[10];
        LSecurity: Record "Loan Security";
        MemberAccounts: Record "Savings Accounts";
        SLedger: Record "Savings Ledger Entry";
        SDate: Date;
        EDate: Date;
        TestDate: Date;
        Loans: Record Loans;
        QualAmt: Decimal;
        Maxqua: Decimal;
        MobileLoans: Record "Sky Mobile Loans";
        account_no: Text;
        LoanType: Record "Product Setup";
        DividendAdvance: Record "Dividend Advance";
        DividendAdvanceDefaulter: Record "Dividend Advance - Defaulter";
        eLoanBal: Decimal;
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Committed: Decimal;
        MultiDepAmt: decimal;
        Available: Decimal;
}
