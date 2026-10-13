Page 51057 "HR Induction Schedule Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'Manage,Process,Report,Participants';
    SourceTable = "HR Induction Schedule";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(InductionCode; Rec."Induction Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateCreated; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field(CreatedBy; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                group(Control8)
                {
                    grid(Control5)
                    {
                        GridLayout = Rows;
                        group(Control6)
                        {
                            field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                            {
                                ApplicationArea = Basic;
                            }
                            field(GlobalDimension1Name; Rec."Global Dimension 1 Name")
                            {
                                ApplicationArea = Basic;
                                ShowCaption = false;
                            }
                        }
                    }
                }
                group(Control15)
                {
                    grid(Control14)
                    {
                        GridLayout = Rows;
                        group(Control13)
                        {
                            field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                            {
                                ApplicationArea = Basic;
                            }
                            field(GlobalDimension2Name; Rec."Global Dimension 2 Name")
                            {
                                ApplicationArea = Basic;
                                ShowCaption = false;
                            }
                        }
                    }
                }
                group(Control9)
                {
                    grid(Control7)
                    {
                        GridLayout = Rows;
                        group(Control3)
                        {
                            field(InductionStartDate; Rec."Induction Start Date")
                            {
                                ApplicationArea = Basic;
                            }
                            field(Durationeg1D2W; Rec."Induction Duration")
                            {
                                ApplicationArea = Basic;
                                Caption = 'Duration (e.g. 1D,2W)';
                            }
                            field(InductionEndDate; Rec."Induction End Date")
                            {
                                ApplicationArea = Basic;
                            }
                        }
                    }
                    field(Comments; Rec.Comments)
                    {
                        ApplicationArea = Basic;
                        MultiLine = true;
                    }
                    field(NoofParticipants; Rec."No. of Participants")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field(HODNotified; Rec."HOD Notified?")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control2; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(ActionGroup1102755014)
            {
            }
            action("Induction Participants ")
            {
                ApplicationArea = Basic;
                Caption = 'Induction Participants';
                Image = PersonInCharge;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "HR Induction Participants List";
                RunPageLink = "Induction Code" = field("Induction Code");
            }
            action("Notify Head of Department")
            {
                ApplicationArea = Basic;
                Image = Email;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //Testfields
                    Rec.TestField("HOD Notified?", Rec."hod notified?"::No);
                    Rec.TestField("Global Dimension 1 Code");
                    Rec.TestField("Global Dimension 2 Code");
                    Rec.CalcFields("No. of Participants");
                    Rec.TestField("No. of Participants");
                    Rec.TestField("Induction Start Date");
                    Rec.TestField("Induction End Date");


                    //Check if respective HOD is setup in HR Heads of Depts. Table

                    /*
                    HR_HODs.Reset;
                    HR_HODs.SetRange(HR_HODs."Global Dimension 1 Code", "Global Dimension 1 Code");
                    HR_HODs.SetRange(HR_HODs."Global Dimension 2 Code", "Global Dimension 2 Code");
                    if not HR_HODs.Find('-') then Error(ERR_HR_HOD_SETUP);
                    HR_HODs.TestField(HR_HODs."Employee No.");

                    //Check if E-Mail parameters have been setup
                    HREmailParam.Reset;
                    HREmailParam.SetRange(HREmailParam."Associate With", HREmailParam."associate with"::"Induction Schedule");
                    if not HREmailParam.Find('-') then begin
                        //Create Email Parameters f not setup
                        HREmailParam.Init;

                        HREmailParam."Associate With" := HREmailParam."associate with"::"Induction Schedule";
                        HREmailParam."Sender Name" := 'HUMAN RESOURCE';
                        HREmailParam."Sender Address" := 'dwesa@coretec.co.ke';
                        HREmailParam.Subject := 'Induction Schedule Participants';
                        HREmailParam.Body := 'Kindly faciliate an Induction for [ Induction Document No ] '
                                            + "Induction Code" + '<br>' +
                                            'Kindly login in the system to view document and participants'
                                            + '<br>' + 'Warm Regards';

                        HREmailParam.Insert;
                    end;
                    */

                    //Send mail
                    //SMTPMail.CreateMessage(HREmailParam."Sender Name", HREmailParam."Sender Address", HR_HODs."E-Mail Address"
                    //                     , HREmailParam.Subject, HREmailParam.Body, true);

                    //SMTPMail.Send;

                    //Check document as processed
                    Rec."HOD Notified?" := Rec."hod notified?"::Yes;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        UpdateControls;
    end;

    var
        Induction: Record "HR Staff  Induction";
        DepartmentName: Text[40];
        sDate: Date;
        Inductionschedule: Record "HR Staff  Induction";
        Number: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Budget Transfer","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval";
        //ApprovalEntries: Page "Approval Entries";
        HRJobs: Record "HR Jobs";
        Department: Record "Dimension Value";
        //HREmailParam: Record UnknownRecord39003942;
        ERR_EMAIL_PARAM_SETUP: label 'Please setup Induction Schedule Notification Template in HR E-Mail Parameters';
        //HR_HODs: Record UnknownRecord52018727;
        //SMTPMail: Codeunit UnknownCodeunit400;
        ERR_HR_HOD_SETUP: label 'Please define HOD for [ %1 - %2 ]';
        HRCodeunit: Codeunit "HR Codeunit.";

    local procedure UpdateControls()
    begin
        CurrPage.Editable := HRCodeunit.fn_UpdateControls(Format(Rec."HOD Notified?"));
    end;
}

