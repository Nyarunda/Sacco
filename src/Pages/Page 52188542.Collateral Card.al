
Page 50205 "Collateral Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Loan Collateral Register";
    PromotedActionCategories = 'New,Process,Report,Approval Requests,Collateral History,Prequilified Suppliers';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PEditable;
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;

                    LookupPageID = "Member Listing";
                }
                field(AccountName; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralType; Rec."Collateral Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        UpdateActions;
                    end;
                }
                field(Collateral; Rec.Collateral)
                {
                    Caption = 'Collateral Classification';
                    ApplicationArea = Basic;
                }
                field(CollateralName; Rec."Collateral Name")
                {
                    Caption = 'Classification Type';
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        UpdateDescription;
                    end;
                }
                field("Third-party Collateral"; Rec."Third-party Collateral")
                {
                    ApplicationArea = Basic;
                }
                group("Third-party Collateral Details")
                {
                    Visible = Rec."Third-party Collateral";
                    Caption = 'Third-party Collateral Details';
                    field("Mobile No."; Rec."Mobile No.")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Email; Rec.Email)
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Cash Conversion Period"; Rec."Cash Conversion Period")
                {
                    Caption = 'Cash Conversion Period';
                    ApplicationArea = Basic;
                    Visible = false;
                }
                /*field(VehicleClass;Rec."Vehicle Class")
                {
                    ApplicationArea = Basic;
                }
                field("Vehicle Reg. No.";"Vehicle Reg. No.")
                {
                    ApplicationArea = Basic;
                }
                field("Plot Location";"Plot Location")
                {
                    ApplicationArea = Basic;
                }
                field("Plot No.";"Plot No.")
                {
                    ApplicationArea = Basic;
                }*/
                field("Serial No."; Rec."Serial No.")
                {
                    Caption = 'Engine No.';
                    ApplicationArea = Basic;
                    Enabled = Rec."Collateral Type" = Rec."Collateral Type"::"Motor Vehicle";
                    ShowMandatory = Rec."Collateral Type" = Rec."Collateral Type"::"Motor Vehicle";
                }
                field("Year of Purchase"; Rec."Year of Purchase")
                {
                    ApplicationArea = Basic;
                    Enabled = Rec."Collateral Type" = Rec."Collateral Type"::"Motor Vehicle";
                    ShowMandatory = Rec."Collateral Type" = Rec."Collateral Type"::"Motor Vehicle";
                }

                field(CollateralDescription; Rec."Collateral Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Chasis No."; Rec."Chasis No.")
                {
                    ApplicationArea = Basic;
                    Editable = secVehicle;
                    Enabled = Rec."Collateral Type" = Rec."Collateral Type"::"Motor Vehicle";
                    ShowMandatory = Rec."Collateral Type" = Rec."Collateral Type"::"Motor Vehicle";
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralMultiplier; Rec."Collateral Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralValue; Rec."Collateral Value")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralLimit; Rec."Collateral Limit")
                {
                    ApplicationArea = Basic;
                }
                field(ChargedValue; Rec."Charged Value")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralDetails; Rec."Collateral Details")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(ValuationType; Rec."Valuation Type")
                {
                    ApplicationArea = Basic;
                }
                field(RegisteredOwner; Rec."Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field(InwardOutward; Rec."Inward/Outward")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LastValuationDate; Rec."Last Valuation Date")
                {
                    ApplicationArea = Basic;
                }
                field(ForcedSaleValue; Rec."Forced Sale Value")
                {
                    ApplicationArea = Basic;
                }
                field(CollateralPerfected; Rec."Collateral Perfected")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Narration; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(NextValuationDate; Rec."Next Valuation Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }

                field(ReOpenedBy; Rec."Re-Opened By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateReOpened; Rec."Date Re-Opened")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LegallyCleared; Rec."Legally Cleared")
                {
                    Caption = 'Legally Cleared/jointly';
                    ApplicationArea = Basic;
                }
                field("Lawyer Code"; Rec."Lawyer Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = Rec."Collateral Type" = Rec."Collateral Type"::"Title Deed";
                }
                field(Lawyer; Rec.Lawyer)
                {
                    ApplicationArea = Basic;
                    //ShowMandatory = Rec."Collateral Type" = Rec."Collateral Type"::"Title Deed";
                }
                field("Valuer Code"; Rec."Valuer Code")
                {
                    ApplicationArea = Basic;
                    //ShowMandatory = Rec."Collateral Type" = Rec."Collateral Type"::"Title Deed";
                }
                field(Valuer; Rec.Valuer)
                {
                    ApplicationArea = Basic;
                    //ShowMandatory = Rec."Collateral Type" = Rec."Collateral Type"::"Title Deed";
                }
            }
            group("Charge Exemption")
            {
                field("Charge Exemption Required"; Rec."Charge Exemption Required")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Charge Exemption Status"; Rec."Charge Exemption Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Charge Exemption Comment"; Rec."Charge Exemption Comment")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Charge Exemption Requested By"; Rec."Charge Exemption Requested By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Charge Exemption Requested On"; Rec."Charge Exemption Requested On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Charge Exemption Approved By"; Rec."Charge Exemption Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Charge Exemption Approved On"; Rec."Charge Exemption Approved On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }

            group("Vehicle Details")
            {
                Editable = PEditable;
                Visible = secVehicle;
                field("Vehicle Class"; Rec."Vehicle Class")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = false;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        UpdateDescription;
                    end;
                }
                field(Make; Rec.Make)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Vehicle Reg. No."; Rec."Vehicle Reg. No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        UpdateDescription;
                    end;
                }
                field("Tracker ID"; Rec."Tracker ID")
                {
                    ApplicationArea = Basic;
                    // ShowMandatory = true;
                }
                field("Tracking Installation Date"; Rec."Tracking Installation Date")
                {
                    ApplicationArea = Basic;
                }
                field("Trucker Expiry Date"; Rec."Trucker Expiry Date")
                {
                    Caption = 'Tracker Expiry Date';
                    ApplicationArea = Basic;
                    //ShowMandatory = true;
                }
            }
            group("Land Details")
            {
                Editable = PEditable;
                Visible = secLand;
                field("Plot Location"; Rec."Plot Location")
                {
                    ApplicationArea = Basic;

                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        UpdateDescription;
                    end;
                }
                field("Plot Reference No."; Rec."Plot No.")
                {
                    ApplicationArea = Basic;
                    caption = 'Title No.';
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        UpdateDescription;
                    end;
                }
                field("Title Name"; Rec."Title Name")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        UpdateDescription;
                    end;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        UpdateDescription;
                    end;
                }
            }
            group("Bonds / Stocks")
            {
                Editable = PEditable;
                Visible = secBonds;
                field(Company; Rec.Company)
                {
                    ApplicationArea = Basic;
                }
                field("Bond Details"; Rec."Bond Details")
                {
                    ApplicationArea = Basic;
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = Basic;
                }
                field("Face Value"; Rec."Face Value")
                {
                    ApplicationArea = Basic;
                }


            }
            group(InsuranceDetails)
            {
                Editable = PEditable;
                Caption = 'Insurance Details';

                field("Insurance Company"; Rec.Insurance)
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Details"; Rec."Insurance Details")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Value"; Rec."Insurance Value")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Start Date"; Rec."Insurance Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Expiry Date"; Rec."Insurance Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Expiry Reminder"; Rec."Insurance Expiry Reminder")
                {
                    ApplicationArea = Basic;
                }
            }
            part(CollateralAllocation; "Collateral Allocation")
            {
                // Visible = secLand;
                ApplicationArea = all;
                SubPageLink = "Collateral No." = field("No.");

            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Loan Collateral Register"),
                              "No." = field("No.");

            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Revised Member Statement")
            {
                ApplicationArea = Basic;
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Members: Record Members;
                begin
                    Members.Reset;
                    Members.SetRange("No.", Rec."Account No.");
                    if Members.FindFirst then
                        Report.Run(50276, true, false, Members);
                end;
            }
            action("Collateral History")
            {
                ApplicationArea = Basic;
                Image = History;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Collateral History";
                RunPageLink = "Col. Reg. No" = field("No.");
            }
            action("Valuation History")
            {
                ApplicationArea = Basic;
                Image = ValueLedger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Valuation History";
                RunPageLink = "Col. Reg. No." = field("No.");
            }
            // action("Prequilified Suppliers")
            // {
            //     ApplicationArea = Basic;
            //     Image = ValueLedger;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     RunObject = Page "Prequlified Supplier List";
            //     RunPageLink = "Col. Reg. No." = field("No.");
            // }
            action("Member Statement")
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
                    Members.SetRange("No.", Rec."Account No.");
                    if Members.FindFirst then
                        Report.Run(50087, true, false, Members);
                end;
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendChargeExemptionApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Charge Exemption Approval';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = category4;

                    trigger OnAction()
                    begin
                        if not Confirm('Are you sure you want to send this charge exemption request?', false) then
                            exit;

                        Rec.SendChargeExemptionForApproval();
                        Rec.Modify(true);
                        Message('Charge exemption has been sent successfully.');
                        CurrPage.Update(false);
                    end;
                }
                action(ApproveChargeExemption)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve Charge Exemption';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = category4;

                    trigger OnAction()
                    begin
                        if not Confirm('Are you sure you want to approve this charge exemption request?', false) then
                            exit;

                        Rec.ApproveChargeExemption();
                        Rec.Modify(true);
                        Message('Charge exemption has been approved successfully.');
                        CurrPage.Update(false);
                    end;
                }
                action(RejectChargeExemption)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject Charge Exemption';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = category4;

                    trigger OnAction()
                    begin
                        Rec.RejectChargeExemption();
                        Rec.Modify(true);
                        CurrPage.Update(false);
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    //Caption = 'Approve Document';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = category4;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                    begin

                        CheckControls;
                        VarVariant := Rec;
                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec."No.", 0, Documenttype::"Collateral Register", Rec."Global Dimension 1 Code", Rec."Global Dimension 2 Code", 0);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = category4;

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
                    PromotedCategory = category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Collateral Register";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec."No.");
                        ApprovalTracker.SetRange("Custom Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(ApprovalTracker.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                        UserSetup: Record "User Setup";
                    begin

                        UserSetup.Get(UserId);
                        if not UserSetup."Re-Open Collateral" then begin
                            Message(
                              'You do not have permission to Re-Open Collateral [Re-Open Collatera].');
                            exit;
                        end;

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
                action(ReopenChargeExemption)
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-open Charge Exemption';
                    Image = ReOpen;

                    trigger OnAction()
                    begin
                        Rec.ReOpenChargeExemption();
                        Rec.Modify(true);
                        CurrPage.Update(false);
                    end;
                }
            }

        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls;
        UpdateActions
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
        UpdateActions
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
        UpdateActions;

    end;

    var
        PEditable: Boolean;
        secLand: Boolean;
        secVehicle: Boolean;
        secBonds: Boolean;

    local procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::Open then
            PEditable := true
        else
            PEditable := false;
    end;


    local procedure UpdateActions()
    begin


        secVehicle := false;
        secLand := false;
        secBonds := false;


        if Rec."Collateral Type" = Rec."Collateral Type"::"Motor Vehicle" then
            secVehicle := true;

        if Rec."Collateral Type" = Rec."Collateral Type"::"Title Deed" then
            secLand := true;

    end;

    local procedure UpdateDescription()
    begin
        Rec."Collateral Description" := '';

        //if ("Vehicle Class" <> '') then
        //  "Collateral Description" += "Vehicle Class";

        if (Rec."Vehicle Reg. No." <> '') then
            Rec."Collateral Description" := ' ' + Rec."Vehicle Reg. No.";

        //if ("Plot Location" <> '') then
        //  "Collateral Description" += ' ' + "Plot Location";

        if (Rec."Plot No." <> '') then
            Rec."Collateral Description" := ' ' + Rec."Plot No.";
    end;


    procedure CheckControls()
    var
        CollAllocation: Record "Collateral Allocation";
    begin

        Rec.TestField(Status, Rec.Status::Open);
        if not Rec."Legally Cleared" then
            if not Confirm('Kindly NOTE that "Legally Cleared" needs to be Confirmed. Do you want to proceed?') then
                Error('Aborted');

        if Rec."Valuation Type" = Rec."valuation type"::" " then
            Error('Valuation Type MUST have a value');

        if Rec."Collateral Type" = Rec."Collateral Type"::"Motor Vehicle" then begin
            Rec.TestField(Insurance);
            Rec.TestField("Insurance Expiry Date");
            //Rec.TestField("Vehicle Class");
            Rec.TestField("Vehicle Reg. No.");
            Rec.TestField(Make);
            Rec.TestField("Forced Sale Value");
        end;

        if Rec."Collateral Type" = Rec."Collateral Type"::"Title Deed" then begin
            Rec.TestField("Plot Location");
            Rec.TestField("Plot No.");
            Rec.TestField("Title Name");
            Rec.TestField("Forced Sale Value");

        end;

        Rec.TestField("Last Valuation Date");
        Rec.TestField("Account No.");
        Rec.TestField(Collateral);
        Rec.TestField("Collateral Limit");
        Rec.TestField("Collateral Multiplier");
        //TESTFIELD("Collateral Perfected");
        Rec.TestField("Collateral Type");
        Rec.TestField("Collateral Value");

        if Rec."Charge Exemption Required" then begin
            Rec.TestField("Charge Exemption Comment");
            if Rec."Charge Exemption Status" <> Rec."Charge Exemption Status"::Approved then
                Error('Charged Value exceeds the policy-supported percentage. Send and get Charge Exemption approval before sending for normal approvals.');
        end;

        Rec.TestField("Registered Owner");

        //Check Allocation
        CollAllocation.Reset();
        CollAllocation.SetRange("Collateral No.", Rec."No.");
        if not CollAllocation.FindFirst() then
            Error('Collateral allocation is required before sending for approval. Please allocate the collateral first.');
    end;
}
