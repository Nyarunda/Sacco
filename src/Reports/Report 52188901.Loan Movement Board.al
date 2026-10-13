report 50545 "Loan Movement Board"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Movement Board.rdlc';
    UsageCategory = ReportsandAnalysis;
    ProcessingOnly = false;

    dataset
    {
        dataitem(Member; Members)
        {
            RequestFilterFields = "No.", "Member Status", "Member Category";
            DataItemTableView = SORTING("No.") ORDER(Ascending) where("Member Category" = filter("Staff Members" | "Board Members"));


            column(MemberNo; "No.") { }
            column(MemberName; "Name") { }
            column(MemberType; "Member Category") { }
            column(OpeningBalance; OpeningBalance) { }
            column(IssuedAmount; IssuedAmount) { }
            column(PrincipalPaid; PrincipalPaid) { }
            column(InterestPaid; InterestPaid) { }
            column(ClosingBalance; ClosingBalance) { }

            trigger OnAfterGetRecord()
            begin
                // Calculate totals for the member
                CalculateMemberTotals(Member);
            end;
        }
    }

    trigger OnPreReport()
    begin
        // validate or set defaults if required
    end;

    local procedure CalculateMemberTotals(var pMember: Record Members)
    var
        Loan: Record Loans;
    //LoanPayment: Record "Loan Payment";
    begin
        // Reset totals
        OpeningBalance := 0;
        IssuedAmount := 0;
        PrincipalPaid := 0;
        InterestPaid := 0;
        ClosingBalance := 0;

        // Get all loans for this member
        Loan.SetRange("Member No.", pMember."No.");
        if Loan.FindSet() then
            repeat
                Loan.CalcFields("Outstanding Principal", "Outstanding Interest", "Principal Paid", "Interest Paid");

                // Opening balance = Original approved amount
                OpeningBalance += Loan."Approved Amount";

                // Calculate issued (disbursed amounts)
                if Loan."Disbursement Date" <> 0D then
                    IssuedAmount += Loan."Approved Amount";

                // Calculate principal paid = Approved - Outstanding
                PrincipalPaid += Loan."Principal Paid";

                InterestPaid += Loan."Interest Paid";

                // Outstanding becomes closing balance
                ClosingBalance += Loan."Outstanding Principal" + Loan."Outstanding Interest";
            until Loan.Next() = 0;

        // Calculate interest paid
        //InterestPaid := OpeningBalance - ClosingBalance - PrincipalPaid;
        if InterestPaid < 0 then
            InterestPaid := 0;
    end;

    var
        OpeningBalance: Decimal;
        IssuedAmount: Decimal;
        PrincipalPaid: Decimal;
        InterestPaid: Decimal;
        ClosingBalance: Decimal;
}
