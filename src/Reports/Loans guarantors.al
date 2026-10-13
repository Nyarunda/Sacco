report 50558 "Loans Guarantors"
{
    DefaultLayout = RDLC;
    Caption = 'Loans I Have Guaranteed';
    RDLCLayout = './src/Layouts/Loans Guarantors.rdlc';

    dataset
    {
        dataitem("Members Register"; Members)
        {
            RequestFilterFields = "No.", Name;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Companyinfo.Name)
            {
            }
            column(CompanyInfo_Address; Companyinfo.Address)
            {
            }
            column(CompanyInfo__Phone_No__; Companyinfo."Phone No.")
            {
            }
            column(CompanyInfo__E_Mail_; Companyinfo."E-Mail")
            {
            }
            column(CompanyInfo_City; Companyinfo.City)
            {
            }
            column(CompanyInfo_Picture; Companyinfo.Picture)
            {
            }

            column(No_Members; "Members Register"."No.")
            {
            }
            column(RNo; RNo)
            {
            }
            column(Name_Members; "Members Register".Name)
            {
            }
            column(PhoneNo_Members; "Members Register"."Phone No.")
            {
            }

            dataitem("Loans Guarantee Details"; "Loan Security")
            {
                CalcFields = "Outstanding Principal";
                DataItemLink = "Member No" = FIELD("No.");
                DataItemTableView = WHERE("Outstanding Principal" = FILTER(<> 0),
                                          Substituted = FILTER(false),
                                          "Self Guarantee" = CONST(false));
                RequestFilterFields = "Member No", "Loan No.";
                column(AmontGuaranteed_LoanGuarantors; "Loans Guarantee Details"."Amount Guaranteed")
                {
                }
                column(NoOfLoansGuaranteed_LoanGuarantors; "Loans Guarantee Details"."No Of Loans Gua.")
                {
                }
                column(Name_LoanGuarantors; "Loans Guarantee Details".Name)
                {
                }
                column(MemberNo_LoanGuarantors; "Loans Guarantee Details"."Member No")
                {
                }
                column(LoanNo_LoanGuarantors; "Loans Guarantee Details"."Loan No.")
                {
                }
                column(LoanProduct_BOSALoansGuarantors; "Loans Guarantee Details"."Loan Type Name")
                {
                }
                column(No; no)
                {
                }
                column(OutstandingBalance_LoanGuarantors; "Loans Guarantee Details"."Outstanding Principal")
                {
                }
                column(OutstandingBAlSt; OutstandingBAlSt)
                {
                }
                column(OutStandingBal; OutStandingBal)
                {
                }
                column(TotalOutstandingBal; TotalOutstandingBal)
                {
                }
                column(FNo; FNo)
                {
                }
                column(AmountGuar; AmountGuar)
                {
                }
                column(LoaneesName_LoanGuarantors; "Loans Guarantee Details"."Loanee Name")
                {
                }
                column(LoaneesNo_LoanGuarantors; "Loans Guarantee Details"."Member Guaranteed")
                {
                }
                column(SelfGuaranteedAmount; SelfGuaranteedAmount)
                {
                }
                column(LoaneeCurrentShares; LoaneeCurrentShares)
                {
                }
                column(CurrentLoanObligation; "Loans Guarantee Details"."Current Committed")
                {
                }
                column(GuaranteeOnHolidaySavings; GuaranteeOnHolidaySavings)
                {
                }
                column(GuaranteeOnFixedDeposits_LoansGuaranteeDetails; GuaranteeOnFixedDeposits)
                {
                }
                dataitem("Loans Register"; Loans)
                {
                    DataItemLink = "Loan No." = FIELD("Loan No.");
                    CalcFields = "Outstanding Principal";
                    column(Client_Code; "Loans Register"."Member No.")
                    {
                    }
                    column(Client_Name; "Loans Register"."Member Name")
                    {
                    }
                    column(EmployerCode_Loans; "Loans Register"."Employer Code")
                    {
                    }
                    column(OutstandingBalance_Loans; "Loans Register"."Outstanding Principal")
                    {
                    }
                    column(ApprovedAmount; "Loans Register"."Approved Amount")
                    { }

                    trigger OnPreDataItem()
                    begin
                        OutStandingBal := 0;
                        TotalOutstandingBal := 0;
                        OutStandingBal := OutStandingBal;
                        TotalOutstandingBal := TotalOutstandingBal;
                    end;
                }

                trigger OnAfterGetRecord()
                var

                    SavingsGuarantorship: Record "Savings Accounts";
                begin
                    SavingsGuarantorship.Reset();
                    SavingsGuarantorship.SetRange("No.", "Loans Guarantee Details"."Account No.");
                    IF SavingsGuarantorship.FindFirst() THEN begin
                        case SavingsGuarantorship."Product Category" of
                            SavingsGuarantorship."Product Category"::"Holiday Savings":
                                begin
                                    GuaranteeOnHolidaySavings := "Loans Guarantee Details"."Amount Guaranteed";
                                end;
                            SavingsGuarantorship."Product Category"::"Fixed Deposit":
                                begin
                                    GuaranteeOnFixedDeposits := "Loans Guarantee Details"."Amount Guaranteed";
                                end;
                        end;

                    end;
                end;
            }
        }
    }
    requestpage
    {


    }

    labels
    {
    }


    trigger OnPreReport()
    begin
        Companyinfo.GET();
        Companyinfo.CALCFIELDS(Companyinfo.Picture);
    end;

    var
        GuaranteeOnHolidaySavings: Decimal;
        GuaranteeOnFixedDeposits: Decimal;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        AvailableSH: Decimal;
        MemberNo: Text;
        MemberName: Text;
        EmployerCode: Text;

        no: Integer;
        TotalOutstandingBal: Decimal;
        OutStandingBal: Decimal;
        FNo: Integer;
        AmountGuar: Decimal;
        OutstandingBAlSt: Decimal;
        RNo: Integer;

        Companyinfo: Record "Company Information";
        Counter: Integer;
        CurrentLoanObligation: Decimal;

        SelfGuaranteedAmount: Decimal;
        LoaneeCurrentShares: Decimal;
        ApprovedAmount: Decimal;
        NewCurrentObligation: Decimal;



}

