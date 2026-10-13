Page 51039 "HR Appraisal Period Setup"
{
    PageType = List;
    SourceTable = "HR Appraisal Period";
    SourceTableView = sorting("Appraisal Period");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AppraisalPeriod; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalPeriodDescription; Rec."Appraisal Period Description")
                {
                    ApplicationArea = Basic;
                }
                field(AppraisalType; Rec."Appraisal Type")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                }
                field(Dateopened; Rec."Date opened")
                {
                    ApplicationArea = Basic;
                }
                field(Dateclosed; Rec."Date closed")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(OpenClosePeriod)
            {
                ApplicationArea = Basic;
                Caption = 'Open / Close Period';
                //Image = Closeperiod;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*
                    Warn user about the consequence of closure - operation is not reversible.Ask if he is sure about the closure.*/

                    HRSetup.Get();
                    HRSetup.TestField("Appraisal Interval");
                    HRSetup.TestField("Target Setting Month");

                    fnGetOpenPeriod;

                    Question := 'Once a period has been closed it can NOT be opened.\It is assumed that you have filled the score card for the period.\'
                    + 'Do still want to close [' + strPeriodName + ']';





                    Answer := Dialog.Confirm(Question, false);
                    if Answer = true then begin
                        fnCloseAppraisalPeriod_NEW;
                        Message('Process Complete');
                    end else begin
                        Message('You have selected NOT to Close the period');
                    end

                end;
            }
            action("Close Target Setting")
            {
                ApplicationArea = Basic;
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Do you want to Close the Target Setting Stage?', true) = false then exit;
                    HRIndividualTarget.Reset;
                    HRIndividualTarget.SetRange(HRIndividualTarget."Appraisal Type", HRIndividualTarget."appraisal type"::"Target Setting");
                    HRIndividualTarget.SetRange(HRIndividualTarget.Status, HRIndividualTarget.Status::Approved);
                    if HRIndividualTarget.Find('-') then
                        HRIndividualTarget."Appraisal Type" := HRIndividualTarget."appraisal type"::"Quarter 1";
                    // HRIndividualTarget."Appraisal Type":=HRIndividualTarget."Appraisal Type"::"End Year Appraisal";
                    HRIndividualTarget.Modify;
                    Message('Target Setting Successfully closed');




                    /*
                    
                    //TESTFIELD("Approval Status","Approval Status"::Approved);
                    
                    //IF "Requisition Type" = "Requisition Type"::External THEN ERROR('Requisition Type must be "Internal" or "Both"');
                    
                    //IF CONFIRM(Text0001,FALSE,"Job ID","Job Description") = FALSE THEN EXIT;
                    HREmp.RESET;
                    HREmp.SETRANGE(HREmp.Status,HREmp.Status::Active);
                    IF HREmp.FIND('-') THEN
                    BEGIN
                        HREmp.TESTFIELD(HREmp."Company E-Mail");
                      //Check if SMTP mail setup is done
                        //SMTPMailSetup.GET;
                        {
                        //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                        HREmailParam.RESET;
                        HREmailParam.SETRANGE(HREmailParam."Associate With",HREmailParam."Associate With"::"Vacancy Advertisements");
                        IF HREmailParam.FIND('-') THEN
                        BEGIN
                             HREmailParam.TESTFIELD(HREmailParam."Sender Name");
                             HREmailParam.TESTFIELD(HREmailParam."Sender Address");
                             HREmailParam.TESTFIELD(HREmailParam.Subject);
                    
                    }
                             REPEAT
                                SMTP.CreateMessage('hkisienya.co.ke','hkisienya.co.ke',HREmp."Company E-Mail",
                                'Quarter 1 Closure','Dear'+' '+ HREmp."First Name" +'<br>'+
                                'Quarter 1 Review has been closed'+'<br><br>Regards',TRUE);
                                SMTP.Send();
                             UNTIL HREmp.NEXT=0;
                             MESSAGE('[%1] Employees have been notified about this vacancy',HREmp.COUNT);
                        END ELSE
                       // BEGIN
                        //     ERROR('No E-Mail Parameters have been setup for Internal Vacany  notifications');
                        END;
                    END;
                    
                    */

                end;
            }
            action("Close Quarter 1 Review")
            {
                ApplicationArea = Basic;
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Do you want to Close the Quarter1 Review stage?', true) = false then exit;
                    HRIndividualTarget.Reset;
                    HRIndividualTarget.SetRange(HRIndividualTarget."Appraisal Type", HRIndividualTarget."appraisal type"::"Quarter 1");
                    HRIndividualTarget.SetRange(HRIndividualTarget.Status, HRIndividualTarget.Status::Approved);
                    if HRIndividualTarget.Find('-') then
                        HRIndividualTarget."Appraisal Type" := HRIndividualTarget."appraisal type"::"Appraisal Review";
                    HRIndividualTarget.Modify;
                    Message('Appraisal Review Successfully closed')
                end;
            }
            action("Close Appraisal Review")
            {
                ApplicationArea = Basic;
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Do you want to Close the Appraisal Review stage?', true) = false then exit;
                    HRIndividualTarget.Reset;
                    HRIndividualTarget.SetRange(HRIndividualTarget."Appraisal Type", HRIndividualTarget."appraisal type"::"Appraisal Review");
                    HRIndividualTarget.SetRange(HRIndividualTarget.Status, HRIndividualTarget.Status::Approved);
                    if HRIndividualTarget.Find('-') then
                        HRIndividualTarget."Appraisal Type" := HRIndividualTarget."appraisal type"::"Quarter 3";
                    HRIndividualTarget.Modify;
                    Message('Appraisal Review Successfully closed')
                end;
            }
            action("Close Quarter 3 Review")
            {
                ApplicationArea = Basic;
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Do you want to Close the Appraisal Review stage?', true) = false then exit;
                    HRIndividualTarget.Reset;
                    HRIndividualTarget.SetRange(HRIndividualTarget."Appraisal Type", HRIndividualTarget."appraisal type"::"Quarter 3");
                    HRIndividualTarget.SetRange(HRIndividualTarget.Status, HRIndividualTarget.Status::Approved);
                    if HRIndividualTarget.Find('-') then
                        HRIndividualTarget."Appraisal Type" := HRIndividualTarget."appraisal type"::"End Year Appraisal";
                    HRIndividualTarget.Modify;
                    Message('Appraisal Review Successfully closed')
                end;
            }
        }
    }

    var
        strPeriodName: Text;
        dtOpenPeriod: Date;
        HRSetup: Record "HR Setup.";
        HRAppraisalPeriod_NEW: Record "HR Appraisal Period";
        Question: Text;
        Answer: Boolean;
        HRAppraisalPeriod: Record "HR Appraisal Period";
        "Appraisal Type Option": Option "Appraisal Review","Target Setting","End Year Appraisal";
        ApprasialPeriod: Record "HR Appraisal Period";
        NextPeriod: Date;
        HRIndividualTarget: Record "HR Individual Targets Header";
        HRLookup: Record "HR Lookup Values";
        HREmp: Record Employee;
    ////SMTP: Codeunit UnknownCodeunit400;


    procedure fnGetOpenPeriod()
    begin
        //Get the open/current period
        HRAppraisalPeriod.Reset;
        HRAppraisalPeriod.SetRange(HRAppraisalPeriod.Closed, false);
        if HRAppraisalPeriod.Find('-') then begin
            strPeriodName := HRAppraisalPeriod."Appraisal Period Description";
            dtOpenPeriod := HRAppraisalPeriod."Date opened";
        end;
    end;


    procedure fnCloseAppraisalPeriod()
    var
        newDate: Date;
        newMonth: Integer;
        newYear: Integer;
        "BSC Line": Record "HR Individual Target Line";
        "BSC Line2": Record "HR Individual Target Line";
        "BSC Header": Record "HR Individual Targets Header";
        newDateTemp: Date;
    begin
        /*
        HRAppraisalPeriod.RESET;
        HRAppraisalPeriod.SETRANGE(HRAppraisalPeriod."Date opened",dtOpenPeriod);
        HRAppraisalPeriod.SETRANGE(HRAppraisalPeriod."Appraisal Type",HRAppraisalPeriod."Appraisal Type"::"End Year Appraisal");
        IF HRAppraisalPeriod.FIND('-') THEN
        BEGIN
               HRAppraisalPeriod.Closed:=TRUE;
               HRAppraisalPeriod."Date closed":=TODAY;
               HRAppraisalPeriod.MODIFY;
        
               //open the taget setting
               newDate:=CALCDATE('+1M',dtOpenPeriod);
               newMonth:=DATE2DMY(newDate,2);
               newYear:=DATE2DMY(newDate,3);
        
                HRAppraisalPeriod_NEW.INIT;
                HRAppraisalPeriod_NEW."Appraisal Period":=newDate;
                HRAppraisalPeriod_NEW."Appraisal Month":=newMonth;
                HRAppraisalPeriod_NEW."Appraisal Year":=newYear;
                HRAppraisalPeriod_NEW."Appraisal Period Description":=FORMAT(newDate,0,'<Month Text>')+' - '+FORMAT(newYear);
                IF DATE2DMY(HRAppraisalPeriod_NEW."Appraisal Period",2) = HRSetup."Target Setting Month" THEN
                 HRAppraisalPeriod_NEW."Appraisal Type":=HRAppraisalPeriod_NEW."Appraisal Type"::"Target Setting"
                ELSE BEGIN
                 HRAppraisalPeriod_NEW."Appraisal Type":=HRAppraisalPeriod_NEW."Appraisal Type"::"Appraisal Review";
                END;
                HRAppraisalPeriod_NEW.Closed:=FALSE;
                HRAppraisalPeriod_NEW."Date opened":=newDate;
                HRAppraisalPeriod_NEW."Date closed":=0D;
                HRAppraisalPeriod_NEW.INSERT;
         END ELSE BEGIN     //IF its not end year period create then continue -------
            ApprasialPeriod.RESET;
            ApprasialPeriod.SETRANGE(ApprasialPeriod."Date opened",dtOpenPeriod);
        //    ApprasialPeriod.SETRANGE(HRAppraisalPeriod_NEW."Appraisal Type",HRAppraisalPeriod_NEW."Appraisal Type"::"Appraisal Review");
            IF ApprasialPeriod.FIND('-') THEN BEGIN
             ApprasialPeriod.Closed:=TRUE;
             ApprasialPeriod."Date closed":=TODAY;
             ApprasialPeriod.MODIFY;
            END;
        
           newDateTemp:=CALCDATE(HRSetup."Appraisal Interval",dtOpenPeriod);
           newMonth:=DATE2DMY(newDateTemp,2);
           newYear:=DATE2DMY(newDateTemp,3);
        
            IF DATE2DMY(newDateTemp,2)=HRSetup."Target Setting Month" THEN BEGIN
              newDate:=CALCDATE('-1M',newDateTemp);
              newMonth:=DATE2DMY(newDate,2);
              newYear:=DATE2DMY(newDate,3);
              "Appraisal Type Option":="Appraisal Type Option"::"End Year Appraisal";
            END ELSE BEGIN
             newDate:=newDateTemp;
            "Appraisal Type Option":="Appraisal Type Option"::"Appraisal Review";
            END;
        
            HRAppraisalPeriod_NEW.INIT;
            HRAppraisalPeriod_NEW."Appraisal Period":=newDate;
            HRAppraisalPeriod_NEW."Appraisal Month":=newMonth;
            HRAppraisalPeriod_NEW."Appraisal Year":=newYear;
            HRAppraisalPeriod_NEW."Appraisal Period Description":=FORMAT(newDate,0,'<Month Text>')+' - '+FORMAT(newYear);;
            HRAppraisalPeriod_NEW.Closed:=FALSE;
            HRAppraisalPeriod_NEW."Date opened":=newDate;
            HRAppraisalPeriod_NEW."Date closed":=0D;
            HRAppraisalPeriod_NEW."Appraisal Type":="Appraisal Type Option";
            HRAppraisalPeriod_NEW.INSERT;
         END;
        */

    end;


    procedure fnCloseAppraisalPeriod_NEW()
    var
        HRSetup: Record "HR Setup.";
        HRAppPeriod: Record "HR Appraisal Period";
        HRAppPeriod_2: Record "HR Appraisal Period";
    begin
        HRSetup.Reset;
        if HRSetup.Get then begin
            //Get Appraisal Start Date/ End Date and Apprisal Interval
            HRSetup.TestField(HRSetup."Appraisal Posting Period[FROM]");
            HRSetup.TestField(HRSetup."Appraisal Posting Period[TO]");
            HRSetup.TestField(HRSetup."Appraisal Interval");

            HRAppPeriod.Reset;
            if not HRAppPeriod.Find('-') then begin
                //Create target setting appraisal period if no appraisal period is defined
                HRAppPeriod.Init;
                HRAppPeriod."Appraisal Period" := HRSetup."Appraisal Posting Period[FROM]";
                HRAppPeriod."Appraisal Type" := HRAppPeriod."appraisal type"::"Target Setting";
                HRAppPeriod."Date opened" := Today;
                HRAppPeriod."Appraisal Year" := Format(Date2dmy(HRSetup."Appraisal Posting Period[FROM]", 3)) + ' - '
                                              + Format(Date2dmy(HRSetup."Appraisal Posting Period[TO]", 3));
                HRAppPeriod."Appraisal Period Description" := 'Target Setting [' + HRAppPeriod."Appraisal Year" + ']';
                HRAppPeriod.Insert;
            end else begin
                //Get last appraisal period
                HRAppPeriod.Reset;
                if HRAppPeriod.Find('+') then begin
                    //If an appraisal period is defined check whether next period should be "Evaluation" or "End Year"

                    NextPeriod := CalcDate((HRSetup."Appraisal Interval"), HRAppPeriod."Appraisal Period");

                    HRAppPeriod_2.Reset;

                    HRAppPeriod_2.Init;
                    HRAppPeriod_2."Appraisal Period" := NextPeriod;
                    HRAppPeriod_2."Date opened" := Today;
                    HRAppPeriod_2."Appraisal Year" := Format(Date2dmy(HRSetup."Appraisal Posting Period[FROM]", 3)) + ' - '
                                                  + Format(Date2dmy(HRSetup."Appraisal Posting Period[TO]", 3));
                    if NextPeriod >= HRSetup."Appraisal Posting Period[TO]" then begin
                        HRAppPeriod_2."Appraisal Type" := HRAppPeriod_2."appraisal type"::"End Year Appraisal";
                        HRAppPeriod_2."Appraisal Period Description" := 'End Year Appraisal [' + HRAppPeriod_2."Appraisal Year" + ']';
                    end else begin
                        HRAppPeriod_2."Appraisal Type" := HRAppPeriod_2."appraisal type"::"Appraisal Review";
                        HRAppPeriod_2."Appraisal Period Description" := 'Appraisal Review [' + HRAppPeriod_2."Appraisal Year" + ']';
                    end;

                    HRAppPeriod_2.Insert;
                    HRAppPeriod.Closed := true;
                    HRAppPeriod."Date closed" := Today;



                end;
            end;
        end;
    end;
}

