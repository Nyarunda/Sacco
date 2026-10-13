Page 51090 "HR Overtime Card"
{
    PageType = Card;
    PromotedActionCategories = 'Manage,Process,Report,Approval';
    SourceTable = "HR Overtime Header";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(ApplicationCode; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = DocumentEditable;
                }
                field(StaffNo; Rec."Staff No.")
                {
                    ApplicationArea = Basic;
                    Editable = DocumentEditable;
                }
                field(StaffName; Rec."Staff Name")
                {
                    ApplicationArea = Basic;
                    Editable = DocumentEditable;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = DocumentEditable;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = DocumentEditable;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = DocumentEditable;
                    visible = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                    Editable = DocumentEditable;
                    Visible = false;
                }
                field(WeekendHours; Rec."WeekDay Hours")
                {
                    ApplicationArea = Basic;
                    Editable = DocumentEditable;
                }
                field(HolidayHours; Rec."Sunday/Holiday Hours")
                {
                    ApplicationArea = Basic;
                    Caption = 'Holiday/Weekends Hours';
                    Editable = DocumentEditable;
                }

                field(TotalOvertimeHours; Rec."Total Overtime Hours")
                {
                    ApplicationArea = Basic;
                    Editable = DocumentEditable;
                }
                field(hoursEarned; Rec."Hours Earned")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = HRResponsibilityUserVisible;
                }
                field("OverTime Amount"; Rec."OverTime Amount")
                {
                    ApplicationArea = Basic;
                    Editable = DocumentEditable;
                    Visible = HRResponsibilityUserVisible;
                }
                field(ConvertTo; Rec."Convert To?")
                {
                    ApplicationArea = Basic;
                    Editable = ConvertToEditable;
                    Visible = HRResponsibilityUserVisible;
                }
                field(Converted; Rec.Converted)
                {
                    ApplicationArea = Basic;
                    Editable = DocumentEditable;
                }
                field(PostedtoPayroll; Rec."Posted to Payroll")
                {
                    ApplicationArea = Basic;
                    Editable = DocumentEditable;
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = DocumentEditable;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = basic;
                    Editable = DocumentEditable;
                }


            }
            group(Lines)
            {
                part("HR Overtime Lines"; "HR Overtime Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = DocumentEditable;
                    SubPageLink = "Application Code" = field("Application Code");
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {

            action(CalculateOverTime)
            {
                ApplicationArea = Basic;
                Caption = 'Calculate Overtime';
                Image = Overdue;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = HRResponsibilityUserVisible;
                trigger OnAction()

                begin
                    CheckHRResponsibilityCenterUser();
                    if Confirm('Calculate the overtime ? ', false) then begin
                        Rec.HasValidLines();
                        Rec."OverTime Amount" := Rec.CalculateOverTime();
                        Rec.Modify();
                        Commit();
                        Message('Overtime Amount has been updated!');
                    end;
                end;
            }

            action(PostPayToLeave)
            {
                ApplicationArea = Basic;
                Caption = 'Post Pay To Leave';
                Image = Overdue;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = HRResponsibilityUserVisible;

                trigger OnAction()
                begin
                    CheckHRResponsibilityCenterUser();
                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField(Converted, false);
                    Rec.TestField("Posted to Payroll", false);
                    Rec.TestField("Convert To?", Rec."Convert To?"::"Convert to Leave");

                    if not Confirm(
                        'Are you sure you want to post overtime application %1 to leave?',
                        false,
                        Rec."Application Code")
                    then
                        exit;

                    Rec.PostPayToLeave();
                end;
            }
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
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        StaffPayrollDtls: Record "Staff Payroll Details";
                    begin
                        Rec.HasValidLines;
                        //Rec."OverTime Amount" := Rec.CalculateOverTime();
                        //Modify();
                        Commit();

                        if Rec."Convert To?" = rec."Convert To?"::"Convert to Pay" then begin
                            if StaffPayrollDtls.Get(Rec."Staff No.") then
                                Rec."Basic Pay" := StaffPayrollDtls."Basic Pay";
                        end;
                        //Rec.TestField("OverTime Amount");

                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."Application Code", 0, DocumentType::"HR OverTime", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
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
                        VarVariant: Variant;
                    begin
                        Rec.TestField(Status, Rec.Status::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec."Application Code");
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
                        ApprovalEntries: Page System.Automation."Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocType: Enum "Custom Document Type";
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        approvalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);

                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."Application Code");
                        ApprovalTracker.SetRange("Document Type", DocType::"HR OverTime");
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField(status, Rec.status::Approved);
                        if not Confirm('Are you sure you want to re-open document?') then exit;
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
            }

        }



        area(creation)
        {
            /* action(Convert)
            {
                ApplicationArea = Basic;
                Image = ProjectExpense;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    //TESTFIELD(Status,Status::Approved);

                    if Confirm('Do you want to convert this Overtime?', true) = false then exit;

                    if Converted = true then
                        Message(Txt001);

                    if "Convert To?" = "convert to?"::" " then
                        Message(Txt002);

                    if "Convert To?" = "convert to?"::"Convert to Leave" then begin

                        Message(Txt003);
                        Converted := true;
                    end;


                    if "Convert To?" = "convert to?"::"Convert to Pay" then begin

                        Message(Txt004);
                        Converted := true;
                    end;
                end;
            } */
            action("Overtime Report")
            {
                ApplicationArea = Basic;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Overtime.Reset;
                    Overtime.SetRange(Overtime."Application Code", Rec."Application Code");
                    if Overtime.Find('-') then
                        Report.Run(Report::"HR Overtime Report", true, true, Overtime);
                end;
            }
        }
    }


    trigger OnOpenPage()
    var
        HRSetup: Record "HR Setup.";
        UserSetup: Record "User Setup";
        isHr: Boolean;
        isApprover: Boolean;
        ApprovalEntry: Record "Approval Entry";
        WUGroup: Record "Workflow User Group Member";
    begin
        HRResponsibilityUserVisible := IsHRResponsibilityCenterUser();

        isApprover := false;
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", Rec."Application Code");
        //ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindSet() then
            repeat
                isApprover := (ApprovalEntry."Approver ID" = UserId);
                if not isApprover then begin
                    WUGroup.Reset();
                    WUGroup.SetRange("User Name", UserId);
                    WUGroup.SetRange("Workflow User Group Code", ApprovalEntry."Approver ID");
                    isApprover := WUGroup.FindFirst();
                end;
            until (ApprovalEntry.Next() = 0) or (isApprover = true);


        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Is HR", true);
        isHr := not UserSetup.IsEmpty;


        if (not isHr) and (not isApprover) then begin
            UserSetup.Reset();
            if not UserSetup.Get(UserId) then
                Error('User setup is missing for %1.', UserId);

            UserSetup.TestField("Staff No");

            Rec.FilterGroup(50);
            Rec.SetRange("Staff No.", UserSetup."Staff No");
            Rec.FilterGroup(0);
        end;

        UpdatePageControl();
    end;

    trigger OnAfterGetCurrRecord()
    var
        Employee: Record Employee;
    begin
        HRResponsibilityUserVisible := IsHRResponsibilityCenterUser();
        UpdatePageControl();
        //trigger OnValidate()
    end;

    procedure UpdatePageControl()
    begin
        HRResponsibilityUserVisible := IsHRResponsibilityCenterUser();
        DocumentEditable := Rec.Status = Rec.Status::Open;
        ConvertToEditable := HRResponsibilityUserVisible and (Rec.Status in [Rec.Status::Open, Rec.Status::Approved]);
        CurrPage.Editable := true;
    end;

    local procedure IsHRResponsibilityCenterUser(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            exit(false);

        exit(UserSetup."Is HR");
    end;

    local procedure CheckHRResponsibilityCenterUser()
    begin
        if not IsHRResponsibilityCenterUser() then
            Error('Only users marked as HR with Responsibility Center HR in User Setup can perform this action.');
    end;


    var
        HRSetup: Record "HR Setup.";
        Txt001: label 'This overtime has already been converted';
        Txt002: label 'Kindly select what you want to convert to';
        Txt003: label 'Overtime succesfully converted to Leave';
        Txt004: label 'Overtime succesfully converted to Pay';
        Overtime: Record "HR Overtime Header";
        CalwideApprovals: Codeunit "Calwide Approvals";
        HRResponsibilityUserVisible: Boolean;
        DocumentEditable: Boolean;
        ConvertToEditable: Boolean;
}
