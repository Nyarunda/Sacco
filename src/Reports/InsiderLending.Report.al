Report 50191 "Insider Lending"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Insider Lending.rdlc';
    dataset
    {
        dataitem("Members Register"; Members)
        {
            DataItemTableView = where("Member Category" = const("Staff Members"));
            //DataItemTableView = sorting("No.") where("Employer Code" = const('BIB01'));

            dataitem("Loans Register"; Loans)
            {
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = where(Posted = filter(true), "Outstanding Principal" = filter(> 0));
                RequestFilterFields = "Disbursement Date", "Loan No.", "Member Name";


                column(ReportForNavId_1120054000; 1120054000)
                {
                }
                column(No_MembersRegister; "Members Register"."No.")
                {
                }
                column(Name_MembersRegister; "Members Register".Name)
                {
                }
                column(AccountCategory_MembersRegister; "Members Register"."Account Category")
                {
                }
                column(EmployerCode_MembersRegister; "Members Register"."Employer Code")
                {
                }
                column(SharesRetained_MembersRegister; SharesCapital)
                {
                }
                column(CurrentShares_MembersRegister; Deposits)
                {
                }
                column(ReportForNavId_1000000000; 1000000000)
                {
                }
                column(ClientName_LoansRegister; "Loans Register"."Member No.")
                {
                }
                column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
                {
                }
                column(ApprovedAmount_LoansRegister; "Loans Register"."Total Disbursed")
                {
                }
                column(Installments_LoansRegister; "Loans Register".Installments)
                {
                }
                column(OutstandingBalance_LoansRegisterr; "Loans Register"."Outstanding Principal")
                {
                }
                column(ClientCode_LoansRegister; "Loans Register"."Member No.")
                {
                }
                column(CurrentShares_LoansRegister; Deposits)
                {
                }
                column(Company_Name; Company.Name)
                {
                }
                column(Company_Address; Company.Address)
                {
                }
                column(Company_Address_2; Company."Address 2")
                {
                }
                column(Company_Phone_No; Company."Phone No.")
                {
                }
                column(Company_Fax_No; Company."Fax No.")
                {
                }
                column(Company_Picture; Company.Picture)
                {
                }
                column(Company_Email; Company."E-Mail")
                {
                }
                /*column(PageNo_Members;CurrReport.PageNo)
                {
                }*/
                column(UserId; UserId)
                {
                }
                column(LoanProductTypeName_LoansRegister; "Loans Register"."Loan Product Type Name")
                {
                }
                column(IssuedDate; "Loans Register"."Disbursement Date")
                {
                }
                column(DaysInArrearsNEW_LoansRegister; DaysInArrear)
                {
                }
                column(LoansCategoryNEW_LoansRegister; "Loans Register"."Loans Category-SASRA")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DaysInArrear := 0;
                    ExpectedAmt := 0;
                    AmtPaid := 0;
                    DefAmount := 0;
                    ArrearsDate := 0D;
                    Deposits := 0;
                    SharesCapital := 0;
                    j += 1;

                    SaccoActivities.GetDefaultedAmount("Loans Register"."Loan No.", Today, ExpectedAmt, AmtPaid, DefAmount, DaysInArrear, ArrearsDate, false, GracePeriod);

                    //if DefAmount > 0 then
                    //  DaysInArrear := ROUND(DaysInArrear / 30, 1, '>');

                    if "Loans Register"."Disbursement Date" = 0D then
                        CurrReport.Skip;
                    if "Loans Register"."Repayment Start Date" = 0D then
                        CurrReport.Skip;
                    if "Loans Register".Installments = 0 then
                        CurrReport.Skip;



                    //SFactory.CalculateArrears("Loans Register"."Loan No.");
                    /*
                    SFactory.CalculateArrears("Loan  No."); Also on the following reports and pages:
                    ----PAGES
                    Loans Sub-Page List
                    ----REPORTS
                    Insider Lending
                    Insider Lending -Board
                    Insider Lending -Housing
                    Loans Tracker
                    Loans Above 1 million
                    */
                    Deposits := MemberActivities.GetAccountBalance(Legacy.GetDepositAccounts("Member No."));
                    SharesCapital := MemberActivities.GetAccountBalance(Legacy.GetShareCapitalAccount("Member No."));


                    if j > 1 then begin
                        if LastNo = "Members Register"."No." then begin

                            Deposits := 0;
                            SharesCapital := 0;
                        end;
                    end;

                    LastNo := "Members Register"."No.";


                    /*if MembReg.Get("Loans Register"."Member No.") then begin
                      MembReg.CalcFields(MembReg."Shares Retained",MembReg."Current Shares");
                      SharesCapital:=MembReg."Shares Retained";
                      Deposits:=MembReg."Current Shares";
                     end;*/
                    /*"Loans Register"."Insider-Board":=TRUE;
                    "Loans Register".MODIFY;
                    */

                end;

                trigger OnPreDataItem()
                begin
                    "Loans Register".SetRange(Posted, true);
                end;
            }

            trigger OnAfterGetRecord()
            var
                loansList: Record Loans;
                outstandingBalance: Decimal;
            begin
                outstandingBalance := 0;

                loansList.Reset;
                loansList.SetRange("Member No.", "Members Register"."No.");
                if loansList.FindFirst then begin
                    //loansList.CalcFields("Outstanding Principal");
                    //outstandingBalance := loansList."Outstanding Principal";
                end;

                //if Deposits <= 0 then begin
                //  if outstandingBalance <= 0 then
                //    CurrReport.Skip;
                //end;
            end;
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
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        SharesCapital: Decimal;
        MembReg: Record "Savings Accounts";
        Deposits: Decimal;
        Company: Record "Company Information";
        SaccoActivities: Codeunit "Sacco Activities";
        loanCategory: Text;
        ExpectedAmt: Decimal;
        AmtPaid: Decimal;
        DefAmount: Decimal;
        DaysInArrear: Integer;
        ArrearsDate: Date;
        MemberActivities: Codeunit "Member Activities";
        Legacy: Codeunit Legacy;
        j: Integer;
        LastNo: Code[20];
        GracePeriod: DateFormula;
    //LoansCategorySetup: Record UnknownRecord52208;
    //SFactory: Codeunit UnknownCodeunit50027;
}

