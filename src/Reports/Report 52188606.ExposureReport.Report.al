Report 50269 "Exposure Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Exposure Report.rdlc';

    dataset
    {
        dataitem(Exposure; Exposure)
        {
            column(ReportForNavId_4645; 4645)
            {
            }
            column(MemberNo; Exposure."Member No.")
            {
            }
            column(Name; Exposure.Name)
            {
            }
            column(TotalLoans; Exposure."Total Loans")
            {
            }
            column(MemberDeposits; Exposure."Member Deposits")
            {
            }
            column(Security; Exposure.Security)
            {
            }
            column(Provision; Provision)
            {
            }

            trigger OnPreDataItem()
            begin

                /*
                dWindow.OPEN('Generating Schedules:     #1#########\'
                                            +'Accounts:             #2#########\'
                                            +'Counter:              #3#########\'
                                            +'Progress:             @4@@@@@@@@@\'
                                            +'Press Esc to abort');
                
                
                */

                if AsAt = 0D then
                    AsAt := Today;

                if GenerateLines then begin
                    Exp.DeleteAll;


                    Members.Reset;
                    if Members.FindFirst then begin

                        dWindow.Open('Generating Schedules:     @1@@@@@@@@@\'
                                                + 'Counter   #2#########'
                                                + 'Total     #3#########'
                                                + 'Press Esc to abort');


                        NoOfRecords := Members.Count;
                        repeat
                            CurrentRecordNo += 1;
                            dWindow.Update(2, CurrentRecordNo);
                            dWindow.Update(3, NoOfRecords);
                            dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));


                            Exp.Init;
                            Exp."Member No." := Members."No.";
                            Exp.Name := Members.Name;

                            Loans.Reset;
                            Loans.SetRange("Member No.", Members."No.");
                            Loans.SetRange(Posted, true);
                            Loans.SetFilter("Date Filter", '..%1', AsAt);
                            if Category <> Category::All then
                                Loans.SetRange("Loans Category-SASRA", Category);
                            if Loans.FindFirst then begin
                                repeat
                                    Loans.CalcFields("Outstanding Principal");
                                    Exp."Total Loans" += Loans."Outstanding Principal";
                                until Loans.Next = 0;
                            end;

                            if Exp."Total Loans" > 0 then begin
                                Savings.Reset;
                                Savings.SetRange("Member No.", Members."No.");
                                Savings.SetFilter("Product Category", '%1|%2|%3', Savings."product category"::"Deposit Contribution", Savings."product category"::"Micro Member Deposit", Savings."product category"::"Micro Group Deposit");
                                Savings.SetFilter("Date Filter", '..%1', AsAt);
                                if Savings.FindFirst then begin
                                    repeat
                                        Savings.CalcFields("Balance (LCY)");
                                        Exp."Member Deposits" += Savings."Balance (LCY)";
                                    until Savings.Next = 0;
                                end;

                                SecuritiesRegister.Reset;
                                SecuritiesRegister.SetRange("Account No.", Members."No.");
                                SecuritiesRegister.SetRange(Status, SecuritiesRegister.Status::Approved);
                                SecuritiesRegister.SetRange("Inward/Outward", SecuritiesRegister."inward/outward"::"In-Store");
                                if SecuritiesRegister.FindFirst then begin
                                    repeat
                                        Exp.Security += SecuritiesRegister."Collateral Value";
                                    until SecuritiesRegister.Next = 0;
                                end;
                                Exp.Date := AsAt;
                                Exp.Insert;
                            end;
                        until Members.Next = 0;
                        dWindow.Close;
                    end;
                end;


                Provision := 0;
                /*
                Loans.RESET;
                Loans.SETRANGE(Posted,TRUE);
                //rLoans.SETFILTER("Outstanding Principal",'>0');
                //Loans.SETFILTER("Loans Category-SASRA",'<>%1&<>%2',Loans."Loans Category-SASRA"::Perfoming,Loans."Loans Category-SASRA"::Watch);
                IF Loans.FINDFIRST THEN BEGIN
                    REPEAT
                
                        Loans.CALCFIELDS("Outstanding Principal");
                        //IF SASRACategorization.GET(Loans."Loan No.") THEN BEGIN
                            IF SASRACategorization."Loans Category-SASRA" = SASRACategorization."Loans Category-SASRA"::Perfoming THEN
                                Provision += Loans."Outstanding Principal"*1/100;
                            IF SASRACategorization."Loans Category-SASRA" = SASRACategorization."Loans Category-SASRA"::Watch THEN
                                Provision += Loans."Outstanding Principal"*5/100;
                            IF SASRACategorization."Loans Category-SASRA" = SASRACategorization."Loans Category-SASRA"::Substandard THEN
                                Provision += Loans."Outstanding Principal"*25/100;
                            IF SASRACategorization."Loans Category-SASRA" = SASRACategorization."Loans Category-SASRA"::Doubtful THEN
                                Provision += Loans."Outstanding Principal"*50/100;
                            IF SASRACategorization."Loans Category-SASRA" = SASRACategorization."Loans Category-SASRA"::Loss THEN
                                Provision += Loans."Outstanding Principal"*100/100;
                        //END;
                    UNTIL Loans.NEXT=0;
                END;
                */



                Loans.Reset;
                Loans.SetRange(Posted, true);
                if Category <> Category::All then
                    Loans.SetRange("Loans Category-SASRA", Category);
                //rLoans.SETFILTER("Outstanding Principal",'>0');
                //Loans.SETFILTER("Loans Category-SASRA",'<>%1&<>%2',Loans."Loans Category-SASRA"::Perfoming,Loans."Loans Category-SASRA"::Watch);
                if Loans.FindFirst then begin
                    repeat

                        Loans.CalcFields("Outstanding Principal", "Loans Category-SASRA");
                        //IF Loans.GET(Loans."Loan No.") THEN BEGIN
                        if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Performing then
                            Provision += Loans."Outstanding Principal" * 1 / 100;
                        if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Watch then
                            Provision += Loans."Outstanding Principal" * 5 / 100;
                        if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Substandard then
                            Provision += Loans."Outstanding Principal" * 25 / 100;
                        if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Doubtful then
                            Provision += Loans."Outstanding Principal" * 50 / 100;
                        if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Loss then
                            Provision += Loans."Outstanding Principal" * 100 / 100;
                    //END;
                    until Loans.Next = 0;
                end;

                Provision := ROUND(Provision);
                //MESSAGE('Provision %1',Provision);

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AllLoans; AllLoans)
                {
                    ApplicationArea = Basic;
                }
                field(GenerateLines; GenerateLines)
                {
                    ApplicationArea = Basic;
                }
                field(Category; Category)
                {
                    ApplicationArea = Basic;
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

    var
        LoansCaptionLbl: label 'Loans';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        VarienceCaptionLbl: label 'Varience';
        Text001: label 'Document No. Must be equal to No.';
        GeneratesuccMSG: label 'Interest Posted Successfully';
        AlreadyPostedErr: label 'This transaction Has already been posted';
        NoTemplateErr: label 'Ensure the Bills Template is set up in banking setup';
        NoBatchErr: label 'Ensure the Bills Batch is set up in the banking setup';
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        ProductFactory: Record "Product Setup";
        Updated: Boolean;
        AllLoans: Boolean;
        Members: Record Members;
        Exp: Record Exposure;
        Loans: Record Loans;
        Savings: Record "Savings Accounts";
        SecuritiesRegister: Record "Loan Collateral Register";
        GenerateLines: Boolean;
        Provision: Decimal;
        AsAt: Date;
        SASRACategorization: Record "Sasra Categorization";
        Category: Option Perfoming,Watch,Substandard,Doubtful,Loss,All;
}

