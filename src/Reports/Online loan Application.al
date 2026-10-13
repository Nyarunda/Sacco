report 50526 "Online loan Application"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Online loan Application.rdlc';

    dataset
    {
        dataitem(OnlineLoan; "Portal Loans")
        {
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
            column(ApplicationNo; OnlineLoan."Application No.")
            {
            }
            column(ApplicationDate; OnlineLoan."Date")
            {
            }
            column(MemberNo; OnlineLoan."Member No.")
            {
            }
            column(MemberNames; OnlineLoan."Account Name")
            {
            }
            column(EmploymentNo; LoaneeCard."Employer Code")
            {
            }
            column(Telephone; LoaneeCard."Mobile Phone No.")
            {
            }
            column(Email; LoaneeCard."E-Mail")
            {
            }
            column(LoanTypeDescription; OnlineLoan."Loan Name")
            {
            }
            column(LoanType; OnlineLoan."Loan Product Type")
            {
            }
            column(LoanAmount; OnlineLoan."Requested Amount")
            {
            }
            column(Instalments; OnlineLoan."Loan Period")
            {
            }
            column(BasicPay; OnlineLoan."Basic Salary")
            {
            }
            column(TotalAllowances; OnlineLoan."Allowances")
            {
            }
            column(TotalDeduction; OnlineLoan."Deductions")
            {
            }
            column(InterestRate; ProductFactory."Interest Rate (Max.)")
            {
            }
            column(BosaNo; OnlineLoan."Member No.")
            {
            }
            column(IdNo; LoaneeCard."Id No.")
            {
            }
            column(KraPinNo; LoaneeCard."KRA PIN")
            {
            }
            column(StaffNo; LoaneeCard."Payroll/Staff No.")
            {
            }
            column(Employer; LoaneeCard."Employer Name")
            {
            }
            column(PurposeofLoan; LoanPurpose)
            {
            }
            column(DateSubmitted; OnlineLoan."Date")
            {
            }
            column(Designation; OnlineLoan.Designation)
            {
            }
            column(DateOfAppointment; OnlineLoan."Date Of Appointment")
            {
            }
            column(TermsOfAppointment; OnlineLoan."Terms Of Appointment")
            {
            }
            column(PositionInSacco; LoaneeCard."Member Category")
            {
            }
            column(FosaBranch; LoaneeCard."Global Dimension 2 Code")
            {
            }
            column(WitnessNo; WitnessCard."No.")
            {
            }
            column(WitnessName; WitnessCard."Name")
            {
            }
            column(WitnessStaffNo; WitnessStaffNo)
            {
            }
            column(WitnessSignature; WitnessImageData.Signature)
            {
            }
            column(LoanAmountText; NumberText[1])
            {
            }
            column(TotalGuaranteedAmtText; NumberTextTwo[1])
            {
            }
            column(TotalGuaranteed; TotalGuaranteed)
            {
            }
            column(BosaLoans; BosaLoans)
            {
            }
            column(TotalDeposits; TotalDeposits)
            {
            }
            column(MonthlyNetSalalry; MonthlyNetSalalry)
            {
            }
            column(FosaLoans; FosaLoans)
            {
            }
            column(DateOfBirth; LoaneeCard."Date of Birth")
            {
            }
            column(EmployerCode; LoaneeCard."Employer Code")
            {
            }
            column(MembersPayrollStaffNo; LoaneeCard."Payroll/Staff No.")
            {
            }
            column(MembersDateofBirth; LoaneeCard."Date of Birth")
            {
            }
            column(MembersEMail; LoaneeCard."E-Mail")
            {
            }
            column(MembersCIty; LoaneeCard.City)
            {
            }
            column(MembersPostCode; LoaneeCard."Post Code")
            {
            }
            column(MembersCurrentAddress; LoaneeCard.Address)
            {
            }
            column(MemberEmployerName; EmployerName)
            {
            }
            column(MemberSignature; ImageData.Signature)
            {
            }
            dataitem("Online Loan Guarantors"; "Portal Guarantors")
            {
                DataItemLink = "Loan Entry No." = FIELD("Application No.");
                DataItemTableView = WHERE("Guarantor Accepted" = filter(Yes));
                column(GuarantorsEntryNo; 0)
                {
                }
                column(GuarantorNo; "Online Loan Guarantors"."Guarantor Member No.")
                {
                }
                column(GuarantorNames; "Online Loan Guarantors"."Guarantor Name")
                {
                }
                column(GuarantorEmail; guarantorCard."E-Mail")
                {
                }
                column(GuarantorIDNo; guarantorCard."ID No.")
                {
                }
                column(GuarantorAmount; "Online Loan Guarantors"."Amount Guaranteed")
                {
                }
                column(GuarantorPhone; guarantorCard."Mobile Phone No.")
                {
                }
                column(GuarantorsDateApproved; "Online Loan Guarantors"."Guarantor Response Date")
                {
                }
                column(GuarantorStaffNo; guarantorCard."Payroll/Staff No.")
                {
                }
                column(GuarantorSignature; GuarantorImageData.Signature)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    GuarantorImageData.RESET;
                    GuarantorImageData.SETRANGE("Member No.", "Online Loan Guarantors"."Guarantor Member No.");
                    IF NOT GuarantorImageData.FINDFIRST THEN EXIT;

                    GuarantorImageData.CALCFIELDS(Signature);

                    guarantorCard.GET("Online Loan Guarantors"."Guarantor Member No.");
                    GuarantorStaffNo := guarantorCard."Payroll/Staff No.";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                FosaLoans := GetFosaLoans();
                BosaLoans := GetBosaLoans();
                MonthlyNetSalalry := GetNetSalary();
                TotalDeposits := GetTotalDeposits();

                LoaneeCard.GET(OnlineLoan."Member No.");
                IF LoaneeCard."Employer Code" <> '' THEN
                    IF Customer.GET(LoaneeCard."Employer Code") THEN EmployerName := Customer.Name;

                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NumberText, "Requested Amount", '');

                IF STRPOS(NumberText[1], 'AND 0/100') > 0 THEN
                    NumberText[1] := DELSTR(NumberText[1], STRPOS(NumberText[1], 'AND 0/100'));

                OnlineGuarantors.RESET;
                OnlineGuarantors.SETRANGE("Loan Entry No.", OnlineLoan."Application No.");
                OnlineGuarantors.SETRANGE("Guarantor Accepted", OnlineGuarantors."Guarantor Accepted"::Yes);
                IF OnlineGuarantors.FINDFIRST THEN OnlineGuarantors.CALCSUMS("Amount Guaranteed");
                TotalGuaranteed := OnlineGuarantors."Amount Guaranteed";

                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NumberTextTwo, TotalGuaranteed, '');

                IF STRPOS(NumberTextTwo[1], 'AND 0/100') > 0 THEN
                    NumberTextTwo[1] := DELSTR(NumberTextTwo[1], STRPOS(NumberTextTwo[1], 'AND 0/100'));

                LoanPurposeTable.Reset();
                LoanPurposeTable.SetRange("Sub-Sector Level 2 Code", OnlineLoan."Loan Purpose");
                IF LoanPurposeTable.findfirst THEN
                    LoanPurpose := LoanPurposeTable."Sub-Sector Level 2 Description";

                ImageData.RESET;
                ImageData.SETRANGE("Member No.", OnlineLoan."Member No.");
                IF ImageData.FINDFIRST THEN
                    ImageData.CALCFIELDS(Signature);


                OnlineWitness.Reset();
                OnlineWitness.SetRange("Loan Application No.", OnlineLoan."Application No.");
                OnlineWitness.SetRange("Witness Approved", OnlineWitness."Witness Approved"::Yes);
                if OnlineWitness.FindFirst() then begin

                    OnlineLoan."Loan Witness" := OnlineWitness."Witness No.";
                    OnlineLoan."Loan Witness Approved" := true;
                    OnlineLoan."Loan Witness Date Approved" := OnlineWitness."Date Approved";
                    OnlineLoan.Modify();

                    IF WitnessCard.GET(OnlineWitness."Witness No.") THEN
                        WitnessStaffNo := WitnessCard."Payroll/Staff No.";

                    WitnessImageData.RESET;
                    WitnessImageData.SETRANGE("Member No.", OnlineLoan."Loan Witness");
                    IF WitnessImageData.FINDFIRST THEN WitnessImageData.CALCFIELDS(Signature);
                END;
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
        FosaLoans: Decimal;
        BosaLoans: Decimal;
        MonthlyNetSalalry: Decimal;
        TotalDeposits: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        ProductFactory: Record "Product Setup";
        EmployerName: Text;
        Customer: Record Customer;
        ImageData: Record "Member Images";
        GuarantorImageData: Record "Member Images";
        WitnessImageData: Record "Member Images";
        MemberCard: Record Members;
        GuarantorStaffNo: Text;
        LoaneeCard: Record Members;
        GuarantorCard: Record Members;
        WitnessCard: Record Members;
        WitnessMember: Record "Loan Witness";
        CheckReport: Report check;
        NumberText: array[2] of Text;
        TotalGuaranteed: Decimal;
        TotalGuaranteedText: Text;
        OnlineGuarantors: Record "Portal Guarantors";
        OnlineWitness: Record "Portal Loan Witness";
        NumberTextTwo: array[2] of Text;
        WitnessStaffNo: Text;
        LoanPurpose: Text;
        LoanPurposeTable: Record "Sasra Sectorial Level 2";

    local procedure GetFosaLoans() fosaAmount: Decimal
    var
        Legacy: Codeunit Legacy;
    begin
        fosaAmount := 0;
        fosaAmount := Legacy.GetTotalFOSALoanPrincipalBalance(OnlineLoan."Member No.") + Legacy.GetTotalFOSALoanInterestBalance(OnlineLoan."Member No.")

    end;

    local procedure GetBosaLoans() bosaAmount: Decimal
    var
        Legacy: Codeunit Legacy;
    begin
        bosaAmount := Legacy.GetTotalBOSALoanPrincipalBalance(OnlineLoan."Member No.") + Legacy.GetTotalBOSALoanInterestBalance(OnlineLoan."Member No.")

    end;

    local procedure GetTotalDeposits() TDeposits: Decimal
    begin
        TDeposits := 0;
        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Member No.", OnlineLoan."Member No.");
        SavingsAccounts.SETRANGE("Product Type", 'DEPOSITS');
        IF SavingsAccounts.FIND('-') THEN BEGIN
            SavingsAccounts.CALCFIELDS(Balance);
            TDeposits := SavingsAccounts.Balance;
        END;
    end;

    local procedure GetNetSalary() NSalary: Decimal
    begin
        NSalary := OnlineLoan."Basic Salary" + OnlineLoan."Allowances" - OnlineLoan."Deductions";
    end;
}

