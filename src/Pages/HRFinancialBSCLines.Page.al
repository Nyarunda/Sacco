Page 51036 "HR Financial BSC Lines"
{
    PageType = ListPart;
    SourceTable = "HR Individual Target Line";
    SourceTableView = where("Perspective Type" = const("Financial Stewardship"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AppraisalNo; Rec."Appraisal No")
                {
                    ApplicationArea = Basic;
                }
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
                    Editable = BaselineScore;
                    Enabled = BaselineScore;
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
                    Editable = ChangeScore;
                    Enabled = ChangeScore;
                }
                field(Quarter1; Rec."Quarter 1")
                {
                    ApplicationArea = Basic;
                    Editable = Quarter1;
                    Enabled = Quarter1;
                    Visible = false;
                }
                field("Mid Year Self Rating"; Rec."Mid Year Self Rating")
                {
                    ApplicationArea = Basic;
                    Editable = SelfMid;
                    Enabled = SelfMid;
                    Visible = false;
                }
                field("Mid Year Supervisor Rationg"; Rec."Mid Year Supervisor Rating")
                {
                    ApplicationArea = Basic;
                    Editable = SupMid;
                    Enabled = SupMid;
                    Visible = false;
                }
                field("Agreed Mid Year Rating"; Rec."Agreed Mid Year Rating")
                {
                    ApplicationArea = Basic;
                    Editable = AgreedMid;
                    Enabled = AgreedMid;
                    Visible = false;
                }
                field(Quarter3; Rec."Quarter 3")
                {
                    ApplicationArea = Basic;
                    Editable = Quarter3;
                    Enabled = Quarter3;
                    Visible = false;
                }
                field("End Year Self Rating"; Rec."Self Rating")
                {
                    ApplicationArea = Basic;
                    Editable = SelfRating;
                    Enabled = SelfRating;
                }
                field("End Year Supervisor Rating"; Rec."Supervisor Rating")
                {
                    ApplicationArea = Basic;
                    Editable = SupervisorRating;
                    Enabled = SupervisorRating;
                }
                field("Agreed End Year Rating"; Rec."Agreed End Year Rating")
                {
                    ApplicationArea = Basic;
                    Editable = AgreedEnd;
                    Enabled = AgreedEnd;
                    Visible = true;
                }
                field("Total Agreed Rating"; Rec."Agreed Rating")
                {
                    ApplicationArea = Basic;
                    Editable = AgreedRating;
                    Enabled = AgreedRating;
                }
                field(AchievedScore; Rec."Achieved Score")
                {
                    ApplicationArea = Basic;
                    Editable = AppraisalStatus;
                    Enabled = AppraisalStatus;
                    Visible = false;
                }
                field(UnachievedTargets; Rec."Unachieved Targets")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = AppraisalStatus;
                    Visible = false;
                }
                field(AppraiseeComments; Rec."Appraisee Comments")
                {
                    ApplicationArea = Basic;
                    Editable = AppraiseeComm;
                    Enabled = AppraiseeComm;
                }
                field(AppraiserComments; Rec."Appraiser Comments")
                {
                    ApplicationArea = Basic;
                    Editable = AppraiserComm;
                    Enabled = AppraiserComm;
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

        Rec."Perspective Type" := Rec."perspective type"::"Financial Stewardship";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        FnEdittableUnedittable;

        Rec."Perspective Type" := Rec."perspective type"::"Financial Stewardship";
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
        BaselineScore: Boolean;
        TargetedScore: Boolean;
        ChangeScore: Boolean;
        SelfMid: Boolean;
        Supmid: Boolean;
        Selfend: Boolean;
        Supend: Boolean;
        AgreedMid: Boolean;
        Quarter1: Boolean;
        Quarter3: Boolean;
        AgreedEnd: Boolean;
        AppraiserComm: Boolean;
        Appraiseecomm: Boolean;
        Strategy: Boolean;
        Measures: Boolean;


    procedure FnEdittableUnedittable()
    begin
        Rec.CalcFields("Appraisal Type", Status);

        if (Rec."Appraisal Type" = Rec."appraisal type"::"Target Setting") then begin
            TargetSettingStatus := true;
            AppraisalStatus := false;
            SupervisorRating := false;
            AgreedRating := false;
            SelfRating := false;
            Quarter1 := false;
            Quarter3 := false;
            AgreedEnd := false;
            BaselineScore := true;
            // Measures:=FALSE;
            // Strategy:=FALSE;
        end else

            if (Rec."Appraisal Type" = Rec."appraisal type"::"Quarter 1") then begin
                TargetSettingStatus := true;
                AppraisalStatus := false;
                SupervisorRating := false;
                AgreedRating := false;
                SelfRating := false;
                Quarter1 := true;
                Quarter3 := false;
                AgreedEnd := false;
                TargetSettingStatus := false;
                BaselineScore := false;
                //Measures:=FALSE;
                //Strategy:=FALSE;
            end else

                if (Rec."Appraisal Type" = Rec."appraisal type"::"Appraisal Review") then begin
                    TargetSettingStatus := false;
                    AppraisalStatus := true;
                    SupervisorRating := true;
                    AgreedRating := false;
                    SelfRating := true;
                    BaselineScore := false;
                    SelfMid := true;
                    Supmid := true;
                    AgreedMid := true;
                    //Measures:=FALSE;
                    //Strategy:=FALSE;
                end else

                    if (Rec."Appraisal Type" = Rec."appraisal type"::"Quarter 3") then begin
                        TargetSettingStatus := false;
                        AppraisalStatus := false;
                        SupervisorRating := false;
                        AgreedRating := false;
                        SelfRating := false;
                        Quarter1 := false;
                        Quarter3 := true;
                        AgreedEnd := false;
                        AgreedMid := false;

                    end else

                        if (Rec."Appraisal Type" = Rec."appraisal type"::"End Year Appraisal") then begin
                            TargetSettingStatus := false;
                            AppraisalStatus := false;
                            SupervisorRating := true;
                            AgreedRating := false;
                            SelfRating := true;
                            Quarter1 := false;
                            Quarter3 := false;
                            AgreedEnd := true;
                            AgreedMid := false;
                            Appraiseecomm := true;
                            AppraiserComm := true;
                            //Measures:=FALSE;
                            //Strategy:=FALSE;
                            BaselineScore := false;
                        end;


        /*
         IF (("Appraisal Type"="Appraisal Type"::"Target Setting") OR ("Appraisal Type"="Appraisal Type"::"End Year Appraisal"))
          AND (Status=Status::Open) THEN BEGIN
         TargetSettingStatus:=FALSE;
         AppraisalStatus:=FALSE;
         SupervisorRating:=FALSE;
         AgreedRating:=FALSE;
         SelfRating:=FALSE;
         END ELSE
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

