Page 51066 "HR Company Activities Card"
{
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Notify Participants';
    SaveValues = true;
    SourceTable = "HR Company Activities";

    layout
    {
        area(content)
        {
            group(Control1102755007)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field(AcitivityDescription; Rec."Acitivity Description")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(StartDate; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(EmployeeResponsible; Rec."Employee Responsible")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Name';
                    Editable = false;
                }
                field(EmailMessage; Rec."Email Message")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(ActivityStatus; Rec."Activity Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1102755011; "HR Activity Participants SF")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field(Code);
            }
        }
        area(factboxes)
        {
            part(Control1102755024; "HR Company Activities Factbox")
            {
                ApplicationArea = all;
                SubPageLink = Code = field(Code);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                action("Notify Participants")
                {
                    ApplicationArea = Basic;
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = true;

                    trigger OnAction()
                    var
                        HRActPart: Record "HR Activity Participants";
                        Heading: Text[30];
                        Msg: Text[30];
                        SalutationTxt: Text[50];
                        Receiver: Text[45];
                        RegardsTxt: Text[30];
                        BodyTxt: Text;
                        SaccoActivities: Codeunit "Sacco Activities";
                        MemberActivities: Codeunit "Member Activities";
                    begin
                        Rec.TestField("Acitivity Description");
                        Rec.TestField("Start Date");
                        Rec.TestField("End Date");
                        Rec.TestField("End Date");
                        Rec.TestField(Venue);
                        Rec.TestField("Email Message");
                        Rec.TestField("Activity Status", Rec."activity status"::Planning);

                        HRActPart.Reset;
                        HRActPart.SetRange(HRActPart."Document No.", Rec.Code);
                        if HRActPart.Find('-') then begin
                            //Check if lines filled
                            if HRActPart.Count = 0 then Error('Please suggest participants on Lines');
                            repeat

                                if SaccoActivities.ValidEmailAddress(HRActPart."Participant E-Mail") then begin

                                    Heading := Rec."Acitivity Description";
                                    SalutationTxt := 'Dear' + ' ' + HRActPart."Participant Name";
                                    BodyTxt := 'You are hereby notified that the above mentioned subject will he held on,' + Format(Rec.Date) + '  ' + 'at' + Rec.Venue + '. ' + 'Please plan to attend';
                                    Receiver := HRActPart."Participant E-Mail";
                                    RegardsTxt := 'Kind Regards';

                                    //EmailSend.CreatecreaMessage(HRActPart."Participant E-Mail", ,
                                    // "Acitivity Description", 'Dear' + ' ' + HRActPart."Participant Name", 'You are hereby notified that the above mentioned subject will he held on,' + Format(Date) + '  ' + 'at' + Venue + '. ' + 'Please plan to attend', true);

                                    MemberActivities.SendEmailNotification(
                                        Heading,
                                        SalutationTxt,
                                        BodyTxt,
                                        RegardsTxt,
                                        Receiver,
                                        '',
                                        ''
                                    );

                                    HRActPart.Modify();
                                end;
                            until HRActPart.Next = 0;

                            Message(HRActPart."Participant E-Mail");
                            Message('notified')

                        end;
                    end;
                }
                action(Close)
                {
                    ApplicationArea = Basic;
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Rec."Activity Status" <> Rec."activity status"::Complete then
                            Error('You can only close an event after it is complete');

                        Rec.Closed := true;
                        Rec.Modify;
                        Message('Event :: %1 :: has been marked as Closed', Rec."Acitivity Description");
                        //CurrPage.CLOSE;
                    end;
                }
                action("Re-Open")
                {
                    ApplicationArea = Basic;
                    Image = Open;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.Closed := false;
                        Rec.Modify;
                        Message('Event :: %1 :: has been Re-Opened', Rec."Acitivity Description");
                        //CurrPage.CLOSE;
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Report;

                    /*trigger OnAction()
                    begin
                        HRCompAct.Reset;
                        HRCompAct.SetRange(HRCompAct.Code, Code);
                        if HRCompAct.Find('-') then
                            Report.Run(50980, true, true, HRCompAct);
                    end;*/
                }
                action("Get Participants")
                {
                    ApplicationArea = Basic;
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    Var
                        HRActivityApprovalEntry: Record "HR Activity Participants";
                    begin
                        Rec.TestField(Closed, false);

                        //DELETE ANY PREVIOS RECORDS RELATED TO THIS ACTIVITY
                        HRActivityApprovalEntry.SetRange(HRActivityApprovalEntry."Document No.", Rec.Code);
                        if HRActivityApprovalEntry.Find('-') then
                            HRActivityApprovalEntry.DeleteAll;

                        //GET ONLY ACTIVE EMPLOYEES
                        HREmp.Reset;
                        HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                        HREmp.FindFirst;
                        begin
                            HRActivityApprovalEntry.Reset;
                            repeat
                                HRActivityApprovalEntry.Init;
                                //HREmp.TESTFIELD(HREmp."User ID");
                                HRActivityApprovalEntry.Participant := HREmp."No.";
                                //HRActivityApprovalEntry."Participant Name" := HREmp."Full Name";
                                HRActivityApprovalEntry."Participant E-Mail" := HREmp."Company E-Mail";
                                HRActivityApprovalEntry."Document No." := Rec.Code;
                                HRActivityApprovalEntry.Validate(HRActivityApprovalEntry.Participant);
                                HRActivityApprovalEntry.Insert();
                            until HREmp.Next = 0;
                        end;
                    end;
                }
                action("Mark as Ongoing")
                {
                    ApplicationArea = Basic;
                    Image = Start;
                    Promoted = true;
                    PromotedCategory = New;
                    trigger OnAction()
                    begin
                        Rec."Activity Status" := Rec."activity status"::"On going";
                        Rec.Modify;
                    end;
                }
                action("Mark as Complete")
                {
                    ApplicationArea = Basic;
                    Image = Completed;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        Rec."Activity Status" := Rec."activity status"::Complete;
                        //ERROR('Can ')
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnInit()
    begin
        // UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        Text001: label 'All Participants have been notified via E-Mail';
        //HRCompAct: Record UnknownRecord52018691;
        //HRActPart: Record UnknownRecord52018692;
        //HRActivityApprovalEntry: Record UnknownRecord52018692;
        HREmp: Record Employee;
    ////SMTP: Codeunit UnknownCodeunit400;


    procedure UpdateControls()
    begin
        if Rec.Closed then begin
            CurrPage.Editable := false;
        end else begin
            CurrPage.Editable := true;
        end;
    end;
}

