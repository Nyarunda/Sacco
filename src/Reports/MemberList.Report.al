Report 50336 "Member List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Member List.rdlc';

    dataset
    {
        dataitem(Member; Members)
        {
            RequestFilterFields = "No.", "Phone No.", Status, "Payroll/Staff No.", "Registration Date", "Date Filter";
            column(ReportForNavId_1; 1)
            {
            }
            column(No; Member."No.")
            {
            }
            column(Name; Member.Name)
            {
            }
            column(StaffNo; Member."Payroll/Staff No.")
            {
            }
            column(Phone; Member."Phone No.")
            {
            }
            column(ID; Member."ID No.")
            {
            }
            column(Gender; Member.Gender)
            {
            }
            column(DOB; Member."Date of Birth")
            {
            }
            column(RegNo; Member."Registration Date")
            {
            }
            column(Emp; Member."Employer Code")
            {
            }
            column(CreatedBy; Member."Captured By")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Status; Member.Status)
            {
            }
            column(RNo; RNo)
            {
            }
            column(Shares; Shares)
            {
            }
            column(Deposits; Deposits)
            {
            }
            column(Loans; Loans)
            {
            }
            column(TotalL; TotalL)
            {
            }
            column(FosaLoan; FosaLoan)
            {
            }
            column(BosaLoan; BosaLoan)
            {
            }

            trigger OnAfterGetRecord()
            begin
                RNo := RNo + 1;

                Loans := 0;
                Shares := 0;
                Deposits := 0;
                BosaLoan := 0;
                FosaLoan := 0;

                SaccoAccount.Reset;
                SaccoAccount.SetRange(SaccoAccount."Member No.", "No.");
                SaccoAccount.SetFilter(SaccoAccount."Product Category", '%1|%2', SaccoAccount."Product Category"::"Deposit Contribution", SaccoAccount."Product Category"::"Share Capital");
                SaccoAccount.SetFilter(SaccoAccount."Date Filter", Member.GetFilter(Member."Date Filter"));
                if SaccoAccount.Find('-') then begin
                    repeat
                        SaccoAccount.CalcFields("Net Change (LCY)");
                        if SaccoAccount."Product Type" = 'S01' then begin
                            Shares := SaccoAccount."Net Change (LCY)";
                        end;
                        if SaccoAccount."Product Type" = 'S02' then begin
                            Deposits := SaccoAccount."Net Change (LCY)";
                        end;
                    until SaccoAccount.Next = 0;
                end;


                LoansTB.Reset;
                LoansTB.SetRange(LoansTB."Member No.", "No.");
                LoansTB.SetFilter(LoansTB."Date filter", Member.GetFilter(Member."Date Filter"));
                if LoansTB.Find('-') then begin
                    repeat
                        LoansTB.CalcFields(LoansTB."Outstanding Principal");
                        if LoansTB."Outstanding Principal" > 0 then begin
                            Loans := Loans + LoansTB."Outstanding Principal";
                            //Loans:=TotalL+LoansTB."Outstanding Principal";
                        end;
                    until LoansTB.Next = 0;
                end;

                LoansTB.Reset;
                LoansTB.SetRange(LoansTB."Member No.", "No.");
                LoansTB.SetFilter(LoansTB."Date filter", Member.GetFilter(Member."Date Filter"));
                LoansTB.SetRange(LoansTB.Source, LoansTB.Source::BOSA);
                if LoansTB.Find('-') then begin
                    repeat
                        LoansTB.CalcFields(LoansTB."Outstanding Principal");
                        if LoansTB."Outstanding Principal" > 0 then begin
                            BosaLoan := BosaLoan + LoansTB."Outstanding Principal";
                            //Loans:=TotalL+LoansTB."Outstanding Principal";
                        end;
                    until LoansTB.Next = 0;
                end;

                LoansTB.Reset;
                LoansTB.SetRange(LoansTB."Member No.", "No.");
                LoansTB.SetFilter(LoansTB."Date filter", Member.GetFilter(Member."Date Filter"));
                LoansTB.SetRange(LoansTB.Source, LoansTB.Source::FOSA);
                if LoansTB.Find('-') then begin
                    repeat
                        LoansTB.CalcFields(LoansTB."Outstanding Principal");
                        if LoansTB."Outstanding Principal" > 0 then begin
                            FosaLoan := FosaLoan + LoansTB."Outstanding Principal";
                            //Loans:=TotalL+LoansTB."Outstanding Principal";
                        end;
                    until LoansTB.Next = 0;
                end;



                //TotalL:=TotalL+Loans;
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

        MActivities.CheckViewReportsPermmission(UserId);

        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        Company: Record "Company Information";
        RNo: Integer;
        Shares: Decimal;
        Deposits: Decimal;
        Loans: Decimal;
        SaccoAccount: Record "Savings Accounts";
        LoansTB: Record Loans;
        TotalL: Decimal;
        FosaLoan: Decimal;
        BosaLoan: Decimal;
        MActivities: Codeunit "Member Activities";
}

