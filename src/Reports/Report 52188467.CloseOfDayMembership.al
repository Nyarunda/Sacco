
Report 50130 "Close of Day Membership Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/CloseofDayMembership.rdlc';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "Registration Date";
            column(membership_No; Members."No.")
            { }
            column(Name; Members.Name)
            { }
            column(Rejoining_Member; Members.Rejoined)
            { }
            column(Intorducer_Member_No; Members."Recruited By")
            { }
            column(Introducer_Name; Members."Recruited By Name")
            { }
            column(Payment_Amount; PaymentAmount)
            { }
            column(Date_Generated; Today)
            { }
            column(Reference_Code; Members."Reference Code")
            { }
            column(Transaction_Reference_No; Members."Reference Code")
            { }
            column(Registration_Date; Members."Registration Date")
            { }
            column(Confirmation_of_payment; ConfirmationOfPayment)
            { }
            column(Letter_Sent; LetterSent)
            { }
            column(CompanyInfo_name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            Column(PreparedBy; Members."Captured By")
            {
            }

            trigger OnAfterGetRecord()
            begin
                PaymentAmount := GetPaymentAmount("No.", "Registration Date");
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(ConfirmationOfPayment; ConfirmationOfPayment)
                    {
                        ApplicationArea = All;
                        Caption = 'Confirmation of Payment';
                    }

                    field(LetterSent; LetterSent)
                    {
                        ApplicationArea = All;
                        Caption = 'Letter Sent';
                    }
                }
            }
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
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        PaymentAmount: Decimal;
        ConfirmationOfPayment: Text[10];
        LetterSent: Text[10];
        CompanyInfo: Record "Company Information";

    local procedure GetPaymentAmount(MemberNo: Code[20]; RegistrationDate: Date): Decimal
    var
        PaymentTotal: Decimal;
    begin
        PaymentTotal := GetRegistrationFeePaymentAmount(MemberNo, RegistrationDate);

        if PaymentTotal = 0 then
            PaymentTotal := GetRegistrationFeePaymentAmount(MemberNo, 0D);

        // Excise duty is posted to the Excise Duty G/L account, rather than to a
        // savings account. Include it so the report shows the full amount paid.
        PaymentTotal += GetRegistrationFeeExciseDutyAmount(Members."Reference Code");

        exit(PaymentTotal);
    end;

    local procedure GetRegistrationFeePaymentAmount(MemberNo: Code[20]; PostingDate: Date): Decimal
    var
        SavingsAccount: Record "Savings Accounts";
        PaymentTotal: Decimal;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
    begin
        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", MemberNo);
        //SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Registration Fee");

        if SavingsAccount.FindSet() then
            repeat
                SavingsLedgerEntry.Reset();
                SavingsLedgerEntry.SetRange("Account No.", SavingsAccount."No.");
                SavingsLedgerEntry.SetRange(Reversed, false);
                SavingsLedgerEntry.SetRange("Document No.", Members."Reference Code");
                if SavingsLedgerEntry.FindSet() then
                    repeat
                        PaymentTotal += Abs(SavingsLedgerEntry.Amount);
                    until SavingsLedgerEntry.Next() = 0;
            until SavingsAccount.Next() = 0;

        exit(PaymentTotal);
    end;

    local procedure GetRegistrationFeeExciseDutyAmount(DocumentNo: Code[50]): Decimal
    var
        GLEntry: Record "G/L Entry";
        SaccoSetup: Record "Sacco Setup";
        ExciseDutyTotal: Decimal;
    begin
        if (DocumentNo = '') or not SaccoSetup.Get() or (SaccoSetup."Excise Duty GL" = '') then
            exit;

        GLEntry.SetRange("Document No.", DocumentNo);
        GLEntry.SetRange("G/L Account No.", SaccoSetup."Excise Duty GL");
        GLEntry.SetRange(Reversed, false);
        if GLEntry.FindSet() then
            repeat
                ExciseDutyTotal += Abs(GLEntry.Amount);
            until GLEntry.Next() = 0;

        exit(ExciseDutyTotal);
    end;
}

