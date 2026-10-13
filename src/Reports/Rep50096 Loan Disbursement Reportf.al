report 50096 "Loan Disbursement Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Disbursement Report.rdlc';

    dataset
    {
        dataitem("Loan Disbursement Buffer"; "Loan Disbursement Buffer")
        {
            column(Loan_Type; "Loan Type") { }
            column(Branch; "Branch") { }
            column(Amount_Previous_Month; "Amount Previous Month") { }
            column(Amount_Current_Month; "Amount Current Month") { }
            column("Variance"; "Variance") { }
            column(Previous_Month; "Previous Month") { }
            column(Current_Month; "Current Month") { }
            column(No__of_Applicants; "No. of Applicants") { }
            column(Total_Previous_Month; "Total Previous Month") { }
            column(Total_Current_Month; "Total Current Month") { }
            column(Total_Amount; "Total Amount") { }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                LoanBuffer.DeleteAll();

                PopulateLoanDisbursementBuffer(StartDate);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Options")
                {
                    field("Start Date"; StartDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;

    procedure PopulateLoanDisbursementBuffer(StartDate: Date)
    var

        Loans: Record Loans;
        ApplicantCount: Integer;
        i: Integer;
        LoanType: Code[30];
        Branch: Code[20];
        PSetup: Record "Product Setup";
    begin

        PSetup.Reset();
        PSetup.SetRange(Status, PSetup.Status::Active);
        PSetup.SetRange("Product Class", PSetup."Product Class"::Credit);
        if PSetup.FindSet() then begin
            repeat

                ApplicantCount := 0;
                Branch := '';
                LoanType := '';
                for i := 1 to 2 do begin
                    Loans.Reset();
                    Loans.SetRange(Posted, false);
                    Loans.SetRange("Loan Product Type", PSetup."Product ID");
                    if i = 1 then
                        Loans.SetRange("Disbursement Date", CalcDate('-CM', StartDate), CalcDate('CM', StartDate));
                    if i = 2 then
                        Loans.SetRange("Disbursement Date", CalcDate('-CM-1M', StartDate), CalcDate('CM-1M', StartDate));
                    if Loans.FindSet() then begin
                        Loans.CalcSums("Amount To Disburse");
                        LoanType := Loans."Loan Product Type Name";
                        Branch := Loans."Booking Branch";

                        // Insert into buffer
                        LoanBuffer.Init();
                        LoanBuffer."Loan Type" := LoanType;
                        LoanBuffer."Branch" := Branch;
                        if i = 1 then begin
                            LoanBuffer."Amount Current Month" := Loans."Amount To Disburse";
                            ApplicantCount := Loans.Count;
                        end;
                        if i = 2 then
                            LoanBuffer."Amount Previous Month" := Loans."Amount To Disburse";
                        LoanBuffer."Total Amount" := LoanBuffer."Amount Previous Month" + LoanBuffer."Amount Current Month";
                        LoanBuffer.Variance := LoanBuffer."Amount Current Month" - LoanBuffer."Amount Previous Month";
                        LoanBuffer."Previous Month" := Format(CalcDate('-CM-1M', StartDate), 0, '<Month Text>');
                        LoanBuffer."Current Month" := Format(CalcDate('-CM', StartDate), 0, '<Month Text>');
                        LoanBuffer."No. of Applicants" := ApplicantCount;
                        LoanBuffer.Insert();

                    end;
                end;
            until Psetup.Next() = 0;
        end;
    end;

    var
        LoanBuffer: Record "Loan Disbursement Buffer";
}
