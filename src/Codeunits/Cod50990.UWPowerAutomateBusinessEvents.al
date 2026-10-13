namespace UnitedWomen.UnitedWomen;

using System.Integration;

codeunit 50990 "UW Power Automate Bus. Events"
{
    procedure RaiseLoanApplicationSubmitted(LoanNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; ProductCode: Code[20]; ProductName: Text[100]; Amount: Decimal; ResponsibilityCenter: Code[20])
    begin
        LoanApplicationSubmitted(LoanNo, MemberNo, MemberName, ProductCode, ProductName, Amount, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    procedure RaiseLoanApproved(LoanNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; ProductCode: Code[20]; ProductName: Text[100]; ApprovedAmount: Decimal; ResponsibilityCenter: Code[20])
    begin
        LoanApproved(LoanNo, MemberNo, MemberName, ProductCode, ProductName, ApprovedAmount, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    procedure RaiseLoanRejected(LoanNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; Reason: Text[250]; ResponsibilityCenter: Code[20])
    begin
        LoanRejected(LoanNo, MemberNo, MemberName, Reason, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    procedure RaisePartialDisbursementPosted(DocumentNo: Code[20]; LoanNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; AmountDisbursed: Decimal; NetAmount: Decimal; PostingDate: Date; ResponsibilityCenter: Code[20])
    begin
        PartialDisbursementPosted(DocumentNo, LoanNo, MemberNo, MemberName, AmountDisbursed, NetAmount, PostingDate, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    procedure RaiseFixedDepositMaturingSoon(FixedDepositNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; FixedDepositAmount: Decimal; MaturityDate: Date; ResponsibilityCenter: Code[20])
    begin
        FixedDepositMaturingSoon(FixedDepositNo, MemberNo, MemberName, FixedDepositAmount, MaturityDate, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    procedure RaiseFixedDepositForfeitApproved(FixedDepositNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; FixedDepositAmount: Decimal; ApprovalDate: Date; ResponsibilityCenter: Code[20])
    begin
        FixedDepositForfeitApproved(FixedDepositNo, MemberNo, MemberName, FixedDepositAmount, ApprovalDate, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    procedure RaiseLeaveApplicationSubmitted(ApplicationNo: Code[20]; StaffNo: Code[20]; StaffName: Text[100]; LeaveType: Code[20]; DaysApplied: Decimal; StartDate: Date; EndDate: Date; ResponsibilityCenter: Code[20])
    begin
        LeaveApplicationSubmitted(ApplicationNo, StaffNo, StaffName, LeaveType, DaysApplied, StartDate, EndDate, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    procedure RaiseLeaveApplicationApproved(ApplicationNo: Code[20]; StaffNo: Code[20]; StaffName: Text[100]; LeaveType: Code[20]; DaysApproved: Decimal; StartDate: Date; EndDate: Date; ResponsibilityCenter: Code[20])
    begin
        LeaveApplicationApproved(ApplicationNo, StaffNo, StaffName, LeaveType, DaysApproved, StartDate, EndDate, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    procedure RaiseLoanChangeApproved(ChangeNo: Code[20]; LoanNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; ChangeType: Text[100]; NewLoanAmount: Decimal; NewInstallments: Integer; ResponsibilityCenter: Code[20])
    begin
        LoanChangeApproved(ChangeNo, LoanNo, MemberNo, MemberName, ChangeType, NewLoanAmount, NewInstallments, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    procedure RaiseReceiptPosted(ReceiptNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; AmountReceived: Decimal; PostingDate: Date; ResponsibilityCenter: Code[20])
    begin
        ReceiptPosted(ReceiptNo, MemberNo, MemberName, AmountReceived, PostingDate, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    procedure RaiseMpesaTransactionNeedsChange(TransactionId: Code[20]; TransactionType: Text[100]; ReceiverAccount: Code[30]; SavingsAccount: Code[30]; Amount: Decimal; Remarks: Text[250])
    begin
        MpesaTransactionNeedsChange(TransactionId, TransactionType, ReceiverAccount, SavingsAccount, Amount, Remarks, CurrentDateTime, UserId);
    end;

    procedure RaiseSaccoJournalApprovalRequested(DocumentNo: Code[20]; BatchName: Code[20]; Amount: Decimal; SenderId: Code[50]; ResponsibilityCenter: Code[20])
    begin
        SaccoJournalApprovalRequested(DocumentNo, BatchName, Amount, SenderId, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    procedure RaiseSecuritySubstitutionApproved(DocumentNo: Code[20]; LoanNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; ReplacementAmount: Decimal; ResponsibilityCenter: Code[20])
    begin
        SecuritySubstitutionApproved(DocumentNo, LoanNo, MemberNo, MemberName, ReplacementAmount, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    procedure RaiseMemberChangeApproved(ChangeNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; ChangeType: Text[100]; ResponsibilityCenter: Code[20])
    begin
        MemberChangeApproved(ChangeNo, MemberNo, MemberName, ChangeType, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    procedure RaiseApprovalRequested(DocumentType: Text[100]; DocumentNo: Code[20]; EntityNo: Code[20]; EntityName: Text[100]; Amount: Decimal; SenderId: Code[50]; ResponsibilityCenter: Code[20])
    begin
        ApprovalRequested(DocumentType, DocumentNo, EntityNo, EntityName, Amount, SenderId, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    procedure RaiseApprovalCompleted(DocumentType: Text[100]; DocumentNo: Code[20]; EntityNo: Code[20]; EntityName: Text[100]; Amount: Decimal; ApprovalStatus: Text[50]; ResponsibilityCenter: Code[20])
    begin
        ApprovalCompleted(DocumentType, DocumentNo, EntityNo, EntityName, Amount, ApprovalStatus, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    procedure RaiseProcessFailed(ProcessName: Text[100]; DocumentNo: Code[20]; ErrorMessage: Text[250]; ResponsibilityCenter: Code[20])
    begin
        ProcessFailed(ProcessName, DocumentNo, ErrorMessage, ResponsibilityCenter, CurrentDateTime, UserId);
    end;

    [BusinessEvent(false)]
    local procedure LoanApplicationSubmitted(LoanNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; ProductCode: Code[20]; ProductName: Text[100]; Amount: Decimal; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [ExternalBusinessEvent(
        'UWLoanApproved',
        'UW Loan Approved',
        'Triggered when a loan is approved in United Women Business Central.',
        EventCategory::"United Women",
        '1.0')]
    local procedure LoanApproved(LoanNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; ProductCode: Code[20]; ProductName: Text[100]; ApprovedAmount: Decimal; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [BusinessEvent(false)]
    local procedure LoanRejected(LoanNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; Reason: Text[250]; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [BusinessEvent(false)]
    local procedure PartialDisbursementPosted(DocumentNo: Code[20]; LoanNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; AmountDisbursed: Decimal; NetAmount: Decimal; PostingDate: Date; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [BusinessEvent(false)]
    local procedure FixedDepositMaturingSoon(FixedDepositNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; FixedDepositAmount: Decimal; MaturityDate: Date; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [BusinessEvent(false)]
    local procedure FixedDepositForfeitApproved(FixedDepositNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; FixedDepositAmount: Decimal; ApprovalDate: Date; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [BusinessEvent(false)]
    local procedure LeaveApplicationSubmitted(ApplicationNo: Code[20]; StaffNo: Code[20]; StaffName: Text[100]; LeaveType: Code[20]; DaysApplied: Decimal; StartDate: Date; EndDate: Date; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [BusinessEvent(false)]
    local procedure LeaveApplicationApproved(ApplicationNo: Code[20]; StaffNo: Code[20]; StaffName: Text[100]; LeaveType: Code[20]; DaysApproved: Decimal; StartDate: Date; EndDate: Date; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [BusinessEvent(false)]
    local procedure LoanChangeApproved(ChangeNo: Code[20]; LoanNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; ChangeType: Text[100]; NewLoanAmount: Decimal; NewInstallments: Integer; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [BusinessEvent(false)]
    local procedure ReceiptPosted(ReceiptNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; AmountReceived: Decimal; PostingDate: Date; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [BusinessEvent(false)]
    local procedure MpesaTransactionNeedsChange(TransactionId: Code[20]; TransactionType: Text[100]; ReceiverAccount: Code[30]; SavingsAccount: Code[30]; Amount: Decimal; Remarks: Text[250]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [BusinessEvent(false)]
    local procedure SaccoJournalApprovalRequested(DocumentNo: Code[20]; BatchName: Code[20]; Amount: Decimal; SenderId: Code[50]; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [BusinessEvent(false)]
    local procedure SecuritySubstitutionApproved(DocumentNo: Code[20]; LoanNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; ReplacementAmount: Decimal; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [BusinessEvent(false)]
    local procedure MemberChangeApproved(ChangeNo: Code[20]; MemberNo: Code[20]; MemberName: Text[100]; ChangeType: Text[100]; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [BusinessEvent(false)]
    local procedure ApprovalRequested(DocumentType: Text[100]; DocumentNo: Code[20]; EntityNo: Code[20]; EntityName: Text[100]; Amount: Decimal; SenderId: Code[50]; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [BusinessEvent(false)]
    local procedure ApprovalCompleted(DocumentType: Text[100]; DocumentNo: Code[20]; EntityNo: Code[20]; EntityName: Text[100]; Amount: Decimal; ApprovalStatus: Text[50]; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;

    [BusinessEvent(false)]
    local procedure ProcessFailed(ProcessName: Text[100]; DocumentNo: Code[20]; ErrorMessage: Text[250]; ResponsibilityCenter: Code[20]; EventDateTime: DateTime; TriggeredBy: Code[50])
    begin
    end;
}
