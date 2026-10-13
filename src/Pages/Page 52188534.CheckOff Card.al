
Page 50197 "CheckOff Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Monthly Checkoff Header";

    PromotedActionCategories = 'New,Process,Report,Request Approval,Importation,Validation,Generate Checkoff Lines,Posting,Variance';

    layout
    {
        area(content)
        {
            group(General)
            {
                // editable = EditCheckoff;
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateEntered; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TimeEntered; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(EnteredBy; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ReportingPeriod; Rec."Reporting Period")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff-Period"; Rec."Checkoff-Period")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Loan Posting"; Rec."Checkoff Loan Posting")
                {
                    ApplicationArea = Basic;
                    Caption = 'Checkoff Posting Period';
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = EditCheckoff;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = EditCheckoff;
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = EditCheckoff;
                }
                field("Batch Entries"; Rec."Batch Entries")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("No. Of Batches"; Rec."No. Of Batches")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(VendorNo; Rec."Vendor No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Type"; Rec."Checkoff Type")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerCode; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = EditCheckoff;
                }
                field(EmployerName; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = EditCheckoff;
                }
                field("Advice No"; Rec."Advice No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan Cut-Off Date"; Rec."Loan Cut-Off Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = EditCheckoff;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = EditCheckoff;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                    Editable = EditCheckoff;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = EditCheckoff;
                }
                /*
                field("Receipt No.";Rec."Receipt No.")
                {
                    ApplicationArea = Basic;
                    Editable = EditCheckoff;
                }

                field("Receipt Amount";Rec."Receipt Amount")
                {
                    ApplicationArea = Basic;
                    Editable = EditCheckoff;
                }
                */
                /*
                field("Amount Already Posted";Rec."Amount Already Posted")
                {
                    ApplicationArea = Basic;
                    Editable = EditCheckoff;
                }
                field("Amount Pending";Rec."Amount Pending")
                {
                    ApplicationArea = Basic;
                    Editable = EditCheckoff;
                }*/
                field(CHKBufferAmount; Rec."CHK Buffer Amount")
                {
                    ApplicationArea = Basic;
                }
                field(CHKLineAmount; Rec."CHK Line Amount")
                {
                    ApplicationArea = Basic;
                    Editable = EditCheckoff;
                }
                field(TotalCount; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                }
                field(PostedRecords; Rec."Posted Records")
                {
                    ApplicationArea = Basic;
                }
                /*
                field("Total Principal";Rec."Total Principal")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Interest";Rec."Total Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }*/

                field("Total Loan"; Rec."Total Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Total Savings"; Rec."Total Savings")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control6; "Checkoff Import")
            {
                Editable = EditCheckoff;
                SubPageLink = "Checkoff No" = field("No.");
            }
            part(Control5; "Checkoff Lines")
            {
                Editable = EditCheckoff;
                SubPageLink = "Checkoff Header" = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Checkoff Report")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange("No.", Rec."No.");
                    if rec.FindFirst() then
                        Report.Run(Report::"Checkoff Report", true, true, Rec);
                end;
            }
            action("Import Full Checkoff")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                visible = false;
                Enabled = Rec."Checkoff Type" = Rec."Checkoff Type"::"Block Checkoff";
                //RunObject = XMLport "Checkoff Buffer";
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    //Message('Ensure the document is as follows: \1. Payroll No/Member No. \2. Savings Amount\3. Loan Amount\4.Line No.\\ - Document Format should be Excel and Should include the Headers');
                    Message('Ensure the document is as follows: \1. Payroll No/Member No. \2. Amount\3.Line No.\\ - Document Format should be Excel and Should include the Headers');

                    if Confirm('Are you sure you want to Import Checkoff?') then begin
                        Rec.ImportCheckOffLinesFromExcel();
                    end;
                end;
            }
            action("Import Checkoff")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                //Enabled = Rec."Checkoff Type" = Rec."Checkoff Type"::"Single Checkoff";
                //RunObject = XMLport "Checkoff Buffer";
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    //Message('Ensure the document is as follows: \1. Payroll No/Member No. \2. Savings Amount\3. Loan Amount\4.Line No.\\ - Document Format should be Excel and Should include the Headers');
                    Message('Ensure the document is as follows: \1. Payroll No/Member No. \2. Amount \3.ReportingName \4.Line No.\\ - Document Format should be Excel and Should include the Headers');

                    if Confirm('Are you sure you want to Import Checkoff?') then begin
                        Rec.ImportSingleCheckOffLinesFromExcel();
                    end;
                end;
            }
            action("Import Share Capital Checkoff")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                //RunObject = XMLport "Checkoff Buffer";
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Message('Ensure the document is as follows: \1. Payroll No or Member no/\2. Share Capital Amount\3.Line No.\ - Document Format should be Excel and Should include the Headers');

                    if Confirm('Are you sure you want to Import Checkoff?') then begin
                        Rec.ImportShareCapitalCheckOffLinesFromExcel();
                    end;
                end;
            }
            action("Validate Buffer Payroll No.")
            {
                ApplicationArea = Basic;
                Image = Accounts;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Enabled = Rec."Checkoff Type" = Rec."Checkoff Type"::"Block Checkoff";

                trigger OnAction()
                var
                    MsgValidate: label 'Validation Successful';
                    Loans: Record Loans;
                begin
                    CheckoffHeader.Reset;
                    CheckoffHeader.SetRange("No.", Rec."No.");
                    if CheckoffHeader.FindFirst then begin
                        n := 0;
                        f := 0;
                        Buffer.Reset;
                        Buffer.SetRange("Checkoff No", Rec."No.");
                        if Buffer.Find('-') then begin
                            dWindow.Open('Validating Buffer:     #1#########\'
                                        + 'Accounts:              #2#########\'
                                        + 'Counter:               #3#########\'
                                        + 'Progress:              @4@@@@@@@@@\'
                                        + 'Press Esc to abort');

                            CurrentRecordNo := 0;
                            NoOfRecords := Buffer.Count;
                            dWindow.Update(2, NoOfRecords);
                            repeat
                                CurrentRecordNo += 1;
                                dWindow.Update(1, Buffer.Payroll);
                                dWindow.Update(3, CurrentRecordNo);
                                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));



                                if Buffer."Loan Amount" > 0 then
                                    Buffer."Loan Not Found" := true
                                else
                                    Buffer."Loan Not Found" := false;

                                Members.Reset;
                                if CheckoffHeader."Employer Code" = '' then
                                    Members.SetRange("No.", Buffer.Payroll)
                                else begin

                                    Members.SetRange("Employer Code", CheckoffHeader."Employer Code");
                                    Members.SetRange("Payroll/Staff No.", Buffer.Payroll);
                                end;
                                if Members.FindFirst then begin
                                    Buffer."Member No." := Members."No.";
                                    Buffer.Name := Members.Name;
                                    Buffer."Member Not Found" := false;
                                    Buffer.Modify;
                                    f += 1;
                                    if Buffer."Loan Amount" > 0 then begin

                                        Loans.Reset;
                                        Loans.SetRange("Loan No.", Buffer."Search Code");
                                        Loans.SetRange("Member No.", Members."No.");
                                        //Loans.SetFilter("Outstanding Principal", '>0');
                                        if Loans.FindFirst() then begin
                                            Buffer."Loan Not Found" := false;
                                        end;
                                    end;
                                end
                                else begin
                                    Buffer."MEmber Not Found" := true;
                                    n += 1;
                                end;

                                Buffer.Modify;

                            until Buffer.Next = 0;
                            dWindow.Close;
                        end;
                        Message('Total Accounts %1\Found %2\Not Found %3', Buffer.Count, f, n);

                    end;

                    //REPORT.RUN(39004277,TRUE,FALSE,CheckoffHeader);
                end;
            }
            action("Validate Buffer Member No.")
            {
                ApplicationArea = Basic;
                Image = Accounts;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MsgValidate: label 'Validation Successful';
                    Loans: Record Loans;
                begin

                    CheckoffHeader.Reset;
                    CheckoffHeader.SetRange("No.", Rec."No.");
                    if CheckoffHeader.FindFirst then begin
                        n := 0;
                        f := 0;
                        Buffer.Reset;
                        Buffer.SetRange("Checkoff No", Rec."No.");
                        if Buffer.Find('-') then begin
                            dWindow.Open('Validating Buffer:     #1#########\'
                                        + 'Accounts:              #2#########\'
                                        + 'Counter:               #3#########\'
                                        + 'Progress:              @4@@@@@@@@@\'
                                        + 'Press Esc to abort');

                            CurrentRecordNo := 0;
                            NoOfRecords := Buffer.Count;
                            dWindow.Update(2, NoOfRecords);
                            repeat
                                CurrentRecordNo += 1;
                                dWindow.Update(1, Buffer.Payroll);
                                dWindow.Update(3, CurrentRecordNo);
                                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));



                                if Buffer."Loan Amount" > 0 then
                                    Buffer."Loan Not Found" := true
                                else
                                    Buffer."Loan Not Found" := false;

                                Members.Reset;
                                if CheckoffHeader."Employer Code" = '' then
                                    Members.SetRange("No.", Buffer.Payroll)
                                else begin

                                    Members.SetRange("Employer Code", CheckoffHeader."Employer Code");
                                    Members.SetRange("No.", Buffer.Payroll);
                                end;
                                if Members.FindFirst then begin
                                    Buffer."Member No." := Members."No.";
                                    Buffer.Name := Members.Name;
                                    Buffer."Member Not Found" := false;
                                    //Buffer.Amount := Buffer."Savings Amount" + Buffer."Loan Amount" + Buffer."Share Capital";
                                    //Buffer.Payroll := Members."Payroll/Staff No.";
                                    //Buffer."Employer Code" := Members."Employer Code";
                                    Buffer.Modify;
                                    f += 1;
                                    /*if Buffer."Loan Amount" > 0 then begin

                                        Loans.Reset;
                                        Loans.SetRange("Loan No.", Buffer."Search Code");
                                        Loans.SetRange("Member No.", Members."No.");
                                        //Loans.SetFilter("Outstanding Principal", '>0');
                                        if Loans.FindFirst() then begin
                                            Buffer."Loan Not Found" := false;
                                        end;
                                    end;Rec.*/
                                end
                                else begin
                                    Buffer."MEmber Not Found" := true;
                                    n += 1;
                                end;

                                Buffer.Modify;

                            until Buffer.Next = 0;
                            dWindow.Close;
                        end;
                        Message('Total Accounts %1\Found %2\Not Found %3', Buffer.Count, f, n);

                    end;

                    //REPORT.RUN(39004277,TRUE,FALSE,CheckoffHeader);
                end;
            }
            action("Validate Buffer Checkoff Codes")
            {
                ApplicationArea = Basic;
                Image = Accounts;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Enabled = Rec."Checkoff Type" = Rec."Checkoff Type"::"Single Checkoff";

                trigger OnAction()
                var
                    MsgValidate: label 'Validation Successful';
                    Loans: Record Loans;
                    Savings: Record "Savings Accounts";
                    CheckoffCode: Record "Check Off Codes";
                    Found: Boolean;
                begin

                    CheckoffHeader.Reset;
                    CheckoffHeader.SetRange("No.", Rec."No.");
                    if CheckoffHeader.FindFirst then begin
                        n := 0;
                        f := 0;
                        Buffer.Reset;
                        Buffer.SetRange("Checkoff No", Rec."No.");
                        if Buffer.Find('-') then begin
                            dWindow.Open('Validating Buffer:     #1#########\'
                                        + 'Accounts:              #2#########\'
                                        + 'Counter:               #3#########\'
                                        + 'Progress:              @4@@@@@@@@@\'
                                        + 'Press Esc to abort');

                            CurrentRecordNo := 0;
                            NoOfRecords := Buffer.Count;
                            dWindow.Update(2, NoOfRecords);
                            repeat
                                CurrentRecordNo += 1;
                                dWindow.Update(1, Buffer.Payroll);
                                dWindow.Update(3, CurrentRecordNo);
                                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                                Members.Reset;
                                if CheckoffHeader."Employer Code" = '' then
                                    Members.SetRange("No.", Buffer.Payroll)
                                else begin
                                    Members.SetRange("Employer Code", CheckoffHeader."Employer Code");
                                    Members.SetRange("Payroll/Staff No.", Buffer.Payroll);
                                end;
                                if Members.FindFirst then begin
                                    Buffer."Member No." := Members."No.";
                                    Buffer.Name := Members.Name;
                                    Buffer."Member Not Found" := false;
                                    Found := false;

                                    CheckoffCode.Reset();
                                    CheckoffCode.SetRange("Reporting Name", Buffer."Reporting Name");
                                    CheckoffCode.SetRange("Account Type", CheckoffCode."Account Type"::Credit);
                                    if CheckoffCode.FindFirst() then begin


                                        Loans.Reset();
                                        Loans.SetRange("Member No.", Members."No.");
                                        Loans.SetRange("Loan Product Type", CheckoffCode."Posting Code");
                                        Loans.SetFilter("Total Outstanding Balance", '>0');
                                        if Loans.FindFirst() then begin
                                            Buffer."Loan Amount" := Buffer.Amount;
                                            Buffer."Loan No" := Loans."Loan No.";
                                        end else
                                            Buffer."Loan Not Found" := true;

                                        Found := true;

                                    end;

                                    CheckoffCode.Reset();
                                    CheckoffCode.SetRange("Reporting Name", Buffer."Reporting Name");
                                    CheckoffCode.SetRange("Account Type", CheckoffCode."Account Type"::Savings);
                                    if CheckoffCode.FindFirst() then begin
                                        repeat

                                            Savings.Reset();
                                            Savings.SetRange("Member No.", Members."No.");
                                            Savings.SetRange("Product Type", CheckoffCode."Posting Code");
                                            if Savings.FindFirst() then begin
                                                Buffer."Savings Amount" := Buffer.Amount;
                                                Buffer."Savings Account" := true;
                                                Buffer."Account No" := Savings."No.";
                                                Buffer."Savings Not Found" := false;

                                            end else
                                                Buffer."Savings Not Found" := true;

                                            if Buffer."Account No" <> ' ' then
                                                Buffer."Savings Not Found" := false;

                                            Found := true;
                                        until CheckoffCode.Next() = 0;
                                    end;
                                    //Buffer.Amount := Buffer."Savings Amount" + Buffer."Loan Amount" + Buffer."Share Capital";
                                    //Buffer.Payroll := Members."Payroll/Staff No.";
                                    //Buffer."Employer Code" := Members."Employer Code";
                                    /*  if not Found then begin
                                         Buffer."Loan Not Found" := true;
                                         Buffer."Savings Not Found" := true;
                                     end;
  */
                                    Buffer.Modify;
                                    f += 1;
                                    /*if Buffer."Loan Amount" > 0 then begin

                                        Loans.Reset;
                                        Loans.SetRange("Loan No.", Buffer."Search Code");
                                        Loans.SetRange("Member No.", Members."No.");
                                        //Loans.SetFilter("Outstanding Principal", '>0');
                                        if Loans.FindFirst() then begin
                                            Buffer."Loan Not Found" := false;
                                        end;
                                    end;Rec.*/
                                end
                                else begin
                                    Buffer."MEmber Not Found" := true;
                                    n += 1;
                                end;

                                Buffer.Modify;

                            until Buffer.Next = 0;
                            dWindow.Close;
                        end;
                        Message('Total Accounts %1\Found %2\Not Found %3', Buffer.Count, f, n);

                    end;

                    //REPORT.RUN(39004277,TRUE,FALSE,CheckoffHeader);
                end;
            }
            action("Generate Share Capital Checkoff Lines")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    Txt0000: label 'Checkoff Successfully Generated';
                begin
                    Rec.CalcFields("Posted Records", "CHK Buffer Amount");
                    Rec.Amount := Rec."CHK Buffer Amount";
                    Rec.TestField("Batch Entries");

                    Rec.Modify();
                    if Rec."Posted Records" > 0 then
                        Error('There are entries that have been posted you cannot generate lines');

                    SaccoActivities.GenerateShareCapitalSingleCheckoff(Rec);
                    //SaccoActivities.GenerateBlockCheckoff(Rec);

                    Message(Txt0000);
                end;
            }
            action("Generate Full Single Checkoff Lines")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                Enabled = Rec."Checkoff Type" = Rec."Checkoff Type"::"Single Checkoff";

                trigger OnAction()
                var
                    Txt0000: label 'Checkoff Successfully Generated';
                begin
                    Rec.CalcFields("Posted Records", "CHK Buffer Amount");
                    Rec.Amount := Rec."CHK Buffer Amount";
                    Rec.TestField("Batch Entries");

                    Rec.Modify();
                    if Rec."Posted Records" > 0 then
                        Error('There are entries that have been posted you cannot generate lines');

                    //SaccoActivities.GenerateSingleCheckoff(Rec);
                    SaccoActivities.GenerateSingleCheckoff(Rec);

                    Message(Txt0000);
                end;
            }
            action("Generate Full Block Checkoff Lines")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                Enabled = Rec."Checkoff Type" = Rec."Checkoff Type"::"Block Checkoff";

                trigger OnAction()
                var
                    Txt0000: label 'Checkoff Successfully Generated';
                begin
                    Rec.CalcFields("Posted Records", "CHK Buffer Amount");
                    Rec.Amount := Rec."CHK Buffer Amount";
                    Rec.TestField("Batch Entries");

                    Rec.Modify();
                    if Rec."Posted Records" > 0 then
                        Error('There are entries that have been posted you cannot generate lines');

                    SaccoActivities.GenerateBlockCheckoffNew(Rec);

                    Message(Txt0000);
                end;
            }
            action("Generate Checkoff Correction")
            {
                ApplicationArea = Basic;
                Image = CalculateHierarchy;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    Txt0000: label 'Checkoff Successfully Generated';
                begin
                    Rec.CalcFields("Posted Records", "CHK Buffer Amount");
                    Rec.Amount := Rec."CHK Buffer Amount";
                    Rec.TestField("Batch Entries");

                    Rec.Modify();
                    if Rec."Posted Records" < 0 then
                        Error('There are entries that have been posted you cannot generate lines');

                    //SaccoActivities.GenerateSingleCheckoff(Rec);
                    SaccoActivities.GenerateCheckoffCorrection(Rec);

                    Message('Completed');
                end;
            }
            action("Checkoff Correction Journal")
            {
                ApplicationArea = Basic;
                Image = CalculateHierarchy;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                Visible = false;
                trigger OnAction()
                var
                    Txt0000: label 'Checkoff Successfully Generated';
                begin
                    Rec.CalcFields("Posted Records", "CHK Buffer Amount");
                    Rec.Amount := Rec."CHK Buffer Amount";
                    Rec.TestField("Batch Entries");

                    Rec.Modify();
                    if Rec."Posted Records" < 0 then
                        Error('There are entries that have been posted you cannot generate lines');

                    //SaccoActivities.GenerateSingleCheckoff(Rec);
                    SaccoActivities.PostCheckoffCorrection(Rec, true);

                    Message('Completed');
                end;
            }
            action("Batch Lines")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Txt0000: label 'Checkoff Successfully Generated';
                begin
                    Rec.CalcFields("Posted Records", "CHK Buffer Amount");
                    Rec.TestField("Batch Entries");

                    if Rec."Posted Records" > 0 then
                        Error('There are entries that have been posted you cannot Batch lines');

                    SaccoActivities.BatchMonthlyCheckoff(Rec, false);
                    Rec.Modify();

                    Message('Process Completed');
                end;
            }
            action("Reset Date")
            {
                ApplicationArea = Basic;
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to Reset the Date?') then begin

                        Rec.TestField(Status, Rec.Status::Approved);
                        Rec.TestField(Posted, false);
                        Rec."Posting Date" := Today;
                        Rec.Modify();
                        Message('Updated');
                    end;
                end;
            }
            action(Post)
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    Rec.TestField(Status, Rec.Status::Approved);
                    if Rec.Status = Rec.Status::Approved then begin

                        //TestField(Posted, false);
                        //if Posted = false then
                        SaccoActivities.PostMonthlyCheckoff(Rec, false);
                    end;
                end;
            }
            action("Journal Transfer")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CheckoffLines: Record "Monthly Checkoff Lines";
                begin

                    CheckoffLines.Reset;
                    CheckoffLines.SetRange(CheckoffLines."Checkoff Header", Rec."No.");
                    CheckoffLines.SetRange("Batch No.", '');
                    CheckoffLines.SetFilter(Amount, '>0');
                    if CheckoffLines.Find('-') then begin
                        Error('Entries Not Batched');
                    end;

                    SaccoActivities.PostMonthlyCheckoff(Rec, true)
                end;
            }
            action("Reverse Checkoff")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Reverse this Checkoff?') then
                        SaccoActivities.ReverseMonthlyCheckoff(Rec);
                end;
            }
            action("Checkoff Variance")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CheckOff: Record "Monthly Checkoff Header";
                begin
                    CheckOff.Reset();
                    CheckOff.SetRange("No.", Rec."No.");
                    if CheckOff.FindFirst() then begin
                        Report.Run(Report::"Checkoff Variance Report", true, false, CheckOff);
                    end;
                end;
            }
            action("Checkoff Variance 2")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CheckOff: Record "Monthly Checkoff Header";
                begin
                    CheckOff.Reset();
                    CheckOff.SetRange("No.", Rec."No.");
                    if CheckOff.FindFirst() then begin
                        Report.Run(Report::"Checkoff Variance Report - Ext", true, false, CheckOff);
                    end;
                end;
            }
        }
        area(processing)
        {
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        NextofKIN: Record "Service Item";
                        ProductFactory: Record "Service Item";
                        SavingsAccountRegistration: Record "Service Item";
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin

                        CheckControls;

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::CheckOff, Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Member Application","Loan Application","Savings Application",FDR,"Def. Recovery","Loan Changes","Guarantor Sub.","Member Exit","Member Exit Notice","Member Changes",STO,"Cheque Book App","Account Transfer","Teller Transaction","Micro Transaction",PV,"Petty Cash","Collateral Register","Collateral Return",CheckOff;
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::CheckOff;

                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
                        ApprovalTracker.SetRange("Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin

                        if Rec.Status = Rec.Status::Pending then begin
                            VarVariant := Rec;
                            CalwideApprovals.CancelTracker(VarVariant, Rec."No.");
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetUpdateControl;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetUpdateControl;
    end;

    trigger OnOpenPage()
    begin
        SetUpdateControl;
    end;

    var
        VarVariant: Variant;
        DateCaption: Boolean;
        EditCheckoff: Boolean;
        EditCheckoffLine: Boolean;
        Percentage: Decimal;
        TotalL: Decimal;
        TotalP: Decimal;
        TotalI: Decimal;
        CheckoffHeader: Record "Monthly Checkoff Header";
        Members: Record Members;
        Buffer: Record "Monthly Checkoff Buffer";
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        f: Integer;
        n: Integer;
        MemberActivities: Codeunit "Member Activities";
        SaccoActivities: Codeunit "Sacco Activities";

    local procedure CheckControls()
    begin

        Rec.TestField(Status, Rec.Status::Open);


        Rec.TestField(Description);
        Rec.TestField(Amount);
        Rec.TestField("Employer Code");
        Rec.TestField("Posting Date");

    end;

    local procedure SetUpdateControl()
    begin
        if Rec.Status = Rec.Status::Open then begin
            EditCheckoff := true;
        end else begin
            EditCheckoff := false;
        end;

    end;
}

