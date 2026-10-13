
Report 50132 "Loan Guarantors Reports"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Guarators Reports.rdlc';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
            DataItemTableView = sorting("No.") order(ascending);
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(No_Members; "No.")
            {
            }
            column(Name_SACCOAccount; Name)
            {
            }
            column(MemberNo_SACCOAccount; '')
            {
            }
            column(Mobile_Phone_No_; "Mobile Phone No.")
            { }
            column(CompanyInfo_Name; Company.Name)
            {
            }
            column(CompanyInfo_Address; Company.Address)
            {
            }
            column(CompanyInfo__Phone_No__; Company."Phone No.")
            {
            }
            column(CompanyInfo__E_Mail_; Company."E-Mail")
            {
            }
            column(CompanyInfo_City; Company.City)
            {
            }
            column(CompanyInfo_Picture; Company.Picture)
            {
            }
            column(CompanyInfo_SMS; Company."Phone No. 2")
            {
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = where("Total Outstanding Balance" = filter(> 0));
                column(ReportForNavId_1102755001; 1102755001)
                {
                }
                column(CurrentLoansCategorySASRA_Loans; "Loans Category-SACCO")
                {
                }
                column(LoanNo_Loans; "Loan No.")
                {
                }
                column(ApplicationDate_Loans; "Application Date")
                {
                }
                column(LoanProductType_Loans; "Loan Product Type")
                {
                }
                column(RequestedAmount_Loans; "Requested Amount")
                {
                }
                column(LoanProductTypeNam; "Loan Product Type Name")
                {
                }
                column(ApprovedAmount_Loans; "Approved Amount")
                {
                }
                column(Repayment_Start_Date_Loans; "Repayment Start Date")
                {
                }
                column(Completion_Date_Loans; "Completion Date")
                { }
                dataitem("Loan Security"; "Loan Security")
                {
                    DataItemLink = "Loan No." = field("Loan No.");
                    CalcFields = "Guaranteed By";
                    column(ReportForNavId_1102755002; 1102755002)
                    {
                    }
                    column(MemberNo_LoanGuarantors; GNo)
                    {
                    }
                    column(Name_LoanGuarantors; GDetails)
                    {
                    }
                    column(LoanBalance_LoanGuarantors; "Guarantor Loan Balance")
                    {
                    }
                    column(Shares_LoanGuarantors; "Guarantor Deposits")
                    {
                    }
                    column(NoOfLoansGuaranteed_LoanGuarantors; "Loans Guaranteed")
                    {
                    }
                    column(Current_Committed; "Current Committed")
                    {
                    }
                    column(Substituted_LoanGuarantors; Sub)
                    {
                    }
                    column(Date_LoanGuarantors; Date)
                    {
                    }
                    column(SharesRecovery_LoanGuarantors; '')
                    {
                    }
                    column(NewUpload_LoanGuarantors; '')
                    {
                    }
                    column(Amount_Guaranteed; "Amount Guaranteed")
                    {
                    }
                    column(StaffPayrollNo_LoanGuarantors; "Staff/Payroll No.")
                    {
                    }
                    column(AccountNo_LoanGuarantors; "Account No.")
                    {
                    }
                    column(SelfGuarantee_LoanGuarantors; "Self Guarantee")
                    {
                    }
                    column(IDNo_LoanGuarantors; "ID No.")
                    {
                    }
                    column(OutstandingBalance_LoanGuarantors; "Outstanding Principal")
                    {
                    }
                    column(MemberGuaranteed_LoanGuarantors; "Member Guaranteed")
                    {
                    }
                    column(Outstanding_Interest; "Outstanding Interest")
                    {
                    }
                    column(Substituted_Member; "Substituted Member")
                    {
                    }
                    column(Guaranteed_By; "Guaranteed By")
                    {
                    }
                    column(CurrentShares; Currentshares)
                    {
                    }
                    column(Phone; Phone)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        Coll: Record "Loan Collateral Register";
                        savAccRec: Record "Savings Accounts";
                    begin
                        Phone := '';
                        currentshares := 0;

                        GNo := "Loan Security"."Member No";
                        GDetails := "Loan Security".Name;

                        Sub := '';
                        if Substituted then begin
                            Sub := 'Yes';
                            "Current Committed" := 0;
                        end;

                        if "Loan Security"."Guarantor Type" = "Loan Security"."guarantor type"::Collateral then begin
                            GNo := "Loan Security"."Collateral Reg. No.";
                            //"Loan Security"."Guarantor Deposits":=0;
                            Coll.Get("Loan Security"."Collateral Reg. No.");
                            if not Coll.IsEmpty() then begin
                                "Loan Security".CalcFields("Security Details");
                                GDetails := "Loan Security"."Security Details";
                            end;
                        end;

                        savAccRec.Reset();
                        savAccRec.SetLoadFields("Balance (LCY)");
                        savAccRec.SetRange("Member No.", "Loan Security"."Member No");
                        savAccRec.SetRange("Product Category", savAccRec."Product Category"::"Deposit Contribution");
                        if savAccRec.FindFirst() then
                            savAccRec.CalcFields("Balance (LCY)");

                        Currentshares := savAccRec."Balance (LCY)";


                        Member.Get("Loan Security"."Member No");
                        Phone := Member."Mobile Phone No.";
                    end;
                }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin

                    if SelectedLoan <> '' then
                        SetRange("Loan No.", SelectedLoan);
                end;

            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Company.Get;
        Company.CalcFields(Company.Picture);
    end;

    procedure SetLoanFilter(Ln: Code[20])
    var
        myInt: Integer;
    begin
        SelectedLoan := Ln;
    end;

    var
        Company: Record "Company Information";
        GDetails: Text;
        GNo: Code[20];
        Sub: Text;
        Phone: Code[15];
        Member: record Members;
        SelectedLoan: Code[20];
        Currentshares: Decimal;
}

