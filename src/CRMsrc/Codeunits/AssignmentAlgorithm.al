codeunit 50002 "Assignment Algorithm"
{
    procedure FindBestAssignee(TicketHeader: Record "Ticket Header"): Code[50]
    var
        DepartmentUsers: Record "Support Personnel";
        UserWorkload: Record "User Workload";
        BestUser: Code[50];
        LowestWorkload: Integer;
        CurrentWorkload: Integer;
    begin
        LowestWorkload := 999999;

        // Find users in the appropriate department
        DepartmentUsers.SetRange("Department Code", TicketHeader."Department Code");
        DepartmentUsers.SetRange(Active, true);

        if DepartmentUsers.FindSet() then
            repeat
                CurrentWorkload := CalculateUserWorkload(DepartmentUsers."User ID");

                if CurrentWorkload < LowestWorkload then begin
                    LowestWorkload := CurrentWorkload;
                    BestUser := DepartmentUsers."User ID";
                end;
            until DepartmentUsers.Next() = 0;

        exit(BestUser);
    end;

    local procedure CalculateUserWorkload(UserID: Code[50]): Integer
    var
        TicketHeader: Record "Ticket Header";
        ActiveTickets: Integer;
    begin
        TicketHeader.SetRange("Assigned To", UserID);
        TicketHeader.SetFilter(Status, '<>%1&<>%2', TicketHeader.Status::Closed, TicketHeader.Status::Cancelled);
        ActiveTickets := TicketHeader.Count();

        exit(ActiveTickets);
    end;

    procedure UpdateUserWorkloadCache()
    var
        UserSetup: Record "User Setup";
        UserWorkload: Record "User Workload";
        Workload: Integer;
    begin
        if UserSetup.FindSet() then
            repeat
                Workload := CalculateUserWorkload(UserSetup."User ID");

                if UserWorkload.Get(UserSetup."User ID") then begin
                    UserWorkload."Active Tickets" := Workload;
                    UserWorkload."Last Updated" := CurrentDateTime();
                    UserWorkload.Modify();
                end else begin
                    UserWorkload.Init();
                    UserWorkload."User ID" := UserSetup."User ID";
                    UserWorkload."Active Tickets" := Workload;
                    UserWorkload."Last Updated" := CurrentDateTime();
                    UserWorkload.Insert();
                end;
            until UserSetup.Next() = 0;
    end;
}