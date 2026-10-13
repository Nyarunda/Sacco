page 55028 "Member Updates"
{
    ApplicationArea = All;
    Caption = 'Member Updates';
    PageType = List;
    SourceTable = "Uploads Update";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff No. field.';
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Updated field.';
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action(UpdateBoard)
            {
                trigger OnAction()
                var
                    myInt: Record "Uploads Update";
                    Cust: Record Members;
                begin
                    myInt.Reset();
                    myInt.SetRange(Updated, false);
                    if myInt.FindFirst() then begin
                        repeat
                            Cust.reset;
                            Cust.setrange("No.", myInt."Member No.");
                            if Cust.FindFirst() then begin
                                Cust."Member Category" := Cust."Member Category"::"Board Members";
                                Cust.Modify();
                                Rec.Updated := true;
                                Rec.Modify();
                            end;

                        until myInt.Next() = 0;
                    end;
                end;
            }
            action(UpdateStaff)
            {
                trigger OnAction()
                var
                    myInt: Record "Uploads Update";
                    Cust: Record Members;
                    SActivities: Codeunit "Sacco Activities";
                begin
                    myInt.Reset();
                    myInt.SetRange(Updated, false);
                    if myInt.FindSet() then begin
                        repeat
                            Cust.reset;
                            Cust.setrange("No.", myInt."Member No.");
                            if Cust.FindFirst() then begin
                                Cust."Member Category" := Cust."Member Category"::"Staff Members";
                                Cust.Modify();
                                myInt.Updated := true;
                                myInt.Modify();
                            end;

                        until myInt.Next() = 0;
                    end;
                end;
            }


            action(UpdateDelagates)
            {
                trigger OnAction()
                var
                    myInt: Record "Uploads Update";
                    Cust: Record Members;
                begin
                    myInt.Reset();
                    myInt.SetRange(Updated, false);
                    if myInt.FindFirst() then begin
                        repeat
                            Cust.reset;
                            Cust.setrange("Payroll/Staff No.", Rec."Staff No.");
                            if Cust.FindFirst() then begin
                                Cust."Member Category" := Cust."Member Category"::Delegates;
                                Cust.Modify();
                                myInt.Updated := true;
                                myInt.Modify();
                            end;

                        until myInt.Next() = 0;
                    end;
                end;
            }
        }
    }

}
