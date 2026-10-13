Page 51073 "HR Jobs to Succeed Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Job';
    SourceTable = "HR Jobs";
    SourceTableView = where("Marked for Succession" = filter(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(JobID; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                }
                field(JobTitle; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                    Importance = Promoted;
                }
                group(Control17)
                {
                    grid(Control16)
                    {
                        GridLayout = Rows;
                        group(Control15)
                        {
                            field(PositionReportingto; Rec."Position Reporting to")
                            {
                                ApplicationArea = Basic;
                                Importance = Promoted;
                            }
                            field(PositionReportingName; Rec."Position Reporting Name")
                            {
                                ApplicationArea = Basic;
                                ShowCaption = false;
                            }
                        }
                    }
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic;
                }
                field(NoofPosts; Rec."No of Posts")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(OccupiedPositions; Rec."Occupied Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(VacantPositions; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                group(Control13)
                {
                    grid(Control12)
                    {
                        GridLayout = Rows;
                        group(Control11)
                        {
                        }
                    }
                }
                field(EmployeeRequisitions; Rec."Employee Requisitions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(DateCreated; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                    Style = Attention;
                }
                field(MarkedforSuccession; Rec."Marked for Succession")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Dimensions)
            {
                Caption = 'Dimensions';
                group(Control29)
                {
                    grid(Control10)
                    {
                        GridLayout = Rows;
                        group(Control9)
                        {
                            field(Department; Rec."Global Dimension 1 Code")
                            {
                                ApplicationArea = Basic;
                                Caption = 'Department';
                            }
                            field(GlobalDimension1Name; Rec."Global Dimension 1 Name")
                            {
                                ApplicationArea = Basic;
                                ShowCaption = false;
                            }
                        }
                    }
                }
                group(Control6)
                {
                    grid(Control5)
                    {
                        GridLayout = Rows;
                        group(Control4)
                        {
                            field(Region; Rec."Global Dimension 2 Code")
                            {
                                ApplicationArea = Basic;
                                Caption = 'Region';
                            }
                            field(GlobalDimension2Name; Rec."Global Dimension 2 Name")
                            {
                                ApplicationArea = Basic;
                                ShowCaption = false;
                            }
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Jobs Factbox")
            {
                SubPageLink = "Job Description" = field("Job ID");
            }
            systempart(Control1102755006; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Job)
            {
                action(Requirements)
                {
                    ApplicationArea = Basic;
                    Caption = 'Requirements';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirement Lines";
                    RunPageLink = "Job ID" = field("Job ID");
                }
                action(Responsibilities)
                {
                    ApplicationArea = Basic;
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Responsiblities Lines";
                    RunPageLink = "Job ID" = field("Job ID");
                }
                action(Occupants)
                {
                    ApplicationArea = Basic;
                    Caption = 'Occupants';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Category5;
                    //RunObject = Page "HR Job Occupants";
                    //RunPageLink = "Job ID" = field("Job ID");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin


        Rec.Validate("Vacant Positions");
        UpdateControls;
    end;

    var
        HREmployees: Record Employee;

    local procedure UpdateControls()
    begin
        CurrPage.Editable := false;

        if Rec.Status = Rec.Status::Open then begin
            CurrPage.Editable := true;
        end;
    end;


    procedure RecordLinkCheck(job: Record "HR Jobs") RecordLnkExist: Boolean
    var
        objRecordLnk: Record "Record Link";
        TableCaption: RecordID;
        objRecord_Link: RecordRef;
    begin
        objRecord_Link.GetTable(job);
        TableCaption := objRecord_Link.RecordId;
        objRecordLnk.Reset;
        objRecordLnk.SetRange(objRecordLnk."Record ID", TableCaption);
        if objRecordLnk.Find('-') then exit(true) else exit(false);
    end;
}

