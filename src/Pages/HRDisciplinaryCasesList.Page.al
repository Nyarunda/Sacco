Page 50985 "HR Disciplinary Cases List"
{
    ApplicationArea = All;
    CardPageID = "HR Disciplinary Cases";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field(FirstName; Rec."First Name")
                {
                    ApplicationArea = Basic;
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                }
                field(LastName; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                }
                /*field(Position;Rec.Position)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                }*/
                field(JobTitle; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000001; Outlook)
            {
            }
            systempart(Control1000000002; Notes)
            {
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
            }
        }
        area(reporting)
        {
            action(DisciplinaryCases)
            {
                ApplicationArea = Basic;
                Caption = 'Disciplinary Cases';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Disciplinary Cases";
            }
        }
    }

    var
        HREmp: Record Employee;
        EmpNames: Text[40];
        //HRDisciplinary: Record UnknownRecord39003961;
        Number: Integer;
}

