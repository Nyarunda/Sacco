namespace UnitedWomen.UnitedWomen;
using Microsoft.Foundation.Company;
using Microsoft.Bank.Check;

report 50584 "Fixed Deposit Termination"
{
    caption = 'Fixed Deposit Termination Slip';
    DefaultLayout = Word;
    WordLayout = './src/Layouts/Fixed Deposit Termination.docx';

    dataset
    {
        dataitem("Savings Accounts"; "Fixed Deposit Accounts")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(DayT; Today)
            {
            }
            column(No; "Savings Accounts"."No.")
            {
            }
            column(Amount; Bal)
            {
            }
            column(FD_Start_Date; "FD Start Date")
            {
            }
            column(Member_No_; "Member No.")
            { }
            column(Name; "Savings Accounts".Name)
            {
            }
            column(FixedDuration; DuratinFD)
            {
            }
            column(Rate; Rate)
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(InterestExpected; InterestExpected)
            {
            }
            column(FD_Amount; "FD Amount" + "Total Interest Earned")
            { }
            column(RefNo; RefNo)
            {
            }
            column(WthTax; WthTax)
            {
            }
            column(MaturityD; MaturityD)
            {
            }
            column(MemberEmail; MemberEmail)
            {

            }
            column(Payee_Bank_Name; "Payee Bank Name")
            { }
            column(Payee_Bank_Account; "Payee Account No.")
            { }
            column(Payee_Branch_Name; "Payee Branch Name")
            { }
            column(Payee_Account_Name; "Payee Account Name")
            { }
            column(compName; COMPANYNAME)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            trigger OnAfterGetRecord()
            var
                SaccoSetup: Record "Sacco Setup";
                Member: Record Members;
            begin

                Rate := "Savings Accounts"."Negotiated Interest %";
                if "Savings Accounts"."Negotiated Interest %" = 0 then
                    Rate := "Savings Accounts"."FD Annual Interest %";

                SaccoSetup.Get();

                Bal := "Savings Accounts"."FD Amount";
                FdType := "Savings Accounts"."FD Type";
                InterestExpected := "Savings Accounts"."Total Expected Interest";
                WthTax := InterestExpected * SaccoSetup.WthTax * 0.01;
                DuratinFD := format("Savings Accounts"."FD Duration");
                MaturityD := "Savings Accounts"."FD Maturity Date";

                if Member.get("Savings Accounts"."Member No.") then begin
                    MemberEmail := Member."E-Mail";

                end;

                if RefNo <> '' then
                    RefNo := "Savings Accounts"."No.";

                //Amount into words
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NumberText, Bal, '')

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
    trigger OnInitReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var

        Rate: Decimal;
        CheckReport: Report Check;
        NumberText: array[2] of Text[120];
        Bal: Decimal;
        RefNo: Code[30];
        InterestExpected: Decimal;
        WthTax: Decimal;
        FdType: Code[20];
        DuratinFD: Code[20];
        MaturityD: Date;
        CompInfo: Record "Company Information";
        MemberEmail: Text[250];
}