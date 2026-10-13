Page 50915 "HR Shortlisting Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Shortlist';
    SourceTable = "HR Employee Requisitions";
    SourceTableView = where("Approval Status" = const(Approved),
                            Closed = const(false));

    layout
    {
        area(content)
        {
            group(EmployeeRequisitionDetails)
            {
                Caption = 'Employee Requisition Details';
                field(RequisitionNo; Rec."Requisition No.")
                {
                    ApplicationArea = Basic;
                }
                field(JobID; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(JobDescription; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                }
                field(JobGrade; Rec."Job Grade")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(RequisitionDate; Rec."Requisition Date")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                }
                field(EmploymentType; Rec."Employment Type")
                {
                    ApplicationArea = Basic;
                }
                field(VacantPositions; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(RequiredPositions; Rec."Required Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(NoofJobApplications; Rec."No. of Job Applications")
                {
                    ApplicationArea = Basic;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic;
                }
                field(ReasonForRequest; Rec."Reason For Request")
                {
                    ApplicationArea = Basic;
                }
                field(ClosingDate; Rec."Closing Date")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(RequisitionType; Rec."Requisition Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(ApprovalStatus; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(CompletionStatus; Rec."Completion Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
            }

            part(Shortlisted; "HR Shortlisting Lines")
            {
                ApplicationArea = Basic;

                SubPageLink = "Employee Requisition No" = field("Requisition No.");
            }

        }

        area(factboxes)
        {
            systempart(Control1102755001; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicants)
            {
                Caption = 'Applicants';
                action(ShortListApplicants)
                {
                    ApplicationArea = Basic;
                    Caption = '&ShortList Applicants';
                    Image = SelectField;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField("Completion Status", Rec."completion status"::Open);

                        if Confirm('Shortlist Applicants for Employee Requisition %1 - %2', false, Rec."Requisition No.", Rec."Job Description") = false then exit;

                        HRJobRequirements.Reset;
                        HRJobRequirements.SetRange(HRJobRequirements."Job ID", Rec."Job ID");
                        if HRJobRequirements.Count = 0 then begin
                            Message('Note that Job Requirements for the job ' + Rec."Job ID" + ' have not been setup');
                        end;

                        //DELETE ALL RECORDS FROM THE SHORTLISTED APPLICANTS TABLE
                        HRShortlistedApplicants.Reset;
                        HRShortlistedApplicants.SetRange(HRShortlistedApplicants."Employee Requisition No", Rec."Requisition No.");
                        HRShortlistedApplicants.DeleteAll;

                        //GET JOB APPLICANTS
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Employee Requisition No", Rec."Requisition No.");
                        if not HRJobApplications.Find('-') then begin
                            Error('No Applicants have applied for this Job');
                        end;
                        found := 0;
                        HRJobApplications.FindFirst;
                        repeat
                            HRJobApplications.Qualified := false;
                            HRJobApplications.Modify;
                        until HRJobApplications.Next = 0;

                        //MOVE TO FIRST RECORD AGAIN
                        HRJobApplications.FindFirst;
                        repeat
                            Rec.Qualified := true;
                            if HRJobRequirements.Find('-') then begin
                                StageScore := 0;
                                Rec.Score := 0;
                                repeat
                                    HRJobRequirements.CalcFields("Related Qualification");
                                    //GET THE APPLICANTS QUALIFICATIONS AND COMPARE THEM WITH THE JOB REQUIREMENTS
                                    if HRJobRequirements."Related Qualification" = false then begin
                                        AppQualifications.Reset;
                                        AppQualifications.SetRange(AppQualifications."Application No", HRJobApplications."Job Application No.");
                                        AppQualifications.SetRange(AppQualifications."Qualification Code", HRJobRequirements."Qualification Code");
                                        if AppQualifications.Find('-') then begin
                                            Rec.Score := Rec.Score + AppQualifications."Score ID";
                                            //Condition 1
                                            if (AppQualifications."Score ID" < HRJobRequirements."Minimum Score") then
                                              //OR //(AppQualifications."Score ID" < HRJobRequirements."Maximum Score")
                                              begin
                                                Rec.Qualified := false;
                                            end;
                                        end else begin
                                            //IF WE DO NOT FIND ANY APPLICANT QUALIFICATIONS
                                            Rec.Qualified := false;
                                        end;
                                    end else
                                        if HRJobRequirements."Related Qualification" = true then begin
                                            /*
                                            AppQualifications.Reset;
                                            AppQualifications.SetRange(AppQualifications."Application No", HRJobApplications."Job Application No.");
                                            AppQualifications.SetRange(AppQualifications."Qualification Code", HRJobRequirements."Qualification Code");
                                            if AppQualifications.Find('-') then begin
                                                Score := Score + AppQualifications."Score ID";
                                                //Condition 1
                                                if (AppQualifications."Score ID" < HRJobRequirements."Minimum Score") then
                                                //OR //(AppQualifications."Score ID" < HRJobRequirements."Maximum Score")
                                                  begin
                                                    Qualified := false;
                                                end;
                                            end else
                                                //check if related course also
                                                //check if related course also
                                                RelatedQualification.Reset;
                                            RelatedQualification.SetRange(RelatedQualification."Qualification ID", HRJobRequirements."Qualification Code");
                                            if RelatedQualification.Find('-') then begin
                                                repeat
                                                    //GET THE APPLICANTS QUALIFICATIONS AND COMPARE THEM WITH THE JOB REQUIREMENTS
                                                    AppQualifications.Reset;
                                                    AppQualifications.SetRange(AppQualifications."Application No", HRJobApplications."Job Application No.");
                                                    AppQualifications.SetRange(AppQualifications."Qualification Code", RelatedQualification."Qualification Code");
                                                    if AppQualifications.Find('-') then begin
                                                        Score := Score + AppQualifications."Score ID";
                                                        //Condition 1
                                                        if (AppQualifications."Score ID" < RelatedQualification."Minimum Score") then
                                                          //OR
                                                          //(AppQualifications."Score ID" < HRJobRequirements."Maximum Score")
                                                          begin
                                                            Qualified := false;
                                                        end;// ELSE

                                                    end else begin
                                                        //IF WE DO NOT FIND ANY APPLICANT QUALIFICATIONS
                                                        Qualified := false;
                                                    end;
                                                until RelatedQualification.Next = 0;
                                            end;
                                            */
                                        end else begin
                                            //IF WE DO NOT FIND ANY APPLICANT QUALIFICATIONS
                                            Rec.Qualified := false;
                                        end;
                                until HRJobRequirements.Next = 0;
                            end;
                            HRShortlistedApplicants."Employee Requisition No" := Rec."Requisition No.";
                            HRShortlistedApplicants."Job Application No" := HRJobApplications."Job Application No.";
                            HRShortlistedApplicants."Stage Score" := Rec.Score;
                            HRShortlistedApplicants.Qualified := Rec.Qualified;
                            HRShortlistedApplicants."First Name" := HRJobApplications."First Name";
                            HRShortlistedApplicants.Validate(HRShortlistedApplicants."First Name");

                            HRShortlistedApplicants."Middle Name" := HRJobApplications."Middle Name";
                            HRShortlistedApplicants.Validate(HRShortlistedApplicants."Middle Name");

                            HRShortlistedApplicants."Last Name" := HRJobApplications."Last Name";
                            HRShortlistedApplicants.Validate(HRShortlistedApplicants."Last Name");
                            HRShortlistedApplicants."ID No" := HRJobApplications."ID Number";
                            HRShortlistedApplicants.Gender := HRJobApplications.Gender;
                            HRShortlistedApplicants."Marital Status" := HRJobApplications."Marital Status";
                            //MESSAGE(HRJobApplications."First Name");
                            HRShortlistedApplicants.Insert;

                            //HRJobApplications.Shorlisted:=TRUE;
                            //HRJobApplications."Total Score After Shortlisting":=Score;
                            HRJobApplications.Modify;


                        until HRJobApplications.Next = 0;

                        //MARK QUALIFIED APPLICANTS AS QUALIFIED
                        HRShortlistedApplicants.SetRange(HRShortlistedApplicants.Qualified, true);
                        if HRShortlistedApplicants.Find('-') then
                            repeat
                                HRJobApplications.Get(HRShortlistedApplicants."Job Application No");
                                HRJobApplications.Qualified := true;
                                HRJobApplications.Modify;
                            until HRShortlistedApplicants.Next = 0;

                        //SORT DESCENDING
                        //HRShortlistedApplicants.SETCURRENTKEY(HRShortlistedApplicants."Stage Score");
                        //HRShortlistedApplicants.ASCENDING;
                        /*
                        RecCount:= 0;
                        MyCount:=0;
                        StageShortlist.RESET;
                        StageShortlist.SETRANGE(StageShortlist."Need Code","Need Code");
                        StageShortlist.SETRANGE(StageShortlist."Stage Code","Stage Code");
                        
                        IF StageShortlist.FIND('-') THEN BEGIN
                        RecCount:=StageShortlist.COUNT ;
                        StageShortlist.SETCURRENTKEY(StageShortlist."Stage Score");
                        StageShortlist.ASCENDING;
                        REPEAT
                        MyCount:=MyCount + 1;
                        StageShortlist.Position:=RecCount - MyCount;
                        StageShortlist.MODIFY;
                        UNTIL StageShortlist.NEXT = 0;
                        END;
                        */
                        Message('Shortlisting Competed Successfully for %1', Rec."Job ID");

                        //END ELSE
                        //MESSAGE('%1','You must select the stage you would like to shortlist.');

                    end;
                }
                action("Shortlisting Panel")
                {
                    ApplicationArea = Basic;
                    Image = SalesPerson;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Shortlisting Panel";
                    RunPageLink = "Requisition No." = field("Requisition No.");
                }

            }
        }
    }

    var
        HRJobRequirements: Record "HR Job Requirements";
        AppQualifications: Record "HR Applicant Qualifications";
        HRJobApplications: Record "HR Job Applications";
        Qualified: Boolean;
        StageScore: Decimal;
        HRShortlistedApplicants: Record "HR Shortlisted Applicants";
        MyCount: Integer;
        RecCount: Integer;
        HREmpReq: Record "HR Employee Requisitions";
        Text19057439: label 'Short Listed Candidates';
        //RelatedQualification: Record related q UnknownRecord52018739;
        found: Integer;
    //DMS: Record UnknownRecord39004241;
}

