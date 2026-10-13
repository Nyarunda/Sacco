Page 50964 "HR Employee Transfer Card Effe"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'Manage,Process,Report,Redeploy';
    SourceTable = "HR Employee Transfer Header";
    SourceTableView = where("Transfer details Updated" = const(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(RequestNo; Rec."Request No")
                {
                    ApplicationArea = Basic;
                }
                field(DateRequested; Rec."Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(JobID; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(JobDescription; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(Dimension1Code; Rec."Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Dimension1Description; Rec."Dimension 1 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(Dimension2Code; Rec."Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Dimension2Description; Rec."Dimension 2 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(Dimension3Code; Rec."Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Dimension3Description; Rec."Dimension 3 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                    Visible = false;
                }
                field(SalaryGrade; Rec."Salary Grade")
                {
                    ApplicationArea = Basic;
                }
                field(SalaryNotch; Rec."Salary Notch")
                {
                    ApplicationArea = Basic;
                }
                field(NewJobID; Rec."New Job ID")
                {
                    ApplicationArea = Basic;
                }
                field(NewJobDescription; Rec."New Job Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(NewDimension1Code; Rec."New Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension1Description; Rec."New Dimension 1 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(NewDimension2Code; Rec."New Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension2Description; Rec."New Dimension 2 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field(NewDimension3Code; Rec."New Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(NewDimension3Description; Rec."New Dimension 3 Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                    Visible = false;
                }
                field(NewSalaryGrade; Rec."New Salary Grade")
                {
                    ApplicationArea = Basic;
                }
                field(NewSalaryNotch; Rec."New Salary Notch")
                {
                    ApplicationArea = Basic;
                }
                field(ReasonforTransfer; Rec."Reason for Transfer")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(TransferdetailsUpdated; Rec."Transfer details Updated")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Transfer Duration")
            {
                field(EffectiveFrom; Rec."Effective From")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                }
                field(EffectiveTo; Rec."Effective To")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Show)
            {
                Caption = '&Show';
            }
            group(Functions)
            {
                Caption = 'F&unctions';
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Jobs,"Employee Req",Employees,Promotion,Confirmation,"Employee Transfer","Asset Transfer","Transport Req",Overtime,"Training App","Leave App";
                    //ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::"Employee Transfer";
                        //ApprovalEntries.Setfilters(Database::"HR Employee Transfer Header", DocumentType, "Request No");
                        //ApprovalEntries.Run;
                    end;
                }
            }
        }
    }

    var
        ApprovalComments: Page "Approval Comments";
        Employees: Record Employee;
        Text001: label 'Employee No. %1 has been successfully redeployed';
        Text002: label 'Do you want to effect this transfer';
}

