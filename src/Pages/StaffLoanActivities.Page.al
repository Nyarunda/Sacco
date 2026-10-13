page 50901 "Staff Loan Activities_"
{
    Caption = 'Staff Loans';
    PageType = CardPart;
    SourceTable = Integer;
    SourceTableTemporary = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup("Staff Loan Activities_")
            {
                Caption = 'Staff Loans';

                field(OpenStaffLoans; OpenStaffLoans)
                {
                    ApplicationArea = All;
                    Caption = 'Open Staff Loans';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Staff Loan Application List");
                    end;
                }

                field(PendingApprovalStaffLoans; PendingApprovalStaffLoans)
                {
                    ApplicationArea = All;
                    Caption = 'Pending Approval';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Staff Loan Pending Approval_");
                    end;
                }

                field(ApprovedStaffLoans; ApprovedStaffLoans)
                {
                    ApplicationArea = All;
                    Caption = 'Approved';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Staff Loan Approved List");
                    end;
                }

                field(RejectedStaffLoans; RejectedStaffLoans)
                {
                    ApplicationArea = All;
                    Caption = 'Rejected';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Staff Loan Rejected List_");
                    end;
                }

                field(PendingDisbursementStaffLoans; PendingDisbursementStaffLoans)
                {
                    ApplicationArea = All;
                    Caption = 'Pending Disbursement';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Staff Loan Pending Disbur._");
                    end;
                }

                field(PostedStaffLoans; PostedStaffLoans)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Staff Loans';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Staff Loan Posted List_");
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.IsEmpty() then begin
            Rec.Number := 1;
            Rec.Insert();
        end;

        RefreshCues();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        RefreshCues();
    end;

    var
        OpenStaffLoans: Integer;
        PendingApprovalStaffLoans: Integer;
        ApprovedStaffLoans: Integer;
        RejectedStaffLoans: Integer;
        PendingDisbursementStaffLoans: Integer;
        PostedStaffLoans: Integer;

    local procedure RefreshCues()
    begin
        OpenStaffLoans := CountStaffLoansByStatus(EnumOrOptionStatusTxt('Open'), false);
        PendingApprovalStaffLoans := CountStaffLoansByStatus(EnumOrOptionStatusTxt('Pending'), false);
        ApprovedStaffLoans := CountStaffLoansByStatus(EnumOrOptionStatusTxt('Approved'), false);
        RejectedStaffLoans := CountStaffLoansByStatus(EnumOrOptionStatusTxt('Rejected'), false);
        PendingDisbursementStaffLoans := CountStaffLoansByStatus(EnumOrOptionStatusTxt('Approved'), false);
        PostedStaffLoans := CountPostedStaffLoans();
    end;

    local procedure CountStaffLoansByStatus(StatusFilter: Text; OnlyUnposted: Boolean): Integer
    var
        Loan: Record Loans;
    begin
        Loan.Reset();
        SetStaffLoanFilters(Loan);

        if StatusFilter <> '' then
            Loan.SetFilter(Status, StatusFilter);

        if OnlyUnposted then
            Loan.SetRange(Posted, false);

        exit(Loan.Count());
    end;

    local procedure CountPostedStaffLoans(): Integer
    var
        Loan: Record Loans;
    begin
        Loan.Reset();
        SetStaffLoanFilters(Loan);
        Loan.SetFilter("Member Category", '%1', Loan."Member Category"::"Staff Members");
        Loan.SetRange(Posted, true);
        exit(Loan.Count());
    end;

    local procedure SetStaffLoanFilters(var Loan: Record Loans)
    begin
        // Change this filter if your Member Category value is different.
        // Examples: STAFF, Staff, Employee
        Loan.SetRange("Member Category", Loan."Member Category"::"Staff Members");
    end;

    local procedure EnumOrOptionStatusTxt(StatusName: Text): Text
    begin
        exit(StatusName);
    end;
}
