Report 50206 "P9 Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/P9 Report.rdlc';

    dataset
    {
        dataitem("HR Employee"; Employee)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(ReportForNavId_7066; 7066)
            {
            }
            column(SelectedPeriod; SelectedPeriod)
            {
            }
            column(EmployerPIN; EmployerPIN)
            {
            }
            column(HR_Employee__First_Name_; "First Name")
            {
            }
            column(HR_Employee__Last_Name_; "Last Name")
            {
            }
            column(HR_Employee__Middle_Name_; "Middle Name")
            {
            }
            column(HR_Employee__No__; "No.")
            {
            }
            column(HR_Employee__PIN_Number_; PIN)
            {
            }
            column(Employer_Name_; "Employer Name")
            {
            }
            column(Total_Tax_Charged_; "Total Tax Charged")
            {
            }
            column(TotalL; TotalL)
            {
            }
            column(TotaA; TotaA)
            {
            }
            column(TotalB; TotalB)
            {
            }
            column(totalD; totalD)
            {
            }
            column(totalC; totalC)
            {
            }
            column(TotalF; TotalF)
            {
            }
            column(TotalE3; TotalE3)
            {
            }
            column(TotalE2_PensionFT_InsuranceFT; TotalE2 + PensionFT + InsuranceFT)
            {
            }
            column(TotalE1; TotalE1)
            {
            }
            column(TotalL_Control1102756148; TotalL)
            {
            }
            column(TotalK; TotalK)
            {
            }
            column(TotalJ; TotalJ)
            {
            }
            column(TotalH; TotalH)
            {
            }
            column(TotalG; TotalG)
            {
            }
            column(Income_Tax_DepartmentCaption; Income_Tax_DepartmentCaptionLbl)
            {
            }
            column(INCOME_TAX_DEDUCTION_CARD_YEAR_Caption; INCOME_TAX_DEDUCTION_CARD_YEAR_CaptionLbl)
            {
            }
            column(EMPLOYER_S_PINCaption; EMPLOYER_S_PINCaptionLbl)
            {
            }
            column(MONTHCaption; MONTHCaptionLbl)
            {
            }
            column(Basic_SalaryCaption; Basic_SalaryCaptionLbl)
            {
            }
            column(Benefits__Non_CashCaption; Benefits__Non_CashCaptionLbl)
            {
            }
            column(Value_Of__QuartersCaption; Value_Of__QuartersCaptionLbl)
            {
            }
            column(Total__Gross_PayCaption; Total__Gross_PayCaptionLbl)
            {
            }
            column(Defined_Contribution__Retirement_SchemeCaption; Defined_Contribution__Retirement_SchemeCaptionLbl)
            {
            }
            column(Owner_Occupier_InterestCaption; Owner_Occupier_InterestCaptionLbl)
            {
            }
            column(Retirement_Contribution___Owner_OccupierCaption; Retirement_Contribution___Owner_OccupierCaptionLbl)
            {
            }
            column(Column_D_G__Chargeable_AmountCaption; Column_D_G__Chargeable_AmountCaptionLbl)
            {
            }
            column(prEmployee_P9_Info__Tax_Charged_Caption; "prEmployee P9 Info".FieldCaption("Tax Charged"))
            {
            }
            column(Personal__ReliefCaption; Personal__ReliefCaptionLbl)
            {
            }
            column(prEmployee_P9_Info__Insurance_Relief_Caption; "prEmployee P9 Info".FieldCaption("Insurance Relief"))
            {
            }
            column(P_A_Y_E__TAXCaption; P_A_Y_E__TAXCaptionLbl)
            {
            }
            column(ECaption; ECaptionLbl)
            {
            }
            column(E1__30_Caption; E1__30_CaptionLbl)
            {
            }
            column(E2__ActualCaption; E2__ActualCaptionLbl)
            {
            }
            column(E3__FIXEDCaption; E3__FIXEDCaptionLbl)
            {
            }
            column(ACaption; ACaptionLbl)
            {
            }
            column(BCaption; BCaptionLbl)
            {
            }
            column(CCaption; CCaptionLbl)
            {
            }
            column(DCaption; DCaptionLbl)
            {
            }
            column(F__Amount_of_InterestCaption; F__Amount_of_InterestCaptionLbl)
            {
            }
            column(G__Lowest_of_E_added_to_FCaption; G__Lowest_of_E_added_to_FCaptionLbl)
            {
            }
            column(HCaption; HCaptionLbl)
            {
            }
            column(JCaption; JCaptionLbl)
            {
            }
            column(V1_162_00Caption; V1_162_00CaptionLbl)
            {
            }
            column(KCaption; KCaptionLbl)
            {
            }
            column(V0Caption; V0CaptionLbl)
            {
            }
            column(LCaption; LCaptionLbl)
            {
            }
            column(Total__Kshs___1_162_00Caption; Total__Kshs___1_162_00CaptionLbl)
            {
            }
            column(Employee_s_NameCaption; Employee_s_NameCaptionLbl)
            {
            }
            column(Personal_File_No_Caption; Personal_File_No_CaptionLbl)
            {
            }
            column(Employee_PINCaption; Employee_PINCaptionLbl)
            {
            }
            column(Employer_s_NameCaption; Employer_s_NameCaptionLbl)
            {
            }
            column(TOTAL_CHARGEABLE_PAY__COL_J__K_PoundCaption; TOTAL_CHARGEABLE_PAY__COL_J__K_PoundCaptionLbl)
            {
            }
            column(TOTAL_TAX__COL_M__KshsCaption; TOTAL_TAX__COL_M__KshsCaptionLbl)
            {
            }
            column(DataItem1102756111; V1__Date_employee_commenced_if_during_the_yearName_and_address_of_emploLbl)
            {
            }
            column(DataItem1102756112; V2__Date_left_if_during_the_yearName_and_addressLbl)
            {
            }
            column(V3__Where_housing_is_provided__State_monthly_rentCaption; V3__Where_housing_is_provided__State_monthly_rentCaptionLbl)
            {
            }
            column(CERTIFICATE_OF_PAY_AND_TAXCaption; CERTIFICATE_OF_PAY_AND_TAXCaptionLbl)
            {
            }
            column(NAME_______________________________________________________________Caption; NAME_______________________________________________________________CaptionLbl)
            {
            }
            column(ADDRESS___________________________________________________________Caption; ADDRESS___________________________________________________________CaptionLbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption; SIGNATURE___________________________________________________________CaptionLbl)
            {
            }
            column(DATE___STAMP___________________________________________________________Caption; DATE___STAMP___________________________________________________________CaptionLbl)
            {
            }
            column(P9ACaption; P9ACaptionLbl)
            {
            }
            column(V4___Where_any_of_the_pay_relates_to_a_period_other_that_this_year_e_g_gratuity__give_details_Caption; V4___Where_any_of_the_pay_relates_to_a_period_other_that_this_year_e_g_gratuity__give_detailsCaptionLbl)
            {
            }
            column(YearCaption; YearCaptionLbl)
            {
            }
            column(Amount__Kenya_Pounds_Caption; Amount__Kenya_Pounds_CaptionLbl)
            {
            }
            column(Tax__Shs_Caption; Tax__Shs_CaptionLbl)
            {
            }
            column(DataItem1102756145; NAMES_OF_MORTGAGE_FINANCIAL_INSTITUTIONLbl)
            {
            }
            column(DataItem1102756146; L_R__No__OF_OWNER_OCCUPIED_HOUSEDATE_OF_OCCUPATILbl)
            {
            }
            column(Reference_No__________________________________________Caption; Reference_No__________________________________________CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            dataitem("prEmployee P9 Info"; "Payroll P9 Buffer")
            {
                DataItemLink = "Employee Code" = field("No.");
                DataItemTableView = sorting("Employee Code", "Payroll Period") order(ascending);
                column(ReportForNavId_7242; 7242)
                {
                }
                column(FORMAT__prEmployee_P9_Info___Payroll_Period__0___Month_Text___; Format("prEmployee P9 Info"."Payroll Period", 0, '<Month Text>'))
                {
                }
                column(Basic; "Basic Pay")
                {
                }
                column(Benefits; Benefits)
                {
                }
                column(Value_Of_Quarters_; "Value Of Quarters")
                {
                }
                column(Gross_Pay_; "Gross Pay")
                {
                }
                column(prEmployee_P9_Info__Owner_Occupier_Interest_; "Owner Occupier Interest")
                {
                }
                column(Basic_Pay__0_3; "Basic Pay" * 0.3)
                {
                }
                column(NSSF___Defined_Contribution___PensionF_InsuranceF; NSSF + PensionF + InsuranceF)
                {
                }
                column(fixedDefContri; fixedDefContri)
                {
                }
                column(Gross_Pay__ColG; "Gross Pay" - ColG)
                {
                }
                column(Tax_Charged_; "Tax Charged")
                {
                }
                column(Tax_Relief_; "Tax Relief")
                {
                }
                column(Insurance_Relief_; "Insurance Relief")
                {
                }
                column(PAYE; PAYE)
                {
                }
                column(ColG; ColG)
                {
                }
                column(prEmployee_P9_Info_Employee_Code; "Employee Code")
                {
                }
                column(prEmployee_P9_Info_Payroll_Period; "Payroll Period")
                {
                }

                trigger OnAfterGetRecord()
                var
                    prPayrollProcess: Codeunit "Payroll Processing";
                begin
                    RestrictAccess;
                    P9.Reset;
                    P9.SetRange(P9."Employee Code", "HR Employee"."No.");
                    P9.SetRange(P9."Period Year", SelectedPeriod);
                    if P9.Find('-') then begin
                        repeat
                            TotaA := TotaA + P9."Basic Pay";
                            TotalB := TotalB + P9.Benefits;
                            totalC := totalC + P9."Value Of Quarters";
                            totalD := totalD + P9."Gross Pay";
                            TotalE1 := TotalE1 + (P9."Basic Pay" * 0.3);
                            TotalE2 := TotalE2 + (P9.NSSF/*+P9."Defined Contribution"*/);
                            TotalE3 := TotalE3 + 20000;
                            TotalF := TotalF + P9."Owner Occupier Interest";
                            if P9.NSSF < 20000 then begin
                                //TotalG:=TotalG+P9.NSSF;
                                TotalH := TotalH + (P9."Gross Pay"/*-(P9.NSSF+P9."Defined Contribution")*/);
                            end else begin
                                //TotalG:=TotalG+20000;
                                TotalH := TotalH + (P9."Gross Pay" - 20000);
                            end;
                            TotalJ := TotalJ + P9."Tax Charged";
                            TotalK := TotalK + (P9."Tax Relief" + P9."Insurance Relief");
                            TotalL := TotalL + P9.PAYE;
                        until P9.Next = 0;
                    end;

                    "Total Tax Charged" := TotalJ;






                    PensionF := 0;
                    PeriodTrans.Reset;
                    PeriodTrans.SetRange(PeriodTrans."Employee Code", "prEmployee P9 Info"."Employee Code");
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", "prEmployee P9 Info"."Payroll Period");
                    PeriodTrans.SetFilter(PeriodTrans."Transaction Code", 'D13');
                    if PeriodTrans.Find('-') then begin
                        PensionF := PeriodTrans.Amount;
                        PensionFT += PensionF;
                    end;

                    InsuranceF := 0;
                    PeriodTrans.Reset;
                    PeriodTrans.SetRange(PeriodTrans."Employee Code", "prEmployee P9 Info"."Employee Code");
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", "prEmployee P9 Info"."Payroll Period");
                    PeriodTrans.SetFilter(PeriodTrans."Transaction Code", 'D0008');
                    if PeriodTrans.Find('-') then begin
                        InsuranceF := PeriodTrans.Amount;
                        InsuranceFT += InsuranceF;
                    end;

                    if (/*"Defined Contribution"+*/NSSF + PensionF + InsuranceF) > 20000 then begin
                        ColG := 20000 + "Owner Occupier Interest";
                        TotalG := TotalG + ColG;
                    end
                    else begin
                        ColG := (/*"Defined Contribution"+*/NSSF + PensionF + InsuranceF) + "Owner Occupier Interest";
                        TotalG := TotalG + ColG;
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    "prEmployee P9 Info".SetFilter("prEmployee P9 Info"."Period Year", Format(SelectedPeriod));
                    PensionFT := 0;
                    InsuranceFT := 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                if SelectedPeriod = 0 then begin
                    Error('Erros');
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Selected Period :"; SelectedPeriod)
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

    trigger OnInitReport()
    begin
        SelectedPeriod := Date2dmy(Today, 3) - 1;
        //RestrictAccess
    end;

    trigger OnPreReport()
    begin

        if "control info".Get then
            "control info".CalcFields(Picture);


        "Employer Name" := "control info".Name;
        EmployerPIN := "control info"."KRA PIN";


        //SelectedPeriod:="prEmployee P9 Info"."Period Year";
        fixedDefContri := 20000;
    end;

    var
        strEmpName: Text[250];
        strPin: Text[30];
        EmployerPIN: Text[30];
        SelectedPeriod: Integer;
        fixedDefContri: Decimal;
        "Total Tax Charged": Decimal;
        "Total PAYE": Decimal;
        TotaA: Decimal;
        TotalB: Decimal;
        totalC: Decimal;
        totalD: Decimal;
        TotalE1: Decimal;
        TotalE2: Decimal;
        TotalE3: Decimal;
        TotalF: Decimal;
        TotalG: Decimal;
        TotalH: Decimal;
        TotalI: Decimal;
        TotalJ: Decimal;
        TotalK: Decimal;
        TotalL: Decimal;
        P9: Record "Payroll P9 Buffer";
        ColG: Decimal;
        "control info": Record "Company Information";
        "Employer Name": Text[50];
        PeriodTrans: Record "Payroll Period Transactions";
        PensionF: Decimal;
        PensionFT: Decimal;
        InsuranceF: Decimal;
        InsuranceFT: Decimal;
        Income_Tax_DepartmentCaptionLbl: label 'Income Tax Department';
        INCOME_TAX_DEDUCTION_CARD_YEAR_CaptionLbl: label 'INCOME TAX DEDUCTION CARD YEAR:';
        EMPLOYER_S_PINCaptionLbl: label 'EMPLOYER''S PIN';
        MONTHCaptionLbl: label 'MONTH';
        Basic_SalaryCaptionLbl: label 'Basic Salary';
        Benefits__Non_CashCaptionLbl: label 'Benefits\ Non-Cash';
        Value_Of__QuartersCaptionLbl: label 'Value Of\ Quarters';
        Total__Gross_PayCaptionLbl: label 'Total\ Gross Pay';
        Defined_Contribution__Retirement_SchemeCaptionLbl: label 'Defined Contribution\ Retirement Scheme';
        Owner_Occupier_InterestCaptionLbl: label 'Owner Occupier Interest';
        Retirement_Contribution___Owner_OccupierCaptionLbl: label 'Retirement Contribution \ Owner Occupier';
        Column_D_G__Chargeable_AmountCaptionLbl: label 'Column D-G\ Chargeable Amount';
        Personal__ReliefCaptionLbl: label 'Personal\ Relief';
        P_A_Y_E__TAXCaptionLbl: label 'P.A.Y.E. TAX';
        ECaptionLbl: label 'E';
        E1__30_CaptionLbl: label 'E1 \30%';
        E2__ActualCaptionLbl: label 'E2 \Actual';
        E3__FIXEDCaptionLbl: label 'E3 \FIXED';
        ACaptionLbl: label 'A';
        BCaptionLbl: label 'B';
        CCaptionLbl: label 'C';
        DCaptionLbl: label 'D';
        F__Amount_of_InterestCaptionLbl: label 'Amount of Interest';
        G__Lowest_of_E_added_to_FCaptionLbl: label 'Lowest of E added to F';
        HCaptionLbl: label 'H';
        JCaptionLbl: label 'J';
        V1_162_00CaptionLbl: label '1408';
        KCaptionLbl: label 'K';
        V0CaptionLbl: label '0';
        LCaptionLbl: label 'L';
        Total__Kshs___1_162_00CaptionLbl: label 'Total (Kshs)';
        Employee_s_NameCaptionLbl: label 'Employee''s Name';
        Personal_File_No_CaptionLbl: label 'Personal File No.';
        Employee_PINCaptionLbl: label 'Employee PIN';
        Employer_s_NameCaptionLbl: label 'Employer''s Name';
        TOTAL_CHARGEABLE_PAY__COL_J__K_PoundCaptionLbl: label 'TOTAL CHARGEABLE PAY (COL J) K-Pound';
        TOTAL_TAX__COL_M__KshsCaptionLbl: label 'TOTAL TAX (COL M) Kshs';
        V1__Date_employee_commenced_if_during_the_yearName_and_address_of_emploLbl: label '(1) Date employee commenced if during the year .....................................';
        V2__Date_left_if_during_the_yearName_and_addressLbl: label '(2) Date left if during the year .................................................................. ';
        V3__Where_housing_is_provided__State_monthly_rentCaptionLbl: label '(3) Where housing is provided, State monthly rent ..................................';
        CERTIFICATE_OF_PAY_AND_TAXCaptionLbl: label 'CERTIFICATE OF PAY AND TAX';
        NAME_______________________________________________________________CaptionLbl: label 'NAME      .........................................................';
        ADDRESS___________________________________________________________CaptionLbl: label 'ADDRESS  .........................................................';
        SIGNATURE___________________________________________________________CaptionLbl: label 'SIGNATURE  .........................................................';
        DATE___STAMP___________________________________________________________CaptionLbl: label 'DATE & STAMP  .........................................................';
        P9ACaptionLbl: label 'P9A';
        V4___Where_any_of_the_pay_relates_to_a_period_other_that_this_year_e_g_gratuity__give_detailsCaptionLbl: label '(4)  Where any of the pay relates to a period other that this year e.g gratuity, give details...................';
        YearCaptionLbl: label 'Year';
        Amount__Kenya_Pounds_CaptionLbl: label 'Amount (Kenya Pounds)';
        Tax__Shs_CaptionLbl: label 'Tax (Shs)';
        NAMES_OF_MORTGAGE_FINANCIAL_INSTITUTIONLbl: label 'NAMES OF MORTGAGE FINANCIAL INSTITUTION .........................................................................................';
        L_R__No__OF_OWNER_OCCUPIED_HOUSEDATE_OF_OCCUPATILbl: label 'L.R. No. OF OWNER OCCUPIED HOUSE........................................................................ .';
        Reference_No__________________________________________CaptionLbl: label 'Reference No: ........................................';
        TotalCaptionLbl: label 'Total';


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange(Payroll, true);
        if not SaccoPermissions.FindFirst then begin

            SaccoPermissions.Get(UserId);
            if SaccoPermissions."Staff No" <> "HR Employee"."No." then
                Error('You do not have the following permission: "Payroll"');
        end;
    end;
}

