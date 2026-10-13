codeunit 50000 "Ticket Management"
{
    procedure AssignTicket(var TicketHeader: Record "Ticket Header")
    var
        UserSetup: Record "User Setup";
        AssignmentPage: Page "Ticket Assignment";
    begin
        AssignmentPage.SetTicket(TicketHeader);
        if AssignmentPage.RunModal() = Action::OK then begin
            AssignmentPage.GetAssignment(TicketHeader);
            TicketHeader.Status := TicketHeader.Status::Assigned;
            TicketHeader.Modify();

            // Send notification
            SendAssignmentNotification(TicketHeader);

            // Log the assignment
            LogTicketAction(TicketHeader."No.", 'Ticket assigned to ' + TicketHeader."Assigned To");
        end;
    end;

    procedure EscalateTicket(var TicketHeader: Record "Ticket Header")
    var
        EscalationRules: Record "Escalation Rules";
        NewAssignee: Code[50];
    begin
        if EscalationRules.Get(TicketHeader."Ticket Type", TicketHeader.Priority) then begin
            NewAssignee := EscalationRules."Escalate To User ID";
            if NewAssignee <> '' then begin
                TicketHeader."Assigned To" := NewAssignee;
                TicketHeader.Priority := TicketHeader.Priority::High; // Increase priority
                TicketHeader.Modify();

                SendEscalationNotification(TicketHeader);
                LogTicketAction(TicketHeader."No.", 'Ticket escalated to ' + NewAssignee);
            end;
        end;
    end;

    procedure AutoAssignTicket(var TicketHeader: Record "Ticket Header")
    var
        DepartmentUsers: Record "Support Personnel";
        AssignmentAlgorithm: Codeunit "Assignment Algorithm";
        BestUser: Code[50];
    begin
        BestUser := AssignmentAlgorithm.FindBestAssignee(TicketHeader);
        if BestUser <> '' then begin
            TicketHeader."Assigned To" := BestUser;
            TicketHeader.Status := TicketHeader.Status::Assigned;
            TicketHeader.Modify();

            SendAssignmentNotification(TicketHeader);
        end;
    end;

    procedure CheckSLABreach(var TicketHeader: Record "Ticket Header")
    var
        SLASetup: Record "SLA Setup";
        CurrentDateTime: DateTime;
        DueDateTime: DateTime;
    begin
        if SLASetup.Get(TicketHeader."Ticket Type", TicketHeader.Priority) then begin
            CurrentDateTime := CurrentDateTime();
            DueDateTime := CreateDateTime(TicketHeader."Due Date", TicketHeader."Due Time");

            if CurrentDateTime > DueDateTime then begin
                TicketHeader."SLA Breached" := true;
                TicketHeader.Modify();

                SendSLABreachNotification(TicketHeader);
                LogTicketAction(TicketHeader."No.", 'SLA breached');
            end;
        end;
    end;

    local procedure SendAssignmentNotification(TicketHeader: Record "Ticket Header")
    var
        NotificationMgmt: Codeunit "CRM Notifications Management";
    begin
        NotificationMgmt.SendTicketAssignmentNotification(TicketHeader);
    end;

    local procedure SendEscalationNotification(TicketHeader: Record "Ticket Header")
    var
        NotificationMgmt: Codeunit "CRM Notifications Management";
    begin
        NotificationMgmt.SendTicketEscalationNotification(TicketHeader);
    end;

    local procedure SendSLABreachNotification(TicketHeader: Record "Ticket Header")
    var
        NotificationMgmt: Codeunit "CRM Notifications Management";
    begin
        NotificationMgmt.SendSLABreachNotification(TicketHeader);
    end;

    local procedure LogTicketAction(TicketNo: Code[20]; ActionDescription: Text[250])
    var
        TicketLog: Record "Ticket Log";
    begin
        TicketLog.Init();
        TicketLog."Ticket No." := TicketNo;
        TicketLog."Action Description" := ActionDescription;
        TicketLog."User ID" := UserId();
        TicketLog."Date Time" := CurrentDateTime();
        TicketLog.Insert();
    end;
}