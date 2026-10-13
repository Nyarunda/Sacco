namespace CalwideSACCO.CalwideSACCO;

codeunit 50006 "Portal Log Management"
{
    procedure LogAction(MemberNo: Code[20]; UserID: Text; ActionCode: Code[50]; ActionDescription: Text) EntryNo: Integer
    var
        PortalActionLog: Record "Portal Action Log";
    begin
        PortalActionLog.Init();
        PortalActionLog."Member No." := MemberNo;
        PortalActionLog."User ID" := CopyStr(UserID, 1, MaxStrLen(PortalActionLog."User ID"));
        PortalActionLog."Action" := ActionCode;
        PortalActionLog."Action Description" := CopyStr(ActionDescription, 1, MaxStrLen(PortalActionLog."Action Description"));
        PortalActionLog."Request Date Time" := CurrentDateTime;
        PortalActionLog.Insert(true);
        exit(PortalActionLog."Entry No.");
    end;
}
