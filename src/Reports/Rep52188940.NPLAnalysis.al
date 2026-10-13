report 50642 "NPL Analysis"
{
    Caption = 'NPL Analysis';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/NPLAnalysis.rdl';

    dataset
    {
        dataitem(SCat; "SASRA Categorization")
        {
            RequestFilterFields = "As At", "Loan Category", "Member No.", "Loan Product Type", "Issued Date";

            column(CompanyPicture; CI.Picture) { }
            column(LoanNo; "Loan No.") { }
            column(MemberNo; "Member No.") { }
            column(MemberName; "Member Name") { }
            column(LoanProductType; "Loan Product Type") { }
            column(ApprovedAmount; "Approved Amount") { }
            column(OutstandingPrincipal; "Outstanding Principal") { }
            column(OutstandingInterest; "Outstanding Interest") { }
            column(OutstandingPenalty; "Outstanding Penalty") { }
            column(OutstandingAppraisal; "Outstanding Appraisal") { }
            column(TotalOutstandingBalance; "Outstanding Principal" + "Outstanding Interest") { }
            column(PrincipalExpected; "Principal Expected") { }
            column(PrincipalPaid; "Principal Paid") { }
            column(PrincipalArrears; "Principal Arrears") { }
            column(InterestArrears; "Interest Arrears") { }
            column(TotalArrears; "Total Arrears") { }
            column(DaysInArrears; "Days in Arrears") { }
            column(MonthsInArrears; "Months in Arrears") { }
            column(LoanCategory; Format("Loan Category")) { }
            column(CategoryType; Format(Type)) { }
            column(AsAt; "As At") { }
            column(IssuedDate; "Issued Date") { }
            column(EmployerCode; "Employer Code") { }
            column(RepayMode; "Repay Mode") { }
            column(MobileLoan; "Mobile Loan") { }
            column(Bucket; BucketTxt) { Caption = 'Bucket'; }
            column(ProvisionPct; ProvisionPct) { Caption = 'Provision %'; }
            column(ProvisionAmount; ProvisionAmount) { Caption = 'Provision Amount'; }

            trigger OnAfterGetRecord()
            begin
                //CalcFields("Repay Mode", "Mobile Loan");

                BucketTxt := GetBucket("Days in Arrears");
                ProvisionPct := GetProvisionPct("Loan Category");
                ProvisionAmount := Round("Total Outstanding Balance" * ProvisionPct / 100, 0.01);
            end;
        }

    }

    requestpage { }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        CI.Get();
        CI.CalcFields(Picture);
        // Set default value for the "As At" filter to today
    end;

    var
        BucketTxt: Text[20];
        ProvisionPct: Decimal;
        ProvisionAmount: Decimal;

        CI: Record "Company Information";

    local procedure GetBucket(DaysInArrears: Integer): Text[20]
    begin
        if DaysInArrears <= 30 then
            exit('0-30');
        if DaysInArrears <= 90 then
            exit('31-90');
        if DaysInArrears <= 180 then
            exit('91-180');
        if DaysInArrears <= 270 then
            exit('181-270');

        exit('270+');
    end;

    local procedure GetProvisionPct(Category: Option Performing,Watch,Substandard,Doubtful,Loss): Decimal
    begin
        case Category of
            Category::Performing:
                exit(1);
            Category::Watch:
                exit(5);
            Category::Substandard:
                exit(25);
            Category::Doubtful:
                exit(50);
            Category::Loss:
                exit(100);
        end;

        exit(0);
    end;
}
