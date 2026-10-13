
page 50779 "Business Card"
{
    ApplicationArea = All;

    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    Caption = 'Business Card';
    SourceTable = Members;
    SourceTableView = where(Type = const(Group));
    // PromotedActionCategories = 'New,Process,Report,Exempt SMS,Group';
    PromotedActionCategories = 'New,Process,Report,Picture & Signature,Account Signatories & NOK, Member Accounts & Loans, Monthly Contribution,Others,Portal,Unblock Accounts';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    Importance = Promoted;
                    ShowMandatory = true;
                }

                field(FileLocation; FileLocation)
                {
                    ApplicationArea = Basic;
                }
                field(FileLocationUser; FileLocationUser)
                {
                }
                field(GroupCategory; Rec."Group Category")
                {
                    ApplicationArea = Basic;
                }
                group("Non-Incorporated")
                {
                    Visible = NonIncorporatedEdit;
                    field(GroupType; Rec."Group Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Other Type Of Group"; Rec."Other Type Of Business")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Date of Group Reg."; Rec."Date of Bus. Reg.")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Group Physical Location"; Rec."Business/Group Location")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Group Plot/Bldg/Street/Road"; Rec."Plot/Bldg/Street/Road")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(Incorporated)
                {
                    Visible = IncorporatedEdit;
                    field(TypeofBusiness; Rec."Type of Business")
                    {
                        ApplicationArea = Basic;
                    }
                    field(OtherTypeOfBusiness; Rec."Other Type Of Business")
                    {
                        ApplicationArea = Basic;
                    }
                    field(BusinessRegNo; Rec."Business Reg. No.")
                    {
                        ApplicationArea = Basic;
                    }
                    field(IncorporationNo; Rec."Incorporation No.")
                    {
                        ApplicationArea = Basic;
                    }
                    field(DateofBusReg; Rec."Date of Bus. Reg.")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Business Physical Location"; Rec."Business/Group Location")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Business Plot/Bldg/Street/Road"; Rec."Plot/Bldg/Street/Road")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field(KRAPIN; Rec."KRA PIN")
                {
                    ApplicationArea = Basic;
                }
                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Business Reg. No."; Rec."Business Reg. No.")
                {
                    Caption = 'Certificate No.';
                    ApplicationArea = Basic;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                group(Address)
                {
                    Caption = 'Address';
                    field(PostCode; Rec."Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("P.O. Box"; Rec.Address)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'P.O. Box';
                        ToolTip = 'Specifies the contact''s address.';
                    }
                    field("Physical Address"; Rec."Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Physical Address';
                        ToolTip = 'Specifies additional address information.';
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the city where the contact is located.';
                    }
                    field(CountryRegionCode; Rec."Country/Region Code")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the country/region of the address.';
                    }
                }
                group(ContactDetails)
                {
                    Caption = 'Contact';
                    field(PhoneNo; Rec."Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the contact''s phone number.';
                    }
                    field(MobilePhoneNo; Rec."Mobile Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the contact''s mobile telephone number.';
                    }
                    field(EMail; Rec."E-Mail")
                    {
                        ApplicationArea = Basic, Suite;
                        ExtendedDatatype = EMail;
                        Importance = Promoted;
                        ToolTip = 'Specifies the email address of the contact.';
                    }
                }
            }

            group("Other Information")
            {

                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field(RelationshipOfficer; Rec."Relationship Officer")
                {
                    ApplicationArea = Basic;
                }
                field(RelationshipOfficerName; Rec."Relationship Officer Name")
                {
                    ApplicationArea = Basic;
                }
                field(BranchManager; Rec."Branch Manager")
                {
                    ApplicationArea = Basic;
                }
                field(BranchManagerName; Rec."Branch Manager Name")
                {
                    ApplicationArea = Basic;
                }
                field(RecruitedbyType; Rec."Recruited by Type")
                {
                    ApplicationArea = Basic;
                }
                field(RecruitedBy; Rec."Recruited By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recruited By';
                }
                field(RecruitedByName; Rec."Recruited By Name")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Bank Details")
            {
                field(BankCode; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field(BranchCode; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field(BankAccountNo; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control47; "Picture & Signature")
            {
                SubPageLink = "Member No." = field("No.");
            }
            part(Control56; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
            part(Control57; "Member Loan Statictics")
            {
                SubPageLink = "Member No." = field("No.");
            }

            part(Control58; "Member Details FactBox")
            {
                Caption = 'Group Picture Factbox';
                SubPageLink = "Member No." = field("No.");
            }
        }
    }

    actions
    {

        area(navigation)
        {

            group(All)
            {
                action("Reset File Location")
                {
                    ApplicationArea = Basic;
                    Image = Absence;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category8;

                    trigger OnAction()
                    var
                        Log: record "File Movement Log";
                        UserSetup: Record "User Setup";
                    begin

                        UserSetup.Reset();
                        UserSetup.SetRange("Reset File Movement", true);
                        UserSetup.SetRange("User ID", UserId);
                        if not UserSetup.FindFirst() then
                            Error('You do not have the right to reset file movement');


                        UserSetup.Reset();
                        UserSetup.SetRange("File Movement Admin", true);
                        if UserSetup.FindFirst() then begin
                            UserSetup.TestField("File Movement Group");


                            Log.Reset();
                            Log.SetFilter("Member No.", Rec."No.");
                            if Log.findlast() then begin
                                Log."Date Returned" := today;
                                Log.Modify();

                                Log.Init();
                                Log."Line No." := 0;
                                Log."Member No." := Rec."No.";
                                Log."Member Name" := Rec.Name;
                                Log."Source Location" := '';
                                Log."Source Name" := '';
                                Log."Source User" := '';
                                Log."Current Location" := UserSetup."File Movement Group";
                                Log."Current Name" := UserSetup."File Movement Group";
                                Log."Current User" := UserSetup."User ID";
                                Log."Movement Date" := Today;
                                Log."File Movement Reference" := Rec."No.";
                                Log."Entry Type" := Log."Entry Type"::" ";
                                Log."Date Returned" := Today;

                                Log.Insert();
                                Message('File Returned to Registry');

                            end
                            else begin

                                Log.Init();
                                Log."Line No." := 0;
                                Log."Member No." := Rec."No.";
                                Log."Member Name" := Rec.Name;
                                Log."Source Location" := '';
                                Log."Source Name" := '';
                                Log."Source User" := '';
                                Log."Current Location" := UserSetup."File Movement Group";
                                Log."Current Name" := UserSetup."File Movement Group";
                                Log."Current User" := UserSetup."User ID";
                                Log."Movement Date" := Today;
                                Log."File Movement Reference" := Rec."No.";
                                Log."Entry Type" := Log."Entry Type"::" ";
                                Log."Date Returned" := Today;

                                Log.Insert();
                                Message('File Added to Registry');
                            end;
                        end
                        else begin
                            Error('File Admin Not Set Up');
                        end;
                    end;
                }


                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Image = NewLotProperties;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Next of Kin";
                    RunPageLink = "No." = field("No.");
                }
                action("Group Accounts")
                {
                    ApplicationArea = Basic;
                    Image = Account;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Member Accounts List";
                    RunPageLink = "Member No." = field("No.");
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Image = NewSparkle;
                    promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Account Signatory List";
                    RunPageLink = Code = field("No.");
                }
                action("Group Members")
                {
                    ApplicationArea = Basic;
                    Image = JobLines;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Member List";
                    RunPageLink = "Group No." = field("No.");
                }
                action("Registration Form")
                {
                    ApplicationArea = Basic;
                    Image = Link;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    Visible = false;
                    trigger OnAction()
                    begin
                        Rec.SetFilter("No.", Rec."No.");
                        Report.Run(Report::"Online Membership Application", false, true, rec);
                    end;
                }
                action("MFI CSR Report")
                {
                    ApplicationArea = Basic;
                    Image = NewBranch;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    visible = false;

                    trigger OnAction()
                    begin
                        Members.Reset;
                        Members.SetRange("No.", Rec."No.");
                        if Members.FindFirst then
                            Report.Run(Report::"MFI Report", true, false, Members);
                    end;
                }
                action("Group Status Report")
                {
                    ApplicationArea = Basic;
                    Image = NewBranch;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Members.Reset;
                        Members.SetRange("No.", Rec."No.");
                        if Members.FindFirst then
                            Report.Run(50138, true, false, Members);
                    end;
                }

                action("Counter Service Statement")
                {
                    ApplicationArea = Basic;
                    Image = PurchaseTaxStatement;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Members.Reset;
                        Members.SetRange("No.", Rec."No.");
                        if Members.FindFirst then
                            Report.Run(Report::"Counter Service Statement", true, false, Members);
                    end;
                }
                action("Group Schedule Report")
                {
                    ApplicationArea = Basic;
                    Image = MapDimensions;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Members.Reset;
                        Members.SetRange("No.", Rec."No.");
                        if Members.FindFirst then
                            Report.Run(50139, true, false, Members);
                    end;
                }
                action("Exempt SMS")
                {
                    ApplicationArea = Basic;
                    Image = Absence;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = category4;
                    RunObject = Page "Members SMS List";
                    RunPageLink = "Member No" = field("No.");

                    trigger OnAction()
                    begin
                        // UserSetup.RESET;
                        // UserSetup.SETRANGE("User ID",USERID);
                        // IF UserSetup.FIND('-') THEN BEGIN
                        /*  IF UserSetup.GET(USERID) THEN
                          IF  UserSetup."Disable SMS" <> TRUE THEN
                                 ERROR('You Are Not Permitted To Perform This Function, Kindly Contact System Admin....');
                       //END;
                         EXIT;
                       */

                    end;
                }
            }
            action("Member Accounts")
            {
                ApplicationArea = Basic;
                Image = Account;
                Promoted = true;
                PromotedCategory = category6;
                PromotedIsBig = true;
                RunObject = Page "Member Accounts List";
                RunPageLink = "Member No." = field("No.");
            }
            action("Member Loans")
            {
                ApplicationArea = Basic;
                Promoted = true;
                Image = EntryStatistics;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                RunObject = Page "Loans Statistics";
                RunPageLink = "Member No." = field("No.");
            }
            action("Nominee")
            {
                ApplicationArea = Basic;
                Image = NewLotProperties;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                RunObject = Page Nominee;
                RunPageLink = "No." = field("No.");
            }
            action("Info Base")
            {
                ApplicationArea = Basic;
                Image = Info;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Information Base";
                RunPageLink = "Member No." = field("No.");
            }

            action("Member Instruction")
            {
                ApplicationArea = Basic;
                Image = Info;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                RunObject = Page "Member Instruction";
                RunPageLink = "Member No." = field("No.");
            }

            action("Portal Uploads")
            {
                ApplicationArea = Basic;
                Image = Info;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                RunObject = Page "Portal Uploads";
                RunPageLink = "Member No." = field("No.");

            }
            action("Monthly Contibutions")
            {
                ApplicationArea = Basic;
                Image = NewToDo;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category7;
                RunObject = Page "Monthly Contributions";
                RunPageLink = "Member No." = field("No.");
            }
            action("Member Statistics")
            {
                ApplicationArea = Basic;
                Image = Absence;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category10;
                RunObject = Page "Member Statistics All";
                RunPageLink = "No." = field("No.");

            }



        }
        area(reporting)
        {

            action("Loan Balance Request")
            {
                ApplicationArea = Basic;
                Image = FinChargeMemo;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Loans: Record Loans;
                begin
                    Loans.Reset();
                    Loans.SetRange("Member No.", Rec."No.");
                    if Loans.FindFirst() then
                        Report.Run(Report::"Loan Balances Request", true, false, Loans);
                end;
            }
            action("Print Membership Card")
            {
                ApplicationArea = Basic;
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."No.");
                    if Members.FindFirst then
                        Report.Run(50189, true, false, Members);
                end;
            }

            action("OLD Member Statement")
            {
                ApplicationArea = Basic;
                Image = StyleSheet;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."No.");
                    if Members.FindFirst then
                        Report.Run(Report::"Old Detailed Member Statement", true, false, Members);
                end;
            }

            action("Member Statement")
            {
                ApplicationArea = Basic;
                Image = StyleSheet;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."No.");
                    if Members.FindFirst then
                        Report.Run(Report::"Detailed Member Statement", true, false, Members);
                end;
            }

            action("E-mail Member Statement")
            {
                ApplicationArea = Basic;
                Image = Email;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."No.");
                    if Members.FindFirst then
                        Report.Run(Report::"E-Mail Member Statement", true, false, Members);
                end;
            }
            action("Loan Guarantors")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."No.");
                    if Members.Find('-') then
                        Report.Run(50132, true, false, Members);
                end;
            }
            action("Loans Guaranteed")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."No.");
                    if Members.Find('-') then
                        Report.Run(50133, true, false, Members);
                end;
            }


            //Staff Pay Slip
            /*
                         action("Loan Balance Report")
                        {
                            ApplicationArea = Basic;
                            Image = "Report";
                            Promoted = true;
                            PromotedCategory = "Report";

                            trigger OnAction()
                            begin
                                Members.Reset;
                                Members.SetRange("No.", "No.");
                                if Members.Find('-') then
                                    Report.Run(50133, true, false, Members);
                            end;
                        }*/



            action("Create Portal Users")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = category9;

                trigger OnAction()
                var
                //CalwidePortal: Codeunit "Calwide Portal";
                begin
                    if Confirm('Are you sure you want to create this portal user') then begin
                        // CalwidePortal.CreatePortalUser(Rec."No.");
                    end;

                end;
            }
            action("Picture & Signature")
            {
                ApplicationArea = Basic;
                Image = Picture;
                Promoted = true;
                PromotedCategory = category4;

                trigger OnAction()
                var
                    ImageData: Record "Member Images";
                begin
                    ImageData.Reset;
                    ImageData.SetRange(ImageData."Member No.", Rec."No.");
                    if ImageData.Find('-') then begin
                        Page.Run(50252, ImageData);
                    end;
                end;
            }

            action("Update staff Nos")
            {
                ApplicationArea = Basic;
                Image = Picture;
                Promoted = true;
                PromotedCategory = category4;

                trigger OnAction()
                var
                    Emp: Record Customer;
                    Cust: Record Members;
                begin
                    Cust.Reset();
                    Cust.SetRange("Registration Date", DMY2Date(01, 12, 2022), Today);
                    if Cust.FindFirst() then begin
                        repeat
                            if Emp.Get(Cust."Employer Code") then begin
                                if Cust."Registration Date" >= DMY2Date(01, 12, 2022) then begin
                                    if Cust."Employer Code" <> '001' then
                                        if Cust."Employer Code" <> '002' then
                                            if not Emp."Employer Based Staff Nos" then begin
                                                if Cust."Payroll/Staff No." <> Cust."No." then begin
                                                    Cust."Payroll/Staff No." := Cust."No.";
                                                    Cust.Modify();
                                                    commit;
                                                end
                                            end;
                                end;
                            end;
                        until Cust.Next() = 0;
                        message('UPdates');
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        IncorporatedEdit: Boolean;
        NonIncorporatedEdit: Boolean;
        Members: Record Members;
        UserSetup: Record "User Setup";

    local procedure UpdateControls()
    begin
        NonIncorporatedEdit := false;
        IncorporatedEdit := false;

        if Rec."Group Category" = Rec."group category"::"Non-Incorporated" then begin
            NonIncorporatedEdit := true;
        end;
        if Rec."Group Category" = Rec."group category"::Incorporated then begin
            IncorporatedEdit := true;
        end;

        if UserSetup.Get(UserId) then begin
            if (Rec."Member Category" = Rec."Member Category"::"Staff Members") or (Rec."Member Category" = Rec."Member Category"::"Board Members") then begin
                if Rec."Payroll/Staff No." <> UserSetup."Staff No" then begin
                    if UserSetup."View Staff Accounts" = false then
                        Error('You Are Not SetUp to View Other Staff''s Accounts');
                end;
            end;
        end else
            Error('You Are Not SetUp As a User under User Setup');

        if UserSetup.Get(UserId) then begin
            if Rec."Member Category" = Rec."member category"::"Board Members" then begin
                if UserSetup."View Board Accounts" = false then
                    Error('You Are Not SetUp to View Board Members Accounts');
            end;

            if Rec."Special Account" then begin
                if UserSetup."View Special Accounts" = false then
                    Error('You Are Not SetUp to View Special Accounts');
            end;

        end else
            Error('You Are Not SetUp to View Board Members Accounts');

        Logs.Reset();
        Logs.SetFilter("Member No.", Rec."No.");
        if Logs.findlast() then begin
            FileLocation := Logs."Current Location";
            FileLocationUser := Logs."Current User";
        end;

    end;

    local procedure UpdateName()
    begin
        Rec.Name := '';

        if (Rec."First Name" <> '') then
            Rec.Name += Rec."First Name";

        if (Rec."Middle Name" <> '') then
            Rec.Name += ' ' + Rec."Middle Name";

        if (Rec.Surname <> '') then
            Rec.Name += ' ' + Rec.Surname;
    end;

    var

        FileLocation: Code[50];
        FileLocationUser: Code[50];
        AvailableGuarantorship: Decimal;
        Logs: Record "File Movement Log";
}

