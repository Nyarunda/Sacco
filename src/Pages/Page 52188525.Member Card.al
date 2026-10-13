
Page 50188 "Member Card"
{
    ApplicationArea = All;
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Members;
    SourceTableView = where(Type = const(Member));
    PromotedActionCategories = 'New,Process,Report,Picture & Signature,Nominee & NOK, Member Accounts & Loans, Monthly Contribution,Others,Portal,Member Statistics,EDMS';

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
                field(FirstName; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        UpdateName;
                    end;
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        UpdateName;
                    end;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        UpdateName;
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    Editable = false;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("Available Guarantorship"; AvailableGuarantorship)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    Editable = false;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("Block Guarantorship"; Rec."Block Guarantorship")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Block Mobile Loan"; Rec."Block Mobile Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Remit Checkoff"; Rec."Remit Checkoff")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field("Rejoined No."; Rec."Rejoined No.")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(SalutationCode; Rec."Salutation Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the salutation code that will be used when you interact with the contact. The salutation code is only used in Word documents. To see a list of the salutation codes already defined, click the field.';
                }
                field(OldMemberNo; Rec."Old Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                }
                field("From Another Sacco"; Rec."From Another Sacco")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("ID Expiry Date"; Rec."ID Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field(Age; MemberAge)
                {
                    Editable = false;
                    ApplicationArea = Basic;
                }

                field(Passport; Rec.Passport)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Passport Expiry Date"; Rec."Passport Expiry Date")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(DateofBirth; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        MemberAge := '';
                        if Rec."Date of Birth" <> 0D then
                            MemberAge := MemberRegister.GetAgeText(Rec."Date of Birth"); //Date2DMY(Today, 3) - Date2DMY(Rec."Date of Birth", 3);
                    end;
                }

                field(KRAPIN; Rec."KRA PIN")
                {
                    ApplicationArea = Basic;
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(MaritalStatus; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Self Employed"; Rec."Self Employed")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Employment Info"; Rec."Employment Info")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employment Information';
                }
                field("Employement Sector"; Rec."Employement Sector")
                {
                    ApplicationArea = Basic;
                    Caption = 'Business Type';
                }
                field(BusinessName; Rec."Business Name")
                {
                    ApplicationArea = Basic;


                }
                field("Business/Group Location"; Rec."Business/Group Location")
                {
                    ApplicationArea = Basic;
                    caption = 'Business Location';
                }

                field(EmployerCode; Rec."Employer Code")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        /*
                        //VALIDATE("Self Employed");
                        Customer.GET("Employer Code");
                        IF ((Customer."Self Employed"=TRUE) OR (Status<>Status::Open))THEN
                          Empstatus:=FALSE ELSE Empstatus:=TRUE;
                          "Payroll/Staff No.":='';
                        "Terms of Employment":="Terms of Employment"::" ";
                        "Appointment Date":=0D;
                        */

                    end;
                }
                field(EmployerName; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Checkoff Station"; Rec."Checkoff Station")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }

                field(TermsofEmployment; Rec."Terms of Employment")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Employment Section"; Rec."Employment Section")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(PayrollStaffNo; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic;

                }
                field("Old Payroll No."; Rec."Old Payroll No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Visible = false;

                }
                field(MemberCategory; Rec."Member Category")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Reference code"; Rec."Reference code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment Reference Code';
                }
                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Manager"; Rec."Account Manager")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MemberStatus; Rec."Member Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

            }
            group("Micro Credit")
            {
                Visible = false;
                field("Group No."; Rec."Group No.")
                {
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
                    field(MobilePhoneNo; Rec."Mobile Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        ExtendedDatatype = PhoneNo;
                        ToolTip = 'Specifies the contact''s mobile telephone number.';
                    }
                    field(PhoneNo; Rec."Phone No.")
                    {
                        Caption = 'Alternative Mobile No.';
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the contact''s phone number.';
                    }
                    field(EMail; Rec."E-Mail")
                    {
                        ApplicationArea = Basic, Suite;
                        ExtendedDatatype = EMail;
                        Importance = Promoted;
                        ToolTip = 'Specifies the email address of the contact.';
                    }
                    field(WorkMail; Rec."Work E-Mail")
                    {
                        ApplicationArea = Basic, Suite;
                        ExtendedDatatype = EMail;
                        Importance = Promoted;
                        ToolTip = 'Specifies the email address of the contact.';
                    }
                    field("Exempt Send SMS"; Rec."Exempt Send SMS")
                    {
                        ApplicationArea = Basic;
                        ToolTip = 'Specifies whether the member is exempted from receiving SMS messages.';
                    }
                    field("Exempt Send Email"; Rec."Exempt Send Email")
                    {
                        ApplicationArea = Basic;
                        ToolTip = 'Specifies whether the member is exempted from receiving emails.';
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
                field("Member Electoral Zone"; Rec."Member Electoral Zone")
                {
                    ApplicationArea = Basic;
                }
                field("Member Class"; Rec."Member Class")
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
                field(BankName; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field(BranchCode; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field(BranchName; Rec."Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field(BankAccountNo; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Swift Code"; Rec."Swift Code")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Member Change Log"; "Member Change Log")
            {
                ApplicationArea = All;
                SubPageLink = "Member No." = field("No.");
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Member Registration"),
                              "No." = field("No."),
                              "Document Type" = field("Document Type");
            }
            part(Control56; "Member Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            part(Control57; "Member Loan Statictics")
            {
                ApplicationArea = All;
                SubPageLink = "Member No." = field("No.");
            }

            part(Control59; "Info Base")
            {
                ApplicationArea = All;
                SubPageLink = "Member No." = field("No.");
            }
            part(Control58; "Member Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Member No." = field("No.");
            }

        }
    }

    actions
    {
        area(navigation)
        {

            action("Attachment")
            {
                ApplicationArea = Basic;
                Image = Link;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    DMSint: Record "DMS Endpoints";
                begin

                    DMSint.RESET;
                    DMSint.SETRANGE(DMSint."Link Type", DMSint."Link Type"::MemberApp);
                    IF DMSint.FIND('-') THEN BEGIN
                        HYPERLINK(DMSint."Path" + Rec."No.");
                    END;
                end;
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
            action("Member Collateral")
            {
                ApplicationArea = Basic;
                Promoted = true;
                Image = Line;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                RunObject = Page "Member Collateral";
                RunPageLink = "Account No." = field("No.");
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
            action("Account Signatories")
            {
                ApplicationArea = Basic;
                Image = NewSparkle;
                Promoted = true;
                Caption = 'Can Transact';
                PromotedCategory = Category5;
                PromotedIsBig = true;
                RunObject = Page "Account Signatories";
                RunPageLink = Code = field("No.");
            }
            action("Authorized Members")
            {
                ApplicationArea = Basic;
                Image = NewSparkle;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Visible = false;
                RunObject = Page "Authorized Members";
                RunPageLink = Code = field("No.");
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
            action("Reset File Location")
            {
                ApplicationArea = Basic;
                Image = Absence;
                Promoted = true;
                PromotedIsBig = true;
                visible = false;
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
            action("Member SMS")
            {
                ApplicationArea = Basic;
                Image = LotInfo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SMSMessage: Record "SMS Messages";
                    PhoneFilter: Text;
                begin
                    Rec.TestField("Mobile Phone No.");

                    PhoneFilter := GetMemberSmsPhoneFilter(Rec."Mobile Phone No.");
                    SMSMessage.Reset();
                    SMSMessage.SetFilter("Mobile Phone No.", PhoneFilter);
                    Page.Run(Page::"SMS Messages", SMSMessage);
                end;
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
            action("Portal Chats")
            {
                ApplicationArea = Basic;
                Image = Info;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                RunObject = Page "Portal Chats";
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
            action("Member Instruction")
            {
                ApplicationArea = Basic;
                Caption = 'Dividend Instructions';
                Image = Info;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                RunObject = Page "Member Instruction";
                RunPageLink = "Member No." = field("No.");
            }
            action("Member Documents")
            {
                ApplicationArea = Basic;
                Image = Info;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                Visible = false;
                RunObject = Page "Member Documents";
                RunPageLink = "Reference No." = field("No.");
            }
            action("Witness Details")
            {
                ApplicationArea = Basic;
                Image = Link;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                RunObject = Page "Loan Witness Part";
                RunPageLink = "Member No." = field("No.");
            }
            action("Exempt SMS")
            {
                ApplicationArea = Basic;
                Image = Absence;
                Promoted = true;
                Visible = false;
                PromotedIsBig = true;
                PromotedCategory = Category7;
                RunObject = Page "Members SMS List";
                RunPageLink = "Member No" = field("No.");

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
            action("Loan Graduation Score")
            {
                ApplicationArea = All;
                Image = Statistics;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category10;
                RunObject = Page "Loan Graduation Score List";
                RunPageLink = "Member No" = field("No.");
            }
            action("Get Member Documents")
            {
                ApplicationArea = Basic;
                Image = Documents;
                Promoted = true;
                PromotedCategory = Category11;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Cust: Record Members;
                    MembNo: Code[20];
                    URL: Text;
                begin
                    Cust.Reset();
                    if Rec."Old Member No." <> '' then
                        Cust.SetRange("Old Member No.", Rec."Old Member No.")
                    else
                        Cust.SetRange("No.", Rec."No.");
                    if Cust.FindFirst() then begin
                        MembNo := Cust."Old Member No.";
                        if MembNo = '' then
                            MembNo := Cust."No.";
                        URL := 'http://192.168.1.129:81/edms/Query?op=m&name=qrymemberfile&MEMBER_NUMBER=' + MembNo;
                        Hyperlink(URL);
                    end;
                end;
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
                        Report.Run(Report::"Membership Card", true, false, Members);
                end;
            }
            action("Acceptance Letter")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."No.");
                    if Members.FindFirst then
                        Report.Run(Report::MembershipAcceptanceLetter, true, false, Members);
                end;
            }
            action("Member Referees")
            {
                ApplicationArea = Basic;
                Image = RefreshVoucher;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."No.");
                    if Members.FindFirst then
                        Report.Run(Report::"Member Referees", true, false, Members);
                end;
            }
            action("OLD Member Statement")
            {
                ApplicationArea = Basic;
                Image = StyleSheet;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."No.");
                    //if Members.FindFirst then
                    //   Report.Run(Report::"Old Detailed Member Statement", true, false, Members);
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
            action("Member Loans Statement")
            {
                ApplicationArea = Basic;
                Image = StyleSheet;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Loans.Reset;
                    Loans.SetRange("Member No.", Rec."No.");
                    if Loans.FindFirst then
                        Report.Run(Report::"Loan Statement", true, false, Loans);
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
            action("Summary Member Statement")
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
                        Report.Run(Report::"Summary Member Statement", true, false, Members);
                end;
            }
            action(DividendSlip)
            {
                ApplicationArea = Basic;
                Image = StyleSheet;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Members: Record Members;
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."No.");
                    if Members.FindFirst then
                        Report.Run(Report::"Dividends Progression", true, false, Members);
                end;

            }
            action("Member Loans Qualification")
            {
                ApplicationArea = Basic;
                Image = QualificationOverview;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."No.");
                    if Members.FindFirst then
                        Report.Run(Report::"Member Loans Quaifications", true, false, Members);
                end;
            }
            action("Board P9")
            {
                ApplicationArea = Basic;
                Image = StyleSheet;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Enabled = Rec."Member Category" = Rec."Member Category"::"Board Members";

                trigger OnAction()
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."No.");
                    if Members.FindFirst then
                        Report.Run(Report::"P9 Report - Board", true, false, Members);
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
                        Report.Run(Report::"Loan Guarantors Reports", true, false, Members);
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
                        Report.Run(Report::"Loan Guaranteed", true, false, Members);
                end;
            }
            action("Loan Schedule Report")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;

                trigger OnAction()
                Var
                    LoanRec: Record Loans;
                    MemberLoans: Record Loans;
                begin

                    LoanRec.Reset;
                    LoanRec.SetRange("Member No.", Rec."Member No.");
                    LoanRec.SetFilter("Outstanding Principal", '>0');
                    if LoanRec.FindFirst then begin
                        MemberLoans.Reset();
                        MemberLoans.SetRange("Loan No.", LoanRec."Loan No.");
                        Report.Run(Report::"Loan Repay Schedule Full Date", true, false, MemberLoans);
                    end;

                end;
            }
            action("Unblock Accounts")
            {
                ApplicationArea = Basic;
                Promoted = true;
                Visible = false;
                PromotedCategory = category9;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to unblock all accounts') then begin
                        MemberAccounts.Reset;
                        MemberAccounts.SetRange("Member No.", Rec."No.");
                        if MemberAccounts.FindFirst then begin
                            MemberAccounts.ModifyAll(Blocked, MemberAccounts.Blocked::" ");
                            MemberAccounts.ModifyAll(Status, MemberAccounts.Status::Active);
                            Rec."Member Status" := Rec."Member Status"::Active;
                            Rec.Modify;
                            Message('Updated');
                        end;
                    end;
                end;
            }
            action("Create Portal Users")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = category9;
                Visible = true;

                trigger OnAction()
                var
                // CalwidePortal: Codeunit "Calwide Portal";
                begin
                    if Confirm('Are you sure you want to create this portal user') then begin
                        // CalwidePortal.CreatePortalUser(REc."No.");
                    end;

                end;
            }
            action("Get Profile")
            {
                ApplicationArea = Basic;
                Promoted = true;
                Visible = false;
                PromotedCategory = category9;

                trigger OnAction()
                var
                //CalwidePortal: Codeunit "Calwide Portal";
                begin
                    if Confirm('Are you sure you want to get user profile') then begin
                        //message(CalwidePortal.GetMemberProfile(Rec."No.", ''));
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
                        Page.Run(page::"Picture & Signature", ImageData);
                    end;
                end;
            }
            action("Member Instructions -Checkoff")
            {
                ApplicationArea = Basic;

                Caption = 'Member Instructions - Checkoff';
                Image = MakeOrder;
                Visible = false;
                Promoted = true;
                PromotedCategory = category7;
                RunObject = Page "Member Instruction - Checkoff";
                RunPageLink = "Member No." = field("No.");
            }
            action("Member Instructions -Receipts")
            {
                ApplicationArea = Basic;

                Caption = 'Member Instructions - Receipts';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = category7;
                RunObject = Page "Member Instruction - Receipts";
                RunPageLink = "Member No." = field("No.");
            }
            action("Update staff Nos")
            {
                ApplicationArea = Basic;
                Image = Picture;
                Promoted = true;
                Visible = false;
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

    trigger OnOpenPage()
    var

    begin
        Updatefields();
    end;

    trigger OnAfterGetCurrRecord()
    var
        Logs: Record "File Movement Log";
        MemberActivities: Codeunit "Member Activities";
        Savings: Record "Savings Accounts";
        Legacy: Codeunit Legacy;
        Setup: Record "Sacco Setup";
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Committed: Decimal;
        Deposits: Decimal;
        LoanSecurity: Record "Loan Security";
    begin

        Updatefields();
        Setup.Get();
        MemberActivities.ShowMemberInfo(Rec."No.");

        AvailableGuarantorship := (MemberActivities.GetAccountBalance(Legacy.GetDepositAccounts(Rec."No."))) - (MemberActivities.GetMemberCommittedDeposits(Legacy.GetDepositAccounts(Rec."No."), true) + MemberActivities.GetSelfGuaranteeCommitment(Legacy.GetDepositAccounts(Rec."No."), true));
        if AvailableGuarantorship < 0 then
            AvailableGuarantorship := 0;

        if not UserSetup.Get(UserId) then
            Error('You Are Not SetUp As a User under User Setup');


        if (Rec."Member Category" in [Rec."Member Category"::"Staff Members", Rec."Member Category"::"Board Members"]) then begin

            if Rec."Payroll/Staff No." = UserSetup."Staff No" then
                exit;

            if not UserSetup."View Staff Accounts" then
                Error('You Are Not SetUp to View Other Staff''s Accounts');
        end;

        if Rec."Member Category" = Rec."Member Category"::"Board Members" then begin
            if not UserSetup."View Board Accounts" then
                Error('You are not authorized to view board member accounts');
        end;


        Logs.Reset();
        Logs.SetFilter("Member No.", Rec."No.");
        if Logs.findlast() then begin
            FileLocation := Logs."Current Location";
            FileLocationUser := Logs."Current User";

        end;
    end;

    var
        Members: Record Members;
        Loans: Record Loans;
        MemberAccounts: Record "Savings Accounts";
        UserSetup: Record "User Setup";
        FileLocation: Code[50];
        FileLocationUser: Code[50];
        AvailableGuarantorship: Decimal;
        MemberRegister: Record "Member Registration";
        MemberAge: Text[30];

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

    local procedure Updatefields()
    begin
        MemberAge := '';
        if Rec."Date of Birth" <> 0D then
            MemberAge := MemberRegister.GetAgeText(Rec."Date of Birth"); //Date2DMY(Today, 3) - Date2DMY(Rec."Date of Birth", 3);
    end;

    local procedure GetMemberSmsPhoneFilter(MobilePhoneNo: Text): Text
    var
        CleanPhoneNo: Text;
        LocalPhoneNo: Text;
        InternationalPhoneNo: Text;
        PhoneFilter: Text;
    begin
        CleanPhoneNo := DelChr(MobilePhoneNo, '=', ' +()-');

        if CopyStr(CleanPhoneNo, 1, 3) = '254' then begin
            InternationalPhoneNo := CleanPhoneNo;
            LocalPhoneNo := '0' + CopyStr(CleanPhoneNo, 4);
        end else
            if CopyStr(CleanPhoneNo, 1, 1) = '0' then begin
                LocalPhoneNo := CleanPhoneNo;
                InternationalPhoneNo := '254' + CopyStr(CleanPhoneNo, 2);
            end else
                if CopyStr(CleanPhoneNo, 1, 1) = '7' then begin
                    LocalPhoneNo := '0' + CleanPhoneNo;
                    InternationalPhoneNo := '254' + CleanPhoneNo;
                end else begin
                    LocalPhoneNo := CleanPhoneNo;
                    InternationalPhoneNo := CleanPhoneNo;
                end;

        AddPhoneNoToFilter(PhoneFilter, MobilePhoneNo);
        AddPhoneNoToFilter(PhoneFilter, LocalPhoneNo);
        AddPhoneNoToFilter(PhoneFilter, InternationalPhoneNo);
        AddPhoneNoToFilter(PhoneFilter, '+' + InternationalPhoneNo);

        exit(PhoneFilter);
    end;

    local procedure AddPhoneNoToFilter(var PhoneFilter: Text; PhoneNo: Text)
    begin
        PhoneNo := DelChr(PhoneNo, '=', ' ');
        if PhoneNo = '' then
            exit;

        if StrPos('|' + PhoneFilter + '|', '|' + PhoneNo + '|') > 0 then
            exit;

        if PhoneFilter <> '' then
            PhoneFilter += '|';

        PhoneFilter += PhoneNo;
    end;

}
