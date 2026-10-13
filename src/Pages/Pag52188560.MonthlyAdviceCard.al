page 50223 "Monthly Advice Card"
{
    ApplicationArea = All;
    Caption = 'Monthly Advice Card';
    PageType = Card;
    SourceTable = "Monthly Advice Header";
    DeleteAllowed = false;
    PromotedActionCategories = 'New,Process,Report,Generate';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Code field.';
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Name field.';
                }
                field("PRD Code"; Rec."PRD Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Name field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Advice Type"; Rec."Advice Type")
                {
                    ApplicationArea = All;
                    ValuesAllowed = "Full Advice", "New Loans", Loans, Savings;
                    ToolTip = 'Specifies the value of the Employer Name field.';
                }
                field("Loan Source"; Rec."Loan Source")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Name field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entered By field.';
                }
                field("Debit Account Type"; Rec."Debit Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Debit Account Type field.';
                    Visible = false;
                }
                field("Debit Account"; Rec."Debit Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Debit Account field.';
                    Visible = false;
                }
                field("Credit Account Type"; Rec."Credit Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Credit Account Type field.';
                    Visible = false;
                }
                field("Credit Account"; Rec."Credit Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Credit Account field.';
                    Visible = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Entered field.';
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Entered field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
            }

            part(Control6; "Monthly Advice Buffer")
            {
                SubPageLink = "Advice Header No." = field("No.");
            }
        }
    }


    actions
    {
        area(processing)
        {
            action("Generate Advice")
            {
                ApplicationArea = Basic;
                Image = GetLines;
                Promoted = true;
                PromotedCategory = category4;

                trigger OnAction()
                var
                    LineNo: Integer;
                    LastPayrollNo: code[20];
                begin
                    MonthlyAdvice.Reset;
                    MonthlyAdvice.SetRange("No.", Rec."No.");
                    if MonthlyAdvice.FindFirst then
                        Report.Run(Report::"Generate Monthly Advice_", true, false, MonthlyAdvice);

                    AdviceBuffer.Reset;
                    AdviceBuffer.SetRange("Advice Header No.", Rec."No.");
                    AdviceBuffer.SetCurrentKey("Payroll No");
                    AdviceBuffer.SetAscending("Payroll No", true);
                    if AdviceBuffer.FindFirst then begin
                        LineNo := 0;
                        LastPayrollNo := '';
                        repeat
                            if LastPayrollNo <> AdviceBuffer."Payroll No" then begin
                                LineNo += 1;
                            end;
                            AdviceBuffer."Line No." := LineNo;
                            AdviceBuffer.Modify();
                            LastPayrollNo := AdviceBuffer."Payroll No";


                        until AdviceBuffer.next = 0;
                    end;


                end;
            }

            action("Generate Advice New")
            {
                ApplicationArea = Basic;
                Image = GeneralLedger;
                Promoted = true;
                Visible = false;
                PromotedCategory = category4;

                trigger OnAction()
                var
                    LineNo: Integer;
                    LastPayrollNo: code[20];
                begin
                    MonthlyAdvice.Reset;
                    MonthlyAdvice.SetRange("No.", Rec."No.");
                    if MonthlyAdvice.FindFirst then
                        Report.Run(Report::"Generate Monthly Advice New", true, false, MonthlyAdvice);

                    AdviceBuffer.Reset;
                    AdviceBuffer.SetRange("Advice Header No.", Rec."No.");
                    AdviceBuffer.SetCurrentKey("Payroll No");
                    AdviceBuffer.SetAscending("Payroll No", true);
                    if AdviceBuffer.FindFirst then begin
                        LineNo := 0;
                        LastPayrollNo := '';
                        repeat
                            if LastPayrollNo <> AdviceBuffer."Payroll No" then begin
                                LineNo += 1;
                            end;
                            AdviceBuffer."Line No." := LineNo;
                            AdviceBuffer.Modify();
                            LastPayrollNo := AdviceBuffer."Payroll No";


                        until AdviceBuffer.next = 0;
                    end;


                end;
            }

            action("New Loans Advice - Standard")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    MonthlyAdviceLine.Reset;
                    MonthlyAdviceLine.SetRange("Advice Header No.", Rec."No.");
                    if MonthlyAdviceLine.FindFirst then
                        Report.Run(Report::"New Loans Advice - Std", true, false, MonthlyAdviceLine);

                end;
            }

            action("New Savings Advice - Standard")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    MonthlyAdviceLine.Reset;
                    MonthlyAdviceLine.SetRange("Advice Header No.", Rec."No.");
                    if MonthlyAdviceLine.FindFirst then
                        Report.Run(Report::"New Savings Advice - Std", true, false, MonthlyAdviceLine);

                end;
            }

            action("Adjustments Loans Advice - Standard")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    MonthlyAdviceLine.Reset;
                    MonthlyAdviceLine.SetRange("Advice Header No.", Rec."No.");
                    if MonthlyAdviceLine.FindFirst then
                        Report.Run(Report::"Stoppage Loans Advice - Std", true, false, MonthlyAdviceLine);

                end;
            }

            action("Adjustments Savings Advice - Standard")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    MonthlyAdviceLine.Reset;
                    MonthlyAdviceLine.SetRange("Advice Header No.", Rec."No.");
                    if MonthlyAdviceLine.FindFirst then
                        Report.Run(Report::"Adjust. Savings Advice - Std", true, false, MonthlyAdviceLine);

                end;
            }

            action("External Advice Report")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    MonthlyAdviceLine.Reset;
                    MonthlyAdviceLine.SetRange("Advice Header No.", Rec."No.");
                    if MonthlyAdviceLine.FindFirst then
                        Report.Run(Report::"External Advice Report", true, false, MonthlyAdviceLine);

                end;
            }
            action("Consolidated Advice Report")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    if Rec.FindFirst then
                        Report.Run(Report::"Advice Consolidated Report", true, false, Rec);

                end;
            }

            action("Checkoff Advice Report")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ChkAdvice: record "Monthly Advice Header";
                begin
                    ChkAdvice.Reset;
                    ChkAdvice.SetRange("No.", Rec."No.");
                    if ChkAdvice.FindFirst then
                        Report.Run(report::"Checkoff Advice Report New", true, false, ChkAdvice);
                end;
            }

            action("Checkoff Report Summary")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ChkAdvice: record "Monthly Advice Header";
                begin
                    ChkAdvice.Reset;
                    ChkAdvice.SetRange("No.", Rec."No.");
                    if ChkAdvice.FindFirst then
                        Report.Run(report::"Advice Report Summary", true, false, ChkAdvice);
                end;
            }

            action("Mark as Processed")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Mark this as Processed?') then begin


                        MonthlyAdviceLine.Reset;
                        MonthlyAdviceLine.SetRange("Advice Header No.", Rec."No.");
                        if MonthlyAdviceLine.FindFirst then begin
                            repeat
                                MonthlyAdviceLine."Advice Date" := Rec."End Date";
                                MonthlyAdviceLine.Modify();
                            until MonthlyAdviceLine.Next() = 0;
                            Rec.Posted := true;
                            Rec.Modify();
                            Message('Processed');
                        end;

                    end;
                end;
            }

            action(Email)
            {
                ApplicationArea = All;
                Caption = 'Send Email';
                Image = Email;
                Visible = false;
                ToolTip = 'Send an email to this customer.';
                trigger OnAction()
                var
                    TempEmailItem: Record "Email Item" temporary;
                    EmailScenario: Enum "Email Scenario";
                    TempBlob: Codeunit "Temp Blob";
                    InStr: InStream;
                    OutStr: OutStream;
                    ExternalAdviceReport: Report "External Advice Report";

                    FileName: Text;
                begin
                    FileName := Rec."No." + '.pdf';

                    // Find the monthly advice line
                    MonthlyAdviceLine.Reset();
                    MonthlyAdviceLine.SetRange("Advice Header No.", Rec."No.");
                    if MonthlyAdviceLine.FindFirst() then begin
                        // Generate report in memory
                        TempBlob.CreateOutStream(OutStr);
                        ExternalAdviceReport.SetTableView(MonthlyAdviceLine);

                        if ExternalAdviceReport.SaveAs('', ReportFormat::Pdf, OutStr) then begin
                            TempBlob.CreateInStream(InStr);

                            // Create email with attachment
                            TempEmailItem.AddSourceDocument(Database::"Monthly Advice Header", Rec.SystemId);
                            TempEmailItem."Send to" := Rec."Employer Email";
                            TempEmailItem.AddAttachment(InStr, FileName);
                            TempEmailItem.Send(false, EmailScenario::Default);
                        end else begin
                            Message('Failed to generate PDF report.');
                        end;
                    end else begin
                        Message('No advice lines found for advice header %1.', Rec."No.");
                    end;
                end;
            }

            action(Post)
            {
                ApplicationArea = All;
                Caption = 'Post';
                Image = Post;
                Visible = true;
                ToolTip = 'Post this debit advice';

                trigger OnAction()
                var
                    SaccoActivities: Codeunit "Sacco Activities";
                begin
                    Rec.TestField("Debit Posted", false);
                    SaccoActivities.DebitCheckoffAdvice(Rec);
                    Message('Posted!');
                end;
            }

            action("Employer Group")
            {
                ApplicationArea = Basic;
                Image = GeneralLedger;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Employer Group";
                RunPageLink = "Advice No." = field("No.");

            }
        }
    }

    var
        MonthlyAdvice: Record "Monthly Advice Header";
        MonthlyAdviceLine: Record "Monthly Advice";
        AdviceBuffer: record "Monthly Advice";

}
