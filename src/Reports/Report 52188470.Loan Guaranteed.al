
Report 50133 "Loan Guaranteed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loan Guaranteed.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(No_Member; "No.")
            {
            }
            column(Name_Member;
            Name)
            {
            }
            column(CompName; Company.Name)
            {
            }
            column(CompAddress; Company.Address)
            {
            }
            column(CompPic; Company.Picture)
            {
            }
            dataitem("Loan Security"; "Loan Security")
            {
                DataItemLink = "Member No" = field("No.");
                DataItemTableView = where(Substituted = const(false), "Outstanding Principal" = filter(> 0));
                CalcFields = "Guaranteed By";
                column(ReportForNavId_4; 4)
                {
                }
                column(CurrentCommitted_LoanGuarantorsandSecurity; "Current Committed")
                {
                }
                column(LoanNo_LoanGuarantors; "Loan No.")
                {
                }
                column(Guaranteed_By; "Guaranteed By")
                { }
                column(SACCOAccountNo_LoanGuarantors; "Account No.")
                {
                }
                column(Name_LoanGuarantors; Name)
                {
                }
                column(LoanBalance_LoanGuarantors; "Guarantor Loan Balance")
                {
                }
                column(Shares_LoanGuarantors; "Guarantor Deposits")
                {
                }
                column(NoOfLoansGuaranteed_LoanGuarantors; "Loans Guaranteed")
                {
                }
                column(Substituted_LoanGuarantors; Sub)
                {
                }
                column(Date_LoanGuarantors; Date)
                {
                }
                column(SharesRecovery_LoanGuarantors; '')
                {
                }
                column(NewUpload_LoanGuarantors; '')
                {
                }
                column(AmountGuaranteed_LoanGuarantors; "Amount Guaranteed")
                {
                }
                column(StaffPayrollNo_LoanGuarantors; "Staff/Payroll No.")
                {
                }
                column(AccountNo_LoanGuarantors; "Account No.")
                {
                }
                column(SelfGuarantee_LoanGuarantors; "Self Guarantee")
                {
                }
                column(IDNo_LoanGuarantors; "ID No.")
                {
                }
                column(OutstandingBalance_LoanGuarantors; "Outstanding Principal")
                {
                }
                column(MemberGuaranteed_LoanGuarantors; "Member Guaranteed")
                {
                }
                column(PercentageGuaranteed_LoanGuarantors; '')
                {
                }
                column(TotalGuaranteed_LoanGuarantors; "Total Guaranteed")
                {
                }
                column(AvailableShares_LoanGuarantors; "Available Guarantorship")
                {
                }
                column(Signature_LoanGuarantors; '')
                {
                }
                column(MemberNo_LoanGuarantors; "Member No")
                {
                }
                column(LoanType_LoanGuarantors; "Loan Type")
                {
                }
                column(GuaranteedBalance_LoanGuarantors; '')
                {
                }
                column(LoaneeName_LoanGuarantors; "Loanee Name")
                {
                }
                column(lNAME; LOANEE)
                {
                }
                column(MemberNo; MemberNo)
                {
                }
                column(StaffNo; StaffNo)
                {
                }

                column(LoanPrdtName; LoanPrdtName)
                {
                }
                column(Rno; Rno)
                {
                }
                column(Category; Category)
                {
                }
                column(loanDisDate; loanDisDate)
                {
                }
                column(Loan_Type_Name; "Loan Type Name")
                {
                }
                column(Phone; Phone)
                {
                }
                column(ApprovedAmount; ApprovedAmount)
                {
                }


                trigger OnAfterGetRecord()
                var
                    Coll: Record "Loan Collateral Register";
                begin

                    /* if "Member No" = Members."No." then
                        CurrReport.Skip(); */


                    Sub := '';
                    Phone := '';
                    ApprovedAmount := 0;

                    if Substituted then
                        Sub := 'Yes';

                    Category := '';

                    //"Loan Security"."Guarantor Deposits":=0;
                    if Coll.Get("Loan Security"."Collateral Reg. No.") then
                        if not Coll.IsEmpty() then begin
                            Name := Coll."Collateral Details";
                        end;

                    if Loanss.Get("Loan No.") then begin
                        Loanss.CalcFields(Loanss."Outstanding Principal", "Loans Category-SACCO");
                        ApprovedAmount := Loanss."Approved Amount";
                        LoanPrdtName := Loanss."Loan Product Type";
                        loanDisDate := Loanss."Disbursement Date";
                        Category := Format(Loanss."Loans Category-SACCO");
                    end;

                    if Loanss.Get("Loan No.") then begin
                        LOANEE := Loanss."Member Name";
                        MemberNo := Loanss."Member No.";
                        StaffNo := Loanss."Staff No";
                        if Loanss.Posted = false then
                            CurrReport.Skip;
                    end;
                    if Member.Get("Loan Security"."Member No") then
                        Phone := Member."Mobile Phone No.";

                    /* if MemberNo = Members."No." then
                        CurrReport.Skip(); */
                    // Show only loans guaranteed for third parties — skip self-guaranteed loans.
                    if ("Member Guaranteed" <> '') and ("Member Guaranteed" = "Member No") then
                        CurrReport.Skip();

                    if MemberNo = Members."No." then
                        CurrReport.Skip();

                    Rno := Rno + 1;


                end;
            }
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
        Company.Get;
        Company.CalcFields(Company.Picture);
    end;

    var
        Phone: Code[15];
        Member: Record Members;
        loanDisDate: Date;
        Loanss: Record Loans;
        Cust: Record Customer;
        Shares: Decimal;
        Cust2: Record Customer;
        LoanGaurantors: Record "Loan Security";
        LCount: Integer;
        A: Decimal;
        T: Decimal;
        LoanApps: Record Loans;
        Lamount: Decimal;
        LGBalance: Decimal;
        "Account No": Code[10];
        LOANEE: Text[80];
        MemberNo: Code[20];
        StaffNo: Code[20];
        LoanPrdtName: Text;
        PrdtFactory: Record "Product Setup";
        Rno: Integer;
        Company: Record "Company Information";
        Sub: Text;
        Category: Text;
        ApprovedAmount: Decimal;
}

