Page 50943 "End Year Review"
{
    PageType = ListPart;
    SourceTable = "HR Individual Target Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(PerspectiveCode; Rec."Perspective Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(PerspectiveDescription; Rec."Perspective Description")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = Basic;
                    Editable = TargetSettingStatus;
                    Enabled = TargetSettingStatus;
                }
                field(Strategy; Rec.Strategy)
                {
                    ApplicationArea = Basic;
                }
                field(Measures; Rec.Measures)
                {
                    ApplicationArea = Basic;
                }
                field(Baseline; Rec.Baseline)
                {
                    ApplicationArea = Basic;
                }
                field(TargetedScore; Rec."Targeted Score")
                {
                    ApplicationArea = Basic;
                    Editable = TargetSettingStatus;
                    Enabled = TargetSettingStatus;
                }
                field(Change; Rec.Change)
                {
                    ApplicationArea = Basic;
                }
                field(AgreedMidYearRating; Rec."Agreed Mid Year Rating")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(AgreedEndYearRating; Rec."Agreed End Year Rating")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(MidYearSelfRating; Rec."Mid Year Self Rating")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(MidYearSupervisorRating; Rec."Mid Year Supervisor Rating")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(AchievedScore; Rec."Achieved Score")
                {
                    ApplicationArea = Basic;
                    Editable = AppraisalStatus;
                    Enabled = AppraisalStatus;
                }
                field(UnachievedTargets; Rec."Unachieved Targets")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SelfRating; Rec."Self Rating")
                {
                    ApplicationArea = Basic;
                    Editable = SelfRating;
                    Enabled = SelfRating;
                }
                field(SupervisorRating; Rec."Supervisor Rating")
                {
                    ApplicationArea = Basic;
                    Editable = SupervisorRating;
                    Enabled = SupervisorRating;
                }
                field(AgreedRating; Rec."Agreed Rating")
                {
                    ApplicationArea = Basic;
                    Editable = AgreedRating;
                    Enabled = AgreedRating;
                }
                field(AppraiseeComments; Rec."Appraisee Comments")
                {
                    ApplicationArea = Basic;
                    Editable = SelfRating;
                    Enabled = SelfRating;
                }
                field(AppraiserComments; Rec."Appraiser Comments")
                {
                    ApplicationArea = Basic;
                    Editable = SupervisorRating;
                    Enabled = SupervisorRating;
                }
                field(PerspectiveType; Rec."Perspective Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        FnEdittableUnedittable;
    end;

    trigger OnInit()
    begin
        FnEdittableUnedittable;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        FnEdittableUnedittable;

        Rec."Perspective Type" := Rec."perspective type"::"Training and Development";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        FnEdittableUnedittable;

        Rec."Perspective Type" := Rec."perspective type"::"Training and Development";
    end;

    trigger OnOpenPage()
    begin
        FnEdittableUnedittable;
    end;

    var
        TargetSettingStatus: Boolean;
        AppraisalStatus: Boolean;
        SupervisorRating: Boolean;
        AgreedRating: Boolean;
        SelfRating: Boolean;


    procedure FnEdittableUnedittable()
    begin
        Rec.CalcFields("Appraisal Type", Status);

        if (Rec."Appraisal Type" = Rec."appraisal type"::"Target Setting") then begin
            TargetSettingStatus := true;
            AppraisalStatus := false;
            SupervisorRating := false;
            AgreedRating := false;
            SelfRating := false;
        end else
            if (Rec."Appraisal Type" = Rec."appraisal type"::"Quarter 1") then begin
                TargetSettingStatus := false;
                AppraisalStatus := false;
                SupervisorRating := true;
                AgreedRating := false;
                SelfRating := true;
            end else
                if (Rec."Appraisal Type" = Rec."appraisal type"::"Appraisal Review") then begin
                    TargetSettingStatus := false;
                    AppraisalStatus := true;
                    SupervisorRating := false;
                    AgreedRating := true;
                    SelfRating := false;
                end;


        /*
         IF ("Appraisal Type"="Appraisal Type"::"Appraisal Review") AND (Status=Status::Open) THEN BEGIN
         TargetSettingStatus:=TRUE;
         AppraisalStatus:=FALSE;
         SupervisorRating:=FALSE;
         AgreedRating:=FALSE;
         SelfRating:=FALSE;
         END ELSE
         IF ("Appraisal Type"="Appraisal Type"::"Appraisal Review") AND (Status<>Status::Open) THEN BEGIN
         TargetSettingStatus:=FALSE;
         AppraisalStatus:=FALSE;
         SupervisorRating:=FALSE;
         AgreedRating:=FALSE;
         SelfRating:=FALSE;
         END ELSE
         IF (("Appraisal Type"="Appraisal Type"::"Target Setting") OR ("Appraisal Type"="Appraisal Type"::"End Year Appraisal"))
          AND (Status=Status::Open) THEN BEGIN
         TargetSettingStatus:=FALSE;
         AppraisalStatus:=TRUE;
         SupervisorRating:=FALSE;
         AgreedRating:=FALSE;
         SelfRating:=TRUE;
         END ELSE
         IF (("Appraisal Type"="Appraisal Type"::"Target Setting") OR ("Appraisal Type"="Appraisal Type"::"End Year Appraisal"))
         AND (Status=Status::"Pending Approval") THEN BEGIN
         TargetSettingStatus:=FALSE;
         AppraisalStatus:=FALSE;
         SupervisorRating:=TRUE;
         AgreedRating:=TRUE;
         SelfRating:=FALSE;
         END ELSE
         IF (("Appraisal Type"="Appraisal Type"::"Target Setting") OR ("Appraisal Type"="Appraisal Type"::"End Year Appraisal"))
         AND (Status=Status::Approved) THEN BEGIN
         TargetSettingStatus:=FALSE;
         AppraisalStatus:=FALSE;
         SupervisorRating:=FALSE;
         AgreedRating:=FALSE;
         SelfRating:=FALSE;
         END;
         IF (Status=Status::Posted) THEN BEGIN
         TargetSettingStatus:=FALSE;
         AppraisalStatus:=FALSE;
         SupervisorRating:=FALSE;
         AgreedRating:=FALSE;
         SelfRating:=FALSE;
         END
        */

    end;
}

