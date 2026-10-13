
Page 50187 "Member List"
{
    ApplicationArea = Basic;
    CardPageID = "Member Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Members;
    SourceTableView = where(Type = const(Member));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    LookupPageId = "Member Listing";
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    Editable = false;
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(RegistrationDate; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
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
                field(OldMemberNo; Rec."Old Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Member Category"; Rec."Member Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("From Another Sacco"; Rec."From Another Sacco")
                {
                    ApplicationArea = Basic;
                }
                field(DateofBirth; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
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
                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
                field(TestNo; Rec."Test No")
                {
                    ApplicationArea = Basic;
                }
                field(RelationshipOfficer; Rec."Relationship Officer")
                {
                    ApplicationArea = Basic;
                }
                field(RelationshipOfficerName; Rec."Relationship Officer Name")
                {
                    ApplicationArea = Basic;
                }
                field(MemberStatus; Rec."Member Status")
                {
                    ApplicationArea = Basic;
                }
                field("Member Tier"; Rec."Member Tier")
                {
                    ApplicationArea = Basic;
                }
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
                Visible = not hideStats;
            }
            part(Control57; "Member Loan Statictics")
            {
                ApplicationArea = All;
                SubPageLink = "Member No." = field("No.");
                Visible = not hideStats;
            }

            part(Control59; "Info Base")
            {
                ApplicationArea = All;
                SubPageLink = "Member No." = field("No.");
                Visible = not hideStats;
            }

        }
    }




    actions
    {
        area(navigation)
        {
            /*group(Transactions)
            {
                Caption = 'Update Customers';
                action(AssignEarningDeductions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Update Customers';
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible=false;

                    trigger OnAction()
                    var
                        Text000: label '@1@@@@@@@@@@@@@@@@@@@@@';
                        Cust: Record Members;
                        Legacy: Codeunit Legacy;
                        ProgressWindow: Dialog;
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust.Type, Cust.Type::" ");
                        if Cust.Find('-') then begin
                            ProgressWindow.Open('Updating Customers #1#################################################################');
                            repeat
                                ProgressWindow.Update(1, Cust."No." + ':' + Cust."First Name");
                                Legacy.GetRandomCustomerData(Cust."First Name", Cust.Surname, cust."ID No.");
                                Cust.Name := Cust."First Name" + Cust.Surname;
                                Cust.Modify();
                                Commit();
                            until Cust.Next = 0;
                            Commit;
                            ProgressWindow.Close;
                        end;

                        Commit;

                    end;
                }
            }
            */
        }
    }




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

        hideStats := false;
        Setup.Get();
        MemberActivities.ShowMemberInfo(Rec."No.");

        AvailableGuarantorship := (MemberActivities.GetAccountBalance(Legacy.GetDepositAccounts(Rec."No."))) - (MemberActivities.GetMemberCommittedDeposits(Legacy.GetDepositAccounts(Rec."No."), true) + MemberActivities.GetSelfGuaranteeCommitment(Legacy.GetDepositAccounts(Rec."No."), true));
        if AvailableGuarantorship < 0 then
            AvailableGuarantorship := 0;

        if not UserSetup.Get(UserId) then
            hideStats := true;


        if (Rec."Member Category" in [Rec."Member Category"::"Staff Members", Rec."Member Category"::"Board Members"]) then begin

            if Rec."Payroll/Staff No." = UserSetup."Staff No" then
                exit;

            if not UserSetup."View Staff Accounts" then
                hideStats := true;
        end;

        if Rec."Member Category" = Rec."Member Category"::"Board Members" then begin
            if not UserSetup."View Board Accounts" then
                hideStats := true;
        end;


        Logs.Reset();
        Logs.SetFilter("Member No.", Rec."No.");
        if Logs.findlast() then begin
            FileLocation := Logs."Current Location";
            FileLocationUser := Logs."Current User";

        end;
    end;

    var
        hideStats: Boolean;
        Members: Record Members;
        Loans: Record Loans;
        MemberAccounts: Record "Savings Accounts";
        UserSetup: Record "User Setup";
        FileLocation: Code[50];
        FileLocationUser: Code[50];
        AvailableGuarantorship: Decimal;
        MemberAge: Integer;




}

