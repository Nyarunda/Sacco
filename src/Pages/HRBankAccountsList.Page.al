Page 51099 "HR Bank Accounts List"
{
    PageType = ListPart;
    Caption = ' Loan Disbursement Bank Accounts';
    SourceTable = "HR Employee Bank Accounts";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EmployeeCode; Rec."Employee Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Disbursement Account No."; Rec."Disbursement Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(BankCode; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field(BankName; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field(BranchCode; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field(BranchName; Rec."Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field(ACNumber; Rec."A/C Number")
                {
                    ApplicationArea = Basic;
                }
                field(PercentagetoTransfer; Rec."Amount to Transfer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount to Transfer';
                    trigger OnValidate()
                    var
                        Loans: Record Loans;
                        HRBankAccounts: Record "HR Employee Bank Accounts";
                        Lines: Record "Partial Loans Disb. Lines";
                    begin
                        Loans.Reset();
                        Loans.SetRange("Loan No.", Rec."Loan No.");
                        if Loans.FindFirst() then begin
                            HRBankAccounts.Reset();
                            HRBankAccounts.SetRange("Loan No.", Rec."Loan No.");
                            if HRBankAccounts.FindFirst() then begin
                                HRBankAccounts.CalcSums("Amount to Transfer");
                                if HRBankAccounts."Amount to Transfer" > Loans."Amount To Disburse" then
                                    Error('Total Amount to Transfer for this Loan exceeds the Loan Amount');

                            end else begin

                                Lines.Reset();
                                Lines.SetRange("Header No.", Rec."Loan No.");
                                if Lines.FindFirst() then begin
                                    HRBankAccounts.Reset();
                                    HRBankAccounts.SetRange("Loan No.", Lines."Header No.");
                                    if HRBankAccounts.FindFirst() then begin
                                        HRBankAccounts.CalcSums("Amount to Transfer");
                                        if HRBankAccounts."Amount to Transfer" > Lines."Amount to Disbuse" then
                                            Error('Total Amount to Transfer for this Loan exceeds the Loan Amount');
                                    end;
                                end;
                            end;
                        end;
                    end;

                }

                field("Loan No."; Rec."Loan No.")
                {
                    editable = false;
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Disbursement Date"; Rec."Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }

    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        SetPageEditability();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetPageEditability();
    end;

    local procedure SetPageEditability()
    var
        PartialDisbHeader: Record "Partial Loans Disb. Header";
    begin
        //CurrPage.Editable := false;

        /* if Rec."Loan No." = '' then
            exit; */

        /* if PartialDisbHeader.Get(Rec."Loan No.") then
            CurrPage.Editable := PartialDisbHeader.Status = PartialDisbHeader.Status::Pending; */
    end;
}

