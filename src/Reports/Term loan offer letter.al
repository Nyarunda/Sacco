report 50030 "Term Loan-Offer Letter"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Term Loan-Offer Letter.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(RequestedAmount_Loans; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount_Loans; Loans."Approved Amount")
            {
            }
            column(MemberName_Loans; Loans."Member Name")
            {
            }
            column(ApprovalDate_Loans; Loans."Disbursement Date")
            {
            }
            column(Installments_Loans; Loans.Installments)
            {
            }
            column(DisbursementDate_Loans; Loans."Disbursement Date")
            {
            }
            column(Repayment_Loans; Loans.Repayment)
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(StaffNo_Loans; Loans."Staff No")
            {
            }
            column(RecommendedAmount_Loans; Loans."Recommended Amount")
            {
            }
            column(InterestCalculationMethod_Loans; Loans."Interest Calculation Method")
            {
            }
            column(Interest_Loans; Loans."Annual Interest %")
            {
            }
            column(NumberText; NumberText[1])
            {
            }
            column(NumberTextI; NumberTextI[1])
            {
            }
            column(NumberTextD; NumberTextD[1])
            {
            }
            column(Requireddeposits; Requireddeposits)
            {
            }
            column(NoOfGuarantors; NoOfGuarantors)
            {
            }
            column(GuarantorTxt; GuarantorTxt)
            {
            }
            dataitem(Members; Members)
            {
                DataItemLink = "No." = FIELD("Member No.");
                column(No_Members; Members."No.")
                {
                }
                column(Name_Members; Members.Name)
                {
                }

                column(Name2_Members; Members.Name)
                {
                }
                column(CurrentAddress_Members; Members."Address 2")
                {
                }
                column(HomeAddress_Members; Members.Address)
                {
                }
                column(City_Members; Members.City)
                {
                }
                column(Contact_Members; Members."Contact Name 2")
                {
                }
                column(PhoneNo_Members; Members."Phone No.")
                {
                }
                column(GlobalDimension1Code_Members; Members."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_Members; Members."Global Dimension 2 Code")
                {
                }
                column(PostCode_Members; Members."Post Code")
                {
                }
                column(County_Members; Members.County)
                {
                }
                column(EMail_Members; Members."E-Mail")
                {
                }
                column(PayrollStaffNo_Members; Members."Payroll/Staff No.")
                {
                }
                column(IDNo_Members; Members."ID No.")
                {
                }
                column(MobilePhoneNo_Members; Members."Mobile Phone No.")
                {
                }
                column(Salutation_Members; Members."Salutation Code")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                Requireddeposits := 0;
                NoOfGuarantors := 0;
                ProductFactory.GET(Loans."Loan Product Type");
                //Amount := Amount + "Receipt Line".Amount;
                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NumberText, Loans."Approved Amount", '');
                CheckReport.FormatNoText(NumberTextI, Loans.Installments, '');
                SavingsAccounts.RESET;
                SavingsAccounts.SETRANGE(SavingsAccounts."Member No.", Loans."Member No.");
                SavingsAccounts.SETRANGE(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"Deposit Contribution");
                IF SavingsAccounts.FIND('-') THEN BEGIN
                    SavingsAccounts.CALCFIELDS(SavingsAccounts.Balance, SavingsAccounts."Balance (LCY)");
                    Requireddeposits := SavingsAccounts."Balance (LCY)";
                END;
                IF Loans."Approved Amount" < 2000000 THEN
                    NoOfGuarantors := ProductFactory."Minimum Guarantors" ELSE
                    NoOfGuarantors := 7;//ProductFactory."Maximum Guarantors";
                IF NoOfGuarantors = 0 THEN
                    GuarantorTxt := 'Zero' ELSE IF
                         NoOfGuarantors = 1 THEN
                                               GuarantorTxt := 'One' ELSE
                    IF NoOfGuarantors = 2 THEN
                        GuarantorTxt := 'Two' ELSE IF
                             NoOfGuarantors = 3 THEN
                                                  GuarantorTxt := 'Three' ELSE
                        IF NoOfGuarantors = 4 THEN
                            GuarantorTxt := 'Four' ELSE IF
                                 NoOfGuarantors = 5 THEN
                                                       GuarantorTxt := 'Five' ELSE
                            IF NoOfGuarantors = 6 THEN
                                GuarantorTxt := 'Six' ELSE IF
                                     NoOfGuarantors = 7 THEN
                                                          GuarantorTxt := 'Seven' ELSE
                                IF NoOfGuarantors = 8 THEN
                                    GuarantorTxt := 'Eight' ELSE IF
                                         NoOfGuarantors = 9 THEN
                                                                GuarantorTxt := 'Nine' ELSE
                                    IF NoOfGuarantors = 10 THEN
                                        GuarantorTxt := 'Ten' ELSE IF
                                             NoOfGuarantors = 11 THEN
                                                                  GuarantorTxt := 'Eleven' ELSE
                                        IF NoOfGuarantors = 12 THEN
                                            GuarantorTxt := 'Twelve' ELSE
                                            GuarantorTxt := 'Zero';
                CheckReport.FormatNoText(NumberTextD, Requireddeposits, '');
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

    var
        CheckReport: Report Check;
        NumberText: array[2] of Text;
        Amount: Decimal;
        NumberTextI: array[2] of Text;
        ProductFactory: Record "Product Setup";
        Requireddeposits: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        NumberTextD: array[2] of Text;
        NoOfGuarantors: Integer;
        GuarantorTxt: Text;
}

