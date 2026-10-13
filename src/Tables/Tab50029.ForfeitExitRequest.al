table 50029 "Forfeit Exit Request"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; "Member No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Members."No.";
        }
        field(3; "Exit No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Member Exit"."No.";
        }
        field(4; "Notice No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Member Exit Notice"."No.";
        }
        field(5; ForfeitReason; Text[250])
        {
            Caption = 'Forfeit Reason';
            DataClassification = CustomerContent;
        }
        field(6; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(7; "Requested By"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
        }
        field(8; "Requested At"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Approved By"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
        }
        field(10; "Approved At"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Rejection Reason"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Forfeit Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Member Exit","Exit Notice";
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(MemberStatus; "Member No.", Status, "Entry No.")
        {
        }
        key(MemberTypeStatus; "Member No.", "Forfeit Type", Status, "Entry No.")
        {
        }
    }

    procedure RequestForfeitExit(MemberNo: Code[20]; ExitNo: Code[20]; NoticeNo: Code[20]; Reason: Text[250])
    var
        Member: Record Members;
        MemberExit: Record "Member Exit";
        PendingRequest: Record "Forfeit Exit Request";
        UserSetup: Record "User Setup";
    begin
        if Reason = '' then
            Error('Enter a reason for forfeiting the exit.');

        Member.Get(MemberNo);
        if Member."Member Status" = Member."Member Status"::Withdrawn then
            Error('This exit has already been posted. Reverse its financial transactions before requesting a Forfeit Exit.');
        if Member."Member Status" <> Member."Member Status"::"Withdrawal Application" then
            Error('Forfeit Exit can only be requested while the member status is Withdrawal Application.');
        if ExitNo = '' then
            Error('A Member Exit number is required to forfeit the exit.');
        MemberExit.Get(ExitNo);
        if MemberExit."Member No." <> MemberNo then
            Error('The selected Member Exit does not belong to member %1.', MemberNo);
        if MemberExit.Posted then
            Error('This exit has already been posted. Reverse its financial transactions before requesting a Forfeit Exit.');
        if MemberExit.Status = MemberExit.Status::Forfeited then
            Error('This Member Exit has already been forfeited.');

        if PendingRequest.HasPendingForMember(MemberNo) then
            Error('A Forfeit Exit request is already pending for this member.');

        UserSetup.Get(UserId);
        UserSetup.TestField("Forfeit Exit Approver");

        Init();
        "Member No." := MemberNo;
        "Exit No." := ExitNo;
        "Notice No." := NoticeNo;
        "Forfeit Type" := "Forfeit Type"::"Member Exit";
        ForfeitReason := Reason;
        Status := Status::Pending;
        "Requested By" := UserId;
        "Requested At" := CurrentDateTime();
        Clear("Approved By");
        Clear("Approved At");
        Clear("Rejection Reason");
        Insert(true);
    end;

    procedure RequestForfeitNotice(MemberNo: Code[20]; NoticeNo: Code[20]; Reason: Text[250])
    var
        Member: Record Members;
        MemberExit: Record "Member Exit";
        ExitNotice: Record "Member Exit Notice";
        PendingRequest: Record "Forfeit Exit Request";
        UserSetup: Record "User Setup";
    begin
        if Reason = '' then
            Error('Enter a reason for forfeiting the notice.');

        Member.Get(MemberNo);
        if Member."Member Status" = Member."Member Status"::Withdrawn then
            Error('This member exit has already been posted. Reverse its financial transactions before forfeiting the notice.');
        if not (Member."Member Status" in [Member."Member Status"::Active, Member."Member Status"::"Withdrawal Application"]) then
            Error('Forfeit Notice can only be requested for an Active member or a member with Withdrawal Application status.');

        ExitNotice.Get(NoticeNo);
        if ExitNotice."Member No." <> MemberNo then
            Error('The selected notice does not belong to member %1.', MemberNo);
        if ExitNotice.Status = ExitNotice.Status::Forfeited then
            Error('This notice has already been forfeited.');
        if ExitNotice."Exit No." <> '' then
            if MemberExit.Get(ExitNotice."Exit No.") then
                if MemberExit.Posted then
                    Error('The linked Member Exit has already been posted. Reverse its financial transactions before forfeiting the notice.');

        if PendingRequest.HasPendingForMember(MemberNo) then
            Error('A Forfeit Exit or Forfeit Notice request is already pending for this member.');

        UserSetup.Get(UserId);
        UserSetup.TestField("Forfeit Exit Approver");

        Init();
        "Member No." := MemberNo;
        "Exit No." := ExitNotice."Exit No.";
        "Notice No." := NoticeNo;
        "Forfeit Type" := "Forfeit Type"::"Exit Notice";
        ForfeitReason := Reason;
        Status := Status::Pending;
        "Requested By" := UserId;
        "Requested At" := CurrentDateTime();
        Clear("Approved By");
        Clear("Approved At");
        Clear("Rejection Reason");
        Insert(true);
    end;

    procedure HasPendingForMember(MemberNo: Code[20]): Boolean
    begin
        Reset();
        SetRange("Member No.", MemberNo);
        SetRange(Status, Status::Pending);
        exit(FindFirst());
    end;

    procedure FindPendingForMember(MemberNo: Code[20]; ForfeitType: Option "Member Exit","Exit Notice"): Boolean
    begin
        Reset();
        SetCurrentKey("Member No.", "Forfeit Type", Status, "Entry No.");
        SetRange("Member No.", MemberNo);
        SetRange("Forfeit Type", ForfeitType);
        SetRange(Status, Status::Pending);
        exit(FindLast());
    end;

    procedure IsForfeitApprovedForExit(ExitNo: Code[20]): Boolean
    begin
        Reset();
        SetRange("Exit No.", ExitNo);
        SetRange("Forfeit Type", "Forfeit Type"::"Member Exit");
        SetRange(Status, Status::Approved);
        exit(FindLast());
    end;

    procedure HasActiveForfeitForNotice(NoticeNo: Code[20]): Boolean
    begin
        Reset();
        SetRange("Notice No.", NoticeNo);
        SetRange("Forfeit Type", "Forfeit Type"::"Exit Notice");
        SetFilter(Status, '%1|%2', Status::Pending, Status::Approved);
        exit(FindLast());
    end;

    procedure ApproveForfeitExit(MemberNo: Code[20])
    var
        Member: Record Members;
        MemberExit: Record "Member Exit";
        RequesterSetup: Record "User Setup";
        TrackerVariant: Variant;
    begin
        if not FindPendingForMember(MemberNo, "Forfeit Type"::"Member Exit") then
            Error('There is no pending Forfeit Exit request for this member.');

        ValidateApprover(RequesterSetup);
        Member.Get(MemberNo);
        if Member."Member Status" <> Member."Member Status"::"Withdrawal Application" then
            Error('The member status changed while the Forfeit Exit request was pending.');

        TestField("Exit No.");
        MemberExit.Get("Exit No.");
        if MemberExit.Posted then
            Error('This exit has already been posted and cannot be forfeited.');
        TrackerVariant := MemberExit;
        CancelOpenApproval(Database::"Member Exit", "Exit No.", TrackerVariant);
        MemberExit.Get("Exit No.");
        MemberExit.Status := MemberExit.Status::Forfeited;
        MemberExit.Modify(true);

        Member."Member Status" := Member."Member Status"::Active;
        Member.Modify(true);

        Status := Status::Approved;
        "Approved By" := UserId;
        "Approved At" := CurrentDateTime();
        Clear("Rejection Reason");
        Modify(true);
    end;

    procedure ApproveForfeitNotice(MemberNo: Code[20])
    var
        Member: Record Members;
        MemberExit: Record "Member Exit";
        ExitNotice: Record "Member Exit Notice";
        RequesterSetup: Record "User Setup";
        TrackerVariant: Variant;
    begin
        if not FindPendingForMember(MemberNo, "Forfeit Type"::"Exit Notice") then
            Error('There is no pending Forfeit Notice request for this member.');

        ValidateApprover(RequesterSetup);
        Member.Get(MemberNo);
        if not (Member."Member Status" in [Member."Member Status"::Active, Member."Member Status"::"Withdrawal Application"]) then
            Error('The member status changed while the Forfeit Notice request was pending.');

        ExitNotice.Get("Notice No.");
        if ExitNotice."Exit No." <> '' then
            if not MemberExit.Get(ExitNotice."Exit No.") then
                Error('The linked Member Exit %1 no longer exists.', ExitNotice."Exit No.")
            else
                if MemberExit.Posted then
                    Error('The linked Member Exit has already been posted and cannot be forfeited.');

        TrackerVariant := ExitNotice;
        CancelOpenApproval(Database::"Member Exit Notice", "Notice No.", TrackerVariant);
        ExitNotice.Get("Notice No.");
        if ExitNotice."Exit No." <> '' then begin
            MemberExit.Get(ExitNotice."Exit No.");
            TrackerVariant := MemberExit;
            CancelOpenApproval(Database::"Member Exit", MemberExit."No.", TrackerVariant);
            MemberExit.Get(MemberExit."No.");
            MemberExit.Status := MemberExit.Status::Forfeited;
            MemberExit.Modify(true);
        end;

        ExitNotice.Status := ExitNotice.Status::Forfeited;
        ExitNotice.Modify(true);
        if Member."Member Status" = Member."Member Status"::"Withdrawal Application" then begin
            Member."Member Status" := Member."Member Status"::Active;
            Member.Modify(true);
        end;

        Status := Status::Approved;
        "Approved By" := UserId;
        "Approved At" := CurrentDateTime();
        Clear("Rejection Reason");
        Modify(true);
    end;

    procedure RejectForfeitExit(MemberNo: Code[20]; RejectionReason: Text[250])
    var
        RequesterSetup: Record "User Setup";
    begin
        if RejectionReason = '' then
            Error('Enter a reason for rejecting the Forfeit Exit request.');
        if not FindPendingForMember(MemberNo, "Forfeit Type"::"Member Exit") then
            Error('There is no pending Forfeit Exit request for this member.');

        ValidateApprover(RequesterSetup);
        Status := Status::Rejected;
        "Rejection Reason" := RejectionReason;
        Clear("Approved By");
        Clear("Approved At");
        Modify(true);
    end;

    procedure RejectForfeitNotice(MemberNo: Code[20]; RejectionReason: Text[250])
    var
        RequesterSetup: Record "User Setup";
    begin
        if RejectionReason = '' then
            Error('Enter a reason for rejecting the Forfeit Notice request.');
        if not FindPendingForMember(MemberNo, "Forfeit Type"::"Exit Notice") then
            Error('There is no pending Forfeit Notice request for this member.');

        ValidateApprover(RequesterSetup);
        Status := Status::Rejected;
        "Rejection Reason" := RejectionReason;
        Clear("Approved By");
        Clear("Approved At");
        Modify(true);
    end;

    local procedure ValidateApprover(var RequesterSetup: Record "User Setup")
    begin
        TestField("Requested By");

        RequesterSetup.Get("Requested By");
        RequesterSetup.TestField("Forfeit Exit Approver");
        if RequesterSetup."Forfeit Exit Approver" <> UserId then
            Error('You are not configured as the Forfeit Exit approver for user %1.', "Requested By");
    end;

    local procedure CancelOpenApproval(TableId: Integer; DocumentNo: Code[20]; var TrackerVariant: Variant)
    var
        ApprovalTracker: Record "Approval Tracker";
        CalwideApprovals: Codeunit "Calwide Approvals";
    begin
        ApprovalTracker.SetRange("Table ID", TableId);
        ApprovalTracker.SetRange("Document No.", DocumentNo);
        ApprovalTracker.SetFilter(Status, '%1|%2', ApprovalTracker.Status::Open, ApprovalTracker.Status::Pending);
        if ApprovalTracker.FindFirst() then
            CalwideApprovals.CancelTracker(TrackerVariant, DocumentNo);
    end;
}