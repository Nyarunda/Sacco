Report 50351 "Checkoff Variance Report - Ext"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Checkoff Variance Report - Ext.rdlc';

    dataset
    {
        dataitem(MHeader; "Monthly Checkoff Header")
        {
            RequestFilterFields = "No.";
            column(EndDate_CheckoffAdviceHeader; MHeader."Posting Date")
            {
            }
            column(EmployerCode_CheckoffAdviceHeader; "Employer Code")
            {
            }
            column(EmployerName_CheckoffAdviceHeader; "Account No.")
            {
            }
            dataitem("MCLines"; "Monthly Checkoff Lines")
            {
                DataItemLinkReference = MHeader;
                DataItemLink = "Checkoff Header" = field("No.");
                column(ChkMember_No_; "Member No.")
                {
                }
                column(ChkProduct_Name; "Product Name")
                {
                }
                column(NotAdvised; NotAdvised)
                {
                }
                column(ReportForNavId_1; 1)
                {
                }
                column(Payroll_No; "Payroll No.")
                {
                }
                column(ExpAmt; ExpAmt)
                {
                }
                column(ChkAmt; ChkAmt)
                {
                }
                column(Variance; Variance)
                {
                }
                column(Member_No_; "Member No.")
                {
                }
                column(Account_No_; "Account No.")
                {
                }
                column(Name; Name)
                {
                }
                column(Loan_No_; "Loan No.")
                {
                }
                column(Amount; Amount)
                {
                }
                column(Type; Type)
                {
                }
                column(Product_Name; "Product Name")
                {
                }
                column(Product_Type; "Product ID")
                {
                }
                column(CompanyName; Company.Name)
                {
                }
                column(CompanyPicture; Company.Picture)
                {
                }


                trigger OnAfterGetRecord()
                var
                    Adv: Record "Monthly Advice";
                    AdvHeader: Record "Monthly Advice Header";
                    MCHeader: Record "Monthly Checkoff Header";
                begin
                    NotAdvised := 0;
                    ChkAmt := 0;
                    ExpAmt := 0;

                    CheckOffNo := "Checkoff Header";

                    MCHeader.get(CheckOffNo);

                    /*Adv.Reset();
                    Adv.SetRange("Advice Header No.", MCHeader."Advice No");
                    Adv.SetRange("Member No.", "Member No.");
                    Adv.SetRange("Product TYpe", MCLines."Product ID");
                    if Adv.FindFirst() then
                        CurrReport.Skip()
                    else begin
                        NotAdvised := ChkLines.Amount;
                    end;

                    if NotAdvised = 0 then
                        CurrReport.skip;
                        */

                    ChkAmt := MCLines.Amount;

                    Loans.Reset;
                    Loans.SetRange("Loan No.", MCLines."Loan No.");
                    Loans.SetFilter(Loans."Total Outstanding Balance", '>0');
                    //Loans.SetRange("Repay Mode", Loans."Repay Mode"::"Check Off");
                    if Loans.Find('-') then begin
                        //repeat


                        Cust.Get(Loans."Member No.");
                        if (Cust."Member Status" <> Cust."Member Status"::Closed) and (Cust."Member Status" <> Cust."Member Status"::Deceased) then begin

                            Loans.CalcFields(
                                "Schedule Interest", "Schedule Principal",
                                "Outstanding Principal", "Outstanding Interest",
                                "Outstanding Penalty", "Outstanding Appraisal",
                                "Total Outstanding Balance"
                            );

                            LSchedule.Reset();
                            LSchedule.SetRange("Loan No.", Loans."Loan No.");
                            LSchedule.SetRange("Repayment Date", CalcDate('-CM', Today), CalcDate('CM', Today));
                            if LSchedule.FindFirst() then begin
                                case MCLines.Type of
                                    MCLines.Type::Principal:
                                        ExpAmt := LSchedule."Monthly Principal";
                                    MCLines.Type::Interest:
                                        ExpAmt := LSchedule."Monthly Interest";
                                end;
                            end else begin
                                case MCLines.Type of
                                    MCLines.Type::Principal:
                                        ExpAmt := LSchedule."Monthly Principal";
                                    MCLines.Type::Interest:
                                        ExpAmt := LSchedule."Monthly Interest";
                                end;
                            end;
                        end;

                        //until Loans.Next() = 0;
                    end;

                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("No.", MCLines."Account No.");
                    SavingsAccounts.SetRange("Repay Mode", SavingsAccounts."Repay Mode"::"Check Off");
                    SavingsAccounts.SetFilter("Monthly Contribution", '>0');
                    if SavingsAccounts.Find('-') then begin
                        ExpAmt := SavingsAccounts."Monthly Contribution";
                    end;


                    Variance := ExpAmt - ChkAmt;

                    //if Variance = 0 then
                    //   CurrReport.Skip();

                end;
            }

            /*dataitem("Monthly Advice"; "Monthly Advice")
            {
                DataItemLinkReference = Mheader;
                DataItemLink = "Advice Header No." = field("Advice No");
                // DataItemTableView = where("Loan No." = filter(<> ''));

                column(ReportForNavId_1; 1)
                {
                }
                column(Payroll_No; "Payroll No")
                {
                }
                column(ExpAmt; ExpAmt)
                {
                }
                column(ChkAmt; ChkAmt)
                {
                }
                column(Variance; Variance)
                {
                }
                column(Advice_Type; "Advice Type")
                {
                }
                column(Member_No_; "Member No.")
                {
                }
                column(Account_No_; "Account No.")
                {
                }
                column(Name; Name)
                {
                }
                column(Loan_No_; "Loan No.")
                {
                }
                column(Amount; Amount)
                {
                }
                column(Product_Name; "Product Name")
                {
                }
                column(Product_Type; "Product Type")
                {
                }
                column(CompanyName; Company.Name)
                {
                }
                column(CompanyPicture; Company.Picture)
                {
                }
                column(EmployerCode_CheckoffAdviceHeader; "Employer Code")
                {
                }
                column(EmployerName_CheckoffAdviceHeader; "Monthly Advice"."Employer Account No.")
                {
                }
                column(EndDate_CheckoffAdviceHeader; "Advice Date")
                {
                }
                column(Period_CheckoffAdviceHeader; "Monthly Advice"."Loan Period")
                {
                }


                trigger OnAfterGetRecord()
                begin
                    ExpAmt := Amount;
                    ChkAmt := 0;
                    ChkLines.Reset();
                    ChkLines.SetRange("Checkoff Header", CheckOffNo);
                    ChkLines.SetRange("Member No.", "Member No.");
                    ChkLines.SetRange("Product ID", "Product Type");
                    if ChkLines.FindFirst() then begin
                        repeat
                            ChkAmt += ChkLines.Amount;
                        until ChkLines.Next() = 0;
                    end;
                    Variance := ExpAmt - ChkAmt;

                    if Variance = 0 then
                        CurrReport.Skip();

                end;

            }*/
            trigger OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Picture);
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

    var
        ProductFactory: Record "Product Setup";
        Loans: Record Loans;
        Cust: Record Members;
        ClolumHeader: Code[10];
        ColumnValue: Decimal;
        MemberNo: Code[10];
        PayrollNo: Code[10];
        Name: Text;
        Interest: Decimal;
        ExpAmt: Decimal;
        Turn: Integer;
        CulumnA: array[50] of Code[10];
        Company: Record "Company Information";
        i: Integer;
        EDcode: Code[10];
        SaccoCode: Code[10];
        NarationCode: Text;
        IntCode: Integer;
        ActionCode: Code[10];
        TransCode: Integer;
        ChAdvice: Record "Monthly Advice";
        ChkAmt: Decimal;
        AccBalance: Decimal;
        HeaderNo: Code[20];
        Variance: Decimal;
        LSchedule: Record "Loan Repayment Schedule";
        SavingsAccounts: Record "Savings Accounts";
        SDate: Date;
        EDate: Date;
        AdvDate: Date;
        EmpCode: Code[20];
        CheckOffNo: Code[20];
        ChkLines: Record "Monthly Checkoff Lines";
        NotAdvised: Decimal;
}