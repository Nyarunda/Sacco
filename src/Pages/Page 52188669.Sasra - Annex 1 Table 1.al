
Page 50332 "Sasra - Annex 1 Table 1"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Sasra - Annex 1 Tabke 1";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanNumber; Rec."Loan Number")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNumber; Rec."Member Number")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(BranchName; Rec."Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field(LoanOfficer; Rec."Loan Officer")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerName; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                }
                field(LoanType; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field(LoanAmortizationType; Rec."Loan Amortization Type")
                {
                    ApplicationArea = Basic;
                }
                field(LoanInstallments; Rec."Loan Installments")
                {
                    ApplicationArea = Basic;
                }
                field(AnnualLoanRate; Rec."Annual Loan Rate")
                {
                    ApplicationArea = Basic;
                }
                field(LoanFrequency; Rec."Loan Frequency")
                {
                    ApplicationArea = Basic;
                }
                field(DateLoanDisbursed; Rec."Date Loan Disbursed")
                {
                    ApplicationArea = Basic;
                }
                field(LoanAmount; Rec."Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field(LoanMaturity; Rec."Loan Maturity")
                {
                    ApplicationArea = Basic;
                }
                field(LoanFirstPmtdate; Rec."Loan First Pmt date")
                {
                    ApplicationArea = Basic;
                }
                field(Latestamountpaid; Rec."Latest amount paid")
                {
                    ApplicationArea = Basic;
                }
                field(Latestpaymentdate; Rec."Latest payment date")
                {
                    ApplicationArea = Basic;
                }
                field(LoanBalance; Rec."Loan Balance")
                {
                    ApplicationArea = Basic;
                }
                field(DaysinArrears; Rec."Days in Arrears")
                {
                    ApplicationArea = Basic;
                }
                field(Arrearsdate; Rec."Arrears date")
                {
                    ApplicationArea = Basic;
                }
                field(LoanClassification; Rec."Loan-Classification")
                {
                    ApplicationArea = Basic;
                }
                field(LoanlossProvision; Rec."Loan loss Provision")
                {
                    ApplicationArea = Basic;
                }
                field(LoanRestructureFlag1; Rec."Loan Restructure Flag[1]")
                {
                    ApplicationArea = Basic;
                }
                field(LoanInterestDue; Rec.Loan_Interest_Due)
                {
                    ApplicationArea = Basic;
                }
                field(NoofLoanGuarantors; Rec."No. of Loan Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field(Amountofguarantee; Rec."Amount of guarantee")
                {
                    ApplicationArea = Basic;
                }
                field(OtherCollateralSecurity; Rec."Other Collateral_Security")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Get Lines")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Sasra - Annex 1 - 1";

                trigger OnAction()
                begin
                    /*
                    IF CONFIRM('Are you sure you want to Generate Lines?') THEN BEGIN
                    
                    
                        Loans.RESET;
                        Loans.SETFILTER("Outstanding Principal",'>0');
                        IF Loans.FINDFIRST THEN BEGIN
                    
                    
                    
                            dWindow.OPEN('Generating Lines:       @1@@@@@@@@@\'
                                                      +'Counter   #2#########'
                                                      +'Total     #3#########'
                                                      +'Press Esc to abort');
                    
                            NoOfRecords:=Loans.COUNT;
                            CurrentRecordNo := 0;
                    
                            REPEAT
                                CurrentRecordNo += 1;
                                dWindow.UPDATE(2,CurrentRecordNo);
                                dWindow.UPDATE(3,NoOfRecords);
                                dWindow.UPDATE(1,ROUND(CurrentRecordNo /  NoOfRecords * 10000,1));
                    
                    
                                Members.GET(Loans."Member No.");
                    
                                Annex.INIT;
                                Annex."Loan Number" := Loans."Loan No.";
                                Annex."Member Number" := Members."No.";
                                Annex."Member Name" := Members.Name;
                                Annex."Branch Name" := Members."Branch Code";
                                Annex."Loan Officer" := Members."Relationship Officer Name";
                                Annex."Employer Name" := Members."Employer Code";
                                Annex."Loan Type" := Members."Employer Code";
                    
                    
                                //Type of amortization schedule (SLA=straight line – constant principal plus interest in each installment, FIA=fixed installment, BUL=bullet loan, OTHER)
                                IF Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Straight Line" THEN
                                    Annex."Loan Amortization Type" := 'SLA';
                                IF Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" THEN
                                    Annex."Loan Amortization Type" := 'OTHER';
                                IF Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised THEN
                                    Annex."Loan Amortization Type" := 'FIA';
                                IF Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Flat" THEN
                                    Annex."Loan Amortization Type" := 'OTHER';
                                IF Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Zero Interest" THEN
                                    Annex."Loan Amortization Type" := 'OTHER';
                    
                                Annex."Loan Installments" := Loans.Installments;
                                Annex."Annual Loan Rate" := Loans."Annual Interest %";
                                Annex."Loan Frequency" := FORMAT(Loans."Repayment Frequency");
                                Annex."Date Loan Disbursed" := Loans."Disbursement Date";
                                Annex."Loan Amount" := Loans."Approved Amount";
                                Annex."Loan Maturity" := Loans."Completion Date";
                    
                                CLedger.RESET;
                                CLedger.SETRANGE("Loan No.",Loans."Loan No.");
                                CLedger.SETRANGE("Transaction Type",CLedger."Transaction Type"::"Principal Repayment");
                                CLedger.SETRANGE(Reversed,FALSE);
                                IF CLedger.FINDFIRST THEN BEGIN
                                    Annex."Loan First Pmt date" := CLedger."Posting Date";
                                END;
                    
                    
                                CLedger.RESET;
                                CLedger.SETRANGE("Loan No.",Loans."Loan No.");
                                CLedger.SETRANGE("Transaction Type",CLedger."Transaction Type"::"Principal Repayment");
                                CLedger.SETFILTER("Document No.",'<>%1','');
                                CLedger.SETRANGE(Reversed,FALSE);
                                IF CLedger.FINDLAST THEN BEGIN
                    
                                    Annex."Latest amount paid" := CLedger."Amount (LCY)"*-1;
                                    Annex."Latest payment date" := CLedger."Posting Date";
                    
                                END;
                    
                                Loans.CALCFIELDS("Outstanding Principal","Outstanding Interest");
                    
                                Annex."Loan Balance" := Loans."Outstanding Principal";
                    
                                Annex."Days in Arrears" := 0;
                                Annex."Arrears date" := 0D;
                                Annex."Loan-Classification" := '';
                                Annex."Loan loss Provision" := '';
                                Annex."Loan Restructure Flag[1]" := 1;
                                Annex.Loan_Interest_Due := Loans."Outstanding Interest";
                                Annex."No. of Loan Guarantors" := 0;
                                Annex."Amount of guarantee" := 0;
                                Annex."Other Collateral_Security" := '';
                                Annex.INSERT;
                    
                    
                    
                            UNTIL Loans.NEXT=0;
                            dWindow.CLOSE;
                        END;
                    END;
                    */

                end;
            }
            action("View Report")
            {
                ApplicationArea = Basic;
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Sasra - Annex 1 Report 1";
            }
            action("Loan Sectoral Report")
            {
                ApplicationArea = Basic;
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Sasra Appendix III Report";
            }
        }
    }

    var
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        Loans: Record Loans;
        Annex: Record "Sasra - Annex 1 Tabke 1";
        Members: Record Members;
        CLedger: Record "Credit Ledger Entry";
}

