report 50395 "Remmittance Form"
{
    ApplicationArea = All;
    Caption = 'Remmittance Form';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Remmittance Form.rdlc';
    dataset
    {
        dataitem(Loans; Loans)
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
            column(LoanNo; "Loan No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(IDNo; "ID No.")
            {
            }
            column(LoanInterestRepayment; "Loan Interest Repayment")
            {
            }
            column(LoanPrincipleRepayment; "Loan Principle Repayment")
            {
            }
            column(Schedule_Start_Date; "Schedule Start Date")
            {
            }
            column(Repayment; Repayment)
            {
            }
            column(ExpRepay; ExpRepay)
            {
            }
            column(SAmt; ShareAmt)
            {
            }
            column(FInterest; FullInterest)
            {
            }
            column(CMInterest; CurrentMonthInterest)
            {
            }
            column(TotalPrincipalRepayment; TotalPrincipalRepayment)
            {
            }
            column(FInstallement; FulInstallement)
            {
            }
            column(Repay_Mode; "Repay Mode")
            {
            }
            column(Employer_Name; "Employer Name")
            {
            }
            column(Upfront_Interest_Charge; "Upfront Interest Charge")
            {
            }
            column(Top_Up_Amount; "Top Up Amount")
            {
            }

            dataitem(CurrentLoanApplication; Loans)
            {
                DataItemLink = "Loan No." = FIELD("Loan No.");
                column(Loan_No_CurrentLoanApplication; "Loan No.")
                {
                }
                column(Member_Name_CurrentLoanApplication; "Member Name")
                {
                }
                column(Member_No_CurrentLoanApplication; "Member No.")
                {
                }
                column(Approved_Amount; "Approved Amount")
                {
                }
                column(Outstanding_Principal_CurrentLoanApplication; "Outstanding Principal")
                {
                }
                column(Outstanding_Interest_CurrentLoanApplication; "Outstanding Interest")
                {
                }
                column(Principal_Repayment_CurrentLoanApplication; "Loan Principle Repayment")
                {
                }
                column(Interest_Repayment_CurrentLoanApplication; "Loan Interest Repayment")
                {
                }
                column(Installement_Repayment_CurrentLoanApplication; Installments)
                {
                }
            }

            dataitem(CurrentLoans; Loans)
            {
                DataItemLink = "Member No." = FIELD("Member No.");
                DataItemTableView = where("Total Outstanding Balance" = filter('>0'), Posted = const(true));
                column(Loan_No_currentloans; "Loan No.")
                {
                }
                column(Member_Name_currentloans; "Member Name")
                {
                }
                column(Member_No_currentloans; "Member No.")
                {
                }
                column(Outstanding_Principal_CurrentLoans; "Outstanding Principal")
                {
                }
                column(Outstanding_Interest_CurrentLoans; "Outstanding Interest")
                {
                }
                column(Principal_Repayment; CurrentLoans."Loan Principle Repayment")
                {
                }
                column(Interest_Repayment_CurrentLoans; "Loan Interest Repayment")
                {
                }
                column(Installement_Repayment_CurrentLoans; Installments)
                {
                }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    CurrentLoans.SetFilter("Loan No.", '<>%1', Loans."Loan No.");
                end;
            }


            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                ShareCapital: Decimal;
                SaccoSetup: Record "Sacco Setup";
                SaccoActivities: Codeunit "Sacco Activities";
                MonthlyContrib: Decimal;
            begin
                if Loans."Loan No." = CurrentLoans."Loan No." then
                    CurrReport.Skip;

                TotalPrincipalRepayment := 0;
                LoanTopUpAmount := 0;
                ShareCapital := 0;
                SaccoSetup.Get();
                Loans.CalcFields("Outstanding Interest");

                Ln.Reset();
                Ln.SetRange("Member No.", "Member No.");
                Ln.SetRange("Mobile Loan", false);
                Ln.SetFilter("Outstanding Principal", '>0');
                Ln.SetAutoCalcFields("Outstanding Interest");
                if Ln.FindFirst() then
                    repeat

                        LoanTopUp.Reset();
                        //LoanTopUp.SetRange(LoanTopUp."Member No.", Ln."Member No.");
                        LoanTopUp.SetRange(LoanTopUp."Loan Top Up", Ln."Loan No.");
                        if not LoanTopUp.FindFirst() then
                            repeat
                                CurrentMonthInterest += Ln."Loan Interest Repayment";
                                TotalPrincipalRepayment += Ln."Loan Principle Repayment";
                                ExpRepay += Ln."Loan Interest Repayment" + Ln."Loan Principle Repayment";
                            until LoanTopUp.Next() = 0;

                    until Ln.Next() = 0;

                //CurrentMonthInterest += Loans."Outstanding Interest";

                SAcc.Reset();
                SAcc.SetRange("Member No.", Loans."Member No.");
                Sacc.SetFilter("Product Category", '%1|%2|%3', SAcc."Product Category"::"Share Capital", SAcc."Product Category"::"Deposit Contribution", SAcc."Product Category"::"Benevolent Fund");
                //SAcc.SetFilter("Monthly Contribution", '>0');
                if SAcc.FindFirst() then
                    repeat
                        ShareCapital := 0;
                        Psetup.Get(SAcc."Product Type");
                        SAcc.CalcFields("Balance (LCY)");
                        if SAcc."Product Category" = SAcc."Product Category"::"Share Capital" then
                            if SAcc."Balance (LCY)" >= SaccoSetup."Minimum Share Capital" then begin
                                ShareCapital := SAcc."Monthly Contribution";
                                if SAcc."Monthly Contribution" = 0 then
                                    ShareCapital := Psetup."Minimum Contribution";
                            end;

                        if SAcc."Product Category" = SAcc."Product Category"::"Deposit Contribution" then begin
                            SaccoActivities.UpdateMonthlyRepayment(Loans, MonthlyContrib);
                            if MonthlyContrib = 0 then begin
                                MonthlyContrib := SAcc."Monthly Contribution";
                                if SAcc."Monthly Contribution" <= 0 then
                                    MonthlyContrib := Psetup."Minimum Contribution";
                            end;

                            ShareAmt += SAcc."Monthly Contribution";
                        end
                        else
                            ShareAmt += SAcc."Monthly Contribution";

                        if Psetup."Product Category" <> Psetup."Product Category"::"Deposit Contribution" then
                            if SAcc."Monthly Contribution" <= 0 then
                                ShareAmt += Psetup."Minimum Contribution";

                        ShareAmt -= ShareCapital;
                    until SAcc.next() = 0;

                FulInstallement := 0;

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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);

        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
#pragma warning disable AL0432
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
#pragma warning restore AL0432

    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Ln: Record Loans;
        SAcc: Record "Savings Accounts";
        Psetup: Record "Product Setup";
        ShareAmt: decimal;
        CurrentMonthInterest: Decimal;
        FullInterest: Decimal;
        ExpRepay: Decimal;
        TotalPrincipalRepayment: Decimal;
        FulInstallement: Decimal;
        LoanTopUpAmount: Decimal;
        LoanTopUp: Record "Loan Top Up";
        TotalRepayment: Decimal;
}
