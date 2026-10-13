report 50046 "Member Register List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Member Register New.rdlc';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Signing Instructions", Status, "Employer Code", "Registration Date", "Group Account", "Global Dimension 1 Code", "Global Dimension 2 Code", Nationality;
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
            column(AccountType_Members; Members."Signing Instructions")
            {
            }
            column(Name_Members; Members.Name)
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
            column(BirthCertificateNo_Members; '')
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
            column(MaritalStatus_Members; Members."Marital Status")
            {
            }
            column(DateofBirth_Members; Members."Date of Birth")
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
            column(MobilePhoneNo_Members; Members."Mobile Phone No.")
            {
            }
            column(CompanyEMail_Members; Members."Work E-Mail")
            {
            }
            column(EMail_Members; Members."E-Mail")
            {
            }
            column(PINNumber_Members; Members."KRA PIN")
            {
            }
            column(Gender_Members; Members.Gender)
            {
            }
            column(HasPicture; HasPicture)
            {
            }
            column(HasSignature; HasSignature)
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

                IF AsAT = 0D THEN
                    AsAT := TODAY;

                EVALUATE(DateFil, FORMAT(AsAT));

                DateFilterr := '..' + DateFil;

                SavingAcc.RESET;
                SavingAcc.SETRANGE(SavingAcc."Member No.", "No.");
                //SavingAcc.SETRANGE("Product Type",AlphaDepositProduct);
                SavingAcc.SETFILTER(SavingAcc."Date Filter", DateFilterr);
                SavingAcc.SETRANGE(SavingAcc."Product Category", SavingAcc."Product Category"::"Deposit Contribution");
                IF SavingAcc.FIND('-') THEN BEGIN
                    SavingAcc.CALCFIELDS("Net Change");
                    AplhaDeposit := SavingAcc."Net Change";
                END;

                SavingAcc.RESET;
                SavingAcc.SETRANGE(SavingAcc."Member No.", "No.");
                SavingAcc.SETFILTER(SavingAcc."Date Filter", DateFilterr);
                //SavingAcc.SETRANGE("Product Type",SharesCapitalProduct);
                SavingAcc.SETRANGE(SavingAcc."Product Category", SavingAcc."Product Category"::"Share Capital");
                IF SavingAcc.FIND('-') THEN BEGIN
                    SavingAcc.CALCFIELDS("Net Change");
                    SharesCapital := SavingAcc."Net Change";
                END;


                SavingAcc.RESET;
                SavingAcc.SETRANGE(SavingAcc."Member No.", "No.");
                SavingAcc.SETFILTER(SavingAcc."Date Filter", DateFilterr);
                //SavingAcc.SETRANGE("Product Type",RegFeesProduct);
                //SavingAcc.SETRANGE(SavingAcc."Product Category", SavingAcc."Product Category"::"Phase II");
                IF SavingAcc.FIND('-') THEN BEGIN
                    SavingAcc.CALCFIELDS("Net Change");
                    Kusco := SavingAcc."Net Change";
                END;

                SavingAcc.RESET;
                SavingAcc.SETRANGE(SavingAcc."Member No.", "No.");
                SavingAcc.SETFILTER(SavingAcc."Date Filter", DateFilterr);
                //SavingAcc.SETRANGE("Product Type",RegFeesProduct);
                SavingAcc.SETRANGE(SavingAcc."Product Category", SavingAcc."Product Category"::"Registration Fee");
                IF SavingAcc.FIND('-') THEN BEGIN
                    SavingAcc.CALCFIELDS("Net Change");
                    RegFees := SavingAcc."Net Change";
                END;

                LoanAcc.RESET;
                LoanAcc.SETRANGE("Member No.", Members."No.");
                LoanAcc.SETFILTER(LoanAcc."Date Filter", DateFilterr);
                IF LoanAcc.FINDFIRST THEN BEGIN
                    REPEAT
                        LoanAcc.CALCFIELDS("Total Outstanding Balance");
                        TotalLoans += LoanAcc."Total Outstanding Balance";
                    UNTIL LoanAcc.NEXT = 0;
                END;

                HasPicture := FALSE;
                HasSignature := FALSE;

                ImageData.RESET;
                ImageData.SETRANGE("Member No.", Members."No.");
                IF ImageData.FINDFIRST THEN BEGIN
                    HasPicture := ImageData.Picture.HASVALUE;
                    HasSignature := ImageData.Signature.HASVALUE;
                END;

                //IF (RegFees=0) AND (SharesCapital=0) AND (AplhaDeposit=0) AND (Kusco=0) AND (TotalLoans = 0) THEN
                // CurrReport.SKIP;

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
        CreditAcc: Record "Credit Accounts";
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
        AsAT: Date;
        DateFil: Text;
        ImageData: Record "Member Images";
        HasPicture: Boolean;
        HasSignature: Boolean;
        StatusPermission: Record "User Setup";
}

