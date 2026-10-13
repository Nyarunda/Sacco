page 50895 "Loan Schedule API"
{
    PageType = API;
    APIPublisher = 'calwide';
    APIGroup = 'loans';
    APIVersion = 'v1.0';

    EntityName = 'loanScheduleImportLine';
    EntitySetName = 'loanScheduleImportLines';

    SourceTable = "Loan Repayment Schedule";
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    InsertAllowed = true;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(systemId; Rec.SystemId)
                {
                    Editable = false;
                }

                field(loanNo; Rec."Loan No.") { }
                field(memberNo; Rec."Member No.") { }
                field(lineNo; Rec."Line No.") { }
                field(repaymentDate; Rec."Repayment Date") { }
                field(oldRepaymentDate; Rec."Old Repayment Date") { }
                field(loanAmount; Rec."Loan Amount") { }
                field(monthlyPrincipal; Rec."Monthly Principal") { }
                field(monthlyInterest; Rec."Monthly Interest") { }
                field(monthlyAppraisal; Rec."Monthly Appraisal") { }
                field(monthlyRepayment; Rec."Monthly Repayment") { }
                field(loanBalance; Rec."Loan Balance") { }
                field(depositAmount; Rec."Monthly Shares") { }
                field(insuranceContribution; Rec."Insurance Contribution") { }
                field(monthlyShares; Rec."Monthly Shares") { }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("Loan No.");
        Rec.TestField("Member No.");
        Rec.TestField("Repayment Date");

        //if Rec."Line No." = 0 then
        //    Rec."Line No." := GetNextLineNo(Rec."Loan No.");

        if Rec."Old Repayment Date" = 0D then
            Rec."Old Repayment Date" := Rec."Repayment Date";

        // 1. If same primary key exists, update it.
        if UpdateExistingByPrimaryKey() then
            exit(false);

        // 2. If same loan + line no exists, update/rename it.
        if UpdateExistingByLoanLineNo() then
            exit(false);

        // 3. Otherwise allow normal insert.
        exit(true);
    end;

    local procedure UpdateExistingByPrimaryKey(): Boolean
    var
        ExistingSchedule: Record "Loan Repayment Schedule";
    begin
        ExistingSchedule.Reset();
        ExistingSchedule.SetRange("Loan No.", Rec."Loan No.");
        ExistingSchedule.SetRange("Repayment Date", Rec."Repayment Date");
        ExistingSchedule.SetRange("Member No.", Rec."Member No.");

        if not ExistingSchedule.FindFirst() then
            exit(false);

        UpdateScheduleFields(ExistingSchedule);
        exit(true);
    end;

    local procedure UpdateExistingByLoanLineNo(): Boolean
    var
        ExistingSchedule: Record "Loan Repayment Schedule";
    begin
        ExistingSchedule.Reset();
        ExistingSchedule.SetCurrentKey("Loan No.", "Line No.");
        ExistingSchedule.SetRange("Loan No.", Rec."Loan No.");
        ExistingSchedule.SetRange("Line No.", Rec."Line No.");

        if not ExistingSchedule.FindFirst() then
            exit(false);

        CheckPrimaryKeyConflict(ExistingSchedule);

        if HasPrimaryKeyChanged(ExistingSchedule) then begin
            ExistingSchedule.Rename(
                Rec."Loan No.",
                Rec."Repayment Date",
                Rec."Member No.");
        end;

        ExistingSchedule.Get(
            Rec."Loan No.",
            Rec."Repayment Date",
            Rec."Member No.");

        UpdateScheduleFields(ExistingSchedule);
        exit(true);
    end;

    local procedure UpdateScheduleFields(var ExistingSchedule: Record "Loan Repayment Schedule")
    begin
        ExistingSchedule."Line No." := Rec."Line No.";
        ExistingSchedule."Old Repayment Date" := Rec."Old Repayment Date";
        ExistingSchedule."Loan Amount" := Rec."Loan Amount";
        ExistingSchedule."Monthly Principal" := Rec."Monthly Principal";
        ExistingSchedule."Monthly Interest" := Rec."Monthly Interest";
        ExistingSchedule."Monthly Appraisal" := Rec."Monthly Appraisal";
        ExistingSchedule."Monthly Repayment" := Rec."Monthly Repayment";
        ExistingSchedule."Loan Balance" := Rec."Loan Balance";
        ExistingSchedule."Deposit Amount" := Rec."Deposit Amount";
        ExistingSchedule."Insurance Contribution" := Rec."Insurance Contribution";
        ExistingSchedule."Monthly Shares" := Rec."Monthly Shares";

        ExistingSchedule.Modify();
    end;

    local procedure HasPrimaryKeyChanged(var ExistingSchedule: Record "Loan Repayment Schedule"): Boolean
    begin
        exit(
            (ExistingSchedule."Loan No." <> Rec."Loan No.") or
            (ExistingSchedule."Repayment Date" <> Rec."Repayment Date") or
            (ExistingSchedule."Member No." <> Rec."Member No.")
        );
    end;

    local procedure CheckPrimaryKeyConflict(var ExistingSchedule: Record "Loan Repayment Schedule")
    var
        ConflictSchedule: Record "Loan Repayment Schedule";
    begin
        ConflictSchedule.Reset();
        ConflictSchedule.SetRange("Loan No.", Rec."Loan No.");
        ConflictSchedule.SetRange("Repayment Date", Rec."Repayment Date");
        ConflictSchedule.SetRange("Member No.", Rec."Member No.");

        if ConflictSchedule.FindFirst() then
            if ConflictSchedule."Line No." <> ExistingSchedule."Line No." then
                Error(
                    'Cannot update Loan %1 Line No. %2 to Repayment Date %3 because another schedule already exists with the same Loan No., Repayment Date, and Member No.',
                    Rec."Loan No.",
                    Rec."Line No.",
                    Rec."Repayment Date");
    end;

    local procedure GetNextLineNo(LoanNo: Code[20]): Integer
    var
        LoanSchedule: Record "Loan Repayment Schedule";
    begin
        LoanSchedule.Reset();
        LoanSchedule.SetCurrentKey("Loan No.", "Line No.");
        LoanSchedule.SetRange("Loan No.", LoanNo);

        if LoanSchedule.FindLast() then
            exit(LoanSchedule."Line No." + 10000);

        exit(10000);
    end;
}