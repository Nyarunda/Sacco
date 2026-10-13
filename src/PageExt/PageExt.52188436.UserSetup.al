
PageExtension 50079 UserSetup extends "User Setup"
{
    layout
    {

        addafter("User ID")
        {
            field("Member No."; Rec."Member No.")
            {
                ApplicationArea = Basic;
                LookupPageId = "Member Listing";
            }

            field("Staff No"; Rec."Staff No")
            {
                ApplicationArea = Basic;

                trigger OnLookup(var Text: Text): Boolean
                var
                    Employee: Record Employee;
                    EmployeeList: Page "Employee List";
                begin
                    Employee.Reset();
                    EmployeeList.SetTableView(Employee);
                    EmployeeList.LookupMode(true);
                    if EmployeeList.RunModal() = Action::LookupOK then begin
                        EmployeeList.GetRecord(Employee);
                        Rec.Validate("Staff No", Employee."No.");
                    end;

                    exit(true);
                end;
            }
            field("Default Journal Nos. Series"; Rec."Default Journal Nos. Series")
            {
                ApplicationArea = Basic;
                TableRelation = "No. Series";
            }

            field("Max. Open Documents"; Rec."Max. Open Documents")
            {
                ApplicationArea = Basic;
            }
            field("File Management Admin"; Rec."File Movement Admin")
            {
                ApplicationArea = Basic;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = Basic;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = Basic;
            }
            field("CashRec Journal Template"; Rec."CashRec Journal Template")
            {
                ApplicationArea = Basic;
            }
            field("CashRec Journal Batch"; Rec."CashRec Journal Batch")
            {
                ApplicationArea = Basic;
            }
            field("Payment Journal Template"; Rec."Payment Journal Template")
            {
                ApplicationArea = Basic;
            }
            field("Payment Journal Batch"; Rec."Payment Journal Batch")
            {
                ApplicationArea = Basic;
            }

            field("General Journal Template"; Rec."General Journal Template")
            {
                ApplicationArea = Basic;
            }
            field("General Journal Batch"; Rec."General Journal Batch")
            {
                ApplicationArea = Basic;
            }

            field("Imprest Account"; Rec."Imprest Account")
            {
                ApplicationArea = Basic;
            }
            field(Payroll; Rec.Payroll)
            {
                ApplicationArea = basic;
            }
            field("View Staff Accounts"; Rec."View Staff Accounts")
            {
                ApplicationArea = Basic;
            }
            field("Is CEO"; Rec."Is CEO")
            {
                ApplicationArea = Basic;
            }
            field("Branch Manager"; Rec."Branch Manager")
            {
                ApplicationArea = Basic;
            }
            field("Default Petty Cash Bank"; Rec."Default Petty Cash Bank")
            {
                ApplicationArea = Basic;
            }
            field("Default Payment Bank"; Rec."Default Payment Bank")
            {
                ApplicationArea = Basic;
            }
            field("Disable SMS"; Rec."Disable SMS")
            {
                ApplicationArea = Basic;
            }
            field("View Board Accounts"; Rec."View Board Accounts")
            {
                ApplicationArea = Basic;
            }
            field(MBanking; Rec.MBanking)
            {
                ApplicationArea = Basic;
            }

            field("Credit Setups"; Rec."Credit Setups")
            {
                ApplicationArea = Basic;
            }
            field("Update Debt Collector"; Rec."Update Debt Collector")
            {
                ApplicationArea = Basic;
            }
            field("De-Link ATM"; Rec."De-Link ATM")
            {
                ApplicationArea = Basic;
            }
            field("Finance Setups"; Rec."Finance Setups")
            {
                ApplicationArea = Basic;
            }

            field("General Setups"; Rec."General Setups")
            {
                ApplicationArea = Basic;
            }

            field("Savings Setups"; Rec."Savings Setups")
            {
                ApplicationArea = Basic;
            }

            field("Administration Setups"; Rec."Administration Setups")
            {
                ApplicationArea = Basic;
                Visible = false;
            }

            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = Basic;
            }
            field("Is HR"; Rec."Is HR")
            {
                ApplicationArea = Basic;
            }
            field("Is Admin"; Rec."Is Admin")
            {
                ApplicationArea = Basic;
            }
            field("Is Credit Department"; Rec."Is Credit Department")
            {
                ApplicationArea = Basic;
            }

            field("File Movement Admin"; Rec."File Movement Admin")
            {
                ApplicationArea = All;

            }
            field("File Movement Group"; Rec."File Movement Group")
            {
                ApplicationArea = All;

            }
            field("Reset File Movement"; Rec."Reset File Movement")
            {
                ApplicationArea = All;

            }
            field("Collateral Exempt Approver"; Rec."Collateral Exempt Approver")
            {
                ApplicationArea = Basic;
                ToolTip = 'Specifies who must approve collateral charge exemption requests created by this user.';
            }
            field("Forfeit Exit Approver"; Rec."Forfeit Exit Approver")
            {
                ApplicationArea = Basic;
                ToolTip = 'Specifies who must approve Forfeit Exit requests created by this user.';
            }
            field("Use POS Printer"; Rec."Use POS Printer")
            {
                ApplicationArea = All;
            }
            field("Dimension Set ID"; Rec."Dimension Set ID")
            {
                ApplicationArea = All;
            }


        }
        addfirst(factboxes)
        {

            part(Control1900919607; "Dimension Set Entries FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Dimension Set ID" = field("Dimension Set ID");
                Visible = true;
            }

        }

    }
    actions
    {

        addfirst(processing)
        {
            action("Status Change Permissions")
            {
                ApplicationArea = Basic;
            }

            action("User Permission")
            {
                ApplicationArea = Basic;
                Image = New;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";

                begin
                    UserSetup.Reset();
                    UserSetup.SetRange("User ID", Rec."User ID");
                    if UserSetup.FindFirst() then
                        page.Run(PAge::"User Permissions", UserSetup);
                end;
            }
            action("Set Posting Date As Current")
            {
                ApplicationArea = Basic;
                Image = New;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Update Posting Date";
            }
            action("Get Users")
            {
                ApplicationArea = Basic;
                Image = New;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                trigger OnAction()
                var
                    User: Record User;
                    UserSetup: Record "User Setup";
                    USetup: Record "User Setup";
                    j: Integer;
                    GenBatch: Record "Gen. Journal Batch";
                    GenTemplate: Record "Gen. Journal Template";
                    Pos: Integer;
                    JTemplate: Code[10];
                    JBatch: Code[20];
                    AccName: Text;
                begin

                    if Confirm('Are you sure you want to Get All Users?') then begin
                        j := 0;

                        JTemplate := 'GENERAL';
                        if not GenTemplate.Get(JTemplate) then begin
                            GenTemplate.Init();
                            GenTemplate.Name := JTemplate;
                            GenTemplate.Type := GenTemplate.Type::General;
                            GenTemplate.Insert();
                        end;

                        JTemplate := 'PAYMENTS';
                        if not GenTemplate.Get(JTemplate) then begin
                            GenTemplate.Init();
                            GenTemplate.Name := JTemplate;
                            GenTemplate.Type := GenTemplate.Type::Payments;
                            GenTemplate.Insert();
                        end;

                        JTemplate := 'RECEIPTS';
                        if not GenTemplate.Get(JTemplate) then begin
                            GenTemplate.Init();
                            GenTemplate.Name := JTemplate;
                            GenTemplate.Type := GenTemplate.Type::"Cash Receipts";
                            GenTemplate.Insert();
                        end;

                        User.Reset();
                        if User.FindFirst() then begin
                            repeat
                                if not UserSetup.Get(User."User Name") then begin
                                    UserSetup.Init();
                                    UserSetup.Validate("User ID", User."User Name");


                                    Pos := StrPos(UserSetup."User ID", '\');

                                    if Pos > 1 then begin
                                        AccName := CopyStr(UserSetup."User ID", Pos + 1, StrLen(UserSetup."User ID"));
                                        Pos := StrPos(AccName, '.');
                                        if Pos > 1 then begin
                                            AccName := CopyStr(AccName, Pos + 1, StrLen(AccName));
                                            GenBatch.Reset();
                                            GenBatch.SetRange(Name, AccName);
                                            IF GenBatch.FindFirst() THEN begin
                                                AccName := CopyStr(AccName, 1, Pos - 1);
                                                JBatch := AccName;
                                            end;
                                        end
                                        else begin

                                            JBatch := AccName;
                                        end;
                                    end
                                    ELSE begin
                                        JBatch := UserSetup."User ID";
                                    end;

                                    USetup.Reset();
                                    USetup.SetRange("General Journal Batch", JBatch);
                                    if not USetup.FindFirst() then begin

                                        JTemplate := 'GENERAL';

                                        if not GenBatch.Get(JTemplate, JBatch) then begin
                                            GenBatch.Init();
                                            GenBatch."Journal Template Name" := JTemplate;
                                            GenBatch.Name := JBatch;
                                            GenBatch.Insert();
                                        end;

                                        UserSetup."General Journal Template" := JTemplate;
                                        UserSetup."General Journal Batch" := JBatch;
                                        JTemplate := 'PAYMENTS';

                                        if not GenBatch.Get(JTemplate, JBatch) then begin
                                            GenBatch.Init();
                                            GenBatch."Journal Template Name" := JTemplate;
                                            GenBatch.Name := JBatch;
                                            GenBatch.Insert();
                                        end;
                                        UserSetup."General Journal Template" := JTemplate;
                                        UserSetup."General Journal Batch" := JBatch;
                                        JTemplate := 'RECEIPTS';

                                        if not GenBatch.Get(JTemplate, JBatch) then begin
                                            GenBatch.Init();
                                            GenBatch."Journal Template Name" := JTemplate;
                                            GenBatch.Name := JBatch;
                                            GenBatch.Insert();
                                        end;
                                        UserSetup."General Journal Template" := JTemplate;
                                        UserSetup."General Journal Batch" := JBatch;

                                    end;

                                    UserSetup.Insert(true);
                                    j += 1;


                                end;
                            until User.Next() = 0;
                        end;
                        Message('%1 Account(s) Created', j);
                    end;

                end;
            }
            action(Dimensions)
            {
                AccessByPermission = TableData Dimension = R;
                ApplicationArea = Dimensions;
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Alt+D';
                ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                trigger OnAction()
                begin
                    Rec.ShowDimensions();
                    CurrPage.SaveRecord();
                end;
            }
        }

    }

    trigger OnOpenPage()
    begin
        RestrictAccess
    end;

    trigger OnModifyRecord(): Boolean
    begin
        RequireEditUserSetupPermission();
        exit(true);
    end;


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange("Administration Setups", true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Administration Setups"');
    end;

    local procedure RequireEditUserSetupPermission()
    var
        StatusChangePermissions: Record "Status Change Permissions";
    begin
        StatusChangePermissions.Reset();
        StatusChangePermissions.SetRange("User ID", UserId);
        StatusChangePermissions.SetRange("Edit User SetUp", true);
        if not StatusChangePermissions.FindFirst() then
            Error('You do not have the following permission: "Edit User SetUp"');
    end;

    var
        UserSetup: Record "User Setup";


}

