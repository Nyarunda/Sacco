report 50396 "Members - Remittance Advice"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Members - Remittance Advice.rdlc';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Employer Code", "Registration Date", Status;
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
            column(Name_Members; Members.Name)
            {
            }
            column(PayrollStaffNo_Members; Members."ID No.")
            {
            }
            column(IDPassportNo_Members; Members.Passport)
            {
            }
            column(EmployerCode_Members; Members."Employer Code")
            {
            }
            column(MinShares; MinShares[3])
            {
            }
            column(MinDeposits; MinDeposits)
            {
            }
            column(LoanPrincipalArrears; PrincipalArrears)
            {
            }
            column(LoanRepayment; LoanRepayment)
            {
            }
            column(InstantLoanRepayment; LoanRepayments)
            {
            }
            column(TotalRemittanc; TotalRemittanc)
            {
            }
            column(SCount; SNo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                MinShares[1] := 0;
                MinShares[2] := 0;
                MinShares[3] := 0;
                MinDeposits := 0;

                SAccount.RESET;
                SAccount.SETRANGE("Member No.", "No.");
                SAccount.SETFILTER("Date Filter", DateFilter);
                SAccount.SetFilter("Product Category", '%1|%2', SAccount."Product Category"::"Deposit Contribution", SAccount."Product Category"::"Share Capital");
                IF SAccount.FIND('-') THEN
                    repeat
                        SAccount.CALCFIELDS("Balance (LCY)");

                        IF SAccount."Monthly Contribution" < GenSetup."Min. Contribution [Deposits]" THEN
                            MinDeposits := GenSetup."Min. Contribution [Deposits]"
                        ELSE
                            MinDeposits := SAccount."Monthly Contribution";

                        IF Members."Member Category" = Members."Member Category"::Member THEN begin
                            MinShares[1] := GenSetup."Min. Contribution [Shares]"
                        end ELSE BEGIN
                            //IF MemberCategory.GET(Cust."Member Category") THEN
                            //  MinShares[1] := MemberCategory."Min. Share Capital";
                        END;

                        if SAccount."Product Category" = SAccount."Product Category"::"Share Capital" then begin
                            IF SAccount."Balance (LCY)" < MinShares[1] THEN
                                MinShares[2] := MinShares[1] - SAccount."Balance (LCY)";
                            IF MinShares[2] > 0 THEN
                                MinShares[3] := MinShares[2];
                        end;
                    until SAccount.Next() = 0;
                //**Repayment
                LoanRepayment := 0;
                LoanRepayments := 0;
                LoanApps.RESET;
                LoanApps.SETRANGE(LoanApps."Member No.", Members."No.");
                LoanApps.SETFILTER(LoanApps."Date Filter", DateFilter);
                IF LoanApps.FIND('-') THEN BEGIN
                    REPEAT
                        IF LoanApps."Disbursement Date" <= CALCDATE(GenSetup."Days for Checkoff", CALCDATE('-CM', RemCutoff)) THEN BEGIN
                            LoanApps.CALCFIELDS("Outstanding Principal", "Outstanding Interest", "Schedule Repayment", "Principal Repayment");
                            IF LoanApps."Outstanding Principal" <> 0 THEN BEGIN

                                MonthlyRep := 0;

                                IF LoanApps."Interest Calculation Method" = LoanApps."Interest Calculation Method"::Amortised THEN
                                    MonthlyRep := LoanApps.Repayment
                                ELSE
                                    MonthlyRep := LoanApps."Loan Principle Repayment" + ROUND(LoanApps."Outstanding Principal" * LoanApps."Annual Interest %" / 1200);

                                LoanRepayments += MonthlyRep;
                            END;
                        END;
                    UNTIL LoanApps.NEXT = 0;
                END;

                //**Arrears
                PrincipalRepayment := 0;
                PrincipalArrears := 0;
                LoansT.RESET;
                LoansT.SETRANGE(LoansT."Member No.", Members."No.");
                LoansT.SETFILTER(LoansT."Date Filter", ArrearsDateFiltr);
                IF LoansT.FIND('-') THEN BEGIN
                    REPEAT
                        IF LoansT."Disbursement Date" <= CALCDATE(GenSetup."Days for Checkoff", CALCDATE('-CM', RemCutoff)) THEN BEGIN
                            LoansT.CALCFIELDS("Outstanding Principal", "Outstanding Interest", "Schedule Repayment", "Principal Repayment");
                            IF LoansT."Outstanding Principal" <> 0 THEN BEGIN

                                IF LoansT."Disbursement Date" <= DMY2Date(31, 12, 16) THEN
                                    PrincipalRepayment := LoansT."Approved Amount" - LoansT."Outstanding Principal"
                                ELSE
                                    PrincipalRepayment := LoansT."Principal Repayment";

                                PrincipalArrears += LoansT."Schedule Repayment" - PrincipalRepayment;
                                //MESSAGE('Scheduled :%1 Actual :%2 Variance :%3',LoansT."Schedule Repayments",PrincipalRepayment,PrincipalArrears); //BLN-005971
                                IF PrincipalArrears < 0 THEN
                                    PrincipalArrears := 0;
                            END;
                        END;

                    UNTIL LoansT.NEXT = 0;
                END;

                TotalRemittanc := MinShares[3] + MinDeposits + LoanRepayment + LoanRepayments + PrincipalArrears;

                SNo += 1;

            END;


            trigger OnPreDataItem()
            begin
                IF RemCutoff = 0D THEN
                    ERROR('Please specify Remittance Cutoff Date');

                GenSetup.GET(0);
                DateFilter := '..' + FORMAT(RemCutoff);
                ArrearsDateFiltr := '..' + FORMAT(CALCDATE('-1M+CM', CALCDATE('-CM', RemCutoff)));
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(RemCutoff; RemCutoff)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        ReportHeader = 'Remittance Advice';
        MemberNo = 'MNo.';
        MemberName = 'Name';
        StaffNo = 'Staff No.';
        IDNumber = 'ID No.';
        Employer = 'Employer';
        MinDeposit = 'Deposits';
        MinShare = 'Shares';
        InstantLoanRepaymentH = 'Instant';
        LoanRepaymentH = 'Repayment';
        LoanArrears = 'Loan Arrears';
        SubTotal = 'SubTotal';
        TotalRemittance = 'Total';
    }

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
        GenSetup: Record "Sacco Setup";
        MinShares: array[3] of Decimal;
        MinDeposits: Decimal;
        SAccount: Record "Savings Accounts";
        //MemberCategory: Record "39004280";
        LoanApps: Record Loans;
        LoansT: Record Loans;
        RemCutoff: Date;
        DateFilter: Text;
        LoanRepayment: Decimal;
        LoanRepayments: Decimal;
        ArrearsDateFiltr: Text;
        PrincipalRepayment: Decimal;
        PrincipalArrears: Decimal;
        SNo: Integer;
        TotalRemittanc: Decimal;
        MonthlyRep: Decimal;
}

