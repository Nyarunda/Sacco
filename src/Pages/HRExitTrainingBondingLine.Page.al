Page 50972 "HR Exit Training Bonding Line"
{
    PageType = ListPart;
    SourceTable = "HR Exit Training Bonding";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field(EmployeeNo; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field(TrainingApplicationCode; Rec."Training Application Code")
                {
                    ApplicationArea = Basic;
                }
                field(TrainingDescription; Rec."Training Description")
                {
                    ApplicationArea = Basic;
                }
                field(BondageStartDate; Rec."Bondage Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(BondingDuration; Rec."Bonding Duration")
                {
                    ApplicationArea = Basic;
                }
                field(BondageReleaseDate; Rec."Bondage Release Date")
                {
                    ApplicationArea = Basic;
                }
                field(ClearedforEarlyRelease; Rec."Cleared for Early Release?")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Line)
            {
                Caption = '&Line';
                action(TrainingBondingConditions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Training Bonding Conditions';
                    Image = BOM;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    RunObject = Page "HR Training Bonding Cond. List";
                    RunPageLink = "Training Bonding Code" = field("Training Application Code");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        if HREmp.Get(Rec."Employee No.") then begin
            JobTitle := HREmp."Job Title";
            sUserID := HREmp."User ID";
        end else begin
            JobTitle := '';
            sUserID := '';
        end;


        Rec.SetRange("Employee No.");
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';

        RecalcDates;
    end;

    var
        JobTitle: Text[30];
        Supervisor: Text[60];
        HREmp: Record Employee;
        HRCodeunit: Codeunit "HR Codeunit.";
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        HREmpForm: Page "HR E-Mail Parameters List";
        sUserID: Code[30];
        //DoclLink: Record "HR Company Attachments";
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        D: Date;
        Misc: Record "Misc. Article Information";
        Text19062217: label 'Misc Articles';
        HRDatess: Codeunit "HR Leave Jnl.- Check Line";


    procedure RecalcDates()
    begin
        /*
    //Recalculate Important Dates
    if (HREmp."Date Of Join" = 0D) then begin
        if (HREmp."Date Of Birth" <> 0D) then
            DAge := HRCodeunit.DetermineAge(HREmp."Date Of Birth", Today);
        if (HREmp."Date Of Join" <> 0D) then
            DService := HRCodeunit.DetermineAge(HREmp."Date Of Join", Today);
        if (HREmp."Pension Scheme Join" <> 0D) then
            DPension := HRCodeunit.DetermineAge(HREmp."Pension Scheme Join", Today);
        if (HREmp."Medical Scheme Join" <> 0D) then
            DMedical := HRCodeunit.DetermineAge(HREmp."Medical Scheme Join", Today);
        //MODIFY;
    end else begin
        if (HREmp."Date Of Birth" <> 0D) then
            DAge := HRCodeunit.DetermineAge(HREmp."Date Of Birth", HREmp."Date Of Leaving");
        if (HREmp."Date Of Join" <> 0D) then
            DService := HRCodeunit.DetermineAge(HREmp."Date Of Join", HREmp."Date Of Leaving");
        if (HREmp."Pension Scheme Join" <> 0D) then
            DPension := HRCodeunit.DetermineAge(HREmp."Pension Scheme Join", HREmp."Date Of Leaving");
        if (HREmp."Medical Scheme Join" <> 0D) then
            DMedical := HRCodeunit.DetermineAge(HREmp."Medical Scheme Join", HREmp."Date Of Leaving");
        //MODIFY;
    end;
    */
    end;

    local procedure EmployeeNoOnAfterValidate()
    begin
        CurrPage.SaveRecord;
        Rec.FilterGroup := 2;
        Misc.SetRange(Misc."Employee No.", Rec."Employee No.");
        Rec.FilterGroup := 0;
        if Misc.Find('-') then;
        CurrPage.Update(false);
    end;
}

