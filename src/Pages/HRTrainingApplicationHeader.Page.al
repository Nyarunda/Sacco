Page 50976 "HR Training Application Header"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Show,Approval Request';
    SourceTable = "HR Training App Header";
    SourceTableView = where(Status = filter(<> Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(ApplicationNo; Rec."Application No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CourseTitle; Rec."Course Title")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    TableRelation = "HR Training Needs" where(Closed = const(false));
                }
                field(BondedTraining; Rec."Bonded Training?")
                {
                    ApplicationArea = Basic;
                }
                field(CourseDescription; Rec."Course Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NoofParticipants; Rec."No. of Participants")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(StartDate; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(EndDate; Rec."End Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = false;
                }
            }
            part(Control3; "HR Training Application Lines")
            {
                ApplicationArea = all;
                SubPageLink = "Application No." = field("Application No");
            }
        }
        area(factboxes)
        {
            systempart(Control14; Outlook)
            {
            }
            systempart(Control15; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Send Approval Request")
            {
                Caption = 'Approval';
                action("Send Approval Reques")
                {
                    ApplicationArea = Basic;
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin
                        //TestField(Posted, false);

                        Rec.TestField(Status, Rec.status::New);


                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."Application No", 0, Documenttype::"HR Training Mng", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin
                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."Application No");
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                    begin
                        //ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group(Get)
            {

                action(SuggestParticipants)
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Participants';
                    Image = Employee;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //DW
                        HRCodeunit.fn_SuggestParticipants(39003976, Rec."Application No", 1);
                        //Rec.Parameters = LineTable ID & Document No
                    end;
                }
                action("Get Participants")
                {
                    ApplicationArea = Basic;
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        //TESTFIELD(Closed,FALSE);

                        //DELETE ANY PREVIOS RECORDS RELATED TO THIS ACTIVITY
                        HRActivityApprovalEntry.SetRange(HRActivityApprovalEntry."Application No.", Rec."Application No");
                        if HRActivityApprovalEntry.Find('-') then
                            HRActivityApprovalEntry.DeleteAll;

                        //GET ONLY ACTIVE EMPLOYEES
                        HREmp.Reset;
                        HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                        if HREmp.FindSet() then begin
                            HRActivityApprovalEntry.Reset;
                            repeat
                                HRActivityApprovalEntry.Init;
                                //HREmp.TESTFIELD(HREmp."User ID");
                                HRActivityApprovalEntry."Employee No." := HREmp."No.";
                                //HRActivityApprovalEntry.Name := HREmp."Full Name";
                                //HRActivityApprovalEntry."Participant E-Mail":= HREmp."Company E-Mail";
                                HRActivityApprovalEntry."Application No." := Rec."Application No";
                                HRActivityApprovalEntry.Validate(HRActivityApprovalEntry."Employee No.");
                                HRActivityApprovalEntry.Insert();
                            until HREmp.Next = 0;
                        end;
                    end;
                }
                action("Notify Participants")
                {
                    ApplicationArea = Basic;
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        MemberActivities: Codeunit "Member Activities";
                        Heading: Text[30];
                        Msg: Text[30];
                        SalutationTxt: Text[50];
                        Receiver: Text[45];
                        RegardsTxt: Text[30];
                        BodyTxt: Text;
                    begin

                        //TESTFIELD(Closed,FALSE);

                        HRActivityApprovalEntry.RESET;
                        HRActivityApprovalEntry.SETRANGE(HRActivityApprovalEntry."Application No.", Rec."Application No");

                        //IF NO PARTICIPANTS ARE IMPORTED
                        IF HRActivityApprovalEntry.COUNT = 0 THEN
                            ERROR('You must get participants to notify before using this function');

                        //ELSE
                        if HRActivityApprovalEntry.FindFirst() then
                            REPEAT
                                HREmp.Get(HRActivityApprovalEntry."Employee No.");
                                if SaccoActivities.ValidEmailAddress(HREmp."Company E-Mail") then begin


                                    Receiver := HREmp."Company E-Mail";
                                    Heading := Rec."Course Description";

                                    SalutationTxt := 'Dear' + ' ' + HREmp.FullName() + ',';

                                    RegardsTxt := 'Kind Regards';

                                    //HRActivityApprovalEntry.GET(HRActivityApprovalEntry."Employee No.");
                                    //HREmp.TESTFIELD(HREmp."Company E-Mail");

                                    HREmailParameters.RESET;
                                    HREmailParameters.GET(HREmailParameters."Associate With"::"Company Activity");
                                    //smtp.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", HREmp."Company E-Mail",

                                    Msg := HREmailParameters.Body + ' ' + Rec."Application No" + ' ' + HREmailParameters."Body 2";

                                    MemberActivities.SendEmailNotification(Heading, SalutationTxt, Msg, RegardsTxt, Receiver, '', '');
                                    //MESSAGE('Leave applicant has been notified successfully');

                                    HRActivityApprovalEntry.Notified := TRUE;
                                    HRActivityApprovalEntry.MODIFY;
                                end;

                            UNTIL HRActivityApprovalEntry.NEXT = 0;
                        MESSAGE('%1', Text001);


                        if Rec.Status = Rec.Status::New then
                            Error('You Cannot notify driver when the application is not approved');
                        /*
                                                smtp.CreateMessage('Dear' + ' ' + HRTrainingAppLines.Name + ',' + 'Training Approval Notification', HRTrainingAppLines."Participant Email", HRTrainingAppLines."Participant Email",
                                                   'Training Approval Notification', 'You have Training Notification,' + "Application No" + '  ' +
                                                    HRTrainingAppLines."Employee No." + ' ', true);//"Drop Off Point"+'  '+"Pickup Point"+'  '+FORMAT("Transport Type")+'   '+'Days Applied'+'   '+FORMAT("Days Applied")+'   '+'   '+'Start Time'+'   ',TRUE)
                                                                                                   // '  '+FORMAT(Time)+'   '+'Start Date'+FORMAT("Start Date")+'   '+'   '+'Return Date'+'   '+ FORMAT("Return Date")+'  ''Driver Name'+'  '+"Driver Name"+'  '+'Vehicle'+'  '+Vehicle+'  '+"Name Vehicle",TRUE);
                                                smtp.Send();
                                                */
                        Message('Email sent to participants');

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        if Rec.Status = Rec.Status::New then begin
            "Responsibility CenterEditable" := true;
            "Application NoEditable" := true;
            "Employee No.Editable" := true;
            "Employee NameEditable" := true;
            "Employee DepartmentEditable" := true;
            "Purpose of TrainingEditable" := true;
            "Course TitleEditable" := true;
        end else begin
            "Responsibility CenterEditable" := false;
            "Application NoEditable" := false;
            "Employee No.Editable" := false;
            "Employee NameEditable" := false;
            "Employee DepartmentEditable" := false;
            "Purpose of TrainingEditable" := false;
            "Course TitleEditable" := false;
        end;

        UpdateControls();
    end;

    trigger OnInit()
    begin
        "Course TitleEditable" := true;
        "Purpose of TrainingEditable" := true;
        "Employee DepartmentEditable" := true;
        "Employee NameEditable" := true;
        "Employee No.Editable" := true;
        "Application NoEditable" := true;
        "Responsibility CenterEditable" := true;
    end;

    var
        HREmp: Record Employee;
        EmpNames: Text[40];
        sDate: Date;
        HRTrainingApplications: Record "HR Training App Header";
        ApprovalComments: Page "Approval Comments";

        "Responsibility CenterEditable": Boolean;

        "Application NoEditable": Boolean;

        "Employee No.Editable": Boolean;

        "Employee NameEditable": Boolean;

        "Employee DepartmentEditable": Boolean;

        "Purpose of TrainingEditable": Boolean;

        "Course TitleEditable": Boolean;
        HRExitTrainingBond: Record "HR Exit Training Bonding";
        HRTrainingAppLines: Record "HR Training App Lines";
        HRTrainingNeeds: Record "HR Training Needs";
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
        HRCodeunit: Codeunit "HR Codeunit.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
        ////CustomApprovals: Codeunit UnknownCodeunit39004245;
        OpenApprovalEntriesExist: Boolean;
        HRActivityApprovalEntry: Record "HR Training App Lines";
        HREmailParameters: Record "HR E-Mail Parameters";
        SaccoActivities: Codeunit "Sacco Activities";
        //SMTP: Codeunit UnknownCodeunit400;
        Text001: label 'All Participants have been notified via E-Mail';



    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    local procedure UpdateControls()
    begin
        if Rec."Status" = Rec."Status"::Approved then
            CurrPage.Editable := false;

        //CurrPage.Editable := HRCodeunit.fn_UpdateControls(Format(Rec."Approval Status"));
    end;

    procedure TESTFIELDS()
    begin
    end;

    local procedure get_LastLineNo() LastLineNo: Integer
    var
        HRExitTrainingBonding2: Record "HR Exit Training Bonding";
    begin
        HRExitTrainingBonding2.Reset;
        if HRExitTrainingBonding2.Find('+') then begin
            Rec.Status := Rec.Status::Approved;
            LastLineNo := HRExitTrainingBonding2."Line No.";
        end else begin
            Rec.Status := Rec.Status::Approved;
            LastLineNo := 1;
        end;
    end;
}

