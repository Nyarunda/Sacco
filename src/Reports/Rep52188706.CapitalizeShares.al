report 50369 "Capitalize Shares"
{
    ApplicationArea = All;
    Caption = 'Capitalize Shares';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Capitalized Shares.rdlc';

    dataset
    {
        dataitem(Vendor; "Savings Accounts")
        {
            DataItemTableView = where("Creditor Type" = const(Fosa), "Product Type" = const('S01'));
            CalcFields = "Balance (LCY)";
            RequestFilterFields = "No.", "Member No.";

            column(No_; "No.") { }
            column(Name; Name) { }
            column(Member_No_; "Member No.") { }
            column(RemainingAmount; RemainingAmount) { }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }


            trigger OnAfterGetRecord()
            var
                PSetup: Record "Product Setup";
                MinBal: Decimal;

                MaxDeductible: Decimal;


            begin


                if PSetup.Get(Vendor."Product Type") then begin
                    MinBal := PSetup."Mandatory Contribution";
                end;
                MaxDeductible := 5000;
                if Vendor."Balance (LCY)" < MinBal then begin
                    RemainingAmount := MinBal - Vendor."Balance (LCY)";
                    if RemainingAmount > MaxDeductible then RemainingAmount := MaxDeductible;

                    //function to transfer Remaining Amount from S02 to S01
                    if RemainingAmount > 0 then TransferRemainingAmount(RemainingAmount, Vendor."Member No.", Vendor."No.");
                end;
            end;

            trigger OnPreDataItem()
            var
                VLE: Record "Savings Ledger Entry";
                PrevDay: Date;
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);

                PrevDay := CalcDate('-1D', Today);

                //check if already Recovered & skip record
                VLE.Reset;
                VLE.SetRange("Account No.", Vendor."No.");
                VLE.setfilter(VLE."Posting Date", '%1..%2', PrevDay, Today);
                if VLE.FindFirst() then
                    Vendor.SetFilter("No.", '<>%1', VLE."Account No.");
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

    var
        RemainingAmount: Decimal;
        CompanyInfo: Record "Company Information";

    procedure TransferRemainingAmount(RA: Decimal; MeNO: CODE[20]; ShareAcc: code[50]);
    var
        SActivities: Codeunit "Sacco Activities";
        JBatch: code[10];
        JTemplate: code[10];
        AcctType: Enum "Gen. Journal Account Type";
        DocNo: Code[150];
        BalAcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Type Enum";
        Dim1: Code[20];
        Dim2: Code[20];
        SavAcc: record "Savings Accounts";
        TChannel: Enum "Transaction Channel";
    begin

        SActivities.GetGeneralJournalTemplate(JTemplate, JBatch);
        SActivities.GetGeneralDimensionVal(Dim1, Dim2);
        SActivities.JournalInit(JTemplate, JBatch);

        //get S02 Acc
        SavAcc.Reset();
        SavAcc.SetRange("Member No.", MeNO);
        SavAcc.SetRange("Product Type", 'S02');
        if SavAcc.FindFirst() then SavAcc.CalcFields(SavAcc."Balance (LCY)");
        if SavAcc."Balance (LCY)" >= RA then begin
            DocNo := StrSubstNo('CAPS01' + MeNO);

            // DR S02
            SActivities.JournalInsert(
                                Jtemplate,
                                JBatch,
                                DocNo,
                                Today,
                                AcctType::Savings,
                                SavAcc."No.",
                                StrSubstNo('Capitalize Shares' + '-' + MeNo + '-' + Format(Today)),
                                Balaccttype::"G/L Account",
                                '',
                                RA,
                                '',
                                '',
                                TransType::" ",
                                Dim1,
                                Dim2,
                                true, TChannel::" ",
                                SavAcc."Dimension Set ID"
                                );
            //CR S01
            SActivities.JournalInsert(
                                Jtemplate,
                                JBatch,
                                DocNo,
                                Today,
                                AcctType::Savings,
                                ShareAcc,
                                StrSubstNo('Capitalize Shares' + '-' + MeNo + '-' + Format(Today)),
                                Balaccttype::"G/L Account",
                                '',
                                RA * -1,
                                '',
                                '',
                                TransType::" ",
                                Dim1,
                                Dim2,
                                true, TChannel::" ",
                                SavAcc."Dimension Set ID"
                                );
            SActivities.JournalPost(JTemplate, JBatch);

        end;




    end;
}
