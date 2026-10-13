Page 50984 "HR Disciplinary Cases"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(EmployeeNo; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee No.';
                    Editable = false;
                    Importance = Promoted;
                }
                field(FirstName; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LastName; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                /*field(Position;Rec.Position)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }*/
                field(JobTitle; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field(CompanyEMail; Rec."Company E-Mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                /*field(CellularPhoneNumber;Rec."Cellular Phone Number")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }*/
            }
            part(Control2; "HR Disciplinary Cases SF")
            {
                SubPageLink = "Accused Employee" = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action(MarkasClosedOpen)
                {
                    ApplicationArea = Basic;
                    Caption = '&Mark as Closed/Open';

                    /*trigger OnAction()
                    begin
                        HRDisciplinary.Reset;
                        HRDisciplinary.SetRange(HRDisciplinary.Selected, true);
                        HRDisciplinary.SetRange(HRDisciplinary."Employee No", "No.");
                        if HRDisciplinary.Find('-') then begin

                            //ENSURE SELECTED RECORDS DO NOT EXCEED ONE
                            Number := 0;
                            Number := HRDisciplinary.Count;
                            if Number > 1 then begin
                                Error('You cannot have more than one application selected');
                                // ERROR(FORMAT(Number)+' applications selected');

                            end;
                            if HRDisciplinary.Status = HRDisciplinary.Status::Open then begin
                                HRDisciplinary.Status := HRDisciplinary.Status::Closed;
                                HRDisciplinary.Modify;
                                HRDisciplinary."Closed By" := UserId;
                            end else begin
                                HRDisciplinary.Status := HRDisciplinary.Status::Open;
                                HRDisciplinary.Modify;
                                HRDisciplinary."Closed By" := UserId;
                            end;

                        end else begin
                            Error('No disciplinary case selected');
                        end;
                    end;*/
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Message('Send For Approval');
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Image = Approvals;
                    Promoted = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Message('Approvals');
                    end;
                }
                action("Cancel Approvals Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Message('Cancel Approval Request');
                    end;
                }
            }
        }
    }

    var
        HREmp: Record Employee;
        EmpNames: Text[40];
        //HRDisciplinary: Record UnknownRecord39003961;
        Number: Integer;
}

