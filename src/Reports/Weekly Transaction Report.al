report 50057 "Weekly Transaction Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Weekly Transaction Report.rdlc';

    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = WHERE("Group Account" = CONST(true));
            RequestFilterFields = "Group No.";
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
            column(No_Members; Members."No.")
            {
            }
            column(No_Members_Old; Members."Old Member No.")
            {
            }
            column(AccountType_Members; Members."Signing Instructions")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(FosaACC; FosaAcc)
            {
            }
            column(GlobalDimension1Code_Members; Members."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_Members; Members."Global Dimension 2 Code")
            {
            }
            column(RegistrationDate_Members; Members."Registration Date")
            {
            }
            column(EmployerCode_Members; Members."Employer Code")
            {
            }
            column(Nationality_Members; Members.Nationality)
            {
            }
            column(PayrollStaffNo_Members; Members."Payroll/Staff No.")
            {
            }
            column(PhoneNo_Members; Members."Phone No.")
            {
            }
            column(IDNumber_Members; Members."ID No.")
            {
            }
            column(BirthCertificateNo_Members; Members."Business Reg. No.")
            {
            }
            column(GroupAccountNo_Members; Members."Group No.")
            {
            }
            column(SalespersonCode_Members; Members."Recruited By")
            {
            }
            column(MemberSegment_Members; Members."Member Electoral Zone")
            {
            }
            column(CreatedBy_Members; Members."Captured By")
            {
            }
            column(Source_Members; '')
            {
            }
            column(Status_Members; Members.Status)
            {
            }
            column(SCount; SNo)
            {
            }
            column(MemberCategory_Members; Members."Member Category")
            {
            }
            column(AplhaDeposit; AplhaDeposit)
            {
            }
            column(SharesCapital; SharesCapital)
            {
            }
            column(RegFees; RegFees)
            {
            }
            column(ShortTLoans; ShortTLoans)
            {
            }
            column(LongTLoans; LongTLoans)
            {
            }
            column(TotalLoans; TotalLoans)
            {
            }
            column(BranchCode_Members; Members."Branch Name")
            {
            }
            column(Little; Juni)
            {
            }
            column(Holiday; Holid)
            {
            }
            column(Kuscco; Kusco)
            {
            }
            column(ShareDeposit; ShareDeposit)
            {
            }
            column(GroupName; GroupName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;


                TotalLoans := 0;
                AplhaDeposit := 0;
                SharesCapital := 0;
                RegFees := 0;
                Kusco := 0;
                Holid := 0;
                Juni := 0;
                ShareDeposit := 0;



                SavingAcc.RESET;
                SavingAcc.SETRANGE(SavingAcc."Member No.", "No.");
                SavingAcc.SETRANGE(SavingAcc."Loan Disbursement Account", TRUE);
                //SavingAcc.SETRANGE("Product Type",AlphaDepositProduct);
                //SavingAcc.SETFILTER(SavingAcc."Date Filter",DateFilterr);
                //SavingAcc.SETRANGE(SavingAcc."Product Category",SavingAcc."Product Category"::"Deposit Contribution");
                IF SavingAcc.FIND('-') THEN BEGIN
                    FosaAcc := SavingAcc."No.";
                    // SavingAcc.CALCFIELDS(Balance);
                    //AplhaDeposit:=SavingAcc.Balance;
                END;


                SavingAcc.RESET;
                SavingAcc.SETRANGE(SavingAcc."Member No.", "No.");
                SavingAcc.SETRANGE(SavingAcc."Product Category", SavingAcc."Product Category"::"Deposit Contribution");
                SavingAcc.SETFILTER(SavingAcc."Date Filter", DateFilterr);
                SavingAcc.SetAutoCalcFields("Balance (LCY)");
                IF SavingAcc.FIND('-') THEN BEGIN
                    ShareDeposit := SavingAcc."Balance (LCY)";
                END;

                //For Group Name
                GroupMemb.RESET;
                GroupMemb.SETRANGE(GroupMemb."No.", "Group No.");
                IF GroupMemb.FINDFIRST THEN
                    GroupName := GroupMemb.Name;

                /*
                SavingAcc.RESET;
                SavingAcc.SETRANGE(SavingAcc."Member No.","No.");
                SavingAcc.SETFILTER(SavingAcc."Date Filter",DateFilterr);
                //SavingAcc.SETRANGE("Product Type",SharesCapitalProduct);
                SavingAcc.SETRANGE(SavingAcc."Product Category",SavingAcc."Product Category"::"Share Capital");
                IF SavingAcc.FIND('-') THEN
                  BEGIN
                  SavingAcc.CALCFIELDS(Balance);
                  SharesCapital:=SavingAcc.Balance;
                  END;*/
                /*
              SavingAcc.RESET;
              SavingAcc.SETRANGE(SavingAcc."Member No.","No.");
              SavingAcc.SETFILTER(SavingAcc."Date Filter",DateFilterr);
              //SavingAcc.SETRANGE("Product Type",RegFeesProduct);
              SavingAcc.SETRANGE(SavingAcc."Product Category",SavingAcc."Product Category"::"9");
              IF SavingAcc.FIND('-') THEN
                BEGIN
                SavingAcc.CALCFIELDS(Balance);
                Kusco:=SavingAcc.Balance;
                END;


              SavingAcc.RESET;
              SavingAcc.SETRANGE(SavingAcc."Member No.","No.");
              SavingAcc.SETFILTER(SavingAcc."Date Filter",DateFilterr);
              //SavingAcc.SETRANGE("Product Type",RegFeesProduct);
              SavingAcc.SETRANGE(SavingAcc."Product Category",SavingAcc."Product Category"::UnAllocated);
              IF SavingAcc.FIND('-') THEN
                BEGIN
                SavingAcc.CALCFIELDS(Balance);
                Holid:=SavingAcc.Balance;
                END;
              */
                /*
                SavingAcc.RESET;
                SavingAcc.SETRANGE(SavingAcc."Member No.","No.");
                SavingAcc.SETFILTER(SavingAcc."Date Filter",DateFilterr);
                //SavingAcc.SETRANGE("Product Type",RegFeesProduct);
                SavingAcc.SETRANGE(SavingAcc."Product Category",SavingAcc."Product Category"::"Registration Fee");
                IF SavingAcc.FIND('-') THEN
                  BEGIN
                  SavingAcc.CALCFIELDS(Balance);
                  RegFees:=SavingAcc.Balance;
                  END;
                  */
                /*
                SavingAcc.RESET;
                SavingAcc.SETRANGE(SavingAcc."Member No.","No.");
                SavingAcc.SETFILTER(SavingAcc."Date Filter",DateFilterr);
                //SavingAcc.SETRANGE("Product Type",RegFeesProduct);
                SavingAcc.SETRANGE(SavingAcc."Product Category",SavingAcc."Product Category"::"Junior Savings");
                IF SavingAcc.FIND('-') THEN
                  BEGIN
                  SavingAcc.CALCFIELDS(Balance);
                  Juni:=SavingAcc.Balance;
                  END;
                */
                //#
                /*
              LoanAcc.RESET;
              LoanAcc.SETRANGE("Member No.","No.");
              LoanAcc.SETRANGE("Loan Span",LoanAcc."Loan Span"::"Short Term");
              IF LoanAcc.FIND('-') THEN
                BEGIN
                REPEAT
                LoanAcc.CALCFIELDS("Outstanding Balance");
                ShortTLoans:=ShortTLoans+LoanAcc."Outstanding Balance";
                UNTIL LoanAcc.NEXT=0;
                END;

              LoanAcc.RESET;
              LoanAcc.SETRANGE("Member No.","No.");
              LoanAcc.SETRANGE("Loan Span",LoanAcc."Loan Span"::"Long Term");
              IF LoanAcc.FIND('-') THEN
                BEGIN
                REPEAT
                LoanAcc.CALCFIELDS("Outstanding Balance");
                LongTLoans:=LongTLoans+LoanAcc."Outstanding Balance";
                UNTIL LoanAcc.NEXT=0;
                END;
                */
                /*
                CreditAcc.RESET;
                CreditAcc.SETRANGE(CreditAcc."Member No.","No.");
                CreditAcc.SETFILTER(CreditAcc."Date Filter",DateFilterr);
                IF CreditAcc.FIND('-') THEN
                    BEGIN
                    REPEAT
                    CreditAcc.CALCFIELDS(Balance);
                    TotalLoans:=TotalLoans+CreditAcc.Balance;
                    UNTIL CreditAcc.NEXT=0;
                    END;
                */

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DateFilterr; DateFilterr)
                {
                    ApplicationArea = All;
                    Caption = 'As At';
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

    trigger OnInitReport()
    begin
        StatusPermission.RESET;
        StatusPermission.SETRANGE(StatusPermission."User ID", USERID);
        StatusPermission.SETRANGE(StatusPermission.Reports, TRUE);
        IF NOT StatusPermission.FIND('-') THEN BEGIN
            ERROR('You Do Not have Permission to perform this action');
        END;
    end;

    trigger OnPreReport()
    begin
        IF CompanyInformation.GET THEN
            CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
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
        SNo: Integer;
        SavingAcc: Record "Savings Accounts";
        CreditAcc: Record "Credit Ledger Entry";
        LoanAcc: Record Loans;
        AplhaDeposit: Decimal;
        SharesCapital: Decimal;
        RegFees: Decimal;
        CreditLoans: Decimal;
        BankingLoans: Decimal;
        AlphaDepositProduct: Code[10];
        SharesCapitalProduct: Code[10];
        RegFeesProduct: Code[10];
        ShortTLoans: Decimal;
        LongTLoans: Decimal;
        TotalLoans: Decimal;
        Kusco: Decimal;
        Holid: Decimal;
        Juni: Decimal;
        DateFilterr: Text;
        FosaAcc: Code[20];
        ShareDeposit: Decimal;
        GroupName: Text;
        GroupMemb: Record Members;
        StatusPermission: Record "User Setup";
}

